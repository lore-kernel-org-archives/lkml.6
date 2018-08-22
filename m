Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C24C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDEB217C9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAZPdSEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDEB217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeHVEp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:45:28 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35731 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHVEp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:45:28 -0400
Received: by mail-qt0-f195.google.com with SMTP id r21-v6so401596qtm.2;
        Tue, 21 Aug 2018 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=6SNHI51KRZzTDYcnMavTDihqimSyreFwEOe0orhx+VI=;
        b=mAZPdSEruGbX6BAGx9oB0ByyNi3/kho0SrNSCNWoX01aap71epmQP4aTVtIY64caWx
         OrJ0XoIvICmoV34LFBpjGdxqhwkzur+aS5PgsTrbjHYZhhNnKMZatu1eXphPU1csgqaO
         nC/Qz5bbuvD0iCFSfOMAJoadvHQ29BWuYdLOmW7e8A+e7jfhrN4hJt/y4SHij5ZiXrKF
         ezdV5yT4oPeg+KCYci4siEWKBO+u6Oy/XtoNX0b0AdwqmqOBWC7pzsNcFXYJGDr0TaLe
         zny9UReqoSlshUfzQjdDhbyExNZTjcF4qDcSzWd9WNehKjTRIQneK87KMzFzM+dmeVTr
         GAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6SNHI51KRZzTDYcnMavTDihqimSyreFwEOe0orhx+VI=;
        b=bZNRo09feGyeQz3VDWkovY1UtmDxM/3cL/i3+truADb4oCp3E6HhDQbOYfFKdyDVj4
         hPjwBzqlJ0ZrHPxODSR2BmJswcRk+RDaRi0Ouz9im6E/IxGgx3L30on2IZTFUO8AJTS6
         z1rkuYtfgmsYc0RSrD9dQiNF4yBJkHHh7Eh8acFQLaR9DVS633M3zzeNG6/iXjlOQEEp
         AYPSVNHDt+AitOwA5opkk5aMI8QvPQ/jm9OAcIdE7AuIF0cvY/tu37DZ+W3uvDxOXTFH
         TjsM38vXsFhzprYy6j3/xXbz7sxGSnq0Oo0UN3FGpMEH4H6VDkgK1CqZ2poUZkoMyOdu
         F2GQ==
X-Gm-Message-State: APzg51AtqJi0JjYKiTs0oObkYTiSaygbN0+zoGtu/heeMTq7LLJ82vQe
        LKiykLboHZ4qwTXVtMoKHTg=
X-Google-Smtp-Source: AA+uWPzUik9i1+8Mk1FqwksFnRqiIrtT76w8PtW3rLwA9ePr+jnvNvQyyH8SQwflkYe+obk6+bt9mw==
X-Received: by 2002:ac8:4249:: with SMTP id r9-v6mr16577075qtm.262.1534900975942;
        Tue, 21 Aug 2018 18:22:55 -0700 (PDT)
Received: from gagoddess.ic.unicamp.br (wifi-177-220-84-180.wifi.ic.unicamp.br. [177.220.84.180])
        by smtp.gmail.com with ESMTPSA id a187-v6sm179479qkd.47.2018.08.21.18.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 18:22:55 -0700 (PDT)
From:   Guilherme Gallo <gagallo7@gmail.com>
To:     lkcamp@lists.libreplanetbr.org, helen.koike@collabora.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hverkuil@xs4all.nl
Subject: [PATCH] media: vimc: implement basic v4l2-ctrls
Date:   Tue, 21 Aug 2018 22:22:19 -0300
Message-Id: <20180822012219.22946-1-gagallo7@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement brightness, contrast and hue controls in vimc-sensor

Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>
---
 drivers/media/platform/vimc/vimc-sensor.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index 605e2a2d5dd5..ecc82cd60900 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -316,6 +316,15 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_VFLIP:
 		tpg_s_vflip(&vsen->tpg, ctrl->val);
 		break;
+	case V4L2_CID_BRIGHTNESS:
+		tpg_s_brightness(&vsen->tpg, ctrl->val);
+		break;
+	case V4L2_CID_CONTRAST:
+		tpg_s_contrast(&vsen->tpg, ctrl->val);
+		break;
+	case V4L2_CID_HUE:
+		tpg_s_hue(&vsen->tpg, ctrl->val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -377,6 +386,12 @@ static int vimc_sen_comp_bind(struct device *comp, struct device *master,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
 			  V4L2_CID_HFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_HUE, 0, 255, 1, 128);
 	vsen->sd.ctrl_handler = &vsen->hdl;
 	if (vsen->hdl.error) {
 		ret = vsen->hdl.error;
-- 
2.13.6

