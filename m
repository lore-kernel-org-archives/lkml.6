Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA71208B6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACUGp+tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA71208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934656AbeGFSeN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:34:13 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:43480 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934516AbeGFSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:34 -0400
Received: by mail-lf0-f54.google.com with SMTP id m12-v6so10510864lfc.10;
        Fri, 06 Jul 2018 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeDV2lrkxWoqZ1Hk0P1fJIMwbqa38mGZkMdNIOePsPM=;
        b=ACUGp+tQwtk1ioCD0jfEVIi0OMR5bqeyjTyWVTH83wnyIOskZaPH0hCIFG3gY20Lkq
         cSmnQck4AYMdpuWL56Pfr+Rgm0IfU1IzQsQl2NWpGa49b7mYu/9q0ylZ6x9ymV2LWOF/
         hQrHXxcQBOlTKg4CbHLDJoGOUiNIcATQGTtYET93vwr0MclwIY1d60ZhThbDVlenzQqT
         alB0Boo6Ro+TQTrvcJcGiWOHDvIf9YzMYTM7MVqYtUU62rDAMVlWecsSsLIXtOKqY06w
         KfDRoXQLoMbF97eZWNwyeQJ8l87NGFhQ4ncGoW2TUoZ+JTm7Lz2B7YX/Gjp1lG5fvU8n
         E1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeDV2lrkxWoqZ1Hk0P1fJIMwbqa38mGZkMdNIOePsPM=;
        b=AjR763UxkEVlMT9EeI2DDjixPTetXd1sXNi2TC1wuZ/FkSeLAlL1/oml9YBw/3iys/
         u72WFVTNKXA9wmbMLL/Bvx9cBJrwT9lbgORYM6WRJUJujYRIGRRYtDxD+AId+leMGbPp
         vqFfRekVSodlyBUud8cgv0nO9SCsa5KvCgudYJMreUI239SAVWxMaipqVr40Y9uHqqe3
         bH8BTnV2Hv7GTIFX2eqJHisYmP9jIWMCkCK1eCuH4fSqobQ6yQcHtbi3twEreHaCEJEx
         NCPGxPRNW4uwl2E7rppK0SCLyIP0Q0lixOzIwt1Zf/mVyYJrrXOED1L4aOwCwI8ROvDJ
         t7cg==
X-Gm-Message-State: APt69E3t0YpMyV7lxc9wiRBNO0/zgK5k5rmnCuMlDjvY04V3ERKoltlg
        cc86CLvuuww44uG/JFpM9oQ=
X-Google-Smtp-Source: AAOMgpdy0T6NyJOWMTiZbRb4UU8QFSw347eQnx5sqm37t4FC4KL4u24Z+q4HFYZ3O8kvCQFjTJaFzw==
X-Received: by 2002:a19:d890:: with SMTP id r16-v6mr7810168lfi.7.1530902012340;
        Fri, 06 Jul 2018 11:33:32 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:31 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 7/9] ARM: s5pv210_defconfig: Run make savedefconfig
Date:   Fri,  6 Jul 2018 20:32:48 +0200
Message-Id: <1530901970-14972-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is result of running savedefconfig.
It's preparation for adding support for Samsung Aries devices.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 arch/arm/configs/s5pv210_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 09b5a7386414..9c862d366fb3 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -13,7 +13,6 @@ CONFIG_SOLARIS_X86_PARTITION=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
2.7.4

