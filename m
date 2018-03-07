Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3563148-1520436271-2-293901503334288182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FREEMAIL_REPLYTO_END_DIGIT 0.25, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520436269; b=TgDqS1IwhAJE4aaWRFbxe8owx4bc2UQWFVdxi/RWZyTt3bY
    xrVr8tRMIw5wtsvRJ7cqJaSN90YevtjPJag9aaKa3a8msj6qncz2QCv7c8n5YlfD
    PkhncbhWxrcSylgVdiQfmHwxzlrBfg8fERIoFJfNi/B/Xu56VNj0zU2TwROF3Gj1
    FsdSBZuzoydeK/X/+hJXlWFN36KYRyOLhzivof52j35hr3NJNCVagpt1njaD03Te
    vrpAj9P6wNY3I399O8sME1F+NRhIPYwatsG0EWhw3olK68u52yoLDls4oyxSK48k
    vBjs9uFlR/b2IapsF87o/yquM6Qglcf3H2oC0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:reply-to:to:cc
    :date:in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520436269; bh=tvHqRSg2tDqzhsTu3Gk1xzwBfryM1tJCYFpqDdqY/2I=; b=Q
    Q4k5iSkePr1TR9+2VZP9p/Fd6chkFlvxlgoIh4hsjfeLCCFvYuu4dI5dEqeBfVcy
    cOz5w9Mmfft2XrJokm05lqaMZuxRiYXhApw8gSzMcVXnS2JmPNnpoYK3RymtItsn
    VW5RY8xKMayl1XZzzVJOWlin/DGB19tzVDQx4jatnIikTO5Lld/zfjoOWTKGMhq4
    cwbEeaZR742+4IG+4x3bkzGcX7Px+qgbGbz1qYqyIJIuaf5Ce8R95Mj6MFunDkyS
    40kmBCJI45r5wpabGNqibeo+TFMbRtJwJx6ZLcn06iJXyii3bJxDtS1EcbGfwv2l
    eMOlAWM40GdKvMqYGPoWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeCGPY2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 10:24:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:22550 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933545AbeCGPY1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 10:24:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,436,1515484800";
   d="scan'208";a="23261259"
Message-ID: <1520436263.2674.35.camel@gmail.com>
Subject: Re: [PATCH] ubi: Reject MLC NAND
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Richard Weinberger <richard@nod.at>, Pavel Machek <pavel@ucw.cz>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, tharvey@gateworks.com, stable@vger.kernel.org
Date: Wed, 07 Mar 2018 17:24:23 +0200
In-Reply-To: <6772577.AmT7QaWTNU@blindfold>
References: <20180303104554.5958-1-richard@nod.at>
         <20180306231805.GA28183@amd> <6772577.AmT7QaWTNU@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-03-07 at 09:01 +0100, Richard Weinberger wrote:
> Pavel,
> 
> Am Mittwoch, 7. März 2018, 00:18:05 CET schrieb Pavel Machek:
> > On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:
> > > While UBI and UBIFS seem to work at first sight with MLC NAND,
> > > you will
> > > most likely lose all your data upon a power-cut or due to
> > > read/write
> > > disturb.
> > > In order to protect users from bad surprises, refuse to attach to
> > > MLC
> > > NAND.
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > That sounds like _really_ bad idea for stable. All it does is it
> > removes support for hardware that somehow works.
> 
> MLC is not supported and does not work. Full stop.

Ack.
