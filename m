Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9192120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547811827;
	bh=1rWIyOeVV4VcpL0e+/AT8D891MmJYlLZjBnUt/t3DsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:List-ID:From;
	b=h1vlDqRHi6NfaEiT0FosphT5h37LEPfyecABHAFMvIoPSPGb9JplLz64Cgx2PmoUr
	 AypYiWmkzPOqL9HYfBiaPBPPuqrSwEwAAV8HTnP7S+voBtVhZE7Fp6EXor11iUPrJI
	 z9RDzqC/Mi/w69YoANBaUm8SGogM9xJNmEjABx7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfARLnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfARLnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:43:45 -0500
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D952087E;
        Fri, 18 Jan 2019 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547811824;
        bh=1rWIyOeVV4VcpL0e+/AT8D891MmJYlLZjBnUt/t3DsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=J6gj4jCl8otaPSOuqb1S+1ULVlsEiE5pgsp+oRFKIe2cJ61amGosHSTxK2l0t4Lm1
         6CATmWfxODfWrEQ53/zRnGgwsKAX2AUVmHuKnjd8rY8J+AcQyupfpBMdKkh67a7cop
         4ES84zlOUUEORCvg4nqOv8aJ5mPH6uBz+FpoKAtw=
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        "linux-stable # v4 . 20" <stable@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: mtd: rawnand: denali: get ->setup_data_interface() working again
Date:   Fri, 18 Jan 2019 12:43:36 +0100
Message-Id: <20190118114336.21970-1-bbrezillon@kernel.org>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d311e0c27b8fcc27f707f8cac48cd8bdc4155224
In-Reply-To: <1547789438-11899-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 05:30:38 UTC, Masahiro Yamada wrote:
> Commit 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to
> nand_controller_ops") missed to invert the if-conditonal for denali.
> Since then, the Denali NAND driver cannnot invoke setup_data_interface.
> 
> Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> Cc: linux-stable <stable@vger.kernel.org> # v4.20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/fixes, thanks.

Boris
