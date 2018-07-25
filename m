Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC358C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CDA20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL7rttPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CDA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeGYXah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38975 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so20986edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4NMRDrMhaZzJ/NUeiE3JKT22C2v/LUJeqU24eXpt5UY=;
        b=cL7rttPAn0an7uaM6K9w2V9HHJTQW2ZpDUHcGUmlUCbqtqvc20VMmAySKzYr+2fCkU
         H6bZd12GHgRsdpU6ZnZ90cJwqEy7klNTWmde4T+wAIZCrT5F8e7LMByCgi1oUaUU3OO+
         WeeWs+V2jpeNC/ffr9VeSpMOnKPNBSnVhdvPgHLdxSYV+WVKuOXp149Ico0WLdrF40qy
         SCp5ae7vB2J3HGiS2qCrcRiO/2B5R6WFs4yBCkaMA+Mp/liJZJjArk/Ka6svX1xyakFO
         amudukLplt2m4pOoQRO+ydOXzeWCvFJxL/CmvIZZabuADMqIJikMr1PNrPVsgTbsQ6QQ
         y2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4NMRDrMhaZzJ/NUeiE3JKT22C2v/LUJeqU24eXpt5UY=;
        b=koYRdI6Y9CgHRWH4zmQWHmKt4jr9xzI13b7sU6rDtrRIErmgom3Lb4adF1OMVCEZB4
         2+eel6qD29ma/fV/yJfwQRFxaYFPMaYK09kWmybQ4TYYLutpyNXlBbKUeOQUFrX4K3ss
         EBg2eVFWcOKM+rfhvXLAkB71CRVXQtGTuZg+hoM5b2QBisr2mKTmd8mtdudptcbE4woN
         6mmNx/e7E0WrQKNPpqMp/YAzT1IpUdVZyBcFZWLg5CR7cqmdra810dQjhPkFk+lxMUmF
         8oF5Y4tJQstq/v/zLKV2rVBcA6egknVMhzA1VElP/lPber4VsMMyojOiCr2+jPpCWPCd
         YkGw==
X-Gm-Message-State: AOUpUlEYNxosTIJx7yQmpAGuRgEdINkYjbvnW6XeB1+yBQsL/p/Bl++V
        LlO8BUvyjK5E/RP5nyaQnvcTl83j
X-Google-Smtp-Source: AAOMgpdAdq6L9mvOP91/2Lkcidbkbxm6MqWnT48ddq17ziLqFnCsDBa03n2z2U8gPhGNu4MhJpT1jw==
X-Received: by 2002:a50:8c06:: with SMTP id p6-v6mr23989888edp.282.1532557013052;
        Wed, 25 Jul 2018 15:16:53 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:16:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/10] staging:rtl8192u: Coding style - r819xU_cmdpkt.h
Date:   Wed, 25 Jul 2018 23:16:20 +0100
Message-Id: <20180725221630.28595-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches contain purely simple coding style changes.

I considered renaming the struct cmpk_set_cfg_t as it is never actually
used. Following its definition however it is used in a #define:

#define		cmpk_query_cfg_t	cmpk_set_cfg_t

So whilst the struct cmpk_set_cfg_t is never used, cmpk_query_cfg_t is.
I left it because the comments described this.

I was also tempted to remove comments at the end of lines pushing the
lines over 80 character length. The comments are at the end of sizeof
operators which explicitly state the size. I'm not sure much is gained
by the comment, but I left them in:

#define ...     sizeof(struct cmpk_txfb_t)	  /* 20 */
#define	...     sizeof(struct cmpk_set_cfg_t)     /* 16 */


*** BLURB HERE ***

John Whitmore (10):
  staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
  staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
  staging:rtl8192u: Rename bit definition ISR_TxBcnOk - Style
  staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
  staging:rtl8192u: Rename ISR_TxBcnErr bit definition - Style
  staging:rtl8192u: Rename ISR_BcnTimerIntr - Style
  staging:rtl8192u: Remove multiple blank lines - Style
  staging:rtl8192u: Correct spelling in comments - style
  staging:rtl8192u: Remove typedef of struct cmpk_intr_sta_t - Style
  staging:rtl8192u: Remove typedef from struct cmpk_set_cfg_t - Style

 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 22 ++++++++---------
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 31 ++++++++++--------------
 2 files changed, 24 insertions(+), 29 deletions(-)

-- 
2.18.0

