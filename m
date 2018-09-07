Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B329C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EB12086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtiPAXrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EB12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeIGJZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:25:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37661 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeIGJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:25:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so6396425pfd.4;
        Thu, 06 Sep 2018 21:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4+QyJDhSp/Sz+HoJ6uFJhpaRaGIS0DhBLItPAAqgsrA=;
        b=EtiPAXrEHy4Qh3oriaCHg91hW4Yk4NVBt8/EWXSLn2gQRnsGKmTXMo+FMsR7D5E+Fb
         wx31Wy4y/Zmwu6dXpBkgjiIQM8/USMO+DkuPj64IJDLFDoRjRbMJJr4jEgmiS/iYg4t4
         jCJt0Hfz5rrK940B4KQXUC1UDXWqs4GdArITC8p9cO1IqD4GddjQTqRgLd5nQhGA/HR7
         EqE0SHpUpzhQYfdxGE1XL9bFpjArB+jXavvh/dmTeh6+f8N5ozbimdmP3/PJ080kN3tw
         ATw0gwsj1CYP2nQhU9MZE1YHz8RB4rtxyc9ZpCcycSUms3ZE5LgH4v8O4EdyEKXxxkAN
         1GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4+QyJDhSp/Sz+HoJ6uFJhpaRaGIS0DhBLItPAAqgsrA=;
        b=Je22OXSwbwBx0GCugevSlXACZLnIFqvLtquInHwLrGERb6ENG15cbnpCdxkPA70GoO
         w13l/Bj4Awl9dRMO3m2WxXCSl8MUDU+3reNAs2zyhqgYr2jg60VFp92abGpYW7c2vz5Z
         59UeHMx7frL3QujEN8m6wprWnV2zhsHGhDPO8UXh0KG5sGzrsO/B7mpQpJ7qAm97ZRTa
         IFOwEzs3FbuHUqmFKAdnXyit8NYDHmkv6ku6hp5euY/NSelNTPuOjDNyLP6YhMbClEcV
         8cMFWFZixWwgBnHreu5bI6uOfjLKn1uc5dyouyc33f6ELFgqMbYtpEhT8TLW58pJuMxk
         sAQw==
X-Gm-Message-State: APzg51CydeLSH3wy2US3Odo0MOlIskoZqYsnmlbl3xMdQGhBZv1eIqKj
        9mWN8Ja/rxKih3zdCHUTmkgYaOBa
X-Google-Smtp-Source: ANB0Vda/4r+wlbfOOKMnQp/ugr8UkJjbpSq17/BfK8W7BPU2dxu7V3/rqGadBHgDTMfkbz+2YDqliQ==
X-Received: by 2002:a63:6446:: with SMTP id y67-v6mr6256094pgb.443.1536295561184;
        Thu, 06 Sep 2018 21:46:01 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 1-v6sm15074411pfk.134.2018.09.06.21.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 21:46:00 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] ARM: qcom_defconfig: Enable MAILBOX
Date:   Thu,  6 Sep 2018 21:44:48 -0700
Message-Id: <1536295488-12296-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Problem:
ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
added a "depends on MAILBOX") to RPMSG_QCOM_SMD, thus RPMSG_QCOM_SMD
becomes unset since MAILBOX was not enabled in qcom_defconfig and is
not otherwise selected for the dragonboard.  When the resulting
kernel is booted the mmc device which contains the root file system
is not available.

Fix:
add CONFIG_MAILBOX to qcom_defconfig

Fixes: ab460a2e72da ("rpmsg: qcom_smd: Access APCS through mailbox framework"
added a "depends on MAILBOX")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Bjorn suggested that multi_v7_defconfig might need this same fix
but I don't have a target to test on so I have not included that
change in this patch

Tested on Qualcomm APQ8074 Dragonboard

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 6aa7046fb91f..bd6440f23493 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -207,6 +207,7 @@ CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
+CONFIG_MAILBOX=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_ADSP_PIL=y
 CONFIG_QCOM_Q6V5_PIL=y
-- 
Frank Rowand <frank.rowand@sony.com>

