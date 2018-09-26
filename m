Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4492064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDuUoRE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4492064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeI0Bbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35903 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeI0Bbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so2899975edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ggsM6hU9JSeGqpU200PShbKBY7SAHZJnGTMHSoO3kjI=;
        b=DDuUoRE3jWrD3m1/MGh6AlEPfN5X+c5TSyfzFDpVbeLPpnaDxMyRJ8mbBSHZR9snZo
         rQtR5E2iEqDfp1VIZoXUeBboB0siwuk4LP/flEUtJBIuUGww0yRXa71HO7iDXwQ52AA0
         x/tcu5ue7Vst40anYOQlcowA1amfzsjiVJD0Ylj/dLJw5rRoDeN9EpAMyRMgEkXQhYST
         ZxUHwcFCnBbpUhoyoSbLnE3ki8UeqUnLf3nzxmnfwOy5sU91k8XwKpnW9vz3ra8HL9AJ
         eTzr5L+8bvN0Kxn9svWj6OmAq5EzK6z6ICjJgmjnv+Xf1606ZVWDoabAxuCimdGH5iTW
         zN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ggsM6hU9JSeGqpU200PShbKBY7SAHZJnGTMHSoO3kjI=;
        b=Aoi7BXwFph0xqmjvXJR/xeYbowDcTLkkabXHgzkbJR+9iJVdm5aiA6eG+Cn+kUfSrs
         eBOcUORayJ6SFHOw/CEHijm/I4m5j73lHQBcLaP48WJhq3UVe0TxJat38HxX+jTnbizQ
         XohlX8nCo/p2T8ojrMEDQpNnAQ8ssGOh3KXJzGzWN7wCCYmEjtuM8FuFSt51up9M2v9m
         RnRupjdJeW+WN0l4dCvjhGbPsVnxjPYlZ/6D6FXg1j0Q0ZjuzZ7xbgZ7sA/hciGMe/ah
         HOoPMaiNdeJX6IZ+oYlxfLOhvtbzz2ZHjyx8+0+E88XXWTXy9TdS60JSxCcAqeUzsHka
         qrmg==
X-Gm-Message-State: ABuFfojyZYUCq1QNh5VxTi05PBF6XFl/BCu6ifbMP2sf+ARzN5noFQty
        K1+7pig4JlIr4Er72MWN6y/lDOJY
X-Google-Smtp-Source: ACcGV61zg9RbhThiNApShMiaxQYPNAQphaw03FnJzZGv1oSLTNKPO/w7MPHeIxzzOJIKf3mT1B9a3Q==
X-Received: by 2002:a50:8ca7:: with SMTP id q36-v6mr12406423edq.3.1537989441450;
        Wed, 26 Sep 2018 12:17:21 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/13] staging:rtl8192u: Style & memory leak fix
Date:   Wed, 26 Sep 2018 20:16:51 +0100
Message-Id: <20180926191704.16322-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back again. I previously went through the struct ht_capability_ele
renaming member variables as being unused. At the time I wasn't
100% sure that the structure wasn't memory mapped, or used by
external callers to the module, through function pointers or exported
symbols. Having had a more detailed look over the code I'm happy
that these member variables are not used and have removed them from
the code.

The last patch is a potential memory leak, which only happens if two
memory allocations succeed and the third allocation fails. So it's
probably never going to happen, but fixed it anyhow.

I've tried to find this device, or a datasheet on it, so that I
could actually make sure it still worked but that's not been possible.
Apparently it's a discontinued device, but that possibly makes it a
safer sandbox to start messing with.

John Whitmore (13):
  staging:rtl8192u: Remove HTHalfMcsToDataRate() - Style
  staging:rtl8192u: Make HTMcsToDataRate static - Style
  staging:rtl8192u: Remove definition of HTSetConnectBwMode - Style
  staging:rtl8192u: Move HTSetConnectBwModeCallback() - Style
  staging:rtl8192u: Remove AdvCoding and GreenField - Style
  staging:rtl8192u: Remove TxSTBC and RxSTBC - Style
  staging:rtl8192u: Remove DelayBA, PSMP and Rsvd1 - Style
  staging:rtl8192u: Remove LSigTxopProtect - Style
  staging:rtl8192u: Remove Rsvd2 - Style
  staging:rtl8192u: Remove ExtHTCapInfo - Style
  staging:rtl8192u: Remove TxBFCap - Style
  staging:rtl8192u: Remove ASCap - Style
  staging:rtl8192u: Remove potential memory leak

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   3 -
 .../rtl8192u/ieee80211/ieee80211_module.c     |   5 +
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  20 +--
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 123 ++++--------------
 4 files changed, 30 insertions(+), 121 deletions(-)

-- 
2.18.0

