Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F45C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD5E214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKgUb0nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD5E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeJICDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B615621479;
        Mon,  8 Oct 2018 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024593;
        bh=v0uSDY0aiH9rRGiekaKeCHuoAMyiAlcBBUFBwoeFmmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKgUb0ndZz1pGi5PcJvCPnScimO6/giNgtFtLu0oYUlWKsukQXbrD6Cu9GZ0diFoO
         6HUm1N5kWawMw+abkTxNgHJxda1Ab7J1jY4TnEw7ZkP7iiRhyWH8cSoLe8ON6jQiVm
         s0IU9UHK2KGCZFXSmHcBNuBG4WD/Nm/ACZSONH84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 067/168] nds32: add NULL entry to the end of_device_id array
Date:   Mon,  8 Oct 2018 20:30:47 +0200
Message-Id: <20181008175622.604229905@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 1944a50859ec2b570b42b459ac25d607fc7c31f0 ]

Make sure of_device_id tables are NULL terminated.
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/kernel/atl2c.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/nds32/kernel/atl2c.c
+++ b/arch/nds32/kernel/atl2c.c
@@ -9,7 +9,8 @@
 
 void __iomem *atl2c_base;
 static const struct of_device_id atl2c_ids[] __initconst = {
-	{.compatible = "andestech,atl2c",}
+	{.compatible = "andestech,atl2c",},
+	{}
 };
 
 static int __init atl2c_of_init(void)


