Return-Path: <hpa@zytor.com>
X-Google-Smtp-Source: AIpwx4+BYCs1hcOfawYTC1l2sKT3vdL8SSIjTGtfi6u3fqLVkFLnxtLdDIpmL5fyBTi6cZPsnd+7
ARC-Seal: i=1; a=rsa-sha256; t=1523901574; cv=none;
        d=google.com; s=arc-20160816;
        b=0FkB+5VcE2c/c5xANOZ1BA5Qt6bT1RonNZOmwjkwkMK/RopTPGxU1JIwhzIY03Hwgt
         DOyFZxayVq7m4NUsW/cLG6iLFB0dHUkfyKdhqDzVnc4GATFd+lWAlc1q6QgO+j9XabDD
         GV6FJg9+JngyMSHz5bmFDn4DquNY69xPLTgO7AQZ+Nh5sI45h3H8U6HTXUAv989E0w0U
         hh09ICjujbKHmeJO1aOJacQxc2e3csJzAaThtk81XuYRY2WiM7Io/ZILaXfZ3PpVc6tA
         0lHQRo5VyBfQLArcOhiafzU4JLSDCAxyORwmoD8x8yrD6gYUnT0bbud7oO7AyAa7HqtY
         MPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=UzT3jw/ok+v1sp6XmMSlHc5AObceOaK/CjiD+1oE7XQ=;
        b=hOMJyFQnSEqrJeHOIvOg3QJcBv+AeM1W3tQ+sFrHbg1Z3UetJAdY6R1YFC4RuhRCyS
         weSvc5uUN6wF/oEFTy9FjK6MC4EXMoy9FM0aEdLJ6HczUuPDuRJ+GcQ8HBjRXOeaPGK9
         vDMdOK03iNjsyzFsfTfPNLa+AYD0HJZoDn30nAPQWkSpLyUbdHY0Oi3IsLvMF+6EN5PI
         +FbFWfIGnSLZ//VGVtr4X3fcBLGS7no3Q0rOEMG37K6WN8NigJ/3vmuFeLCWsWYQBBDT
         8mHgUtGGuYCNx0Qc19h7aLgeEuR4Ucf2n6T/Bk09rP2tDhFw3Tae4Y8B2kUlO9ywXbEM
         /qgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hpa@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=hpa@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hpa@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=hpa@zytor.com
Subject: Re: [PATCH 00/35 v5] PTI support for x32
To: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <db40f8f6-7990-676c-e536-b876254e66c0@zytor.com>
Date: Mon, 16 Apr 2018 10:57:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916931664810234?=
X-GMAIL-MSGID: =?utf-8?q?1597926617757016738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/18 08:24, Joerg Roedel wrote:
> Hi,
> 
> here is the 5th iteration of my PTI enablement patches for
> x86-32. There are no real changes between v4 and v5 besides
> that I rebased the whole patch-set to v4.17-rc1 and resolved
> the numerous conflicts that this caused.
> 

Please don't use the term "x32" for i386/x86-32.  "x32" generally refers
to the x32 ABI for x86-64.  "x64" in Microsoft terminology for x86-64
corresponds to "x86" for x86-32.

	-hpa
