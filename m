Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51596C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA41D2170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ/Egv/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA41D2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeH0C3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:29:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40649 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0C3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:29:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so9181458edq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pV2ggFMn0oJdpgePJ2n9t0gx0Ss/YtSkOTk0DUWMoJI=;
        b=QZ/Egv/pGcxm4WGRLuehcssBVSOOdFEfwsBWOitvUY7eUfDmCM3c/vhm0W3Xc3way+
         KGeRmjVFKeKiyc1l9xb2l17dcrNh/pZeeivnk/JofBoy8OzlNBVYBpA9KXRo6Lab3dWV
         TN3SJ1RD903a0eOPSi8ve+Jqj/3r7t71ov2ZCQux+F5FFH5FZILqXqyDC/LokHupjnRw
         VQk49nCp30ZfsbivzK8WQC8lhVkxkWBjwUGZX2tgdWcYZykV0Ue4Go5zIIV1l165AxTp
         AeT7c3uciiYPpbmvZzm/dEXmiLRiDJ8jmI/snmrEqgDfgMrYAIz0fTW88JyT1ZJ94GgP
         s+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pV2ggFMn0oJdpgePJ2n9t0gx0Ss/YtSkOTk0DUWMoJI=;
        b=uS7ondHZEsOCB8MszublQmmOR8xxfwpQbQF9zTECs8mM25LIQ6fQRzYCX4RGkW+vPm
         uD5h8cKMmpOjr6YucfqQpPTV7NtQ9JQqbbecB6oSA/n+yVOqnncv/be7ZRPY+ZqZ/xhQ
         Cd/sERHbE22Rxj7snaXougAWAG96SYzXM2VJCVm2Orpy8QymKzvTHjFQT9X1ltkwaT2i
         CkVE9UMQmdbgVOHsyItvn8zSNm39v8DopFPBYh35EidDl/OanPgnfSzZHJuGy+rsvINx
         e47mQaKiV6daLo6htHBk6/ByzUb6P/ydatzbv8Q8p1qQqBz+FYE8jpB57Trg2pfZAbaN
         NNFw==
X-Gm-Message-State: APzg51BEbpVj9D0p1QjOFQ0jZNQ8cPetcHTVJIETiBiT+pJ+zILHOBmF
        G3k1kHpnLOGgsYhwt+Jh9FZWz+zs
X-Google-Smtp-Source: ANB0VdYQerBrs9bZuEcrzHnZDgpwAzsTgj45nNU7x+AEepkBWZFrYUNsZHXwojiJnPBukdSBousHZg==
X-Received: by 2002:a50:d619:: with SMTP id x25-v6mr14337719edi.178.1535323555314;
        Sun, 26 Aug 2018 15:45:55 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:45:54 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 0/6] staging:rtl8192u: r8190_rtl8256.h - Style changes
Date:   Sun, 26 Aug 2018 23:45:27 +0100
Message-Id: <20180826224533.16020-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simple checkpatch cleanup of the file r8190_rtl8256.h,
mostly to clear CamelCase naming problems.

The directory contains a copying file which suggests GPL2.0 so that
has been added as the missing SPDX-License-Identifier tag.

John Whitmore (6):
  staging:rtl8192u: Rename PHY_SetRF8256Bandwidth() - Style
  staging:rtl8192u: Rename function PHY_RF8256_Config() - Style
  staging:rtl8192u: Refactor phy_RF8256_Config_ParaFile() - Style
  staging:rtl8192u: Rename PHY_SetRF8256CCKTxPower() - Style
  staging:rtl8192u: Rename PHY_SetRF8256OFDMTxPower() - Style
  staging:rtl8192u: Add SPDX-License-Identifier tag - Style

 drivers/staging/rtl8192u/r8190_rtl8256.c | 27 ++++++++++++++----------
 drivers/staging/rtl8192u/r8190_rtl8256.h | 11 +++++-----
 drivers/staging/rtl8192u/r819xU_phy.c    | 14 ++++++------
 3 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.18.0

