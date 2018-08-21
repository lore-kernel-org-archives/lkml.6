Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6AD208EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LszB+VNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6AD208EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeHUUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35422 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeHUUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so675354wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uzRy4RfruqTay4Lnp2+O9MrOYOsua39Ei76DQ0i6VMI=;
        b=LszB+VNF0PM1e/21yl67OSIzImRqMp0guwbnbTTLPT4jIRmtWyFhm8VIRdkcaKfhGB
         /Nsr8bkRNfaMTsPOM7PT++m+Xtg1JMzdJWaCixqb3WBd7jXt8dbXQqmCxVL1/ihfuLKl
         po8TlLPVzNMYAu2h8gOkmEfQbgRdHrIOpQ527kv2Fia7s/2od8+H8v9+XQGBoqryEmIB
         CCsTbXwq8xO46xzeYISGW4ji2ruzCgdLtiAqqzav96LfSQW8OPuREQXtl90gnPmxBgwM
         AluhjK+z863X1ElyBfjqSHbAziET58VqgB4R3X0T0v8Bd5lp+5BUDoHm9K6LIceG/F/a
         1nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uzRy4RfruqTay4Lnp2+O9MrOYOsua39Ei76DQ0i6VMI=;
        b=pAUKYVbz6S9ZoN7xLBcGwL5LbD2M15qDK1olz4mDFprEZBIhkvHFWS+tfevWpbEhZs
         +xarZTH1feHM9O8gUNZFVFjryqC/us0tahp7P35opShsg3nS92aCs/8/h6lZIjkcXk/f
         1g3yYMY1t2JnicfZ2G0Vtu+71u0GwTN2f+Ad5kDuyYnin9VypeezCyXgWc6GRahG9Xxd
         MKh0JguRhT4+7v8ejilZHmtTGBZCm8vm8lE0NxSibNuzoddtTqPO2UPpRHcoBntvNIIa
         A/+2z8TGeM3GSlQ7/EEVr8E8BYfT5V1eD4NhKKomuNZ01ub8OIGPFe54ui0yfSzVtyBy
         eOvw==
X-Gm-Message-State: AOUpUlEUACejz6j6anee1+lc7xlsGGwkjY/+X/JayI3znkSEvwDbLIhA
        T0tRKVmQEmRBqcgMV2amoGo/h8Fh1MQ=
X-Google-Smtp-Source: AA+uWPzIBA9hM0nXO2ZmAavYCTvGfx1XakpLXp8h89C3F6dmSYASvJsdZXkWs7NDVXSj5KzGGm7otw==
X-Received: by 2002:adf:8161:: with SMTP id 88-v6mr32084875wrm.22.1534871739203;
        Tue, 21 Aug 2018 10:15:39 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/17] staging:rtl8192u: Coding Style changes
Date:   Tue, 21 Aug 2018 18:15:20 +0100
Message-Id: <20180821171537.9330-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to clean up the header file:
drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h

John Whitmore (17):
  staging:rtl8192u: Remove unused defines - Style
  staging:rtl8192u: Refactor SEQUENCE_CONTROL - Style
  staging:rtl8192u: Rename ShortData - Style
  staging:rtl8192u: Rename member variables - Style
  staging:rtl8192u: Refactor BA_PARAM_SET - Style
  staging:rtl8192u: Remove charData and rename shortData - Style
  staging:rtl8192u: Rename ba_param_set members - Style
  staging:rtl8192u: Refactor DELBA_PARAM_SET - Style
  staging:rtl8192u: Refactor union delba_param_set - Style
  staging:rtl8192u: Refactor struct BA_RECORD - Style
  staging:rtl8192u: Rename member variable Timer - Style
  staging:rtl8192u: Rename bValid - Style
  staging:rtl8192u: Rename DialogToken - Style
  staging:rtl8192u: Rename BaParamSet - Style
  staging:rtl8192u: Rename BaTimeoutValue - Style
  staging:rtl8192u: Rename BaStartSeqCtrl - Style
  staging:rtl8192u: Remove commented out code and indent - Style

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |   4 +-
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |  84 ++++----
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 184 +++++++++---------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |   6 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |   6 +-
 6 files changed, 136 insertions(+), 150 deletions(-)

-- 
2.18.0

