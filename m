Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACB32151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEqlxj3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACB32151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeISULW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33726 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbeISULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:11:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id z78-v6so3123426qka.0;
        Wed, 19 Sep 2018 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKzwpcQ3B3kdvSJOAAVDVIuSlQoQVipqdyNbcYJD7Z8=;
        b=fEqlxj3eabgBNevuGFJbQR1TgOfxp4fl2FfOF1tpzsnBsxxtuED4ENewP1B0ZzNGB8
         tb19q9yt7L7qZwB91bhBbmecC2sHchYR60hAchdN1qGsS8IDMz6fRqxzvPC6mMBJSxVu
         l6ep64SgmJGrJUhqSJhab4FWpvqbxhz+d3cWuaBzSxpEzdVxJ/JcMTWbxyn0H5w+MYj0
         I2E5NcJCJ52V+q4kqwP9Vm+LExCnr//lZboDTKuTBBwTbiUhrigxtGocbRTsim4C6KVt
         OxF3cQXpccjKnzll19P8IR0SDPvHinWOuqzGvv1NMNXqrKVF7Exw3eqhCZP0ka9P0PLw
         JYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKzwpcQ3B3kdvSJOAAVDVIuSlQoQVipqdyNbcYJD7Z8=;
        b=aMUwGG+yOzMHwn9vdeaksJIRiB5T8Hz13z+NSnbQGuZTlL7cLODC8zT/U6Sr/zNR3v
         5cgGnEgNRxeXetcsWn0mpnnFeejBTvFnU72gEtBduOS5gKCMV0NdjfnDEJFCXEMTGtuf
         30Ffj/fktW/uKcAdl0k3VD/pBcrkrtpSTfg6yFkb3Ioh1dGLcLuVAFqUKUR0yHnlN1Az
         zjNYN2BmbwA6iKrAhGfCn9xgfmULnOoo0tNV6z1hJ9HBhcJtq27+rZVfI4HAGFxj15d0
         FS3Wh0M711ooUVGwy18HsSf+mloIo2qx9d9jn7FAfINwba/IjHZQj0TpW86tHqRgpkso
         okEA==
X-Gm-Message-State: APzg51AJlRGJpTxbCdvxrb1BGUgzLHJxe2rmgxIOzA5jBc1eFgn2YIfR
        CQCA+UR/9TMTznLShy0pOTQ9yp0p
X-Google-Smtp-Source: ANB0VdZlWdL/f2NOH6sh3wty7DeGOAhhahucPCEGkthjKPKHs8LQcbMnXVr7PSr0CM9YJazo0DR3KA==
X-Received: by 2002:a37:d708:: with SMTP id m8-v6mr22813927qki.132.1537367588881;
        Wed, 19 Sep 2018 07:33:08 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:08 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 07/12] PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
Date:   Wed, 19 Sep 2018 10:32:02 -0400
Message-Id: <1537367527-20773-8-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
generation of msi.h in the MIPS arch.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 56ff8f6..61a9539 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -22,7 +22,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || MIPS || X86
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
1.9.0.138.g2de3478

