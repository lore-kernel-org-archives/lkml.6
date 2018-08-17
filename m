Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5094C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071621A2F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlRpE2dV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7071621A2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeHQVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37850 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHQVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so8148915wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1ngY4I0/fN7k8+qVDk6hrXDhVBRDUMQ22iL0c5BiuCQ=;
        b=MlRpE2dVJO9bf4qX6pbAsQTWEkXxkiro2zpuhVKEusCmrjQJwGA7lCLDY24b9XlotO
         UxvOSyA7/IkHRlKJSCunzayTbNHM3tIvL9wYAiUVrBe1pTjMctR61NIEuoH0G/bneD9C
         vaQUmXS2kidLsuw4U2lAZUKJ8t+EAUahOa5g/gOzW/AVO3GfMy7cpLmGvh3E1+dwKwKn
         H5iboEOJJMrpAlObV28SSMy2ctIhbBnDbRWXFOx9SqV6l7vp/Ce+iVPYcA59mt6TdhcE
         4vXYFJE2idA4jjF9OcJe8r05gR8dRVNmELQkEu9H5H4SRpnLwkBJhu1a3iCqK/kE59LH
         I9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ngY4I0/fN7k8+qVDk6hrXDhVBRDUMQ22iL0c5BiuCQ=;
        b=BZ8txcsPaV6REfSuwAGVrG+3nuu3VzzEsL1XP/NUNjYASc1zuEfWdtla3PI6LYZ1CL
         KCevlhs7t+60fX9LVCX+iVXeSmavNP4K3r6+578LLCrHyfJUKQ0LzQk7hqfNRAym1g36
         8WmDVSv74a02zQc82trHEGlTL58pIAxSxkijresT2MqP2kRuX4zHANuG33rqziKJsQ1W
         aWFxr9TC1tlsinGzq3LkEAIwOSpyF9Wz/2LzBmVhqSBwrZ4ZHCObi8O6CKg1qqv+Dn27
         oXQz/R79plhexg7z8hFG/sohDHqf+IlHS9mhS9iQh/iStejE4UW5xl1BUUA54I+pM+RH
         B1qA==
X-Gm-Message-State: AOUpUlFbeDcD/G0f2rSk6hmzLmQpjLwVF5+ZlnK9dXa0DAnHjQhC/uP8
        SDBdrv7JgMRYtaMZ+7pWfUxn+kszux0=
X-Google-Smtp-Source: AA+uWPwNeLSJbabOwDHaE5ySm+sP2VcGYM+Bm0ltirvf2bsuXRAtiwZ3ZlYzm/RCKTmoAlzL4vsdQg==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr21106080wmh.113.1534530894390;
        Fri, 17 Aug 2018 11:34:54 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:34:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/10] staging:rtl8192u: Coding Style changes
Date:   Fri, 17 Aug 2018 19:34:37 +0100
Message-Id: <20180817183447.15993-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few coding style changes in the file rtl819x_HT.h

John Whitmore (10):
  staging:rtl8192u: Replace magic number with defined constant - Style
  staging:rtl8192u: Rename sHTCLng - Style
  staging:rtl8192u: Remove unnecessary blank lines - Style
  staging:rtl8192u: Add required spaces - Style
  staging:rtl8192u: Remove unused constants - Style
  staging:rtl8192u: Correct block comments - Style
  staging:rtl8192u: Remove unused CHHLOP_IN_PROGRESS - Style
  staging:rtl8192u: Removed commented out structure - Style
  staging:rtl8192u: Remove enum CHNLOP - Style
  staging:rtl8192u: Refactor struct HT_CAPABILITY_ELE - Style

 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   6 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   | 161 ++++++------------
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       |  37 ++--
 drivers/staging/rtl8192u/r8192U_core.c        |   2 +-
 5 files changed, 73 insertions(+), 135 deletions(-)

-- 
2.18.0

