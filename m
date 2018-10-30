Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96910C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48720827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaHrOuNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F48720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeJ3WPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:15:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38440 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeJ3WPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:15:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id p7-v6so5548190plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZX25RBS0K0zGBNNwI85JRx7aiFM3svnHk/4qU82CIr4=;
        b=AaHrOuNjnMLy6zinBnhx5R3wWOognmxuVQjVyjSquApDYa594r635V5lLXGqQGdy5I
         GGnhQXKTpA5CCYKpJO4FsYR1mgH4PXTWH2nrcKn3CqosnemseNIn+xJIpNaxDf0oCvNz
         vm31b5e5R5wtTQXUlDfSB1qH5f0j24rBTxzQ/WD1lWD21mq9hr84myNyfIbCMUK9A2Mn
         Jrp2w7sjrDd68RR4QMwzZSmVxlMlC+SwIF9hMreSdx1nZxo4gs/RQkreUxUtaQgkX6fo
         wz2rJ0nbp1f/ss5C6B50i9fWGWax4Jrh+PTtkxQ6lGYQG8chzFKU2LohOSWY50RpzpEF
         66Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZX25RBS0K0zGBNNwI85JRx7aiFM3svnHk/4qU82CIr4=;
        b=SRwx0sFp8IRXOpQdJNMgB0Pcv/E7j1RhippT0XpcuFXXCkhC2ODOtc5taxXFlAkWKF
         aLxMMCUl4UkpKfTB2b4pCOZBzajQkeQ8wHKNWDB0jd0tBGFFIN1FpJxfHtqmc96xYRgU
         ABJqu2Tb2z8k5Pfc5jPUvWqVcikXpVKk7FDetc/7M1z1WXswOn7mH1TkuRLzcrVamyJA
         5NcrYXnLycWUFskkX7NomGpEZ/dGC2b7oMKOzDpF7+ZwvGF0PQ9ewthzsGDoM5OmX8tD
         lF9zSrIgSgJflTs1vgl48nMoBC3rOREUZOEqF+dTp/uJ8JYl7e+ha6TKvuPve6FuxKVP
         pBDQ==
X-Gm-Message-State: AGRZ1gJXcRLvQlmxLUhsWIXrVRU4DTYRgXbxs0P1S1Mx4EzoqMKhAQhz
        RwPQa1UbMaAHZm1YqJiJMBw=
X-Google-Smtp-Source: AJdET5eW+SZrYa+BrKRhEZ9hE6939oamm2r04ock8KPSG1UWi0DNBUWbSXTgrXImazZcQ1xdonlg7w==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3-v6mr18820570plq.287.1540905743465;
        Tue, 30 Oct 2018 06:22:23 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id b11-v6sm11765566pgi.10.2018.10.30.06.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 06:22:22 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     Bo YU <tsu.yubo@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: fix without checked-return value with lseek
Date:   Tue, 30 Oct 2018 09:21:55 -0400
Message-Id: <1540905715-4266-1-git-send-email-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lseek should have returned value but we miss it maybe.
This is detected by Coverity scan:
CID: 1440481

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 arch/powerpc/boot/addnote.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 9d9f6f334d3c..3da3e2b1b51b 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -223,7 +223,11 @@ main(int ac, char **av)
 	PUT_16(E_PHNUM, np + 2);
 
 	/* write back */
-	lseek(fd, (long) 0, SEEK_SET);
+	i = lseek(fd, (long) 0, SEEK_SET);
+	if (i < 0) {
+		perror("lseek");
+		exit(1);
+	}
 	i = write(fd, buf, n);
 	if (i < 0) {
 		perror("write");
-- 
2.11.0

