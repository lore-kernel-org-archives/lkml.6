Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA653C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603120700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YggHQ1R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6603120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLHV2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:28:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40466 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLHV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 16:28:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so3221624pgp.7;
        Sat, 08 Dec 2018 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3DG4Rb9UKfbFwGj/p1Ztvn3H7Df1xmPUh5r95YoM7g4=;
        b=YggHQ1R/zB2aLuF48lCjiFe+6KCEJlrIRe3XOkWd3ZbMTxTaBFZh96seCo1Ek3Eusi
         6bigJhLWf2EgWVqF5nWCmZjz+1yOfRy6hxoaCqJpatpR549zLUyi5U1UeHjzOk1vINUA
         rGod3ZN9sCKbz03I1MUTwch70g0r7Reoy+LjwsncT9v/xFbEaSVK3T0NFI/Ks6p8p3tJ
         wpKxxw3qXKxaZWkdq4Xaz2wUuh/YyrcL4Xm4jYIIsDKnTRySEj2Qn6Hx5/3df2jvaf+0
         LdHQxM3qLQhr/xaaNcx1LKTgjOyG/hj0yQDp2LCWDAEERqGGRhrWWE12T83lMHhaJyAJ
         5F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3DG4Rb9UKfbFwGj/p1Ztvn3H7Df1xmPUh5r95YoM7g4=;
        b=MNvZpawM5Cq20k+/n4wXYuORtGtkdc1bB/306dULyLMdrun/uECbt8d9BAadSD99XH
         KsiWTbVbk24HKrpDX9T6y952Me7s9z8RSV8Lyks9gIn1oJrZOUihOLR9+EaJj82hfN9y
         aaG2Gyl5J9syB2sbc9MDOR4jarvxXWsYilJcyazteeVF7jpH9ajLYZfxLmpVWWb/sYBI
         uQ7QLlyFoVjccjsOWwTe/RxYkv/pIVRZEEjH6Nk3jWvhMoD1muWkC+id/0ogNWygS0+8
         YdNs74PjuhVt7A6YZCjHJ7hDQl0UsF1BUwNHKCjww9Pgw/zMU1Nq6AY+XeX49pIQga7A
         bD1Q==
X-Gm-Message-State: AA+aEWaqeqP57FPql3ddKGy1fqq7Oe9hVbHn/9KRg1FtRRalz+rW6KXn
        MNSlOt4nfVEsNyJ5FdFs3mQ=
X-Google-Smtp-Source: AFSGD/V1eVc4syEIpDQIM99YG3Wu00OPz0X8JjT4hqM4b23/6OwHlI5IEoNRZUulgoUxZ29VHCcFqw==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr6186701pgk.147.1544304531692;
        Sat, 08 Dec 2018 13:28:51 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id r76sm10060012pfb.69.2018.12.08.13.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 13:28:50 -0800 (PST)
Date:   Sat, 8 Dec 2018 13:28:48 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rui Zhang <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management fixes for v4.20-rc6
Message-ID: <20181208212847.GA3352@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Consider pulling the following patches containing fixes on thermal soc.

The following changes since commit 0072a0c14d5b7cb72c611d396f143f5dcd73ebe2:

  Merge tag 'media/v4.20-4' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-12-03 11:29:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 1aea7aee805e3d1288f9f1fa4484964b51664960:

  thermal: broadcom: constify thermal_zone_of_device_ops structure (2018-12-05 06:47:46 -0800)

Specifics:
 - Fixes on armada and broadcom thermal drivers.

BR,

Eduardo

----------------------------------------------------------------
Julia Lawall (2):
      thermal: armada: constify thermal_zone_of_device_ops structure
      thermal: broadcom: constify thermal_zone_of_device_ops structure

Russell King (2):
      thermal: armada: fix legacy validity test sense
      thermal: armada: fix legacy resource fixup

Stefan Wahren (1):
      thermal: bcm2835: Switch to SPDX identifier

 drivers/thermal/armada_thermal.c           | 28 +++++++++++++---------------
 drivers/thermal/broadcom/bcm2835_thermal.c | 11 +----------
 drivers/thermal/broadcom/brcmstb_thermal.c |  2 +-
 3 files changed, 15 insertions(+), 26 deletions(-)
