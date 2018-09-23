Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5FECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABF2214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmmxf2rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABF2214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeIWTOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:14:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:14:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so7133538wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=p7X0yz9bohgsstRqcuUcHtE+rLVFDbuxAjHaPg6E4Xo=;
        b=Lmmxf2rAEwV2oJm/zaTNMbAtSwfRIZgBX/c2xX49X5lvLqBVqX12/s233PpMoHxaYK
         /S1OaRFmY2Lr79GRVlbb+k0d02mAoefjcioHTjzr5PzwKJhtK3nj7gqZP7L2tIkabLWc
         Y1ZDsQJj0uxLoaq6OX8tdxeIYePDhVxv2cldp/9AE1r+KfZ/YWAJWp/oaVAIROb7HBHY
         zlg4vqw2KVh4egjUgqERfnbFxk3za8tMEphak9Puo90choIWAzCm+FgDgLiDjTAyqXZj
         HBSTr6eKCtk5OYw4QtkPXL7hu08ZeV1+rkxvYahBv/R8mcfHwNk7FAfCzBMGtgNTKjoD
         hURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p7X0yz9bohgsstRqcuUcHtE+rLVFDbuxAjHaPg6E4Xo=;
        b=nfF8xG/DR2ZLalvbyyqpB8vpsRVe2lAI079QOjQfFn5Kj4CWFn1DwB/4ix0+ybLPen
         mFX+Zqfbk4jKWC6tOe+m2C/pSbRz3WFspieSthroSghao1yXAHEoOo+IM4OtaDxNDdDG
         hnRA77i831tITqTLoOby2i6mgcGsfhr8gbfX9qUvYDn4SAvXSS7inx69WiJuu5NoAXg6
         xFgMvRJt3KTbKoOjwjXP1F8kRU0/ad12i+qQjy8sdZzMT7rXf62DZXHBiF4pmK2pYo2u
         FW3AnHdNSoAHW+SYr/CGZzi1+7a9lQtLfSvxFa9PFDqENU8ifXpDkeC5PBWDCtJCeia2
         OfPQ==
X-Gm-Message-State: ABuFfoio6IgjjfoodhFX6+MengL/A2mPGyyTPNMv4Z9eoFGdYdE0X1g5
        JY7jpYyxynwMz7JHC7h0Ih8=
X-Google-Smtp-Source: ANB0VdYLvlmXoy3b6joUuEnkpU9Gdy1oQALQc0mQ3G7V5UE/0rQadZnInQ860HApzehTMyKpqpDhug==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr4117725wmi.28.1537708624809;
        Sun, 23 Sep 2018 06:17:04 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:8])
        by smtp.gmail.com with ESMTPSA id 200-v6sm25426876wmv.6.2018.09.23.06.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:17:04 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Aymen Qader <qader.aymen@gmail.com>
Subject: [PATCH 0/5] staging: vc04_services: Fix checkpatch.pl errors
Date:   Sun, 23 Sep 2018 14:16:56 +0100
Message-Id: <20180923131656.9062-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: Macros with complex values should be enclosed in parenthese



Aymen Qader (5):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Add spaces after commas
  staging: vc04_services: Surround complex macros
  staging: vc04_services: Remove spaces after '*'

 .../vc04_services/interface/vchi/vchi.h       | 200 +++++++++---------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 101 insertions(+), 101 deletions(-)

-- 
2.17.1

