Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2592411-1520409598-2-5111916643504179817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520409598; b=C+U/9dDdtFd6/VAHaQjlIvREpGnD8AQ2b6Y+TRX63qgv3b4
    QzLNHs9+94DEkrxNRBJo6ZiMkucTZat76O+Uodko1glK3zBqdLNdBcNXuC4E7T+q
    vvifOndr0ugSNq3QQLaSpunyErrVK76ukRAZjG4Yqx/ed49vRrlFFuSFTCAeKhY7
    +S+Aq2Mrec5tKxLtGMPAW4V8df970SvFK2o+gVE/IaKw6Py+nmilpQ8zX+L5wIb8
    kq5lQaKhPWmNEvXj7zRWIvv7VSd+ayhWIQOB26QmwAKaZWUpWvB6l8IeQg4A3b7r
    BA1KaTttt7j4m8/5L2hUAdSx8/xN4QtiUA9n4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1520409598; bh=vmsdb4
    2urj6hYNhSin1s6Wt3790a6EoR5DN1PuY02Vw=; b=H+jEMfL3dDJd0pFdc7bE6u
    HFsvNjV9XVsitWNmUM0xTPwuX/04IYxaZVpT2WVL2Pqj/WlAPHVNgWBRbGHFwEgf
    fMUzjnZNzL/SFzV2csO2twfwONrFvJovBf+3Isx3iAfI5ogGInLVUHLcL9yrpBUH
    DRTbIGVx8uTzAJbLAmbnuUErcnloSNv7dP0wsPmzYzNYHIbFexPex3zIxsC4Oxpg
    TU0xDwV+3sHliMrJ2pyNbVtzmf5RrQiakBM7YjN3z1xlvzlz2a+kNf12PWvugjdy
    YKzMVqjyhg2l8HI0GnbqWeMQRXsX41xqHZhDkmNtGpISWPUTu184BKqWoAOGojxQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeCGH7z convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 7 Mar 2018 02:59:55 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:35272 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCGH7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 02:59:55 -0500
From: Richard Weinberger <richard@nod.at>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com,
        boris.brezillon@free-electrons.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, dedekind1@gmail.com, tharvey@gateworks.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ubi: Reject MLC NAND
Date: Wed, 07 Mar 2018 09:01:16 +0100
Message-ID: <6772577.AmT7QaWTNU@blindfold>
In-Reply-To: <20180306231805.GA28183@amd>
References: <20180303104554.5958-1-richard@nod.at> <20180306231805.GA28183@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pavel,

Am Mittwoch, 7. März 2018, 00:18:05 CET schrieb Pavel Machek:
> On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:
> > While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> > most likely lose all your data upon a power-cut or due to read/write
> > disturb.
> > In order to protect users from bad surprises, refuse to attach to MLC
> > NAND.
> > 
> > Cc: stable@vger.kernel.org
> 
> That sounds like _really_ bad idea for stable. All it does is it
> removes support for hardware that somehow works.

MLC is not supported and does not work. Full stop.
If someone manages to get it somehow work, either with hardware or software 
hacks they are on their own.
Having it in stable is the only chance we have to get it into vendor kernels.

All this patch does is representing the current state of UBI/UBIFS.

In the last months I got a way too much boards with MLC NAND on my desk where 
UBIFS broke. Customers wished they had known before...

Thanks,
//richard
