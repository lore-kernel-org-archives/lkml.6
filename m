Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADE4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676568;
	bh=3vNyvNmZGQoN/9Cz25hkAEyXM5zvPf8TRGZwFYqOOvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7m2/ToUTSlUuvGlZU753MNfLXZsaXYIPNSAN/uaddC5jhr9WAgKRr7umlit7STkS
	 dIc04Qs+suaNlwYh1MjL2Tw22UyBcS3ZeVSUpULnEeWmzaKYE6sdbAv9rY0qcLQv4l
	 m1o1BDzhNz7kinffTS5y5MexZej6E3gyw1GBvILk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD0F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeLMEt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbeLME34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60E5520873;
        Thu, 13 Dec 2018 04:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675396;
        bh=3vNyvNmZGQoN/9Cz25hkAEyXM5zvPf8TRGZwFYqOOvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2f83194uRdrAG6AdS2lEBp7R6EA5/3cb+9CK8Tc5uBbXq3IHhacxvJdQLz0vmIpCJ
         Ifwon0JHuRa5XrW4sHIdzV5BtWFqhLTUbfre4sDx3g4cOCLN0PSk6QhQ3MUE+tdeX7
         93nA8dEdWaKDZPEQ+vsfc6PnmWH+zvvxID+xW6pM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Teika Kazura <teika@gmx.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/73] Input: synaptics - enable SMBus for HP 15-ay000
Date:   Wed, 12 Dec 2018 23:28:04 -0500
Message-Id: <20181213042838.75160-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teika Kazura <teika@gmx.com>

[ Upstream commit 5a6dab15f7a79817cab4af612ddd99eda793fce6 ]

SMBus works fine for the touchpad with id SYN3221, used in the HP 15-ay000
series,

This device has been reported in these messages in the "linux-input"
mailing list:
* https://marc.info/?l=linux-input&m=152016683003369&w=2
* https://www.spinics.net/lists/linux-input/msg52525.html

Reported-by: Nitesh Debnath <niteshkd1999@gmail.com>
Reported-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c42813d50591..2bd5bb11c8ba 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -178,6 +178,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3221", /* HP 15-ay000 */
 	NULL
 };
 
-- 
2.19.1

