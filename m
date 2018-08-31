Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FE42083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJPnIVaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FE42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeIADMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36204 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id j192-v6so6691696wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MMShPp0/lrrS2FGODqYab7Q9hNO5GnOkteCDRggYpz8=;
        b=CJPnIVaX3WP1FlOyn+cUlTCz22sgG2WZwYMPrVldAx2bPtIZz62Hrls43rydoPdZYS
         t/avuzyetSABph3JQc3QPEug1F3MtWtuJRErXENGBrx75Hghb3eFX7dn/dkPuacAgpag
         r5Eu2ILbCL32QIuhBavCXsILqI5qMo4s5jzAUGiryWkN93N2DdAyyhPSEK/oke5ZNLVj
         T831O2Fqoq42j0Ya6uWYOyyasH8YfoIA35xF5Lb/XZfZ+CIcg4vBzpcqRVqM4YkqNLjU
         om2skNh/L4YI16vjBjgrhlM+AN2jhPBrAp/Ux8a4YZdTLl9IxIsObnUCpkMwSzgMf4Ba
         aoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MMShPp0/lrrS2FGODqYab7Q9hNO5GnOkteCDRggYpz8=;
        b=M+gCQfz4p8rtWhzY5qyk8ZQT9l0YcpCTVV/PKpdUYz2FbbutOUSYSQrP0xhy8jUcP7
         +8jk071+rDOblOqM2Panzz9OMSMHP9lvFRc1V9kcj1hezAdFvLwoKyZeQ8lEqx+LN1OK
         DoyKfYz1da09FonTHqXRO/om7e6j50knrRmW720GSp7kkmPC5AtbUl/9Rtq0EoyPz1e9
         SFpwnNvi61QXniDZgiUjPYGS0Q5mWmhNYDejrbc5OsuRFN0X8szHPPORQScaHyp+t+9w
         2Pqufucn+eV1+Qq4csq7CE/SuGwFMKMW4tLGrLe2lP2WstrIaVEqfQBYOXYRFoC5nCm6
         QrGw==
X-Gm-Message-State: APzg51AzD6ssJYBAlJSA89OPT2aW/1/0Y/34+kUVWp2fAMMsdQZqFtWs
        0jpaQwR7GwIoI6ViQgfZZWy7IP8lRgA=
X-Google-Smtp-Source: ANB0VdaOJXjxRLwIIsursaA4LyAmBcVHY3A1oMHgE8ZblIxtGO7zJxLavlXZIZ4DKCeFQvzDkgVozA==
X-Received: by 2002:a1c:b984:: with SMTP id j126-v6mr5542534wmf.25.1535756575479;
        Fri, 31 Aug 2018 16:02:55 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:02:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/20] staging:rtl8192u: r8192U.h cleanup - Style
Date:   Sat,  1 Sep 2018 00:02:30 +0100
Message-Id: <20180831230250.16810-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another series of patchs to cleanup and clear some checkpatch
isses, this time the file r8192U.h. These are all simple changes
which are mostly renaming variables. A MACRO has been removed as
it's not used in the code, and added SPDX-License-Identifier.

John Whitmore (20):
  staging:rtl8192u: Remove write_cam() - Style
  staging:rtl8192u: Remove read_cam() - Style
  staging:rtl8192u: Remove unused functions - Style
  staging:rtl8192u: Add SPDX-License-Identifier - Style
  staging:rtl8192u: Rename RTL819xU_MODULE_NAME - Style
  staging:rtl8192u: Rename Rx_Smooth_Factor - Style
  staging:rtl8192u: Refactor RT_TRACE - Style
  staging:rtl8192u: Fix space characters - Style
  staging:rtl8192u: Remove RT_DEBUG_DATA - Style
  staging:rtl8192u: Rename PHY_Beacon_RSSI_SLID_WIN_MAX - Style
  staging:rtl8192u: Rename OFDM_Table_Length - Style
  staging:rtl8192u: Rename CCK_Table_length - Style
  staging:rtl8192u: Rename PktSize Style
  staging:rtl8192u: Rename Offset - Style
  staging:rtl8192u: Rename Reserved... structure members - Style
  staging:rtl8192u: Rename CmdInit - Style
  staging:rtl8192u: Rename LastSeg - Style
  staging:rtl8192u: Rename FirstSeg - Style
  staging:rtl8192u: Rename LINIP - Style
  staging:rtl8192u: Rename OWN - Style

 drivers/staging/rtl8192u/r8192U.h      | 82 ++++++++------------------
 drivers/staging/rtl8192u/r8192U_core.c | 67 +++++++--------------
 drivers/staging/rtl8192u/r8192U_dm.c   | 22 +++----
 3 files changed, 58 insertions(+), 113 deletions(-)

-- 
2.18.0

