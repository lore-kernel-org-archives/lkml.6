Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AG47ELtTIS7a42MdAGAyqWdrb7jqGUpjmMNCYt7vHUGLXKka3z1H+BTd8GHR3+wVGkSV+6mU6VDQ
ARC-Seal: i=1; a=rsa-sha256; t=1520494796; cv=none;
        d=google.com; s=arc-20160816;
        b=ZCDVefDu7l4rQu50vqRyHlIhS8lhtD8rsX2eFZ/UXOE5LTRdd736F/V9kaJUOxMxrh
         Cd98u6xsj7KSWAiH5GkMjfWekVPi56ZcdmhI6DZWPjwGyCzCBPWd3s3aZQt9Ig/r59Xn
         js/QgetQekgRaFwSktbeKRT25KbYuRLSlFqqHasvDLx1o21nh7qBnjEOPNotjNo6z/0N
         TTegpa8ePUN+J1IZjei9cx0hCOXq3lmW3obTU00IqFZuSZvO3+eG6fIAhh8bzwMfy+xi
         MdV9aWKS8nxAZg2Owf+z97v7L0IGo1lUV7j5y40wlppuYtpT8w4lXE89X1dbwgqNtFjf
         5p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vzxBpNORdASbh5oZDZj9r8wKEXvxFq808gI5bfBjgX0=;
        b=RBy1QB0Sr/cvDsK8+MtQoliELNMIbJOa/Fjo4+42Jq7UvhjQ41xqXNnyBWc3x5tCTa
         9AuHf9RtS1Kz6kZtvn+RQiEyaj0wm5BXtoyG8aIg3MbdQf/FBZqfIW92CGCSXhsbwKlm
         klTtdtLtnLv6chQRzo5ipn88usZO1dxbguEAVB/FAgb+E2eD1qiPW9ezDqmuHuxhKmaU
         eE0iqprnWZCmH906nKb6sb+d3yxh5yPnqAqtHunEQbDZFWsgZ9R4pjQV0JQKKw0U4fSu
         Yu1jaxoaef3txqyzbIy2sOrh5MUwPxmaoS8CCBeL4ZSHvxq7tgt7+cQTE14vDcyUJN7I
         VxRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qIhqsToA;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qIhqsToA;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 8 Mar 2018 08:39:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix compilation of 64-bit kernel with 32-bit compiler
Message-ID: <20180308073940.GT25181@hirez.programming.kicks-ass.net>
References: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1803080107001.7847@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594348785980298320?=
X-GMAIL-MSGID: =?utf-8?q?1594354351257605885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 01:11:26AM -0500, Mikulas Patocka wrote:
> The patch b5bc2231b8ad4387c9641f235ca0ad8cd300b6df ("objtool: Add 
> retpoline validation") broke compiling 64-bit kernel with 32-bit compiler.
> 
> This patch fixes the following error and a large number of "can't find
> rela for retpoline_safe" errors that occur when using x32 or i386 gcc.
> 
> You shouldn't use the type 'unsigned long' in objtool at all - because its
> size depends on the compiler and not on the kernel you are compiling.

Your patch is wrong because the data field is actually a long. A correct
patch is already in merged in tip.
