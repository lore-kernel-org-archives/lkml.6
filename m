Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39E208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 21:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V03FPUFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeKPHvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 02:51:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42874 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 02:51:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so11578451lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 13:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w8hYc+cJknzx6E5VRs7a7d8rjfXPC1SfjFbzIaJtqfo=;
        b=V03FPUFCFK2w1Mab6l2rlo+bIAC+wqoR9XgAzvLRNSXOS09CxxfqHfrLXuiENNqV6K
         zGgv2s6YICJbufja/yEQWxJbg9LcMRLF+Zy52oMk+tKPv0O7g3RuGIKvB8z458jh1ucj
         jS2AMoxiefJRFBu/UwRU2e4HgILH7AVhfuOGRzkLdFOVdDMTVwb+SNsX7jUnVTwMDBNL
         axvUuTh2fRWeZ8ENLU7YuDfPMXpTreXu3eKdjsMjZWmI5Qz4ygMPEQyU6f3Gf8Zt0vPF
         qsXkYMInJ4x7Bo00bjyrnmj3xt57RuynRzBMrMbwNq4WXmhfjmCV6SKVvPWstIruscoy
         dGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w8hYc+cJknzx6E5VRs7a7d8rjfXPC1SfjFbzIaJtqfo=;
        b=W73Mk4mfhCHxIDjoZ6Uyv/YCjwGYGibQLhrmgEN3m/4TTWoGQyWh3D8SuwITyqjOJw
         RSKHtVGyyUp2hOrn1XAzj06XwEpSuNJMoTehq73Esyh00GXzf/eguNoPkrHSF0mtwtwI
         mVre5Ggy9996HCDNDUkbeQR+nXvIP+h2CoBODL6auy2KepOkxlzygbhnibOG21AA4qbd
         pXAndBLDoaJXj6S4QcNqM3VX3jI361U5lZMZG6DbXVuVQYY4pRD5gZdlmDvwClt42l4l
         RFZzlXH3FmpS30aGEqvnnNZa+X+iPI4g3BgnFs9RwbgAyC4aof45OHZ9kOv4k0H5Z7i3
         c+fQ==
X-Gm-Message-State: AGRZ1gJU0xwfTJqfJVfbuHH9AuY+zDU+6DV++BDvxXpZvRybIALjV55y
        PXpPvCW1CLbtL0ihoxLy0PQ=
X-Google-Smtp-Source: AJdET5eeK7SWosRA03+0T/91+KgImiLdb6FnRMbpXKsujDHVvJrcok3gZauJqFs8zzqC9c5bOEYccA==
X-Received: by 2002:a19:7013:: with SMTP id h19mr4610239lfc.147.1542318085992;
        Thu, 15 Nov 2018 13:41:25 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id y14-v6sm2224847ljj.55.2018.11.15.13.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 13:41:25 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/2] Xtensa fixes for v4.20-rc3
Date:   Thu, 15 Nov 2018 13:41:07 -0800
Message-Id: <20181115214107.7376-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two fixes for the Xtensa architecture.

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20181115

for you to fetch changes up to 40dc948f234b73497c3278875eb08a01d5854d3f:

  xtensa: fix boot parameters address translation (2018-11-14 00:15:32 -0800)

----------------------------------------------------------------
Xtensa fixes for v4.20-rc3

- Fix stack alignment for bFLT binaries.
- Fix physical-to-virtual address translation for boot parameters in MMUv3
  256+256 and 512+512 virtual memory layouts.

----------------------------------------------------------------
Max Filippov (2):
      xtensa: make sure bFLT stack is 16 byte aligned
      xtensa: fix boot parameters address translation

 arch/xtensa/include/asm/processor.h | 6 +++++-
 arch/xtensa/kernel/head.S           | 7 +++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

Thanks.
-- Max
