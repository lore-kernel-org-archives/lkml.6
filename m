Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4266BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF9E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9wVJrWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfAaLbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:31:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34173 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:31:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so1355494pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 03:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNv0JE5CSLKIeFOycq0zQ7rCCuMx/vP5u62Spz1WZpo=;
        b=B9wVJrWSpUNbwX2aX3zZJEL/FwY2mObzsYPNRzUXRp9CpjUOrJ6N8GaPTNtgM1VtSk
         vWFNdkhBK+sHlSk/hKNZeR7c1BCdVdx0by05kM2J4l0hv8//OcwKlLd+/qA+Dt+yHN5+
         ZOggw4DfDqLbNt+RB0CTCHVRbOtnrKqz9lH3XGBpRJQoZJCvQbnFPwY9p1ukRxU2/dLG
         6F4y1rhKTaBo55Ph31kzVikGmgzhjLNJgOSlY215g32u13zy9DylCAH323NjmRlfuVEo
         Rxqpi6S/U6nNYpTJjUDI+I2MbaK2URGflc5vnBT2k+7A3AjfIEgaDQSwH6xZWsReUu7T
         +0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNv0JE5CSLKIeFOycq0zQ7rCCuMx/vP5u62Spz1WZpo=;
        b=Jwm0PyH772lyiHd8YYCgreexA/YJkmSUjPEWTyLfakOjmRpCjJEjxx8NgFKF3pYIxJ
         iS5Ji6zEMHvy5e7eIxm/34a6BBHRzKS2fxPf9G8AqH7cmfBiuz6/cnFjwm0yZXzKTIJ3
         /IYmFk7nNUCmnJ9IKSeKp3Rz3mBCIXRmlWsbDbuFI5N3vG/js4Par4tPF5zFFTdP+39e
         b/ErYVPIV7msMqXagXM3HacEH+xMqgGe62DFK9b0+wrs66DFTHKhZjTwwfMh2nFYzuoy
         XYXzZHxWN6nWAdyCwl1+mnTuRoI+Aascq+fF3LMVtSvHqs3aZJezFJ+dnKQfmx/l4dMs
         P+Cg==
X-Gm-Message-State: AJcUukeegXVkWnfkjcmdHkvFqYLpKBcblPkjoEgzRf39xCw5dISG6go2
        a+hwqDQuhCTyQs6Hsj1Hyk0=
X-Google-Smtp-Source: ALg8bN7fXHugPq3Q5GmDUhcft1fN6K1sbK+N8xI5VBosxINFfXrZEngaABUnQxXbABT2Yvevg3paeQ==
X-Received: by 2002:a63:5a57:: with SMTP id k23mr30922002pgm.5.1548934263000;
        Thu, 31 Jan 2019 03:31:03 -0800 (PST)
Received: from localhost.localdomain ([183.207.178.209])
        by smtp.gmail.com with ESMTPSA id g190sm5635313pgc.28.2019.01.31.03.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 03:31:02 -0800 (PST)
From:   Zhiwei Jiang <qq282012236@gmail.com>
To:     qq282012236@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dapm: Add warnings for widget overwrite when adding route
Date:   Thu, 31 Jan 2019 19:30:05 +0800
Message-Id: <20190131113005.13380-1-qq282012236@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in some complex cases, more than one widgets have same
name and registed from differnt dapm context, and route add from
another context too. When snd_soc_dapm_add_route, the previous
registered widget will overwritten by the latest same name widget,
will cause unexpect error. For Asoc framework we cant avoid this
situation and we cant decide which widget that wanted with route.
At least we can give users a notice.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
---
 sound/soc/soc-dapm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..af45ffcf712d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2741,6 +2741,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_sink[80];
 	char prefixed_source[80];
 	const char *prefix;
+	unsigned int sink_ref = 0;
+	unsigned int source_ref = 0;
 	int ret;
 
 	prefix = soc_dapm_prefix(dapm);
@@ -2774,6 +2776,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsource)
 					break;
 			}
+			sink_ref++;
+			if (sink_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: sink widget %s overwritten\n",
+					w->name);
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
@@ -2783,6 +2790,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsink)
 					break;
 			}
+			source_ref++;
+			if (source_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: source widget %s overwritten\n",
+					w->name);
 		}
 	}
 	/* use widget from another DAPM context if not found from this */
-- 
2.19.0

