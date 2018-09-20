Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E41AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED4521532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIruuPQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED4521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbeITWsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:48:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36734 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeITWsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:48:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id j192-v6so299242wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OihSbtX6r/5FcAq4RCGAb9NXTtzuxjqR/7Wa5bdSJbk=;
        b=qIruuPQQTMZH9jcueFcJd1fLCT8nJpQUj6pUXz95Pwry4lGMb0eoEMIxlKwBu/d0Vr
         e08pIk3dKwcgsZIQI6WvXCqTIS0xniHZ8O6al9gGV905Xif68S0jvdOSRdA9emoiODqc
         8wPKm5UxxCPXn/jBvFCnAfzOOW2V1ya+wW0ZUurnk9xWaTbpeTTsBRNe+hUKnysDPAyJ
         +C1N5L5fM0E9EsafzliYYLdsAqvJGo+kyNT3TVn17uxNG1rBr0hWfW6BkMXLHC7owDx/
         PJd4ECU8bq1GVnW3bUFfFY0Nj/lGXl80FL0+vklyzDKUVUTIygeGSMHTApZyM5UovQ2b
         zbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OihSbtX6r/5FcAq4RCGAb9NXTtzuxjqR/7Wa5bdSJbk=;
        b=Ckb3XljvEbFbi9ES2QgiCCN+etc9yNvuVhf2WBgUOY8xnIwidSsHdnAmvYM3XuQHKM
         aaYQSrN/nzLIGtc8sByKMrWHjZ9VZwBh431O9Cu81EFMPV3kB2YF+AOHBaKSsj9eGc9i
         9KEscwACwUWDjAHKhGa6R7cntyI8VfdaGRDGkLj0tZVe52Rd2eoMwGB0fWBYqrZ9o38L
         dRyVsbU+ZeuA+mNeYKN6o7OP0BuR2114VGbn+sxW2ZVJANxtNFjfIt74V0+NU4kqTiUq
         XLGttUiUT5zfopL1sB4SEOKTINhSfg/5WMd+tHipVpxOroc+tFSMf1koonga+IgShXmb
         owdw==
X-Gm-Message-State: APzg51Cx1TagomFkUHW5drXnjZs47th/prh/k5H50cY31sLZSUHx8e2l
        mWcIIg6L7rV3KA0d+6Fw2ULTvJZUBpE=
X-Google-Smtp-Source: ANB0Vdau4htIXZcDW86bmGFhHcxY+6O9ra2kvuKmnZV2LQcWtiaXuEACpdzvF5bGY6G/uFulMsQ3xA==
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr3499939wmk.119.1537463024959;
        Thu, 20 Sep 2018 10:03:44 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id t131-v6sm1540221wmg.10.2018.09.20.10.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:03:44 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Yasha Cherikovsky <yasha.che3@gmail.com>
Subject: [PATCH 0/1] MIPS: Lexra CPU support, prerequisite patch
Date:   Thu, 20 Sep 2018 20:03:05 +0300
Message-Id: <20180920170306.9157-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a prerequisite patch required for adding Lexra CPU [1] support in
arch/mips.
It does not add any Lexra CPU support yet, but it is required for such future
support.

The patch is written on top of v4.18.

Background:
I'm currently working on porting Linux/MIPS to run on the Realtek RTL8186 SoC [1],
which has Lexra LX5280 CPU [2].

The complete Lexra + RTL8186 support is still WIP [3] so I'm not sending that
for review right now.

Thanks,
Yasha

[1] https://wikidevi.com/wiki/Realtek_RTL8186
[2] https://www.linux-mips.org/wiki/Lexra
[3] https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18


Yasha Cherikovsky (1):
  MIPS: Add new Kconfig variable to avoid unaligned access instructions

 arch/mips/Kconfig            |  7 +++++--
 arch/mips/kernel/unaligned.c | 24 ++++++++++++------------
 arch/mips/lib/memcpy.S       | 10 +++++-----
 arch/mips/lib/memset.S       | 12 ++++++------
 4 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.19.0

