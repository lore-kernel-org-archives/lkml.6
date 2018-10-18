Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CD721477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FSfL86ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CD721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeJRXiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:38:52 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42720 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJRXiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:38:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 40B4B1E7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id trx28R7TR697 for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 10:37:17 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 16B73151
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:37:17 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id f9-v6so27648746iok.23
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3dX82rOYO7DEpyz0Se9zrkSR5rfN8IjHAfYQ5x8NFGs=;
        b=FSfL86ZU3w2dlok1RUxtNv52rp7GjlXfOw2GQ7RDON2NUNFnN+kD3IlfVPXDTtSEMN
         s+EdbgJq+kdMlXLppSA+eqeZ3uGAoAc7PkEkWVx1Yt4peX0P7O4PAfjwB+exL7YOWAhD
         3FYS5fKvzzLHB2v0AXDV1hZUfkzHE/xPDQokSS+EA08cm1WnTNLF51PrBrQfF2Q6KPKW
         RrHydSqC/jItiRJPaozKr0gL/X6FeVUuCgtSd7FmjtrtuTZZbQnisFGMjnXicnxT0HbF
         jNxlXgqmp4NAaN6+5Ps4V37iQWJo4O/ZF8TGvgwiyEOLbxf2hDjmpdkykgry6OrzpaRL
         M1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3dX82rOYO7DEpyz0Se9zrkSR5rfN8IjHAfYQ5x8NFGs=;
        b=UhN/ztwesk8m7nwZS0DgiqT5WR4h2QJKKWznvK+VRsuSIrCRUS/r6h+Oays6RZpUON
         dtHllw61DqWh0MkAPWlEa7eB32KWK81ikyZkA+rsQrIjmZCFSCmmsgylpmZsjIUy5UsV
         eyoHWNSQby1KdSNCqB7YrhjgopW4GIwFSx6LYObNL1QsHPnYXKolvb7HjGCla5DVH8i9
         osIeZiBaM/iEBcVGcmU6vA1zLVZ1HemT4YX7ynQogmxkhZ124Yrw4/Wd2Clp0e07Ipi7
         +F1IxfM3/gmrxhcrVBlmCPfjpDszXGDPUmlF5Oqz2Hy3RweCoWhAsLz2rXw2kFBoJ/mG
         tmvA==
X-Gm-Message-State: ABuFfojqYnotz8Swyng1SGakqKdN7vXhDKcac7qaYZXRORKipFMimyx/
        VKS4INKezyUqyTFC/foy8PyNwoshLFVCNgThfkiN/RM/dgLeZkFdUwHH3JgrYE/ccos7q5QL8Se
        ZGIBo+7D11GSJYVHieHobHGI2JMvn
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr664143iti.16.1539877036701;
        Thu, 18 Oct 2018 08:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62f74+lNygw8uSn9AF4NL2GJuNVzJWmCXENc0crBTrr+On2bHLeGgBXYtGfMpMv779JXC+UxQ==
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr664125iti.16.1539877036437;
        Thu, 18 Oct 2018 08:37:16 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id l186-v6sm225618itb.19.2018.10.18.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 08:37:15 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] firmware: coreboot: Fix a missing-check bug
Date:   Thu, 18 Oct 2018 10:37:01 -0500
Message-Id: <1539877023-6398-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In coreboot_table_init(), a for loop is used to copy the entries of the
coreboot table. For each entry, the header of the entry, which is a
structure coreboot_table_entry and includes the size of the entry, is
firstly copied from the IO region 'ptr_entry' to 'entry' through the first
memcpy_fromio(). Then the 'entry.size' is used to allocate the
coreboot_device 'device' through kzalloc(). After 'device' is allocated,
the whole entry, including the header, is then copied to 'device->entry'
through the second memcpy_fromio(). Obviously, the header of the entry is
copied twice here. More importantly, no check is enforced after the second
copy to make sure the two copies obtain the same values. Given that the IO
region can also be accessed by the device, it is possible that
'device->entry.size' is different from 'entry.size' after the second copy,
especially when the device race to modify the size value between these two
copies. This can cause undefined behavior of the kernel and introduce
potential security risk, because 'device->entry.size' is inconsistent with
the actual size of the entry.

This patch rewrites the header of each entry after the second copy, using
the value acquired in the first copy. Through this way, the above issue can
be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/firmware/google/coreboot_table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 19db570..20fcd54 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -128,6 +128,7 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
 		memcpy_fromio(&device->entry, ptr_entry, entry.size);
+		device->entry = entry;
 
 		ret = device_register(&device->dev);
 		if (ret) {
-- 
2.7.4

