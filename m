Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848BFC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E293217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdzRmY8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E293217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbeHDLTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeHDLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so8707249wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P3mUxz9MTDPsKM0996Jpn6GqhSHJsbB+IGTFZ1WkBaw=;
        b=QdzRmY8KFTmOROcI9QLZD+WoVsLf5zOMpF3h8xcV6JDPnRcpOcW48YxZl6DY3T376r
         +7ya0IQHWIQ5OhVgu8XBSnPhQ9QuhxoT3/s+geiQHgITYcPTWlOu1/Vaba8qJZNRUTQQ
         CcfWlY1lSdcVd+jawN4kXHND+EuAWtA2UX17F6DPMW9m7s3lgq2c2S99hrjZKv0zODeB
         lXFLOLAAQLIaXnesUEy9/zpj/4LDfFTXbBQAP1sqkDTekBOCXTulxfOFbD3YmeqrNdNL
         LhxeQtFJyElV/waGZ6pj3HdMX3ZyxMMNOnpcyLgGov7ULLCTDyl3g4+6hQutpYYRXZ0Q
         uUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P3mUxz9MTDPsKM0996Jpn6GqhSHJsbB+IGTFZ1WkBaw=;
        b=fcJbP6gihKeDrRbfCkErEuhSDqNBoRDrWLIKrsTJrFaowmHZMBuwH3mdlFWA+1ZdSI
         J1dMaTC8Y9gs9d2NAqbCOgsqzyqS633mJsLL4MgkTDltWSgiNsK7DWo4i8pROqlnTy8X
         64vuw2jRZNMTByMA2ZV7Rl7aCu1L/u7shMGGrE40zjHU4oV0eUIsK4v1JRgrwulu3LjW
         GWHh4JwNHOe1CAks16XsZUpTisQtuk4wrwriVabgAru58ocLLthRN8WgIdYaNpUzpZ5w
         WhfUyvTg2WX+VTYzmkI0V+GuPNrnlBeHQyiLXPuj0d95cXxkyV6YMJde40YAEoK4RpEN
         AZZg==
X-Gm-Message-State: AOUpUlGzkN9QwexWuDQPiOyE/hJty7nb3MonmAcd/NL9HMf7eUsnexK2
        4dCwPm4nmw00VIAAdlB0OnK5+WJJNYg=
X-Google-Smtp-Source: AAOMgpf5vQr9O6Sc30/OKtmsM843mrnFwqdk1pbh8MiI4vjzep1UUk1h/8zAfbungsbaX1rqGFzhXw==
X-Received: by 2002:a1c:c4ce:: with SMTP id u197-v6mr6821933wmf.10.1533374345253;
        Sat, 04 Aug 2018 02:19:05 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 0/7] staging:rtl8192u: Coding style changes
Date:   Sat,  4 Aug 2018 10:18:52 +0100
Message-Id: <20180804091859.6729-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup of the drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h file as
the QOS_TCLAS union was moved into this file, in a previous patch. The
type contained a number of naming issues.

John Whitmore (7):
  staging:rtl8192u: Remove typedef and rename QOS_TCLAS - Style
  staging:rtl8192u: Rename types in QOS_TCLAS union - Style
  staging:rtl8192u: Rename multiple variables - Style
  staging:rtl8192u: Remove blank line - Style
  staging:rtl8192u: Remove comments - Style
  staging:rtl8192u: Remove unused member variable - Style
  staging:rtl8192u: Replace magic number with defined constant - Style

 .../staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  2 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   | 99 +++++++++----------
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  6 +-
 4 files changed, 54 insertions(+), 55 deletions(-)

-- 
2.18.0

