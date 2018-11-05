Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BF820831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BF820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeKEQtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:49:39 -0500
Received: from shell.v3.sk ([90.176.6.54]:49512 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeKEQti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:49:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A613BC5591;
        Mon,  5 Nov 2018 08:31:16 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wqKrtSllIZTM; Mon,  5 Nov 2018 08:31:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9132FC551C;
        Mon,  5 Nov 2018 08:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X9Yi3oib4QED; Mon,  5 Nov 2018 08:31:03 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B644BC5582;
        Mon,  5 Nov 2018 08:31:02 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 01/11] media: ov7670: hook s_power onto v4l2 core
Date:   Mon,  5 Nov 2018 08:30:44 +0100
Message-Id: <20181105073054.24407-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105073054.24407-1-lkundrak@v3.sk>
References: <20181105073054.24407-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 71862f63f351 ("media: ov7670: Add the ov7670_s_power function"=
)
added a s_power function. For some reason it didn't register it with v4l2=
,
only uses it internally. Fix this now.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/media/i2c/ov7670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index bc68a3a5b4ec..d87f2362bf40 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1651,6 +1651,7 @@ static int ov7670_open(struct v4l2_subdev *sd, stru=
ct v4l2_subdev_fh *fh)
 static const struct v4l2_subdev_core_ops ov7670_core_ops =3D {
 	.reset =3D ov7670_reset,
 	.init =3D ov7670_init,
+	.s_power =3D ov7670_s_power,
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	.g_register =3D ov7670_g_register,
 	.s_register =3D ov7670_s_register,
--=20
2.19.1

