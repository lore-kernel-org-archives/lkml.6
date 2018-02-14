Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518624548; cv=none;
        d=google.com; s=arc-20160816;
        b=ecU5Whb28UE/A+VGoW/FF7G33s5TXV7HmGjCKvOiBCrrcVUiaghySFD5aCz86JZBSH
         68JqOzOabyvtJJLTQ8f2WKNfBTe5dPZzzAq1HxIudDLoNsMx+demX1qPWPZh6GsYZAjg
         7+cke4BextEW+3zhQ+ekbWUZDscrfpHypZPxmxFkFMQe6ScKZ91izHAjIlCxU4LoRfNk
         sA0V9Bwcml6DXnxLPr4MsZcbpCbTLJ8EEDZkTIcmFCMW5tpw2Ug+mYRnrBDyyFC7KMWO
         5SI31GxJAbKbLVLb+0iUH8VIxG+iGhlg7bjTQKpQ7dI7wC5DckUqKL+aVqZx4KFUOPUx
         OvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=ZBf3iq57jDs9I3ETL/5F7xTGaDedvyFs006OEqfZe7o=;
        b=ITm3TcZAk0Re88fLjsFazxm3o1hNWSKp2KmnrnPH66bLLHq3HlkbycMkUJCHCNzC7g
         aE6aontZia3Z5C5JLsKOdFOxaK3flWqYQ+jpg8mACPvq0A20wDmUke5XepdUkDVOtmtS
         4h55OU+ENPwQiTVrErwM/MUY3sqlv2toOwhkiIhkwXpy3OenEZ9T3AdanYfJa6IYBKb6
         W4xfahuRwJrrAjPQcgXsHzb+875yTLF5iMjee/fASx1a9hLxry1nfmFeT6Q7DmOY/zFL
         PqwVkCHG7Vj2ObCe6KllxOkgCw2U5CGE0ViWPbNFSrY91cQk36J5z84tDjns5Wr8Pvft
         pZpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A7ji9GDt;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=A7ji9GDt;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x224JOTxyEQ++7I2fYXW8bO2vYlHa+G6V2L9CrKzkGP4r4dKtZSgLtheGJy5zqAaPrisJJMlN4Q==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 14 Feb 2018 08:09:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	gnomes@lxorguk.ukuu.org.uk, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, thomas.lendacky@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] x86/retpoline: Add clang support
Message-ID: <20180214160906.GB6223@roeck-us.net>
References: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
 <1518042518.3677.153.camel@infradead.org>
 <20180207233211.GA13991@roeck-us.net>
 <20180213234122.GA10961@roeck-us.net>
 <1518567057.12890.99.camel@infradead.org>
 <97abdb69-9ef5-a0f8-5055-3e9295024c42@roeck-us.net>
 <1518613769.12890.125.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518613769.12890.125.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1592393255323325576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:09:29PM +0000, David Woodhouse wrote:
> 
> 
> On Tue, 2018-02-13 at 18:18 -0800, Guenter Roeck wrote:
> > 
> > > We're going to need the percpu.h fix too, and I'd also like to see the
> > > status of the i915 build failure you mentioned. Is there a bug filed
> > > for that already, and is it on the blocker list for 6.0? If not, why
> > > not?
> > > 
> > For my part I completely forgot about it :-(. Did you expect me to file a bug ?
> > If so, I'll need to retest and try to figure out how to do that. Let me know;
> > I should be able to get that done tomorrow.
> 
> I *thought* you had mentioned that it didn't build; in that case
> absolutely, I expected there to be a bug filed already. As a general
> rule, nobody should *ever* mention that something is broken, without
> first ensuring the bug is filed.
> 
> Looking back, I can't now see where you said that; maybe I made it up
> and I only observed this failure myself. Either way, I already filed

I found it in my e-mail logs, so it definitely was me. Or maybe both
of us in parallel.

> https://bugs.llvm.org/show_bug.cgi?id=36378 after searching bugzilla
> and not finding it.
> 
Thanks!
Guenter
