Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F83C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D513D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikVarA4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D513D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeIZARi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:17:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:17:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so24293333wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aL5T5Qh+oA9oOnuNZ5zxuTk7P9cDVFLf0HY33WTeFy0=;
        b=ikVarA4eJIcV29KoWwcVVYKHU+saFjDeb+Jjoy17lHNYqW6OpFW4WhRK3WWnpqpWIW
         XPvWWTDno4cDf+keHs6qhWQalwvb3UMZazRPrl88KsU0iYbONyQCYBjvFXbdwvpwFA2w
         vwIdEPTLUIejSCuJO1P3Q0MD2ZEaVaRhy7B3ujEWAJUE+uk6RaqoLcCn1SzO9nwthVfn
         wrfrzoPHojlraI80JkdT/56deg4YQG7VCUljuskbuInm2WxfhdEPttyEFO4DYcMPX/SX
         mKfjC2kWkYfXfwbMQHYY3GxNbmTQDPuI0+wZjnKlL3FtPDRKiftFqVyWi2x2EpFzSp6s
         mmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aL5T5Qh+oA9oOnuNZ5zxuTk7P9cDVFLf0HY33WTeFy0=;
        b=Qwaj/C4P9WqKeAp+FWEW6o937tl6t2O+NZP4ukCU2aKhFQPNZRINwH/498mrWdXcC8
         Q3YdkdVx7jz5ug4qFv5v9j84zutQH9Ft9iaOWqTWt6ecOCu3Zs6AvOua5MaughnOj07N
         l/po/SwFf87EpZpTWAjeuvRT3gGU1PurutFctiqZvb+4Wy4DtwHUxyr8OKMkHf4i+QQH
         y+PyhKAxzlHNSTO+FS2yoG+NcDEs04M713mocCJhVKqVD7FhTj2b28uIZ5dGgR6q+t5G
         a+4oi0Fzs1RXQFkBiFbyaRhm4t/Pc0VFn1Rp+wiyZpJQsirdYolFciQJfArMTh+iqbZh
         erog==
X-Gm-Message-State: ABuFfohYnu9QyehFffvXE/2WQrHtTBSa2eQ7Nk6Ljw7fQZpSZu9b6ESz
        hgdIaqw8SV0ayNuytAafoR8=
X-Google-Smtp-Source: ACcGV61O0Ko6JP0N3FE8Wa+75Rdo37r87nrfq17PpgBScoOQ0+aBhHeXjl8G19n9HOdHENsYec+ytQ==
X-Received: by 2002:adf:ac4a:: with SMTP id v68-v6mr1915078wrc.165.1537898933774;
        Tue, 25 Sep 2018 11:08:53 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:53 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] MIPS: BMIPS: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
Date:   Tue, 25 Sep 2018 21:08:24 +0300
Message-Id: <20180925180825.24659-4-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925180825.24659-1-yasha.che3@gmail.com>
References: <20180925180825.24659-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF appended dtb can be accessed now via 'fw_passed_dtb'.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/bmips/setup.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index 3b6f687f177c..b71b6eaaf7ed 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -153,8 +153,6 @@ void __init plat_time_init(void)
 	mips_hpt_frequency = freq;
 }
 
-extern const char __appended_dtb;
-
 void __init plat_mem_setup(void)
 {
 	void *dtb;
@@ -164,15 +162,10 @@ void __init plat_mem_setup(void)
 	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
-#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
-	if (!fdt_check_header(&__appended_dtb))
-		dtb = (void *)&__appended_dtb;
-	else
-#endif
 	/* intended to somewhat resemble ARM; see Documentation/arm/Booting */
 	if (fw_arg0 == 0 && fw_arg1 == 0xffffffff)
 		dtb = phys_to_virt(fw_arg2);
-	else if (fw_passed_dtb) /* UHI interface */
+	else if (fw_passed_dtb) /* UHI interface or appended dtb */
 		dtb = (void *)fw_passed_dtb;
 	else if (__dtb_start != __dtb_end)
 		dtb = (void *)__dtb_start;
-- 
2.19.0

