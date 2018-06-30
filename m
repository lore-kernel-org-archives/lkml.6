Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43EC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462F125355
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 18:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgp+jPEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462F125355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeF3SPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 14:15:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34509 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeF3SO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 14:14:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so11699827wro.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gO/86tRt9NlAGScGojZKPyrqb7LqvKeAVjssTQAJEz0=;
        b=tgp+jPElG8HZwLmyjhsYW/dYxGRTgZgKZ6eAuIdzrsHliKi4kLM/HcVP9zs66BE83D
         QELpG1ZF26YaNf4rexGyR2QsYPTlu4mmsO+c3+6oS769iSCyBpLvH4MVjBcGoqiI/gIj
         6IYBCCCHovCga3LFCchAda1fLfr/8QRkidDRwYvxGWB348FdMj5OgRXd2OxYjPNT6rTa
         12fb+Sit3vaZxmlsP+Lfqgpr+lRFNPEozQXxRHmE7vaXBEwI7Tcbuu1/wcHQHBWGwZ0U
         q8O5mwirQJtefSI7WpSZtZEHoVmhMtughcWPuKhxfIo2wGxVCns3OLKuOqw+7zUcq4EH
         wflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gO/86tRt9NlAGScGojZKPyrqb7LqvKeAVjssTQAJEz0=;
        b=MO71RdA4KwJhUs4C7k+C4hDpzYjUBNBsSS4tT4Mps2XDNpcxgAwDEOriiij+z48APJ
         B7Vm5NITZCesJ4NxlpFXIGDQkKDNL4wsJcGa3Wq286SRggJLqEqotoZl99ES7s5k+iD1
         Qta+7NF/ffsmivVckPsksFFZOcFe7TcYKYWySCSjymXA/A6b7H8Ul9vEQ2ZNmxxHm8VZ
         ezvR57Y2qopBYdYNtNL7tCpT7m+yrh5J3pEkLHQCQF66n42Elw9PpSnPhtPss337gIaH
         EclcEveoIcotM3q82JAi4TY01oxq14eZuI6Ip12MA04sxQ8KbonkLDOB23cBdPm3vzZo
         1UUg==
X-Gm-Message-State: APt69E1RjAUHsGo1aRoNK7YXtx6ldnz8uiHkkGdHJajL2QuVfnNE3vXf
        OMnVBXaKyMUhHg/9nWdbdfw=
X-Google-Smtp-Source: AAOMgpc+A/Ct4Y6B3d2Ajb0l5joHUzHNBrNVzgwHHq6nebrUETf0IIQGtcO0i5LHkJ+hefJjJ0IUlA==
X-Received: by 2002:adf:8f2e:: with SMTP id p43-v6mr13184241wrb.193.1530382497101;
        Sat, 30 Jun 2018 11:14:57 -0700 (PDT)
Received: from arch.localdomain (x4db215a8.dyn.telefonica.de. [77.178.21.168])
        by smtp.gmail.com with ESMTPSA id l78-v6sm9769732wmb.39.2018.06.30.11.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 11:14:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: move return type to functions definition line
Date:   Sat, 30 Jun 2018 20:14:39 +0200
Message-Id: <20180630181440.3097-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630181440.3097-1-straube.linux@gmail.com>
References: <20180630181440.3097-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of a function should be on the same line as the
definition.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index b2ea3d435af0..ca26a4f4dd86 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -44,10 +44,10 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 
 #define	CHAN_PLAN_HW	0x80
 
-u8 /* return the final channel plan decision */
-hal_com_get_channel_plan(struct adapter *padapter, u8 hw_channel_plan,
-			 u8 sw_channel_plan, u8 def_channel_plan,
-			 bool load_fail)
+/* return the final channel plan decision */
+u8 hal_com_get_channel_plan(struct adapter *padapter, u8 hw_channel_plan,
+			    u8 sw_channel_plan, u8 def_channel_plan,
+			    bool load_fail)
 {
 	u8 sw_cfg;
 	u8 chnlplan;
-- 
2.18.0

