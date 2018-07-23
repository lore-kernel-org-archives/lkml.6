Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE50ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0DB20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+S/QOxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0DB20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeGWKMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:12:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55778 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388069AbeGWKMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:12:05 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so403718itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 02:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g/A0HXvTyptqquHi8iOsgkwG8Ne7mVwyujgbPwC35DU=;
        b=o+S/QOxxea5lCeCP3sOnPn+zagpgiuWNnD3QtWejVFfUDKxgucyFWXOQm+d9SZGECQ
         n++rBlKryxT5BKANr2IX7lwPY+4reA6LrhSE0sjxcR8hQmFLr1DwphVRWvS4argpjhn+
         1ZuKPilv1hQ0f8eNN/fw1501tNmoYelCACQa86Z0c3OcjyPjVMmY8IIjow+mVsSAlCwA
         cM4GRp3sXI819VdWwi7VoGUZI+6VDCKCTSKZN7ais5KCF/qi+Enf9kMnEhtHq0gX7W4B
         aMsikN4ItExbSfcyAMhtalpNKzTI1uVmP58FCthX22/8/N/d+1goWws3aJ2b2CcXXk9a
         JsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g/A0HXvTyptqquHi8iOsgkwG8Ne7mVwyujgbPwC35DU=;
        b=kbdGOhXJrRTa4GkreXOh9BRtIUw82I6XFbJ/j5KktSPMBLhv4XlOKU4wmR3w6fEmqD
         qd+3NjzzLLkDGjAN+fNkOytKuXFFwFlV4KCnIEcgWC3ePT6+5MZ0x5dRYCMZ0o5cFHIM
         5xU1M7yi8Fu2AhYDDBGhDpk9qoTG+8rQ0q2sMcSXWW0bGx6l1DfHb0RCuMaZJffomRq0
         aK2gz7v1Nzw5BkpVArHjNx3ioL7AxxyHQ50jb/vw11b+ws4Yr3iv4WUC9sBfTaCOuKoW
         YrdcZpfl4h0vCq2R5KbommicJI+wcDbkx1T+rT8r8D0jDeAl7J3EQVgJdv3lQ+aUkIlx
         UdIQ==
X-Gm-Message-State: AOUpUlF8SoPt2akhvyFAakgKqhclmZgEoxj9p7DgF0gsq+9NxhuoqJfw
        sr4vHWH95l1CXhKvMIERVkg=
X-Google-Smtp-Source: AAOMgpfm6UvEFrMldiTKClYinmdJSTvDj3XlbKsREU9jj9HfXc9wM8QuPqAFmLcXHodGjmsHz6cTbA==
X-Received: by 2002:a02:503:: with SMTP id e3-v6mr11127241jad.29.1532337112546;
        Mon, 23 Jul 2018 02:11:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id z71-v6sm6409540ioz.34.2018.07.23.02.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 02:11:52 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bernhard.walle@gmx.de
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] firmware: memmap: Replace GFP_ATOMIC with GFP_KERNEL in firmware_map_add_hotplug()
Date:   Mon, 23 Jul 2018 17:11:45 +0800
Message-Id: <20180723091146.11233-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

firmware_map_add_hotplug() is only called by add_memory_resource(),
which is never called in atomic context.

firmware_map_add_hotplug() calls kzalloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/firmware/memmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 5de3ed29282c..598eb0511097 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -297,7 +297,7 @@ int __meminit firmware_map_add_hotplug(u64 start, u64 end, const char *type)
 
 	entry = firmware_map_find_entry_bootmem(start, end - 1, type);
 	if (!entry) {
-		entry = kzalloc(sizeof(struct firmware_map_entry), GFP_ATOMIC);
+		entry = kzalloc(sizeof(struct firmware_map_entry), GFP_KERNEL);
 		if (!entry)
 			return -ENOMEM;
 	} else {
-- 
2.17.0

