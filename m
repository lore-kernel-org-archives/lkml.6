Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB34C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614A20894
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv41qV0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8614A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeG2WkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:40:00 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33786 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2WkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so6706916wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=byoy0kY0Yp01VSsOtvnM5p4lZI4yFPW8Wnq4QFMclyE=;
        b=Mv41qV0SR2MPe2XM4Ei7aerEn7iELK9H0nyiG7js8dDUzAdjdKg0Iy58Zh5YV+Apmo
         Sww95nQbVURvxPJWqM456kNKN+9pewdRH2COhTcVC/hXF+Wj2RCKbdxLrYGdghaqyZRz
         OOIAXBi2l1D2M23bWzAyl/GYXfA8vgrBWMXpdVOoMuj5OMIGhstg/ss0HT2VpKcUtriE
         UyWaSGOo2+n9nXXNYwlj7txodK41E8XDJ3fqR5wUhOBT4XjBaClMrrleJNO2NCbltvI8
         D9XkEqacvyiTXEqd84wH05rKBNoc2oHVgcGt/sdazz3cw/wWmytOalIlDVjvChJsxQBP
         ZBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=byoy0kY0Yp01VSsOtvnM5p4lZI4yFPW8Wnq4QFMclyE=;
        b=JldQgxeQVpU4ha3rPXS7pX/rt3890wn3C/6aDBLkJz6fCj8P2qEJBo9Xw0ac64MO1q
         b3MGJs7LU13317/KutLYPshYo1GEV4g6nHfewrnJEdC4nSQUoiTQVbWZ6HvDw1JOnK8f
         f0BYaEJfG/dwGlv1XEi5yFcZjy0TIDEJLw6QIiCgYHWjayA9hERWckMms80FSgxDlmot
         GCXkMNfvYmozAHpO0LOpI1uTrsidpomj9bo7PMSVSsVDzgnJGkEJpjv6eLNABwIF/exJ
         UnxmGKcXsUTtHF+PVtcuvmzxQTBJG9m0SrXuIffKqHIa5Rre+s/RzKAtZmu86ZFQNaCf
         YD3Q==
X-Gm-Message-State: AOUpUlFsOMd1ZVZxEffPr9uagsynv/DwdGay5BAJM3icicClc4G8nQgt
        3a2hVnLotZl4C5p3KTq2o0wogOoCeS4=
X-Google-Smtp-Source: AAOMgpe/QRQ/BRi+DYbXkOmJCCxI5UzsSI7ugW/zlWFhJCCi6QsoP+s8Fz2Ti7+U4NQSxFwrQoPZ/A==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr13231577wmg.149.1532898488362;
        Sun, 29 Jul 2018 14:08:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/15] staging:rtl8192u: Coding style changes
Date:   Sun, 29 Jul 2018 22:07:32 +0100
Message-Id: <20180729210747.10803-1-johnfwhitmore@gmail.com>
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

