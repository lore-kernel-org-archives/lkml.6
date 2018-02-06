Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AH8x224Q1B25ADMLec89WyWEMZn7h8lsepDXH8gYChhzkBpvh7S3kQ+LvO5sKvphInMqKBkkAV51
ARC-Seal: i=1; a=rsa-sha256; t=1517927118; cv=none;
        d=google.com; s=arc-20160816;
        b=c3lgIqfkwENSZL4JhviyNew22n/7SbC2ByVIWMr/osSVQn1BgjJuoago6/Ofhe/Cd6
         cJosADKV/fo9KK1jSuPL2ZyY+NMgxZ7eQgDFsQ97T666moh3XYRxwubqEWCnF9i0wSWm
         VlOI7Tn744wFRkZAptgxUR3eJ5JPApRiGwtFoXea60sj42QcsxgSwMT3vkDZjInmrOZ8
         DSO+O63U+GFAwxoDsNKJTTQVg7KIczSAwYzzdOmEbsZKNzQB6PVsgCwTjtWsWR/XVphJ
         92b311vhFFuZ71Y2mesbOPXrIadh4E9AjvK7OFkCLbtWJjjFf80qrjovwTyxmXa83eHP
         U99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4/SSz+VJOyTLckIZGxNsN3E5TwhoekEIKmoSegBdwD0=;
        b=YL9cy0zdxkIaSJHqHRdwDKgGBwRtYs7Sr7nlEiNkAx051UUj3rZuixr15VgiuMxojX
         hSsGjI7AR1fwyvH98HjQ3RKPyO3j5u7RZ3eO5gci0YACdRHRw2+tM8qTVvmPsyxp2/O3
         8bl+GU+X74DUhUuyLp7Rg2MUwsn3el9DgKfHt7mprVnTRW4eNgObtLBkpMLhxOchn3jC
         DV1wC784KHFcGNMqYZZAjB6u//9MHsJIfRvzn2Smyh890QoOzL12JQUr+2OBAdqGIP3z
         134JhCL3XPZTOrOGuNZst+gwvtLAj6Ht6ILVCBagQ7yR23JnM0bHF0Jc6P3X5bS56x7a
         c0iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Tue, 6 Feb 2018 15:24:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591661945605907900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 02:09:35PM +0000, Rolf Neugebauer wrote:
> The backport of 7e702d17ed1 ("x86/microcode/intel: Extend BDW
> late-loading further with LLC size check") to 4.9.79 and 4.4.14 causes
> a division by zero panic on some single vCPU machine types on Google
> Cloud (e.g. g1-small and n1-standard-1):

The microcode loader is not supposed to load in a guest.

Greg, I guess you need something like this:

a15a753539ec ("x86/microcode/AMD: Do not load when running on a hypervisor")

I haven't tried whether it applies cleanly though...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
