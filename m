Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518127057; cv=none;
        d=google.com; s=arc-20160816;
        b=BhLhV+BHAYLBtcoedHwYWuxcp0HGN5JSpfG7pUIS2g0BC4+83t6+5M+MBSO/OXwyWX
         gTczLN2l7vXIZDQ6NFceK7qIyhPR2bztJr4maLvO1QAu5NPas+LA6thbv7hZuyjlL//6
         lijXLi95UF5H8LCEV2InIC7uZf9TiRwcKEVykVjPW5xVJ6ykPdiG2CnfeuyIJyjVIApl
         2eyLLabUlt3zAV36BtrBMT/OtKRcPEiWagHIR7VLN7syexpzU+hP/xGZFn1vqCnBCuI1
         wG7OumJ/ObKBE2UvhW5J5GZ4HNKvAiVNM1R68UEf5FAYMl1nFvDUxv9fxh8vvjyswquj
         rPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=agqr2PdpATpoq0eDxInIrZwVtyTqWOT4Lj9wrUd3wx8=;
        b=X30hKiLmHqeO6xLg7qVgoBqgIfHHUu/m2XefdPavdT/9a2N9ddGpEnEtQwHIsM2ti5
         0qC+smIFo930Pq878gdXgwKmx32Q3Dt9Rd1nMgZ8qg5Rx50YWaIBMtBvVUzJ0I3NjPQM
         K3bFN9BjjzNCMdPIndEnhNukQcwrLJLdRWn3Bmvo4ArR/8UpPlhMB5/dO38bfay3Dyki
         VcO62qmWa9Objl8X1eNCXC1QalUtRnG7B7T8GR0CJXDBOJN0vEyxgw+JwOM75eFXo3fh
         yfDDcqfRSCCum3DzSDpN6aZucJVkMgC10xego9/q2BVDEQ/k5v33eSp6FHf11NfJ++rh
         UWCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eFTx0QP/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eFTx0QP/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x224PEBqTc3NEWn1TjiVtpjyqfd/oS5/664fNRa4dFnS6CW0CfMcV0lUK0/XdQUelHvDIcqrKiRk2mNYUvwMN9JU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180208211636.28d82edd@alans-desktop>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org> <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com> <20180208211636.28d82edd@alans-desktop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Feb 2018 22:57:36 +0100
X-Google-Sender-Auth: FRjoQ5OA10tvxy9tkXQ1t8L3vwI
Message-ID: <CAK8P3a3Xh02m5aoHaz+kvc4xKSa+1n_f-3cSL9vr2L9+747u6A@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Ondrej Zary <linux@rainbow-software.org>, whiteheadm@acm.org,
	David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jikos@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>, Jamie Iles <jamie@jamieiles.com>,
	Eduardo Valentin <eduval@amazon.com>, Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591871597163349772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 10:16 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Thu, 8 Feb 2018 16:22:40 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Thu, Feb 8, 2018 at 2:49 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> What about Pentium II and 3? I'm using 5 such machines (and also a Pentium
>> >> MMX). I've tried a spectre test before and it wasn't reading anything useful.
>> >> Don't know about meltdown. Is there a complete test program? (The web is so
>> >> full of crap that even google can't find anything useful.)
>> >
>> > For x86 speculation came in (as far as I can tell) in
>> >
>> > AMD Am5x86
>> > Cyrix 5x86, but branch predictors are disabled by default according to
>> > the docs
>> > Cyrix 6x86, branch prediction on by default
>> > Pentium Pro
>> >
>> > There are later processors that don't have speculation: Quark series, Nat
>> > Semi/Cyrix Geode, earliest AMD geode (I think), some Intel Atom
>> > processors.
>>
>> Wasn't Am5x86 just a 486 clone? AFAICT, speculation only came with the
>> K6 (Am6x86 aka NexGen Nx6x86)
>
> The AMD 486 was a 486, just like UMC. The Am5x86 was a sort of super 486.
> But you are correct I'm muddling that with the K5 - which does speculate
> or at least some of them do. The K5 branch predictor is software
> controllable via the HWCR MSR but who has one today to test or cares 8)

Right, I completely forgot about the K5.

>> All the Geode are apparently derived from Cyrix 5x86 (I always thought
>
> Not quite all. The older ones are Cyrix 5x86 related which indeed means
> they don't have branch prediction on by default until the LX. Just to
> confuse the AMD Geode NX is basically an Athlon mobile.

This one I knew, I was just not using precise enough language.

      Arnd
