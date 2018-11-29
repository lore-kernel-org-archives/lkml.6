Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1206DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A9020868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A9020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeK3H6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:58:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33438 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3H6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:58:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so3130930otl.0;
        Thu, 29 Nov 2018 12:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nKOQseCdTl0/lm5f+RObKZLKvHMphndCC5EWz2ISwhw=;
        b=b+hkZ/IcfbrXussWnr4U4AicxDZsoeI0iWmpMAXbABh5RavrM6/KvGBLQ2eGDnqoVX
         jjUCcf1quIwASIgE03UKILlifBlcAdTSNwHCCDX2+W+//qP2VAcace/3UlGwVWrj0v5A
         Uct1aQkZjlb5xMcf5yeDh4Q2jQywZmQfanL4dVndfWMZDVxye/hnOXTIYdXceyEXzFS9
         WcbFG7hpPd7Hrj60fUJC+fNcJz7fGPShfqjddD6rsenaopuWdZcqJb9VpTu2Phq6Sv9E
         wg5I2h0t2lChVfU58ntobWFa3oEhcF4JNA9REUGGudh4pfJUfONbbjDRibP2hVc8VJjO
         0CZg==
X-Gm-Message-State: AA+aEWa3fbzKJv12Ku65OykGFd+cHlH+YAUjoI5wuwNCr61mAgmljSyA
        bCHM8JDKcZzqsa8vVXyl4rPw4lMrm7muinh8J0Y=
X-Google-Smtp-Source: AFSGD/X/j0Jpkxi3yy9ThdzZqGOLoZ6dHrDUFzfylZ9am1dk2d9s8DQ4fYs/VeO4BcZ37h5fvLy6hcxRB6wQ+8u0xCg=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr1955945otg.139.1543524716265;
 Thu, 29 Nov 2018 12:51:56 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 21:51:44 +0100
Message-ID: <CAJZ5v0hgS2fyWLDyeeGzqyFyeie26KnswNnc=aX3RYoP5Zv7vg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.20-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.20-rc5

with top-most commit 36c3aeb4b48d5b058526d606fde14db4fd7e5e6d

 Merge branch 'opp/fixes-for-4.20' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436

 Linux 4.20-rc4

to receive power management fixes for 4.20-rc5.

These fix two issues in the operating performance points (OPP)
framework.

Specifics:

 - Fix the handling of the "operating-points-v2" property to
   avoid failures if multiple phandles are present in it which
   is legitimate (Viresh Kumar).

 - Drop the unnecessary static initialization of the .owner field in
   the ti_opp_supply_driver structure (YueHaibing).

Thanks!


---------------

Viresh Kumar (1):
      OPP: Fix parsing of multiple phandles in "operating-points-v2" property

YueHaibing (1):
      opp: ti-opp-supply: Fix platform_no_drv_owner.cocci warnings

---------------

 drivers/opp/of.c            | 6 ++----
 drivers/opp/ti-opp-supply.c | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)
