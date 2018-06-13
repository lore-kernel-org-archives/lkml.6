Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 55627C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CC52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ud6VnljQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CC52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeFMBQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:16:28 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39059 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbeFMBQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:16:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id r11-v6so456475pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 18:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E0M8Ta60hVqQQqmtEArjGAMG6zOPmqI8ppk2K3dx5kc=;
        b=ud6VnljQxGEazvTiwXrHMXWsDfQkzD0ZMqw8DekLcD4tAoZTbgEwLoVtZBlvf6KQF0
         UDRJKvGAOW8yVVpk3claZa92DFcA8q+3B5WbA5H0DsagXSPiIkMzgkMs8nmUODeRBlue
         rbaVCyWPPzsTRylKbri9blGtGgwWRJwnqb0qE01R4a1QBISwsD1dPquQJcdN+5DuKSuI
         jFtfjofnUrq3gY5Ktl8ZiiXcisGDBs6pt1fT8s7sRhGFB1IntDsQXDJ6ZySIsdFsReSa
         Wo1H+3DBYZQ9+RC7uQ/PDLSujSRQCdegZBjEFLIksTHFMnIgj8ppKDKsEOaC1q56XAeJ
         3gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E0M8Ta60hVqQQqmtEArjGAMG6zOPmqI8ppk2K3dx5kc=;
        b=rOpirqK/IDrW9QKeGdyNf5QBEdaT4JVaRStWC4dlvzEHceTGFw2P7EyR44hbeePYcx
         b7HU62tW8myfwMBuGX6p/fDUKKrRkwEljuGuzdxe3Y1Lut5pULgGJe/ek39ce7EZ4I2m
         CYByZigu6a15U/fbUh/fq41pELozmi6Dynw8uLxuw3Q/YJdHseTNfzpjWjDghh3nabBj
         pwwik6bwzKbtzIRcLdyCNMV++CPpbBIPm+jnqCljO102HdJbmTn/Qk2fXUOCz0Wa8MTf
         oDE5Ffp9t+crLAKuaEUCrTowtibrgbx0djsrrrqo3DCtmpqAS+zzLPhGS4CMJZCaAiAf
         SpDA==
X-Gm-Message-State: APt69E37wVK95cy8QrmWaOLJgey7X2dKAuYiOQqVepKCA7LtUL6MKA++
        00o1H/FKEAAM05ZEU8wRwns=
X-Google-Smtp-Source: ADUXVKIEw8rXfeyoyFW3Nx99FQ06MHucBat6zXc4vzB32/7gkATTSMrUZhwP6gcfDChh9sydS1whxw==
X-Received: by 2002:a63:27c6:: with SMTP id n189-v6mr2306894pgn.164.1528852586904;
        Tue, 12 Jun 2018 18:16:26 -0700 (PDT)
Received: from localhost ([123.117.176.200])
        by smtp.gmail.com with ESMTPSA id g66-v6sm1874973pfk.99.2018.06.12.18.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 18:16:26 -0700 (PDT)
From:   Peng Donglin <dolinux.peng@gmail.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Donglin <dolinux.peng@gmail.com>
Subject: [PATCH 2/2] ARM64: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed, 13 Jun 2018 09:11:56 +0800
Message-Id: <7f70740d2e9f21d273e0c6bdef6fca2b511a285e.1528819790.git.dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
References: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
In-Reply-To: <cover.1528819790.git.dolinux.peng@gmail.com>
References: <cover.1528819790.git.dolinux.peng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
---
 arch/arm64/mm/ptdump_debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 02b18f8..24d786f 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -10,18 +10,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	ptdump_walk_pgd(m, info);
 	return 0;
 }
-
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
2.7.4

