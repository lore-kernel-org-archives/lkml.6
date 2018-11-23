Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06117C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A8D20824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c79iPrQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A8D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441209AbeKXFfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:35:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39796 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441183AbeKXFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:35:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so5274113wra.6;
        Fri, 23 Nov 2018 10:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+M26Lr8s/c9SHMmyEDRoQeC9KLS+s2vrgXbNicaowEA=;
        b=c79iPrQWHrhgy5XIeKpbu9QXGL1QeB7e6RdwXsLyChsNh3MChahRxUxNjy4XSKGg3U
         3YXhYDGeK5ZhD351+LVIMjVUOiGMUi7a4s708jFRDszxwBjTbRpgpLVnlXGzdMpNRNNp
         BSK4oKrkZN9Phm+5GmULZhWbpwRjUVDp64MjAUf+w9HtEU4iqx6nHSSsoIUY2jPEU2Qb
         pJfjf2Qy+61q1WKvxevyVa4cofFrC4svdmYuse6SjeGGg1UDGTAGB7Hfp+48TdGkw5Rt
         BwN7jfaI89ujK1Qdb+8TeQtPfRDuGAGW9wYCBICiMnyk3qQ86IAWWXnCHudVmcMIpOr5
         i2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+M26Lr8s/c9SHMmyEDRoQeC9KLS+s2vrgXbNicaowEA=;
        b=C7V/OGS5iR9xM8d5eUVGGSag+YYmwnpw4WruX+E3JbbneaALn2O3Y23whb9XEqVdd3
         mVvlWlsUANpnwYri2MzqoRDclzaBkuSY98pY9A+mapuqo7DGNUIl4Yj0psPSfJK7Pua9
         0rJ19b3//ZZPkDB6N1gk+DZvh3TtzZrfyA4g82KvFnZaPuVRLXJO7Ka5U1JfbugggnSF
         bMRgWnzQUNAOlXLVchB651QOQb3G1F+3xJAR20OxoM9/QJDXTHOKC3kzCGgKnzn6p+BW
         pRLlf2FL00GWWVRsEH+RQRsWNP7tA1CcluPW2f+08+GrSeip3o1aVUbwHmJCfeeMQtlw
         hfVA==
X-Gm-Message-State: AA+aEWb64+3MhLZfPm+jB5udl8cCJ/j9nspU4SLZZYCCdljSCKIKJqJj
        pxcdtXVgfmHub2/eXy2JoG5OWrsI
X-Google-Smtp-Source: AFSGD/XkHaXxgHqZ31S0Yv1wnxQeYmwwDCliBBpuuNSOB7iRGi7N/+nJjaMexT4YvFZ8vaSZGC33BA==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr16100360wrq.175.1542998979831;
        Fri, 23 Nov 2018 10:49:39 -0800 (PST)
Received: from orange.local (ip-94-112-136-201.net.upcbroadband.cz. [94.112.136.201])
        by smtp.gmail.com with ESMTPSA id x136sm11120632wme.0.2018.11.23.10.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 10:49:38 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 4.20-rc4
Date:   Fri, 23 Nov 2018 19:49:19 +0100
Message-Id: <20181123184919.10675-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-4.20-rc4

for you to fetch changes up to 7e241f647dc7087a0401418a187f3f5b527cc690:

  libceph: fall back to sendmsg for slab pages (2018-11-19 17:59:47 +0100)

----------------------------------------------------------------
A messenger fix, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: fall back to sendmsg for slab pages

 net/ceph/messenger.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)
