Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ECFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A50321726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MNdJOeH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbeLZBlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:41:23 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:54752 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeLZBlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:41:23 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 73B21BCD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ic3Lz2uLvV7F for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:41:21 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 44F5BBC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:41:21 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id t133so17852799iof.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dmiemlAjIR5AeUuw0ROL1K9qk9Wk5AR25MevIiNZ/a8=;
        b=MNdJOeH6NfkjXhrh49nk5JnP8t/2qmequkIQ0xZEtbF6maZNr6y8g+szW1xJ20wL7/
         96Nn7iBsNvY8BWxU6P25yyitVzd+80BPUp6SQa363K/V4vxdK8w691HJ8GhqpnzHvsU+
         9pF7apXEk59wnHnAA8iOUr2jI3bTXsK9G1FgXxrVuY7L9m8pKkePCGcxCnydu1mMSssu
         YjKWONkrlawhQI/12ZFbfFpw8yaDOcyG1ZdpRrDzOtteO3Nz54GyALDY0outuCxMYByp
         AOusbLpgogmq7g/EPyTjq7x4Ojvvu27MgNgCZZUjrme/MXu2JSKntijZurdSzxOlp0a/
         kALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dmiemlAjIR5AeUuw0ROL1K9qk9Wk5AR25MevIiNZ/a8=;
        b=q2MWg1/YHvlvjYdNG43H70Mzn/tszj1DGDuijqNi8nGq/+80ocnE/Yzhrl0eszu0db
         /oCdlTbnKbDKN6Njjz7tjNv9wbo35AYlmQU/o4bvqvKTSTvRoDDmzdk8wzDhIKDNENaf
         zfbP9XbzzrTA8bBjBRKh/ZEAuSKzQhoMW8Bijg+rxaWi9wbiK/QLq4+uNJZX7KevaoRQ
         DgTgCtRbWEBWzLsZPfUbO6IZjAeQb/zXsrEJCV2JJ69GceqLcfyh0fzxigzIGaKG/Bhh
         ZyxWshljqpL0btXuG0yyRjp5VdFWI1aFDvNGmInUekiL9Ai1hCdKpMCRK/k1BhgEprxp
         QzNA==
X-Gm-Message-State: AA+aEWYEJUrV1lB5Nl+N0984RCwjamXlWf+iLXUdcPdg6rMMKzPU345g
        sv7sB0tErLNH7ch0LeSjLNPZ3aT7WvJxb755I4swx6T7p9sdDS4p/TyleYhkq3ApBPoPrVmQ7Hn
        BqwN9CnZCX7iDdIHVGcHHbgz9AFI3
X-Received: by 2002:a02:734b:: with SMTP id a11mr10997079jae.62.1545788480892;
        Tue, 25 Dec 2018 17:41:20 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Vw539rHr0Z3Bg3+c64+Wo+WfIfJlNX6Ii2vUjOTHJ9iJ5pwhQwfI+K2RuTbwgFKeLr7wO97Q==
X-Received: by 2002:a02:734b:: with SMTP id a11mr10997074jae.62.1545788480658;
        Tue, 25 Dec 2018 17:41:20 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 18sm12177127itk.28.2018.12.25.17.41.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:41:19 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gus: add a check of the status of snd_ctl_add
Date:   Tue, 25 Dec 2018 19:40:51 -0600
Message-Id: <20181226014052.70937-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_ctl_add() could fail, so let's check its status and issue an error
message if it indeed fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/isa/gus/gus_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 3b8a0c880db5..33c8b66d5c8a 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -92,8 +92,17 @@ static const struct snd_kcontrol_new snd_gus_joystick_control = {
 
 static void snd_gus_init_control(struct snd_gus_card *gus)
 {
-	if (!gus->ace_flag)
-		snd_ctl_add(gus->card, snd_ctl_new1(&snd_gus_joystick_control, gus));
+	int ret;
+
+	if (!gus->ace_flag) {
+		ret =
+			snd_ctl_add(gus->card,
+					snd_ctl_new1(&snd_gus_joystick_control,
+						gus));
+		if (ret)
+			snd_printk(KERN_ERR "gus: snd_ctl_add failed: %d\n",
+					ret);
+	}
 }
 
 /*
-- 
2.17.2 (Apple Git-113)

