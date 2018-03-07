Return-Path: <boris.brezillon@bootlin.com>
X-Cyrus-Session-Id: sloti22d1t05-199112-1520461872-2-3359096215038275780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, SPF_PASS -0.001, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='62.4.15.54', Host='mail.bootlin.com', Country='FR', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: boris.brezillon@bootlin.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520461871; b=IZzzGilOmc9LYAt+xhSbeviW1qxAZQVFzYFWhXAaLfc3SZ/
    GplCKtZSljZopbXY029z9yRCNT+uuTEJduWnOm2Jec5HJz7txp3d6RMSdnhGNm5H
    3w0YwECENKgPBEpntnFa3AjF/V8IfDokxOYzUuY3iLSzJFql7cRlASLakoLZat/v
    dmRET3Zv2Krr2FhD2FsodqWwNdtcsCqx4EkwSQYphqrArMDg29D3hcGexZj8/EPa
    iGqLyr59MZIEsFYQ61snuNurqEqgUViuxoQMYMvdB5ebLF/j2IQFkk+Ra8uYDpYj
    2NZnBnrMlkjoKCmKgHtt4xF0ydUTMYCGpTFsaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding; s=arctest; t=1520461871; bh=IQlJScVM
    RRLCSVTN2qpEkGblr/NfPUvJQBcN4d6mL/A=; b=P4kpfqBJ8bIZY0td/Y69T8+V
    MnHsKoAvukUF0pTMXlzEAuyzwbSjj+NX5n6Q661isT4LqezExdGPHGWR4babVczG
    zW+vn9RXWVPrM4PkBwISr6t81SIaWuueViOL9+SiHZRzH5V0BeNmXQvHbkHuU+jf
    lEyX/yOcXsfIKZjvlxmAN/W92TU8DMj9OcEYGrqfG9+HsiNmbTLez315JQU0f6B9
    Ti/f4QEyzWbuSXEpD5QnYVWY0ErmDb97GpJ6ZFS7bp8VSUHboJ78EaeVW7pvDd+d
    IpjQ3c699ocfBGPz983ES0SyhH3pZ08gKoWhom5d98Gi2fkzw1fCoX75X8n89Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=62.4.15.54 (mail.bootlin.com);
    spf=pass smtp.mailfrom=boris.brezillon@bootlin.com smtp.helo=mail.bootlin.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.bootlin.com x-ptr-lookup=mail.bootlin.com;
    x-return-mx=pass smtp.domain=bootlin.com smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=62.4.15.54 (mail.bootlin.com);
    spf=pass smtp.mailfrom=boris.brezillon@bootlin.com smtp.helo=mail.bootlin.com;
    x-aligned-from=pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.bootlin.com x-ptr-lookup=mail.bootlin.com;
    x-return-mx=pass smtp.domain=bootlin.com smtp.result=pass smtp_is_org_domain=yes header.domain=bootlin.com header.result=pass header_is_org_domain=yes
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
	URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Wed, 7 Mar 2018 23:30:57 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>, Steve
 deRosier <derosier@gmail.com>, Richard Weinberger <richard@nod.at>, Boris
 Brezillon <boris.brezillon@free-electrons.com>, dedekind1@gmail.com,
 tharvey@gateworks.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, marek.vasut@gmail.com,
 linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
 computersforpeace@gmail.com
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180307233057.54bd35c3@bbrezillon>
In-Reply-To: <20180307221733.GE10438@amd>
References: <20180303104554.5958-1-richard@nod.at>
	<20180306231805.GA28183@amd>
	<6772577.AmT7QaWTNU@blindfold>
	<20180307214342.GA9852@amd>
	<CALLGbRK4w9Yhznt6+aqr8jptQjsp7FmbjQMPtvhh2h354n2G0A@mail.gmail.com>
	<1520460673.31298.136.camel@infradead.org>
	<20180307221733.GE10438@amd>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

On Wed, 7 Mar 2018 23:17:33 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-03-07 22:11:13, David Woodhouse wrote:
> > 
> > 
> > On Wed, 2018-03-07 at 14:08 -0800, Steve deRosier wrote:  
> > > 
> > > To clarify one thing: the reason for this is MLC has actually never
> > > been supported, nor worked properly. The fact that it kinda worked was
> > > incidental and the cause of major problems for people due to that not
> > > being clear. This patch only makes it explicit and avoids people
> > > mistakenly trying to use UBIFS on MLC flash and risking their data and
> > > products. To me, that's what's important.
> > > 
> > > This is an important patch, even if all it does is keep people from
> > > loosing data. It also changes the conversation from "I have a
> > > corrupted UBIFS device, BTW it's on MLC..." to "What can we do to get
> > > UBIFS to work on MLC".  
> 
> Well, for -stable I'd suggest printk(KERN_ALERT ...) but keep the
> system running.
> 
> > This is a bug fix.
> > 
> > UBI on MLC never worked. It was a bug that we ever permitted it. This
> > is now fixed.  
> 
> Yeah, well, so lets say I have a working hardware (maybe using
> read-only UBI on MLC), update to next stable kernel, and now kernel
> refuses to see the partition.

Read-only does not save you from the read-disturb issue, and you even
have to take care of programming the full erase-block on some MLC
NANDs, which AFAIR is not done when updating a static volume.

I have one simple question: did you ever play with MLC NANDs or are you
just trolling? If you had, like Richard and I did when working on MLC
support, I'm pretty sure you wouldn't play this "don't backport to
stable" card.

Now, if you volunteer to add reliable MLC support, I can send you a
few boards to play with. I even have a "working but not so tested PoC"
here [1] if you want to finish the job, but please don't do the mistake
of thinking the fix is that simple.

> 
> I'll certainly not consider this patch a bug fix.

And apparently a lot of people disagree with you on this point, and I
guess all of them had problems with MLC NANDs.

> 
> Removing support for hardware that "only works by mistake" may be good
> idea, but maybe it is slightly too surprising for a -stable.

I wouldn't say "work by mistake" but "seems to work at first but in the
end breaks", so definitely a candidate for -stable IMO.

Regards,

Boris

[1]https://github.com/bbrezillon/linux/tree/nand/mlc
-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
