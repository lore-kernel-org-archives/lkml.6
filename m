Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E27C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A70E208E6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A70E208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFRNPD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:15:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36747 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933182AbeFRNPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:15:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 630C420798; Mon, 18 Jun 2018 15:15:00 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C72F20650;
        Mon, 18 Jun 2018 15:14:50 +0200 (CEST)
Date:   Mon, 18 Jun 2018 15:14:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180618151450.3e740270@xps13>
In-Reply-To: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, 18 Jun 2018 16:52:53 +1200, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> Hi,
> 
> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip
> to one of our boards which uses the Marvell NFCv2 controller.
> 
> This particular chip is a bit odd in that the datasheet states support
> for ONFI 1.0 but the revision number field is 00 00. It also is marked
> ABAFA but reports internally as ABAGA. Finally it has internal 8-bit ECC
> which cannot be disabled.

Boris and I agree that in this case, the chip should not be probed if
ecc->type != ON_DIE (and eventually NONE).

This should be handled in the Micron driver.

Also, what is the returned value of micron_supports_on_die_ecc() (with
patch 1/2)?

Regards,
Miquèl
