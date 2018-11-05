Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C64C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF842085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJidsjYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF842085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbeKFAVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:21:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34386 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbeKFAVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:21:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id y18-v6so2162622pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3gYZRtrbX5ghD33CiTpEkdHxJdZHVlkk1o9milWK0P8=;
        b=KJidsjYesKTgUnD+WRPbdFJRD29hlmroinWgPNnzT5eAqQdcs+HPBcV5OcZGh9pSPo
         LlQvA6eqg4S/wmgpK5W9aNMpFFFXRXBElTsSd5l0ktygpFApR2neMCoBdRgX8VM8sqqN
         iQ65iV54BISJkZfd/vJ9bT5UfE5Q+O2zQUVUGkE/EvaHw3IThjtbqkDuNrBHv56lLM6T
         qfVu7wtDX50eZxK0pXJQfC8oPwrlWo94aeVFyEjfyKeFrKjUZgHiodbmKixvKBTPsDU4
         7eNkOrxslhEIqlIykf7SPo5cO9UwMl4Mozus3X8+YyoYhvouHOCUxadhwIn4oFBBSP75
         9zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3gYZRtrbX5ghD33CiTpEkdHxJdZHVlkk1o9milWK0P8=;
        b=ezB3PgTA5s3Gr2EH9ejGyub+09WTgSZVTCSGvUehpf6EiLh1tTTA/yhxrAfYujzSfc
         Xle2LNdCifDP/gwBLWm0bz7IZIc2E3b9vDFexcxJXx7ON/vUNOUeJ0vD6qx1nakDDcus
         VlMpwy0GoVLgMsQLnSNpupUHVkptsFzGLiMm8pfLY3tUdqtQXsyiP85hlgjbu8CGzqf9
         bdzkxiAYXXDxxe/FHNK6++juvFEJSNGx8Nox85tWsW10EE7D/2vAxn5KUiFIn7Z0/RKP
         otjqK+6tueh8xiXYL3LLGuIbjspSyBJLoRrUAZ5B+QToG7cep+hiLM27qP9435YJSa2a
         KAag==
X-Gm-Message-State: AGRZ1gK7iKU/Wk0Kf7qCQVHcSztrfQJmkRFAFATYfm0+CGIRl4+GvArm
        3GQtVC8gVLuTq+ZQCmth9Vk=
X-Google-Smtp-Source: AJdET5cWmP6/esTv8Nh5ylAho4fdMs6Ow0hq+m/befBtj4M+euxQPeXHTf4WU53eyCeIPPLFQ5ftBA==
X-Received: by 2002:a65:4049:: with SMTP id h9mr20159224pgp.304.1541430085070;
        Mon, 05 Nov 2018 07:01:25 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n87-v6sm55558608pfb.62.2018.11.05.07.01.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 07:01:24 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        david@gibson.dropbear.id.au, msuchanek@suse.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] powerpc/fadump: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 10:01:19 -0500
Message-Id: <20181105150119.6452-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a711d22339ea..2df5e04b5afc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1531,17 +1531,7 @@ static struct kobj_attribute fadump_register_attr = __ATTR(fadump_registered,
 						0644, fadump_register_show,
 						fadump_register_store);
 
-static int fadump_region_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fadump_region_show, inode->i_private);
-}
-
-static const struct file_operations fadump_region_fops = {
-	.open    = fadump_region_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fadump_region);
 
 static void fadump_init_files(void)
 {
-- 
2.17.0

