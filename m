Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48606ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1020833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8xL+J5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeGTEgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeGTEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so5625694pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dg3xIzBiiAUq2DNELD03K3Q86K4G/i1CzzoFATJh2wg=;
        b=C8xL+J5GoK1Yr8b4NncUlH6Is1ghULoQbzRCpR9U41AiXAeC3XQOCGC90SJQcEu6+f
         EnFoQ72W1A2LpTcrr2ioRQlEbuoPcsywgWkU+M2W216jYI91wP8/Ls/QWEMWDOMpj60o
         jXbCvHk+DBi5O+Vv99Hu3MahI7sOlZsEY/N0hDcGb80Vyv2sMnL/TxwzQAs2Y4/tjkrX
         dv9uD9MfTxhfMNGPpgXy4o2tota5BCU5nNgRX9leBSCo0Xb/Fygg7V7JAdYgzUoD6pqw
         hewX0q5xIZRkOp7gwUeJalwYaE58EI2yow0afPvDmMDBAIoKBeUV/cmgNSGwiZ672qJO
         2Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dg3xIzBiiAUq2DNELD03K3Q86K4G/i1CzzoFATJh2wg=;
        b=Ap/8DmxrypHDlkEbJoD81VzL6ZbFZ2VGjbAdabjqeGIB1gERC732+PW7L87Wd6PJvI
         dptLerKl1To6usJWmbNcIxmt315mVqwEmu/NUVKNg0UK19xKbb7lHebejTkZ5BaTtRBA
         0AmMbBioQaBYYsi+SsS5nvkSIpuAKpR9HNAyaZ9ERVCNh7ocRbc0CvSKpsod9v2/8cFT
         r/RiADEKfxXM22pSiK5z8LCZpvgyAteepLJYRdbaZgSIsddnNNuaYiCS6zoZoLPdUw83
         etpqw5A4HPKMpfKzOL1EEHFB+iSKsCGTez2EVeo3RV3tOsuVWc4yOdXSNibPwNpwLE2L
         ioTg==
X-Gm-Message-State: AOUpUlFTvpffW9hNGpHuehSPVUgG06eLrGgP6kifbUFztcBoKhKfIb2r
        QrdaCxoHpItAW2Rb+ZAK8XnET03lLW0=
X-Google-Smtp-Source: AAOMgpcamL5UrAJJEOmhE2a+d4yk899gTh9VaIXNFXUm4OGtADyNFY+7FNa/FdVux5IgwkMVTVHa5A==
X-Received: by 2002:a62:5dd7:: with SMTP id n84-v6mr490307pfj.68.1532058603438;
        Thu, 19 Jul 2018 20:50:03 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 15/20] staging: gasket: fix multi-line comment syntax in gasket_core.h
Date:   Thu, 19 Jul 2018 20:49:15 -0700
Message-Id: <20180720034920.77320-16-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use consistent kernel-style multi-line comment syntax.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 50ad0c8853183..7ea1df123ba5d 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -54,7 +54,8 @@ enum gasket_interrupt_type {
 	PLATFORM_WIRE = 2,
 };
 
-/* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
+/*
+ * Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
  * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
-- 
2.18.0.233.g985f88cf7e-goog

