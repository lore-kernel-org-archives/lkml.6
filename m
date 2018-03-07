Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-199112-1520462491-2-16719652893549094745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520462491; b=dez//Zv3efCeZLpx0OKe04audS/YXuJn0+EkSmjC3dFFDSq
    eWvq2nv7N4QPaEEIFWCOE1o1fUoEfL3CzdVDciz8lywT0R8GhLouIdTxe6OgcjNV
    Y2dEBbHrKyQj0POIgIXr3t03z23C8JtT5rcgAlbfmrlWMbRLxlyRZNAgjngYM5FK
    +R7f6SIzBZVgVQ94jx5dNagWtHDuMacXqTsqhDqugbqedzT3Gn6DKsNnLO9GtecN
    ySC87fe3vVgPHtyBUUaUuCgbvfJlVqZFHTZ3YRRneuQBrI9XHsNW0PRTEkLDH+z6
    uFOQ/TCMhgQequ87iCmdwGqxyfiKpPTAhl8YblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520462491; bh=0fgQTNMnSxbjF+1EeXKTMIwnNGJH7OcID+ZNREO+kVA=; b=B
    RaNPE/6K65JeI0t8rumbXJD5pMpfkLxatobSY1qJGbdYjpCgkvPv9pQ2eGRX4WzO
    LZZpDrXR/ljTW+un9ERmAW17HMMnVkuKrNg08RMwk0C/Hw6SWnyS+Q6tz819+9Pb
    m6a5h21kgEUhyMX0+AebQLi5JoQFar1j1/LvvdSAAIvf0In+id/+8rIuImWyHDQ1
    8VXzLcLLMsBfqF4BVTmRqbGPC05s0YSwKy+hZvyVgs518qzSLl2jy69J7lyh9XXG
    nDSqf1Z4YeV4BWX7QE1YqcMnbfhHPSBYN4vXZxGQcmwAGnFO8trKQbKtNGwBbBm+
    2oVz20ygiIASKlSG7AFYQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeCGWl2 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 7 Mar 2018 17:41:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56319 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbeCGWl2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 17:41:28 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Wed, 7 Mar 2018 23:40:51 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr,
        marek.vasut@gmail.com, boris.brezillon@free-electrons.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        dedekind1@gmail.com, tharvey@gateworks.com, stable@vger.kernel.org
Subject: Re: [PATCH] ubi: Reject MLC NAND
Message-ID: <20180307234051.479d9eed@bbrezillon>
In-Reply-To: <20180307214342.GA9852@amd>
References: <20180303104554.5958-1-richard@nod.at>
        <20180306231805.GA28183@amd>
        <6772577.AmT7QaWTNU@blindfold>
        <20180307214342.GA9852@amd>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018 22:43:42 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Wed 2018-03-07 09:01:16, Richard Weinberger wrote:
> > Pavel,
> > 
> > Am Mittwoch, 7. März 2018, 00:18:05 CET schrieb Pavel Machek:  
> > > On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:  
> > > > While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> > > > most likely lose all your data upon a power-cut or due to read/write
> > > > disturb.
> > > > In order to protect users from bad surprises, refuse to attach to MLC
> > > > NAND.
> > > > 
> > > > Cc: stable@vger.kernel.org  
> > > 
> > > That sounds like _really_ bad idea for stable. All it does is it
> > > removes support for hardware that somehow works.  
> > 
> > MLC is not supported and does not work. Full stop.
> > If someone manages to get it somehow work, either with hardware or software 
> > hacks they are on their own.
> > Having it in stable is the only chance we have to get it into vendor
> > kernels.  
> 
> Can you show how it meets the stable kernel criteria? They are
> documented in tree. This should not be in stable.
> 
> And I'd like to see changelog improved. Real reason MLC is not
> supported is upper/lower page parts on MLC. And real fix to work with
> bigger pages in UBI.

Come on! Don't you think this would have been fixed already if it was
that easy?! Have you looked at an MLC datasheet to see how paired pages
are combined? If you had you would now that paired pages are almost all
the time not contiguous, thus preventing the trick you're suggesting
here. Please document yourself before doing such presumptuous
statements (you can have a look at these slides if you want some details
about why this is not so simple [1]).

I'm definitely not saying supporting MLC NANDs in Linux is impossible,
and if you're interested in working on this topic I'd be happy to help.
But please don't block this patch without understanding what supporting
MLC NANDs implies.

[1]https://events.static.linuxfound.org/sites/events/files/slides/ubi-mlc.pdf

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
