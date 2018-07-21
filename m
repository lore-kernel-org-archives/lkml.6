Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCECECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3760C20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqUporAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3760C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeGUUEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35490 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1273590wmc.0;
        Sat, 21 Jul 2018 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4VpnKFelclX0L+FoN8Y1vffLYVvjqWXQc+YzeGv9LVc=;
        b=bqUporAVlBxRBSYi7r6TtsnQcAJaU+njB+W4uuonkT/jYOd7GpfbkHlaJ963DI0E3I
         km7ikReXskT753OYZym+k4cSO4DnI1WUdxC4IqtfJ0QL7Vrl8cipixdLwk6XflVacRWH
         07SEciW6r0U92neWi2hURVv1RvhH2Q2TQlFrOWPHXf95Kirtn3ooPGjaS3+yT4UsGoXp
         G4Tye+GfHJpoSaLvgo7tUI1lgkwoO8v5AxXpZXNr7EIRCh8AVuCvY0TyxhBMjjd+Xh6x
         B9HFy4ErcIWfqX3dG/hXQ+mfRBj6dMXyRe2b74HZv8EgYtUVD8/Y1p1Yj2sMPAZxLqZY
         5RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4VpnKFelclX0L+FoN8Y1vffLYVvjqWXQc+YzeGv9LVc=;
        b=l+gKFkhU9pntavUROLaPI6XsThYoHgF4EsfOw+1OpD391mn35dkqkCEyjfuS3bpwTs
         /c7w4yZz6MH76Y5VavK6/Murap+J8peNCGsxS78radsavsIABzviZRpAVQc6I0mOgJSR
         fzD6+FTKBMOTFYfqeKoKv62f/M6K/kpLSymnTs9J6G5sQRUjqv+65GcpRS2muLlFZMKu
         292USSdhJO2PmSLWigU3RmTYUBxVJoQvPyF1DOzBTEG+BtCtQKthr9NDjYykJA0p4giI
         ghfZlYEHv/0DMJDsubim7YrpWEgm9fBA6eKu0DByoAD6AUP9nnk2lN+unWBZaCVSWv+4
         PD2A==
X-Gm-Message-State: AOUpUlGHrxzYiJp+sH2OgEZ/nnFfk6kCeytZrLtS3jH9BXJ6vU4hPMOY
        ckiCuLuNsqtHGIoan2fo3js=
X-Google-Smtp-Source: AAOMgpcKepa9pi3fg+XalEmzifS8bsj6vATyGspVsuY8HkoNhS0hAnFY39aU65MfpBzXR1HOLCmK1g==
X-Received: by 2002:a1c:b84e:: with SMTP id i75-v6mr3872309wmf.158.1532200266631;
        Sat, 21 Jul 2018 12:11:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:11:06 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/11] touchscreen: sun4i_ts: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:50 +0530
Message-Id: <20180721191029.25658-9-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/sun4i-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9e5975..78960961a524 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -230,8 +230,8 @@ static ssize_t show_temp_label(struct device *dev,
 	return sprintf(buf, "SoC temperature\n");
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL);
+static DEVICE_ATTR(temp1_input, 0444, show_temp, NULL);
+static DEVICE_ATTR(temp1_label, 0444, show_temp_label, NULL);
 
 static struct attribute *sun4i_ts_attrs[] = {
 	&dev_attr_temp1_input.attr,
-- 
2.17.1

