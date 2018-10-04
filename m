Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DFD2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jNh8hNK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DFD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJDWeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:34:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34395 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbeJDWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:34:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so5368203plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=kWKEk2GQeNeC03T6CWNduYdT1trS0Z7OPzf0PsUC8to=;
        b=jNh8hNK4tlMKjJ+e1loUBKe4+O6+mPGRFvycYAD5IyM6iu1MVjkdkxKAkF8yDpKInw
         QlQT/CipmUueH8Gz/lyNPImkhIeYhYjUEtonjWj/GPcUSlnDPCrWk80C/w+LDm65seRB
         YRS1ZLmNR5C6WkMi1LYJv9fOwaVVBIPft86ZFxatg4W+1uQyzcxxOZlJ3eKpjLLLRJWf
         6+2ZMSOHaMHPmTZw0+aHfqdsgDEG2D+g1O3lZqpLA2Ml3SU4Hm2FkQUonXu0fo7efLmT
         65aQW+Mc9FVMjv5vCZGSIIqzoaNAdPMgdTBlX/aV9XSpUtpdW8VBEUNJy6y6jGkxIxFF
         IKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=kWKEk2GQeNeC03T6CWNduYdT1trS0Z7OPzf0PsUC8to=;
        b=CEadDLBkVTwV2Nr6v5GNi3vnDqVnGf/ioLKkM2nSZJeVh3KCZKihNfdP1UgaXV5MfU
         9Hwg7INe1uHPhTGvbZG99Xy2+dblimhgZxBNbcqEBxnRQqJKiSR2oPJvBwQydf9zFBHQ
         Hx82u66Mn3CUC57G1HAM3hZmaOh6pxELbMh5eJiHUG7ckOn2l7VDy8spKRQLTdOXYIHb
         afMqh2iA4nMHTx90DHN8wtmD8Rn0rL00sgEwVIewFXa1PAGkZNkrpGD5+WuPZjy65LyK
         +FXNvjwN8WXEy1+shmri3tycyZg9Sm5vY4P6ELL+GI/Zz33sVA1/Rwn3PO+CBw6LRaMa
         jwUg==
X-Gm-Message-State: ABuFfojmDcLbKIdK9zQBqXwWYLVcIQ+KnyZyquqomqnnugm5xgvDUIwv
        sM/DGK+PEnDqjkeJa2qAkryJjQ==
X-Google-Smtp-Source: ACcGV619gqdQZb3S7xorCWlbocKJFDrmpgASNDD+9NdGaQd/uvU5gPVW2sT/1Lqy8C4lyKC7rSdRAw==
X-Received: by 2002:a17:902:b109:: with SMTP id q9-v6mr7217885plr.83.1538667619228;
        Thu, 04 Oct 2018 08:40:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b29-v6sm9504228pfj.183.2018.10.04.08.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 08:40:18 -0700 (PDT)
Date:   Thu, 04 Oct 2018 08:40:18 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Oct 2018 08:40:13 PDT (-0700)
Subject: [GIT PULL] A Single RISC-V Fix for 4.19-rc7
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-cfdf26dd-f145-40fa-b698-efb9b65de276@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.19-rc7

for you to fetch changes up to ef1f2258748b675422ca0107e5bfb9ceeac675de:

  RISCV: Fix end PFN for low memory (2018-10-02 12:50:01 -0700)

----------------------------------------------------------------
A Single RISC-V Fix for 4.19-rc7

This tag contains a single patch that managed to get lost in the
shuffle, which explains why it's so late.  This single line has been
floating around in various patch sets for months, and fixes our DMA32
region.

----------------------------------------------------------------
Atish Patra (1):
      RISCV: Fix end PFN for low memory

 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
