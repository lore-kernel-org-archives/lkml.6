Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9E6C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C370220857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+bhl7qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C370220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbeG2Whd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45019 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeG2Whc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so10587977wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=byoy0kY0Yp01VSsOtvnM5p4lZI4yFPW8Wnq4QFMclyE=;
        b=P+bhl7qxbWEjmOtxgW4d2ipsQ0ceqT5XhevR1+wgclnqy4W5MJxqropM9QXCf4eLIE
         o7k6fmtMcTQgIivg2Ufh78xByxXPhuvmht+abwbyd26JfE99+GlpW25aSW3ov0+8JvqZ
         Kd/WtYHh1B+XiiEJDiLsH1jvLcN+4Dlrk8vNLGbLCa2erR2Uv4onSk9Yi9ZSBCFQnijI
         TBQTInYeMzXze07w7firsnvmX0wJOEzFJoBifJ2vOKZSpK95U1q6e0DV7nZ6bEvlu2ga
         Z0nlKvSk+dNrCuwWeCYzV/o9sbQZcEuhXkIStWrSYqjpDaO8avnJQ/VOBR2rxPcrcjiu
         O20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=byoy0kY0Yp01VSsOtvnM5p4lZI4yFPW8Wnq4QFMclyE=;
        b=EPCMGkUIpqZxL5rAbqw8+8efblIUNjLlepMfTyjrmOkzk3WRZ72b4PFFH29MAbjOjs
         6jXq0LLMCj5hWhSSrjFyadLX8VEnMyBvcyVu+D9CB5lPQkfNcze+5jkAAHscEZkHYWGA
         xS/N7StFG+ctaFF6UPFONDLOrsRoWxp0drnPoTdgRkXvoCYyVn/qP8Nc/jCZ6sVoxADR
         aBp2ZtDSiV0lww2N1AaorshoOEbxyWuM2INtk55Syc3F0OIP3oXCe2mg6k5xjBPqSgcC
         NcWnOaqrJ6X7xTptqspPbSrS98LdrJMDMrdRruBaAFNQfVcXTOfZLLv9WVZCfQKlcksd
         gpJA==
X-Gm-Message-State: AOUpUlEnItWcqvVdMZxGrbZI79qbpEXtdU33bCAGMl1Sq5bWtfNe0OnO
        Sx5bH+qLeusny+CoGLAK66sGjaxqHpk=
X-Google-Smtp-Source: AAOMgpdKio53G6rpGK45HbGx7rmoWFnhsiwGErpUI5pOH09LdvbeXXz/QFebWahEqBRGWzM6+9QREA==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr15027236wre.115.1532898342029;
        Sun, 29 Jul 2018 14:05:42 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/15] staging:rtl8192u: Coding style changes
Date:   Sun, 29 Jul 2018 22:05:11 +0100
Message-Id: <20180729210534.10617-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Second attempt correcting my initial attempt where I left '_t'
and '_e' trailing the structures defined. These have now been
corrected.

John Whitmore (15):
  staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
  staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
  staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
  staging:rtl8192u: Correct spelling in comments - style
  staging:rtl8192u: Remove typedef of cmpk_intr_sta_t - Style
  staging:rtl8192u: Remove typedef of cmpk_set_cfg_t - Style
  staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
  staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
  staging:rtl8192u: Remove enum dm_dig_op_e - Style
  staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
  staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
  staging:rtl8192u: Refactor dm_dig_connect_e - Style
  staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
  staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
  staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style

 drivers/staging/rtl8192u/r8192U.h        |  10 +-
 drivers/staging/rtl8192u/r8192U_dm.c     |  91 -----------------
 drivers/staging/rtl8192u/r8192U_dm.h     | 122 ++++++++---------------
 drivers/staging/rtl8192u/r819xU_cmdpkt.c |  16 +--
 drivers/staging/rtl8192u/r819xU_cmdpkt.h |  24 ++---
 5 files changed, 70 insertions(+), 193 deletions(-)

-- 
2.18.0

