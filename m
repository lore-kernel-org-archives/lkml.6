Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE38C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDABC2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 20:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1iVCwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfASUHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:07:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46252 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfASUHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 15:07:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so18894735wrt.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 12:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FcIkyt1qb61GftfpgTWg4H4x05ilc5MHpd5J7cqtPPs=;
        b=dF1iVCwygFRRdyL2QlQlkOOBTIbNUri5xdTAM8BMNOOiH5zocq1dwFncJyWWxQZLmr
         zh9hTjCtLEZGrjpXOKnR9sunbysBZerQ4ad/9evhGsJU1JPjCZjFXLH2ttWTkEd3RtJD
         7Pb5JS2FSnAIaptHbaLK5Q7+BmY2Vg3oc0fpLuI3bHM0FJSq7VCbXjGOJichbTC0m3Xu
         AAohi2PNPQuTvSKRWGnaGUAWRLenYhiMem0PsLbV2skn6R9K7cZnvblbFIMo0HK3UYu0
         t4+Xo9K4cPiXO1LR2Z1qajdZDsLDQf9tN7DPJ7glVdjgC521igVcKSUMhkcXFqsQ89RR
         D9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FcIkyt1qb61GftfpgTWg4H4x05ilc5MHpd5J7cqtPPs=;
        b=lRQDCdv5wEuiekw9/nz04v7okOTUYfJ2nKeQO2KQwibO456ZdiIqdZUnr8dlt+3xYF
         XpTJCHCKq21qtrCwo4YVNfG79vPHgTRUXKZgBHG/iZGrARt1qXArJVtVYRzWgdYJ66GY
         1vzIHe+Npk7pqE6uV3BVYTS5MkIdIbGViZKX/Dc10yJDuAejo57BvsPpX05ww25F5rA1
         Z0FVBqX6eK5Pg7jLsPuIXYTT5fID5B+azhs+aakTt4d4txX9SQ7p4jUnL/tLA1CRSc5k
         mUS9oARXXGGe7kfPDgsOyJVxf34jU/mm4r7bwwXO+Y0h36/nmGSzOflnDfolyDEZ9gSR
         j+bg==
X-Gm-Message-State: AJcUukcL2VSrUo0Dcn30etXDVWzOiBW1mO+98vlpt2uwLVvPOTs72PRk
        30Zdhf3YI8zy5F985Wyq2Lk=
X-Google-Smtp-Source: ALg8bN4EK3izkSTa2J3vsyZ5rP0B2S4GDGahrI1lXF9xKMacfot1GQzZcKJYGyX/BbZWgd6SiC0OWw==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr22263213wra.81.1547928454880;
        Sat, 19 Jan 2019 12:07:34 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d90:4f00:49c3:3590:ca42:b19e])
        by smtp.gmail.com with ESMTPSA id n11sm27238072wrw.60.2019.01.19.12.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:07:34 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Jiang Liu <jiang.liu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update simple firmware interface (SFI) section entry
Date:   Sat, 19 Jan 2019 21:07:19 +0100
Message-Id: <20190119200719.5686-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown has not been active in this part since around 2010. The recent
activity suggests that Thomas Gleixner and Jiang Lui were maintaining
this part of the kernel sources. Jiang Lui has not been active in the
kernel sources since beginning 2016. So, the maintainer's role seems to
be now with Thomas.

The referenced git tree does not exist. Instead, I found an sfi branch
in Len's kernel git repository, but that has not been updated since 2014;
so that is not worth to be mentioned in MAINTAINERS now anymore either.

This change was motivated after I found that I could not send any mails
to the sfi-devel mailing list, and that the mailing list does not exist
anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Len, please ack this patch.

Thomas, if you are maintaining SFI, please pick this.

 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 887b4b9fb6c4..e2d370910a07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13841,10 +13841,8 @@ F:	drivers/video/fbdev/sm712*
 F:	Documentation/fb/sm712fb.txt
 
 SIMPLE FIRMWARE INTERFACE (SFI)
-M:	Len Brown <lenb@kernel.org>
-L:	sfi-devel@simplefirmware.org
+M:	Thomas Gleixner <tglx@linutronix.de>
 W:	http://simplefirmware.org/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-sfi-2.6.git
 S:	Supported
 F:	arch/x86/platform/sfi/
 F:	drivers/sfi/
-- 
2.17.1

