Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E58C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994EA2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fNsMKOos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLZDkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:40:03 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44912 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLZDkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:40:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 7B7C9B60
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mayJGUflLeOi for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:40:01 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4370B9D7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:40:01 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id m12so16996055ioc.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MF2aaqAoo2govJRDtQGXINO+TRQ79vguhs6ICRS23Rc=;
        b=fNsMKOosCs+SBExfdWnGXJ8TS9ZN7zizmEZ+/33l+k0IAirRK5/AZeZIhgy6XCpXzR
         l5ATKA/ycRR6YnWtpUva8XaMH1CF6B14gD9bekCdmBtVEHXPSdC9tu51PzAQ2xx1Arjd
         r5AFxdwAIoied8apg8o1+iI1IU5BRWsvTIYP2/R5m1kzoXqSwyiKiqwKP19pUEb/3T22
         +JNivygRpOwHOhD1zzKgBG/zlZRsYrj30WV8Uu6ta8wsCaHZodpBTPXc4QSXTiuiJQCe
         apysSVDdxoRUlOXRbxLa1wP/n7BA7HeOdY2s1VEnyEYwJvJ++KtQEEoowsrvjpLhmUtz
         DKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MF2aaqAoo2govJRDtQGXINO+TRQ79vguhs6ICRS23Rc=;
        b=gM8k4d9htdrWT9TD0TwUvFmHBDHRdoIdbbDvzscwcgYYiNDajAYM8Ryx4iJ0O194+F
         wLlBqewVRmBM0Cvz7AJUKJTtmwhXfdGBF1IwXBaCHphsCbQUejVXfTlAshDtgljeD/ea
         2huy/xGt7z5ywwcHqNOiHJlv5ZgNmtgyLY0JiML5yd1J30azMz4w+2f1WZCz7UGvg7p+
         gC5ZGspfc58qEt7nI3wR4js7qLedjEB8MA5dLWn26/g+/P4z2T0t2vYnO4wee9xTW2oW
         tOUBFzWTX7oWWjK3khY0qh9OvcsW7heMPeRBrmiF/vtOnJcDLDubBc4MdTs5k5AG5vVj
         PQ8Q==
X-Gm-Message-State: AA+aEWaSICGBgUttyedazCbsCtBSSBcxl9GP2sLHC2IHX+VT7B9zWQT5
        DW4m5XqTsRZdBN+Bx2VqAby2EXgfUK+wnV7t091T3pHio4IaKAL6+FDS0zPPVr/vrDK3vqsJRYs
        cLmYRIWDuOX8nueYeb2RAV62L+r3I
X-Received: by 2002:a24:1c86:: with SMTP id c128mr11654497itc.58.1545795600347;
        Tue, 25 Dec 2018 19:40:00 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WofrHbYCJeYFFqptDzQQNdfil6ZHFWEfGy+YbwlgF4XKbAYUTV+nfpaGzvoikxVtz6LkJCyQ==
X-Received: by 2002:a24:1c86:: with SMTP id c128mr11654491itc.58.1545795600106;
        Tue, 25 Dec 2018 19:40:00 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id e22sm15373844iod.47.2018.12.25.19.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:39:59 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] line6: add a  check for snd_card_register
Date:   Tue, 25 Dec 2018 21:39:31 -0600
Message-Id: <20181226033933.73306-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix checks if snd_card_register() fails, and if so, issues a
warning.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/usb/line6/pod.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 020c81818951..da8837bc5a5b 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -320,7 +320,8 @@ static void pod_startup4(struct work_struct *work)
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
 
 	/* ALSA audio interface: */
-	snd_card_register(line6->card);
+	if (snd_card_register(line6->card))
+		pr_warn("Failed to register ALSA card.\n");
 }
 
 /* POD special files: */
-- 
2.17.2 (Apple Git-113)

