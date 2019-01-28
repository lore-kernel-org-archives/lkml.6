Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702F2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1302175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695130;
	bh=LF+0B3X4uux6QCNcCR/zdyodNfOcW0aujFiRzmTlBG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pG3kZ99IFDTIXxnIJAg1MtE1+SRvPGb5NK7SKE8v0fCKxj1+s6nBCEEKgYEglnjIC
	 Hhx4OYRnQLlkZNwf91QuEYObh/6+dty6B7gWFxeba4ltYsp9i9kJen2jUww8qThfoB
	 dumrvrGBY0cc5lK8P+G73MBINkci6mTeHKLrI+yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbfA1RFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbfA1QNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CB32147A;
        Mon, 28 Jan 2019 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692022;
        bh=LF+0B3X4uux6QCNcCR/zdyodNfOcW0aujFiRzmTlBG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVPauFC7ergGip1+Ywz2RM7QmPPdgl6WgJTTFdJOR30btVXW19AaswMX/JBegJVIB
         BC1K5cAn6HK4RnGjWtMKX/bHr5Rg/MKp5xOmHzGdP8b6LB4SiL2Wzq0KoL+/V2Ogiu
         JzW5ti1wsjsMXeIOeEgmTBkbsvmD95BSZ+Z8Qwu8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 041/170] iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID
Date:   Mon, 28 Jan 2019 11:09:51 -0500
Message-Id: <20190128161200.55107-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7f6232e69539971cf9eaed07a6c14ab4a2361133 ]

Various 2-in-1's use KIOX010A and KIOX020A as HIDs for 2 KXCJ91008
accelerometers. The KIOX010A HID is for the one in the base and the
KIOX020A for the accelerometer in the keyboard.

Since userspace does not have a way yet to deal with (or ignore) the
accelerometer in the keyboard, this commit just adds the KIOX010A HID
for now so that display rotation will work.

Related: https://github.com/hadess/iio-sensor-proxy/issues/166
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 3f968c46e667..784636800361 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1393,6 +1393,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1008", KXCJ91008},
 	{"KXCJ9000", KXCJ91008},
 	{"KIOX000A", KXCJ91008},
+	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
 	{"KXTJ1009", KXTJ21009},
 	{"SMO8500",  KXCJ91008},
 	{ },
-- 
2.19.1

