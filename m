Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YbhbGBsuHls3VAAAmS7hNA
	; Mon, 11 Jun 2018 08:08:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4B472607BB; Mon, 11 Jun 2018 08:08:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVEF33G1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3800605A5;
	Mon, 11 Jun 2018 08:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3800605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeFKII4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:08:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36272 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeFKIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:08:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id a12-v6so9817962pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K3kACUPAfqbxZzulW9WPncbnq99w+I0nZ59lhPVqKyg=;
        b=QVEF33G1G6eAUeWOdxXm+hBVSzMu70QPUIiU02l5K+WSiI2Lv+CaddcKpZWMY4W3oH
         M27flgeEblO0eI1jQ4fBzQxSbvLXe0BpZovYsQP4bgUiiq/vg9hVd28abEKAqNXgYHys
         IMzIp5se+24J/yw+3jYALLuplugRmPspffJ74WOwbzljJrEs7cJ+9AnB8x+GGe3Z812v
         knl0J5GTFEjvjcqnli4PkprErYDC8mrMIU6Pqd2RJbWNEZ6tEBU/xcwnWzkKS63VUEWa
         X/C9BBt7NBn1FQIVtUA9rHCx8TvSwbPbe7wJW9/vs8/VhCBH0yxZsNEDWR+2cN+P1u5i
         fk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K3kACUPAfqbxZzulW9WPncbnq99w+I0nZ59lhPVqKyg=;
        b=PAFEzpjWh4MaGDsetG/VQl8v72E/TTkGr8OVnzQAyMFYt5bV4Ztr0b82OXhZ8KZXin
         NQ/ka4R6oR7p/tZiCxoFIq8HxG3HmA+Br8DJ/oSj1l1OY/XZhzthOKcKVkJVyZy3iZuH
         CpR4qJIwNZne5oK6tItznsJ9FA1TF+/qfew6JFcSJKuYjRA1cyLBBwFzAnDzkvLNusvo
         kT8EDDvHrz6BG9ltr0hut6oA2e46ynNjOVNBb8r7TTovtLek61Wg4Im1e9y+9eRLyZiT
         FjEH+/ol8bikIRdVRO2RASXYVEjbH8PESAqPSLkU9waMM2wfSLglDh80vS/kxLfnTeNS
         UGFw==
X-Gm-Message-State: APt69E3ZSbSyiG7Y7O7wRQk9I4K1GA7SKmLnFlx/PCJspbbgskhhSawU
        lMPMBZYQPcqm5Lt41niH30ys0rSTeY8=
X-Google-Smtp-Source: ADUXVKJHEUwuN1kD543gILpT1A+Lf7rsQBb3Z0XqNmhKxNjs1USYqZ51D9x3DkbMIh70qsYgMnoRRA==
X-Received: by 2002:a63:86c8:: with SMTP id x191-v6mr13563799pgd.2.1528704533184;
        Mon, 11 Jun 2018 01:08:53 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id m5-v6sm108887977pfa.93.2018.06.11.01.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:08:52 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sonicvibes: add error handling for snd_ctl_add
Date: Mon, 11 Jun 2018 16:08:40 +0800
Message-Id: <1528704521-34060-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/sonicvibes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index a8abb15..57cb77a 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1188,6 +1188,7 @@ SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 {
 	struct gameport *gp;
+	int err;
 
 	sonic->gameport = gp = gameport_allocate_port();
 	if (!gp) {
@@ -1203,7 +1204,10 @@ static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
 
 	gameport_register_port(gp);
 
-	snd_ctl_add(sonic->card, snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	err = snd_ctl_add(sonic->card,
+		snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
2.7.4
