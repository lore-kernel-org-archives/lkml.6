Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAFAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D055020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Egh+OxHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbeFSWYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:24:51 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:32870 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeFSWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:24:49 -0400
Received: by mail-qt0-f202.google.com with SMTP id o68-v6so1072346qte.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=uncWFNBjAkHw+l3xy4zcwJBPHd3qrgfhZmJUKb48q0c=;
        b=Egh+OxHmqVqc0196AnKJPsZMge4xRReguXonN880oI3zad4PWSz89VNbiofo8LkOAe
         M91ic58tuwT+7tQElo5QHWczfX/BQp2gDpO8h4Trkqw2VZZrsPeeSBkRZMfQdNh9rL0v
         vS4q9f+Cx2p9k1IPvvGLYW3nPMdOC6Z4AkIQNhn/hn+pA4rtP0LZMs0TV1EFrIweLhtC
         dszvN/YUL0iCXTw/0HzSinTfdoisyEIkAa3QyJzkS8gDWcaoN4ucHbsnhSAti+WqxiQD
         YY+S/iBcX5Oo5YjSM4+2el+2IJjF17OAoMQjeD7xBlkKIMC9VhXRt4JSbmjxFXidOHta
         qyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=uncWFNBjAkHw+l3xy4zcwJBPHd3qrgfhZmJUKb48q0c=;
        b=hBEdwUDdezKvqzh8/FhVrkdUYQ0TbJnjDFeswT1m8ZxT282MW9c5+gXxIUjX64ctGu
         DpZjEE5GHhjzeEyGSTXfqVKW5QUnMDS1r3wrQsNSGZ/Wou4wyr5FMYLLMn1AKkRSCbie
         YARenQl8TrqnmeZnthwAUPM0ZF9WJu5oCgLg+mfm5iBU5hPbF2QJw4A4ziOFxvzoIkka
         9P1S88zoCW64OgnM77doCim2L73+0FfNCk8w1b010oR/dwflSSnuo0kBDm7yKvJi/oHm
         tfvt9dpnpvw8xXqIxmfADMwHlreGAy9Xt0BcPuJ+0LddYLAxJfPcE5oo6V2CViPWzgJJ
         WvPA==
X-Gm-Message-State: APt69E2/iNmyPwmMhiS67IONnGvb/07dNPJwfwKK8OG/KIDKZu88Et8y
        wtI0kg44PwkgICptxGzJisGK0OCuJgzsItNUEPDXzfjHRYE5dMUmteyM0f8QL2Yrdwww0FhDCtB
        xK/QSBGDnYxzBNQhkOdAyDzUyAWnXqpezWTPh6ausoNesjwWGhkFyJVgvx4GXSUVMB57ZrhHPfL
        iH5Q==
X-Google-Smtp-Source: ADUXVKIxcrCjygM5UZvGZkjmIV7TBKIZnZ0cJBbN0GVJ6PVhXGz22zM2iZ55f9owEm8ZhEtv8tpCqzFUIl3ZV3M=
X-Received: by 2002:a37:2785:: with SMTP id n127-v6mr10319398qkn.56.1529447088528;
 Tue, 19 Jun 2018 15:24:48 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:24:44 -0700
Message-Id: <20180619222444.134928-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] staging: android: ashmem: Fix mmap size validation
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Strachan <astrachan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ashmem driver did not check that the size/offset of the vma passed
to its .mmap() function was not larger than the ashmem object being
mapped. This could cause mmap() to succeed, even though accessing parts
of the mapping would later fail with a segmentation fault.

Ensure an error is returned by the ashmem_mmap() function if the vma
size is larger than the ashmem object size. This enables safer handling
of the problem in userspace.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: devel@driverdev.osuosl.org
Cc: kernel-team@android.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 drivers/staging/android/ashmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index a1a0025b59e0..1eeedb529a10 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -366,6 +366,12 @@ static int ashmem_mmap(struct file *file, struct vm_ar=
ea_struct *vma)
 		goto out;
 	}
=20
+	/* requested mapping size larger than object size */
+	if (unlikely(vma->vm_end - vma->vm_start > PAGE_ALIGN(asma->size))) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	/* requested protection bits must match our allowed protection mask */
 	if (unlikely((vma->vm_flags & ~calc_vm_prot_bits(asma->prot_mask, 0)) &
 		     calc_vm_prot_bits(PROT_MASK, 0))) {
