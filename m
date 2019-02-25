Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC0C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77092146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130177;
	bh=3Hi0azkIQXMQ3U6LNK72NFAnvR+qbzfUtLOnMjv6EMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lf5JQvODIgzE8JZhUUaSa8jjwVId8YRSoqajs3NsjAlyQYPylqANRSepZ/4RISC8n
	 PTfJ+wYldCwywrkTFpuJfJH/pze/cczm5KsmVBvWW+d4Z9CqQhwvzTrLg69+B+ZJja
	 Q6uXTO52IkKIdFtLKXjwL+VJQVp2QuTmkv3yPdGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfBYV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731714AbfBYV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBD12146F;
        Mon, 25 Feb 2019 21:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130167;
        bh=3Hi0azkIQXMQ3U6LNK72NFAnvR+qbzfUtLOnMjv6EMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SF/68s0/yPsjLdfPx7hQmuRSq7raJ90CVa/kzVRNAMLJxMHygCKVGGvP1AVXbUNAh
         Qlz5cs6vLeMLQN4l10vDu3fI9Ha8hrQTSZgbP883MmSAWOsqKbu4qtRJ/DyXIvITqh
         0twHJfUi/YWoYwhmZx6s7Yhye1b6kyhpRipYg22c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 036/183] mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove
Date:   Mon, 25 Feb 2019 22:10:09 +0100
Message-Id: <20190225195100.777409024@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 18e294ddafaeb80a1e2e10c9bd750a6cb8388d5b ]

The driver adds different MFD child devices via mfd_add_devices() and
hence it is required to call mfd_remove_devices() to remove MFD child
devices.

Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index b99a194ce5a4a..2d0fee488c5aa 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -499,6 +499,7 @@ static int ec_device_remove(struct platform_device *pdev)
 
 	cros_ec_debugfs_remove(ec);
 
+	mfd_remove_devices(ec->dev);
 	cdev_del(&ec->cdev);
 	device_unregister(&ec->class_dev);
 	return 0;
-- 
2.19.1



