Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC68205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlk2tTWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC68205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeH3Aeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:34:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36762 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3Aeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:34:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so6033259wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=arbiJAhsTu0YO9qD1ED4+vwK6ERvJo4dindujakL9lM=;
        b=Nlk2tTWqD5810c1v2Fn8zMBrTwFo9XiEVb9IMk2nAglSM1ocYXHKJ9jKQYTS2HrWhx
         Nif1+v3xR3ZS96DnawUMitSk/glzjBwRG0wc3HrCz533Ekjvdj9wgMDWQFzGuySqLFRM
         1THU843tK1RvrzOZ8RDS5NbXvtPpFRwFB3bYRmhEXsIKs57zIxO9Wy+TUT7C1CdrpLVm
         XiV9mp1puD/y4mBv+4jL5phcPP8qrRA1m6b1ope0oRO/+vezey3ByN4V4b8JmscpCnGb
         o+OueQyzjhZepoykjWZyAHjGNmW45+gKZ86YM5sfuYzbISKBprQRq0RYKBqmtPc4Riqr
         LFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=arbiJAhsTu0YO9qD1ED4+vwK6ERvJo4dindujakL9lM=;
        b=HFlacs+MJNvBeo1Uj7SRQGJCPGTqKFUXIEZJJwxfJUpdAUcf7gjxu5V9FbZMdDe8IV
         aTap3QFwRuwIt8QyJdXi7DVWmCl2lE9j6S4wjMmrpP8qmCrCKFJpXu8yAw76STMKlmsa
         hvy4HRzzLAS7XpjY6CB7G4iGDxrkNLeEpMtkf9OZxntcov2dgka0LySZyB2XsM7wR06U
         By++rpzowmfhxjHpWN2kpcRyuUnbrdLA0XpguxWbPlk+B12j7zKcscJsTyevZ+W7AwEP
         7a9GRItQai8uc9nxkQ+9HNQwOKneS4K2nhBZRTKX5jL9oAw/J5Q64sDtykAZNnxpjdke
         gRCQ==
X-Gm-Message-State: APzg51AK9HDf9TrAoIm2s5rlwNchn/aO0EUs/8dY7CXeXhurLNoCains
        zrX1uZgePicf2Zqgu8zSB93+GzA5xhY=
X-Google-Smtp-Source: ANB0VdZ2f5MhpwPAVruOxIZ4qfs1vrcqi+Qp+Y/PIA7ZHvPliEXKVD9NPp3q3G5lNs0mZD2TIqimkA==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr5759618wra.100.1535574956167;
        Wed, 29 Aug 2018 13:35:56 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm10625519wma.33.2018.08.29.13.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:35:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/21] staging:rtl8192u: Refactor ht_capability_ele - Style
Date:   Wed, 29 Aug 2018 21:35:26 +0100
Message-Id: <20180829203547.15650-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patchs is a coding style clean up of the structure
ht_capability_ele. The changes are all simply changes of the member
names, to remove the CamelCase naming.

A number of the member have been renamed with the prefix 'not_used...'
to emphasise the fact that member is not used in code. At a future
time the structure might be stripped of these member variables, but
for the moment they have been left, as I'm not sure that the size
of the structure is not significant, and possibly mapped to Hardware.

John Whitmore (21):
  staging:rtl8192u: Rename AdvCoding - Style
  staging:rtl8192u: Rename ChlWidth - Style
  staging:rtl8192u: Rename MimoPwrSave - Style
  staging:rtl8192u: Rename GreenField - Style
  staging:rtl8192u: Rename ShortGI20Mhz - Style
  staging:rtl8192u: Rename ShortGI40Mhz - Style
  staging:rtl8192u: Rename TxSTBC - Style
  staging:rtl8192u: Rename RxSTBC - Style
  staging:rtl8192u: Rename DelayBA - Style
  staging:rtl8192u: Rename MaxAMSDUSize - Style
  staging:rtl8192u: Rename DssCCk - Style
  staging:rtl8192u: Rename PSMP - Style
  staging:rtl8192u: Rename Rsvd1 - Style
  staging:rtl8192u: Rename LSigTxopProtect - Style
  staging:rtl8192u: Rename MaxRxAMPDUFactor - Style
  staging:rtl8192u: Rename MPDUDensity - Style
  staging:rtl8192u: Rename Rsvd2 - Style
  staging:rtl8192u: Rename MCS - Style
  staging:rtl8192u: Rename ExtHTCapInfo - Style
  staging:rtl8192u: Rename TxBFCap - Style
  staging:rtl8192u: Rename ASCap - Style

 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  10 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  42 +++----
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 115 ++++++++----------
 3 files changed, 75 insertions(+), 92 deletions(-)

-- 
2.18.0

