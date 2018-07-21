Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3113120856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0fRVKtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3113120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeGUUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:20:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:20:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so14162855wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l3bVYrrFE0XnXCRlHY9xPflsOkaXYCwWitnft3x99aQ=;
        b=T0fRVKtrbHpsVFqemesqxTT9PPVMzckjtk442jk+N/3UEV6HPk6M3u6ukYJWSZszaq
         wEX5VPnRifXoQRvTvvLnkC3ZBbD5CnKPhEfzhmiW843pt1WdS8p56Ou/jBK+f3aF0fsT
         BiJ34D3pS/fE6dRrF8AzP1INyQ+POeX38NFGN46ZIMzsqVSHh4hWX8aLTjNhu5PJXgg8
         TwvGNLs30iQToimI2IRljwjkvDAjyMU+b3K1AdaZk4/4oR2fLMZOiqk+6DGRACXnPJWG
         YuaRTDEZ1UrdwCbmqDtOpgfrkJ+puVN0FnFaY4EOJcrFMPd7QgVaAyCdrby+tqwgzXDE
         nr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3bVYrrFE0XnXCRlHY9xPflsOkaXYCwWitnft3x99aQ=;
        b=WGf24fh0Oxo/Z8BPEFfC1Y3+6H4+dltdHtO3+9ZWLFoXAinu8paAVnAbuQwoNW/84J
         vz1sgD3rorPKF10MTwCk/SV3pB2gKhJ5baRPkdUTr2i0xhDTkwN2+kbWy3/QjUPfOdjT
         1oDrtGLrX5c3KjjvPzdU+UXTW5EundGXzpcwg+zkDWtoG200x0EpxkKO9gTnFhL4C1Yg
         QDED7nJDfv/PXRwh2lq11SbgrRh/7PrygwQwms/KsB+rvjntSaoDjxMklqbRLJcSkjQ6
         nKAZY/f1aS2zcs+mPOYRStw8zOyC25exd1FIIkYRvUJPIPc+Lu+69G/b5AUctG2CKUex
         4qFw==
X-Gm-Message-State: AOUpUlG+r7Qesl80J/shj7DCcX7FuG3oa4sbuA35DkmIJzoteH/4jO7b
        ypWx+5I3AwCmIuiVqW05XooA+ACS
X-Google-Smtp-Source: AAOMgpfzAlZOqVr5OM3St5C/jC3JWTHAbz6WPMOx2okOMVjOes3xApA2LJfVx7ddFqpGc23OjP4TGQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr4507832wrv.33.1532201176433;
        Sat, 21 Jul 2018 12:26:16 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e196-v6sm11788615wmf.46.2018.07.21.12.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:26:15 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 00/10] staging:rtl8192u: Coding style changes
Date:   Sat, 21 Jul 2018 20:25:42 +0100
Message-Id: <20180721192552.5378-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are previously failed patches from two seperate series of coding
style changes. I've just combined the failed from both into this series.

I compiled the patches with 'format-patch -v2' Never used the '-v' option
previously so hope it's not a mistake to do so. Guess I'll find out if it is.

Thanks

John Whitmore (10):
  staging:rtl8192u: Rename TClasProc > t_clas_proc - Style
  staging:rtl8192u: Rename TClasNum > t_clas_num - Style
  staging:rtl8192u: Remove typedef and rename struct RT_DOT11D_INFO -
    Style
  staging:rtl8192u: Rename bEnabled > enabled - Style
  staging:rtl8192u: Rename CountryIeLen > country_ie_len - Style
  staging:rtl8192u: Rename CountryIeBuf to country_ie_buf - Style
  staging:rtl8192u: Rename variable CountryIeSrcAddr - Style
  staging:rtl8192u: Rename CountryIeWatchdog > country_ie_watchdog -
    Style
  staging:rtl8192u: Rename MaxTxPwrDbmList > max_tx_pwr_dbm_list - Style
  staging:rtl8192u: Rename variable State > state - Style

 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 44 +++++++++----------
 drivers/staging/rtl8192u/ieee80211/dot11d.h   | 39 ++++++++--------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  4 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  8 ++--
 drivers/staging/rtl8192u/r8192U_core.c        |  2 +-
 6 files changed, 50 insertions(+), 49 deletions(-)

-- 
2.18.0

