Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E64C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5EF24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLWEeNkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5EF24207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964822AbeGDJGh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:06:37 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37379 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGDJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:29 -0400
Received: by mail-lj1-f170.google.com with SMTP id c11-v6so3724482lja.4;
        Wed, 04 Jul 2018 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=U7uZng3++7TGnwzzRNS+3s92/iS7grhyziRS6KdkRww=;
        b=XLWEeNkvG45FBVxFmv14DgxzA64t7Td2GTZWA7ZXRRfFKCN7aGwTm4XnpG1RvOyjbZ
         oZOKeMuQ24duBGaI43RW9l+zb3Tv9JOR1jDXV2Qo3rt891ZiQLtoY3bx72uFVQUAAhag
         lFnR4tmq+b6F5c/4QQJZ7DR38yLfX9SwqTa8R0fW7nm5tZVLImMipl8E31N0q3ObQWuH
         uQd6rJdSDQhkYadVzVL6Vxa96hycAgao9F8E/fr1uME2erFZEFQGuhCag/tNJ24tyHEY
         pZ7gbjQjiLT4t3xec3igzJpRi8Ap3DB0NqHIS6o5PVrzHoJWbkY4+5FDO+ZypKzgcjII
         LXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=U7uZng3++7TGnwzzRNS+3s92/iS7grhyziRS6KdkRww=;
        b=GxFgTrtg+KtsQZzjJ6tyoKDBYAOqB4yZBOpm2sIxPP7qCNiGHpBhMO7qFjLOkUi6/y
         SBb7nIamE+kFMM1j6KtAy6UFyxQyeq5wTXm87KOCheEIGLng2IwycKKnjsP9dKBI9ODG
         K1NjtS7Ma54P5ZSf60AMhyf6dD9BqkG7wmjxWanOJLaTQlavedgvfVptRl1LWdNqCH3s
         tHP+3JlBZkJ84V42lUiaWUhQSKWfkhZoAeYWqPggRhN18UecjMt5Ky2Nkmp1Ck9p8ydz
         muFFMLkgEQuGwBTOcyekliUg1YCzDHJt9XoxOxtQFkAZbfZxXR9uYQLnPVmJzH5wmbmY
         GIGw==
X-Gm-Message-State: APt69E0wemL4BEdJ2XN5OV7zdOUXVna2E+OVU+hIKUJhyts1ZhWNbPYm
        U6kFhi3YxwhsXtkxC9rPJMU=
X-Google-Smtp-Source: AAOMgpdXJGMbpQYTCHsoo8qhjrYLq7bptI82ZBT3aQQieEieYyoYSljJkWmtD9APx7b7bN+TvPg5tg==
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr900366ljd.120.1530695187753;
        Wed, 04 Jul 2018 02:06:27 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n6-v6sm495815ljh.77.2018.07.04.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:06:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fadjv-0004LH-Aq; Wed, 04 Jul 2018 11:06:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] rtc: omap: fixes and clean ups
Date:   Wed,  4 Jul 2018 11:05:54 +0200
Message-Id: <20180704090558.16647-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a couple of fixes for issues discovered through inspection
along with some clean ups.

Johan


Johan Hovold (4):
  rtc: omap: fix potential crash on power off
  rtc: omap: fix resource leak in registration error path
  rtc: omap: add missing register lock in error path
  rtc: omap: drop unnecessary register unlock around reads

 drivers/rtc/rtc-omap.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
2.18.0

