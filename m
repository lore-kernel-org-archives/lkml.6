Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33351ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE842083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 07:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE842083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJUPT5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 11:19:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeJUPT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 11:19:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3686A78;
        Sun, 21 Oct 2018 00:06:37 -0700 (PDT)
Received: from E111387 (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 402043F71A;
        Sun, 21 Oct 2018 00:06:34 -0700 (PDT)
From:   <yael.chemla@foss.arm.com>
To:     "'Herbert Xu'" <herbert@gondor.apana.org.au>
Cc:     "'Gilad Ben-Yossef'" <gilad@benyossef.com>,
        "'David Miller'" <davem@davemloft.net>,
        "'Linux Crypto Mailing List'" <linux-crypto@vger.kernel.org>,
        "'Ofir Drang'" <ofir.drang@arm.com>,
        "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>
References: <1539867599-20504-1-git-send-email-yael.chemla@foss.arm.com> <CAOtvUMe8ACJtadM1B50qBT=TBwD45rPN-89Pw+AdU20uMqyU-g@mail.gmail.com>
In-Reply-To: <CAOtvUMe8ACJtadM1B50qBT=TBwD45rPN-89Pw+AdU20uMqyU-g@mail.gmail.com>
Subject: RE: [PATCH 0/3] crypto: ccree: add SM3 support
Date:   Sun, 21 Oct 2018 10:06:30 +0300
Message-ID: <000901d4690c$9ae267c0$d0a73740$@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLC+d5TQMYPXQeM6UwNTDzzXXurpQGIQUE1oz/hbXA=
Content-Language: en-il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert, 
I'm sorry for notifying just now, but this patch set should be applies on top of
"crypto: ccree: add CryptoCell 713 baseline support" patch set by Gilad Ben-Yossef
Hence failures reported by kbuild test robot .

> -----Original Message-----
> From: Gilad Ben-Yossef <gilad@benyossef.com>
> Sent: Thursday, 18 October 2018 16:26
> To: yaeceh01 <yael.chemla@foss.arm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; David Miller
> <davem@davemloft.net>; Linux Crypto Mailing List <linux-
> crypto@vger.kernel.org>; Ofir Drang <ofir.drang@arm.com>; Linux kernel
> mailing list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 0/3] crypto: ccree: add SM3 support
> 
> On Thu, Oct 18, 2018 at 4:00 PM Yael Chemla <yael.chemla@foss.arm.com>
> wrote:
> >
> > Add support for SM3 in CryptoCell 713.
> >
> > Yael Chemla (3):
> >   crypto: ccree: adjust hash length to suit certain context specifics
> >   crypto: ccree:  modify set_cipher_mode usage from cc_hash
> >   crypto: ccree: add SM3 support
> >
> >  drivers/crypto/Kconfig                  |   1 +
> >  drivers/crypto/ccree/cc_aead.c          |  19 +++-
> >  drivers/crypto/ccree/cc_crypto_ctx.h    |   4 +-
> >  drivers/crypto/ccree/cc_driver.c        |  10 +-
> >  drivers/crypto/ccree/cc_driver.h        |   2 +-
> >  drivers/crypto/ccree/cc_hash.c          | 175 +++++++++++++++++++++++------
> ---
> >  drivers/crypto/ccree/cc_hw_queue_defs.h |  27 +++++
> >  7 files changed, 182 insertions(+), 56 deletions(-)
> >
> > --
> > 2.7.4
> >
> 
> Herbert, these go on top of my own previous patch set that adds the
> CryptoCell 713 and its SM4 cipher support.
> 
> Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>
> 
> Thanks,
> Gilad
> 
> --
> Gilad Ben-Yossef
> Chief Coffee Drinker
> 
> values of β will give rise to dom!

