Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F1DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1517B21A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1517B21A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeHKRkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 13:40:43 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:33187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727348AbeHKRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 13:40:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4418F837F24A;
        Sat, 11 Aug 2018 15:06:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tail16_8d54ac301ad15
X-Filterd-Recvd-Size: 1986
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Aug 2018 15:06:11 +0000 (UTC)
Message-ID: <2089960838bccf80f6fb9cc586b1a663f1f9e9da.camel@perches.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   Joe Perches <joe@perches.com>
To:     dgilbert@interlog.com, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, martin.petersen@oracle.com,
        david.darrington@wdc.com, jeff.furlong@wdc.com
Date:   Sat, 11 Aug 2018 08:06:10 -0700
In-Reply-To: <8e63583eb6898c3f481f1cb45b067234737a11b4.camel@perches.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
         <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com>
         <nycvar.YSQ.7.76.1808101601110.13885@knanqh.ubzr>
         <b3c86ddd67a73c09e09f3e51d7fc70036f00fb7b.camel@perches.com>
         <75d66dfa-688b-f941-04fd-5a39cf882b21@interlog.com>
         <8e63583eb6898c3f481f1cb45b067234737a11b4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-11 at 02:04 -0700, Joe Perches wrote:
> On Fri, 2018-08-10 at 22:39 -0400, Douglas Gilbert wrote:
> > but below is a copy and paste of a table 27 from draft SBC-4
> > revision 15 in chapter 4.22.4.4 on page 87.
> 
> The posted code returns the proper crc for each
> CONFIG_CRYPTO_CRCT10DIF_TABLE_SIZE value from
> 1 to 5 for these arrays.

Jeff, could you please test the suggested patch
with your comparison framework again with each
CONFIG_CRYPTO_CRCT10DIF_TABLE_SIZE from 1 to 5?

I get on a very limited test framework here:
(runtime average of 10 runs)

1: 4.32
2: 1.86
3: 1.31
4: 1.05
5: 0.99

