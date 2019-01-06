Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF7BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BBF20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S1Lc3Yr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfAFRCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 12:02:00 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57916 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAFRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 12:02:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 5E742B06
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 17:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f5wqYRO2MpUJ for <linux-kernel@vger.kernel.org>;
        Sun,  6 Jan 2019 11:01:58 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 2BEA1B02
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jan 2019 11:01:58 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id w15so6325981ita.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 09:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B+Eu6br2anEg0uz0v66G4VjCENoORD4RL12IG6pO+WE=;
        b=S1Lc3Yr25ml1Izd7Svumf4Z9HFupK8cPV2OtWON/9UUMAd+oSlaQbdQnIvb8Uy6WEo
         ilFakMFv3hLWUAY7gwuSSCcFlkJXwvrjqlCHMWFk64fVhpc/JotRJL7hkjxScjbpp5gb
         aH2f5YCcYTd6QoNS2ids3hYX7imBakCyEPXe+Ib2WqGVD3tFNpbTZRPeckAmaKqKTana
         c8AVstEGuBFDRU5v51pFTrmcuQ/nzXG7T835Xiev4GSC5/s5n91Xj6sRtsPJesHrQABB
         LMQnGt1cIHb5louKrMpuu9vE+SSqgw1lF3mlEe2wFfZ+J0AmMqo8S4xx08Lw0eimqn1t
         R4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B+Eu6br2anEg0uz0v66G4VjCENoORD4RL12IG6pO+WE=;
        b=ij6bK/WkyMA6zt7z1AQW3aJAQvx4n4NQiRuUCa4pLp/OySbC5Cw8Op65k7+YtASq4/
         XoYI+6Yn4VolIeuWpIiN0T1cLalfy4ehktNFoVoSL5+B8j8vXdlQBaA2cCxc+MUntgwR
         GVfUfFhrSjlVFyp9vScHjSrGoqNFbvsTiCnlUuolxD2AEf+F9pdEkxl1unwwafJfv6+v
         1KGhb1YpXxqGEH/smyRqmAKh2E2UvY38TLCWwvQ59QUI0Bg1TbW4aDFG43dQBDhZbKOm
         jYGdaD5ZxtflMmsNqEppHdp3esm1DRiKys0PJzOlHbrqx13kB/NLwHQp7lfIJaQbGNgz
         erhQ==
X-Gm-Message-State: AJcUukccl7daJsJmhQtTrljYs8bBf5gkI7EpLM+wFJJB3WXZzBNWjNL+
        fXpdsGtq0NNn/lbMEFJhSxzdSwCOw5dO7OR+BKGnfNvVqEjFXBUl+kDdYGwb9YCA6Wr72pxosfm
        zUv4r8M+vtRXbGkdZC1UnVu9nyumM
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr42057785ior.217.1546794117174;
        Sun, 06 Jan 2019 09:01:57 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5EOiElLENaKyEpvPX/S0esPwLM40YvSNbENG3eVMWcMNVS/qUVETqHe0teyzVIKh6uMaowOA==
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr42057770ior.217.1546794116887;
        Sun, 06 Jan 2019 09:01:56 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m2sm26420293iol.75.2019.01.06.09.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 09:01:56 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ALSA: line6: fix check on snd_card_register
Date:   Sun,  6 Jan 2019 11:01:47 -0600
Message-Id: <20190106170148.9938-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix checks if snd_card_register() fails, and if so logs the error
via dev_err() consistent with other patches.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 sound/usb/line6/pod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 020c81818951..ce45b6dab651 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -320,7 +320,8 @@ static void pod_startup4(struct work_struct *work)
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
 
 	/* ALSA audio interface: */
-	snd_card_register(line6->card);
+	if (snd_card_register(line6->card))
+		dev_err(line6->ifcdev, "Failed to register POD card.\n");
 }
 
 /* POD special files: */
-- 
2.17.1

