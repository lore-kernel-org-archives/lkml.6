Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F73C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4JP3Ikb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC9E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbeKTDMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbeKTDMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:12:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CB920823;
        Mon, 19 Nov 2018 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646119;
        bh=gKtmFena5YlXchas9w3gns4rtIsi6/qJHXwltuYxwjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4JP3Ikbi+Ri2lkfXcKU63x4I1n8v1F+6B8tYXPYm/iO5P8gAvW6XxaKzOY7MY44g
         8+pZvFQOfl+OZZeuz0L8H/jyce+Jx+HvnF6w1Vf+VlCQeb4DIZH7OQ4C8vcQr8acnl
         Q8i/BQZzuV6vtqqbd8MNMKL81cVeQV4sRNSr9L2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 044/124] clk: mvebu: use correct bit for 98DX3236 NAND
Date:   Mon, 19 Nov 2018 17:28:18 +0100
Message-Id: <20181119162622.218313680@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

commit 00c5a926af12a9f0236928dab3dc9faf621406a1 upstream.

The correct fieldbit value for the NAND PLL reload trigger is 27.

Fixes: commit e120c17a70e5 ("clk: mvebu: support for 98DX3236 SoC")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/clk-corediv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -72,7 +72,7 @@ static const struct clk_corediv_desc mve
 };
 
 static const struct clk_corediv_desc mv98dx3236_corediv_desc[] = {
-	{ .mask = 0x0f, .offset = 6, .fieldbit = 26 }, /* NAND clock */
+	{ .mask = 0x0f, .offset = 6, .fieldbit = 27 }, /* NAND clock */
 };
 
 #define to_corediv_clk(p) container_of(p, struct clk_corediv, hw)


