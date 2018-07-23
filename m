Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D420874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4PZRPIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbeGWIZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:25:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40700 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387943AbeGWIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:25:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so11615950pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ahe6q9GAkvTIeYQHIUTF7j3aUxuQhtLx13Ct+dggzA8=;
        b=V4PZRPIE5iIlBKNPo7fkfryra3tz+MSYTkQKglle3yUek1mGCRRJq31MGy+Q4vcnd8
         BEeEzC3YIl88+axtcX6JTS4WoHutUO8vtlkLMxQ+SDU5V/iyqJ4oM15zaPv7NXwx0lct
         xZgQKmc8DB+Ny98GIwwhNiwj1TgfrqP2VWsBCTB20qJulVmPOhPskJUeoED0tXMqgMhA
         cN+gbTOcOOPEaos5F+oZ2bykC8Q604klLY/dJR3gKmEEcNYICrnr6vRDY9OVViQBJOHk
         TaJbzHOZerVvE3GP6/RodLDullZTQ+LexLyW+PNONXChzk0Pihg0GQRcNykX/dGX7A74
         5QxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ahe6q9GAkvTIeYQHIUTF7j3aUxuQhtLx13Ct+dggzA8=;
        b=cO8bbaN5Gnf+rd98UO9H9tF9cLYeVFgsz0E55xmgmqyrml806cOkjtGLz4smGhjnZo
         YQCG9/BFX5z5Jiwc8EnMwvKEv97cNGUMoZVqILpS47Gi+8jWnexDq1SOynbwNCSjo8sA
         qitUH3JsPYVg2LeklprqNaOpRp+m6cu6HW/R3MCGaFzaDTk3Xg9zhZcDC2nAHM4pAehH
         YNbIFCKTd+IkeVUTegZ6tPr1caNePiq3vp1kLXba5vLE3pXvz8vffTb5pEtjGd6Zntzh
         RJMlR9FY0ecHKBoUyIA5avCdYAn8dhISwckkwWTllpETEzJNEvU39QoBctvs+mOxoSbQ
         BOCw==
X-Gm-Message-State: AOUpUlEci9lHux8JnZunsCKzv4QEHZMdh7Gff1VrPgJPpUM57EGtCM0b
        DoKdNInmjYPCcNfaaGHO4vCvze43MfU=
X-Google-Smtp-Source: AAOMgpc7Ifkrucf+BMq/ObmkFFbcNi+dIMvdJiLHfkTwGS4Evreff+vWoVvPJ8S72R1krsux3+URQA==
X-Received: by 2002:a63:6383:: with SMTP id x125-v6mr11197686pgb.127.1532330743506;
        Mon, 23 Jul 2018 00:25:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-162-147-103.hsd1.ca.comcast.net. [73.162.147.103])
        by smtp.gmail.com with ESMTPSA id h190-v6sm16413880pge.85.2018.07.23.00.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 00:25:42 -0700 (PDT)
From:   yuleopen@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     yuleopen@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
Date:   Mon, 23 Jul 2018 00:25:34 -0700
Message-Id: <20180723072536.39240-1-yuleopen@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Wang <yuleopen@gmail.com>

Signed-off-by: Yue Wang <yuleopen@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc02767f..c51e2dee3075 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1374,6 +1374,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
-- 
2.17.0.441.gb46fe60e1d-goog

