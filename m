Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1867ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD7D2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD7D2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeIOWkz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 18:40:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36576 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbeIOWkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 18:40:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0EF6D20799; Sat, 15 Sep 2018 19:21:12 +0200 (CEST)
Received: from xps13 (84-112-184-8.cable.dynamic.surfer.at [84.112.184.8])
        by mail.bootlin.com (Postfix) with ESMTPSA id B0B9520741;
        Sat, 15 Sep 2018 19:21:11 +0200 (CEST)
Date:   Sat, 15 Sep 2018 19:21:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH AUTOSEL 4.18 10/92] mtd: rawnand: fscm: Avoid collision
 on PC def when compiling for MIPS
Message-ID: <20180915192111.59105520@xps13>
In-Reply-To: <20180915012944.179481-10-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
        <20180915012944.179481-10-alexander.levin@microsoft.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

Sasha Levin <Alexander.Levin@microsoft.com> wrote on Sat, 15 Sep 2018
01:29:55 +0000:

> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> [ Upstream commit 8f3931ed975e1d775b87ce85d65ecacd54138359 ]
> 
> We want to allow this driver to be selected when COMPILE_TEST=y, this
> means the driver can be compiled for any arch, including MIPS. When
> compiling this driver for MIPS, we end up with a collision on the 'PC'
> macro definition (also defined in arch/mips/include/asm/ptrace.h).
> 
> Prefix the fsmc one with FSMC_ to avoid this problem.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

I don't know what the exact policy is regarding backporting patches to
stable but this one, while harmless, will have no effect on
stable kernels AFAICT because it fixes issues discovered when allowing
COMPILE_TEST on a few drivers, which is a change that is not going to be
stable materials anyway.

Same situation for:
[PATCH AUTOSEL 4.18 11/92] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAGE_OP definition
[PATCH AUTOSEL 4.14 08/57] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAGE_OP definition
[PATCH AUTOSEL 4.9 04/34] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAGE_OP definition
[PATCH AUTOSEL 4.4 04/20] mtd: rawnand: sunxi: Add an U suffix to  NFC_PAGE_OP definition

Thanks,
Miquèl
