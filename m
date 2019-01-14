Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F97nyTRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfANCgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:36:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43777 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfANCgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:36:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so17623762lji.10;
        Sun, 13 Jan 2019 18:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9HbW6BA0ESYfJXYk+hs76hK+0F/mQba/nCWS8F5gOk=;
        b=F97nyTRV96AXjZJgYAi6rnYQRWZTs7Ly0reFfrhHuf82502Az13vlpM8e7ckptfTbX
         ALneGcKJguc92kr2cvS8tPBB478EPd4ToSKEyFShoyx9TuVZf0hWAdAVteDKCTolV1Zc
         3zPrvjcOeV0dcskN6AoiDeGMC16u72eKUsz+vvBoRLp8IwD3eCLqmayReXCoNK2HUgTU
         9ckKc4n+JUoU+nBIGZQZXTZXDzVvv+XspQ/NFf8MJyFbYIK8dNCMH1GV47ZYvFMAAeHi
         Qs0QnhPIvuuPBMu8KZysj26FwD3kga6cU2GuKmbbfJeJWwSLTsOlxFI8GYogbpaYGV3f
         CMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9HbW6BA0ESYfJXYk+hs76hK+0F/mQba/nCWS8F5gOk=;
        b=VjR5Pi85tkS2mR3TZt3y8MJEFk+CoNX9YD4sWW01aO+l6MPaEZZeH+EYTHVG/LA5Mh
         zT8X5gQyIyb2ulGgOG/ElW7npc+Dl9PVsdSELxkc9YUeixWSkIW+rNo83jgUFr58y5HK
         FtPF0BPQ+zpwgnCSKUrRoMSNKxhELoAMWMOYMPYiVgbkXcNVEL1gxxoPQAZ4eODkAK7U
         ykt3xr35q+yY/7w8vnepw1Gk9DUwJzEtmmGX5kQwH1y8Eq8anKGTLKW6QOZz24TKW5S6
         qRERaw9aPJETQi/QjrbPHDSI6Oi/9ugJYR1rkJe0xDiRq9j0+9ckQdTuRzPMIkFa9fBO
         mCjA==
X-Gm-Message-State: AJcUukfcda1yhTq606SNVDFeb03gvOz3D14031pbWqBrNOMDhr0XoY52
        yOEUv0x41xaQgKDs9k0VRApdZABS6WDBMg==
X-Google-Smtp-Source: ALg8bN7sdI+3uKtRPQthKsvaY7rmEDNMJwj/8+Gp3vcidqQ9iflwRll8Mk1h+zTgSPP8xvYgjy79hg==
X-Received: by 2002:a2e:561d:: with SMTP id k29-v6mr9021370ljb.91.1547433396119;
        Sun, 13 Jan 2019 18:36:36 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id m4-v6sm16876897ljb.58.2019.01.13.18.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 18:36:35 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-watchdog@vger.kernel.org, mironov.ivan@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 3/4] watchdog: hpwdt: Add more information into message
Date:   Mon, 14 Jan 2019 07:36:16 +0500
Message-Id: <20190114023617.10656-4-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114023617.10656-1-mironov.ivan@gmail.com>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default NMI handling code prints the same into the kernel log.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/watchdog/hpwdt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e2958df46c69..95d002b5b120 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -155,19 +155,20 @@ static int hpwdt_my_nmi(void)
 static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 {
 	unsigned int mynmi = hpwdt_my_nmi();
-	static char panic_msg[] =
-		"00: An NMI occurred. Depending on your system the reason "
-		"for the NMI is logged in any one of the following resources:\n"
-		"1. Integrated Management Log (IML)\n"
-		"2. OA Syslog\n"
-		"3. OA Forward Progress Log\n"
-		"4. iLO Event Log";
 
 	if (!mynmi)
 		return NMI_DONE;
 
-	hex_byte_pack(panic_msg, mynmi);
-	nmi_panic(regs, panic_msg);
+	pr_emerg("%02x: An NMI occurred (reason %02x, CPU %d). Depending on "
+		 "your system the reason for the NMI is logged in any one of "
+		 "the following resources:\n"
+		 "1. Integrated Management Log (IML)\n"
+		 "2. OA Syslog\n"
+		 "3. OA Forward Progress Log\n"
+		 "4. iLO Event Log\n",
+		 mynmi, ulReason, smp_processor_id());
+
+	nmi_panic(regs, "hpwdt: NMI: Not continuing");
 
 	return NMI_HANDLED;
 }
-- 
2.20.1

