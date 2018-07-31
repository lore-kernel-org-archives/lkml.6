Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA04C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8AB208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhCFErvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8AB208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeGaRE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:04:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34231 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:04:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so14102109ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GpP6k4JTfrqeihunp3ivhRw2aZFUwsJn6HIbR/dMplM=;
        b=nhCFErvja+2FXOK0GxY6DjLZasQ4AxKbMrGse3MmY2DPv1jm44J1zxxaSey5SOs4GR
         XaEFHykMebSUgivIOATKI3eOagb+AuxUqjRIu/xWb2ykDvhTc4/XJGNrQYSrw66lmEnV
         BmuPROU7PpPGdCk3vzRZpnjm9VGwKHBVkfiQAzVMFF2YkWqONDSUVj+j2G6yt85+X/7z
         9QErhpdkG8jNcJVKmVjFk8Yro7RnssgpEHihhZEg6ZF2YqrnIaeltTVfGABn4zq1CZqv
         2NLL6ydhwhnayaXJkluta2sqiXH442WHCjgVnmZh0CiFXYdMQrDzGpoYp3SCn1y+6v15
         iEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GpP6k4JTfrqeihunp3ivhRw2aZFUwsJn6HIbR/dMplM=;
        b=Ignio/R5GhHNcedvvF3QQm7yplvZ9cES8+7V9ZZMEpIxgDLw5JsAirHUxbA3bBkMaB
         Mz8P/JBeNJ9QsMlCvexxspEFYY39VGECNPDzrNody6eHd9/Rx4hlX8ROMz7X7ViAlyHh
         qOLuIDDrU4F5uRl2Te6O2Y8YKFSGQRJFIo2LOlRzLJqXJ2e2je24VbqwQAemt7xIyCCG
         wV6H2lmKQYXMcxb7UOjTT9ajfgx9/ycWEKB4CD9bsPpaQWpqdtva30eiVIN9qfsJUdx3
         40trg7Eh1WtKn8YAoDvIN6//ssPQXZzta3gi49U9u1Ya/sml8WrPT+OKI63lIEM1RsXF
         T3pQ==
X-Gm-Message-State: AOUpUlHoV70/Tf44iG2dzKrYVvpkuO8hPwarzvljpfUnoSCQOhYuBnqR
        qI68kbZhalMI3rTZrTPoB44=
X-Google-Smtp-Source: AAOMgpfh/FLdHDXfQrDL6nX+6cvRFFTFvndbV8lvTrUMhRzLGqleZtCKSLujWJwhHs8M44Q0mvQwEg==
X-Received: by 2002:a2e:1004:: with SMTP id j4-v6mr17433673lje.2.1533050647911;
        Tue, 31 Jul 2018 08:24:07 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.47])
        by smtp.gmail.com with ESMTPSA id g133-v6sm1998271lfg.81.2018.07.31.08.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 08:24:06 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] staging: gasket: sysfs: fix potential null dereference
Date:   Tue, 31 Jul 2018 18:23:20 +0300
Message-Id: <20180731152320.11575-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of possible allocation failure.

Reported by smatch:

  drivers/staging/gasket/gasket_sysfs.c:105 put_mapping() error: potential null dereference 'files_to_remove'. (kcalloc returns null)

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index ef4eca02afa6..682e5c21f203 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -101,6 +101,12 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 		files_to_remove = kcalloc(num_files_to_remove,
 					  sizeof(*files_to_remove),
 					  GFP_KERNEL);
+		if (!files_to_remove) {
+			pr_err("%s: can't allocate memory\n", __func__);
+			mutex_unlock(&mapping->mutex);
+			return;
+		}
+
 		for (i = 0; i < num_files_to_remove; i++)
 			files_to_remove[i] = mapping->attributes[i].attr;
 
-- 
2.16.4

