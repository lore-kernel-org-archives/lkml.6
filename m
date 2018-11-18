Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F907C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86EC2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hco5GoIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86EC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeKSKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 05:12:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51877 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 05:12:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id w7-v6so3583692wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vbz3WMnXKGCpjcsYeVzgqx6iuaeUu09p1Ftbl7aIV38=;
        b=hco5GoIOavU0oF4E/ae6ci+OAQCOhAkLdcalGYGEedT9oTUdjhfghIIwCHyj3yMEyD
         rFDS/STLieTuSyQfDRgMxI8BK+80uRydnS5GwMtgHmS2iBrOHC8JVBJZNEcdDScSKOe4
         h9M4eHwISAtdaVuzwIw7e4SQSVs1DbfCji40c69YWqzoMaECOYv9uq+LphYIMVk7Fr8t
         SpsKi70Ae+m7g9wOSsuERPRA9Rj0UjR7Zgj1BCwu6wsTrQWGRIX1Q6Xp2jX76pnZPxae
         ScAbe3OwOQd1UQ1e5lSTP0DYvf+ik3f5Va0444hdV1TnBZtuo8O73r49TRTPLYqUYIrd
         0qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vbz3WMnXKGCpjcsYeVzgqx6iuaeUu09p1Ftbl7aIV38=;
        b=RkKlqC3fagDEvccJ+xU+V5DFTwGC09Tmciw3t4HSqXAdEuBO5D1T7esVZbSU/bolL5
         HY9Iui9ik8Fi0WmdTklKRpKwtUkCdTqNbKYt8DYH2yP//8JE5amxFCJuT4rdKhMWwpI4
         jIyTSnER3rRMRbXpdd4qJoZR/Vkx+c5AAkiq1Lq5Aw56oHFMZ7CKR1iYLvot6XYvbDAY
         ut5SIGNZ6E1rZ4i5BxjvfOFHAKUv84VEP8KBp3Dt8DE5RvcoF1eDcF/FBPqA2OzadyLD
         lTErpNZeB2hW0GQwNDwoxBhrQysrcXtQe71pcXRVjEk4gVBX1DGtzUPRVA7mtzILMzJ4
         VmYw==
X-Gm-Message-State: AGRZ1gLNGvGt/gELw4JMwl+0wAalOXdmMQQhXUsM5Qr3EXckcFiRi6q0
        TK6fxOea84fxPC12PK9m4wdAl7QSFSI=
X-Google-Smtp-Source: AFSGD/WKW3DUkmesBaOx3eJ34/c8gIBEqXfrJ5Gv78JwOuPB+IKlQckU+fPCT0PmkJ76Bpvjkpwbew==
X-Received: by 2002:a1c:6283:: with SMTP id w125-v6mr5566594wmb.117.1542585032802;
        Sun, 18 Nov 2018 15:50:32 -0800 (PST)
Received: from qg-desktop-d00 (cpc83989-pool15-2-0-cust601.15-1.cable.virginm.net. [82.4.42.90])
        by smtp.gmail.com with ESMTPSA id t137-v6sm10348223wmt.0.2018.11.18.15.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 15:50:32 -0800 (PST)
Received: from daniel-robson by qg-desktop-d00 with local (Exim 4.91)
        (envelope-from <daniel-robson@qg-desktop-d00>)
        id 1gOWpj-0004cJ-BA; Sun, 18 Nov 2018 23:50:31 +0000
From:   danielijrobson@gmail.com
To:     danielijrobson@gmail.com
Cc:     akpm@linux-foundation.org, dbueso@suse.de,
        manfred@colorfullife.com, ebiederm@xmission.com,
        mike.kravetz@oracle.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, ebiggers@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/shm.c: removed 'int err' from shm_get_policy()
Date:   Sun, 18 Nov 2018 23:49:11 +0000
Message-Id: <20181118234911.17697-1-danielijrobson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Robson <danielijrobson@gmail.com>

removed unneeded variable in shm_get_policy()

Signed-off-by: Daniel Robson <danielijrobson@gmail.com>
---
 ipc/shm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0842411cb0e9..2cb493214108 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -461,11 +461,10 @@ static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
 	struct file *file = vma->vm_file;
 	struct shm_file_data *sfd = shm_file_data(file);
-	int err = 0;
 
 	if (sfd->vm_ops->set_policy)
-		err = sfd->vm_ops->set_policy(vma, new);
-	return err;
+		return sfd->vm_ops->set_policy(vma, new);
+	return 0;
 }
 
 static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
-- 
2.18.0

