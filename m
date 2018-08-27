Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0C208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOrRGmYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA0C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeH0Xwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:52:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36987 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeH0Xwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:52:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so84399pfd.4;
        Mon, 27 Aug 2018 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GOdJAoXuIeXe5R/4K2x6SaJn9M7867Zd3zC7P3VOoZs=;
        b=WOrRGmYNJku1mXGlraI/44A+csEHy2RGhEEyuRd6gbxcGvR716xOITSShyGNWWOiLf
         v0rBJSUaKByr3y8l2blYkPc7/rDz9aYSvVDv3YOYczCDOL/GS2ei8yaTc82F6NWy6b8O
         9stsfv2q7btDTVyfsaLmyAHj5e54WhY5MuyNwe7ZcA5iEe9Kpfy2yzMU11luPJyPH9Qf
         rSkVa0DqQe9lUnOBuvTMKnCtTQtuT1bDHfM0Hptm8OENa7Yv9KZaYm2NvLa4kDa9DWAX
         0p+Dnwm9Gu69Vq9jMnvBJWU9tp2G0EfY3VeutIhCzHGLRTtKDRgezOETPGFmIYetZ30l
         6LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GOdJAoXuIeXe5R/4K2x6SaJn9M7867Zd3zC7P3VOoZs=;
        b=G8EIUC2fUOHdBSld2VHhd8dE5bJ+Yp3oGqW3BVUOluxjGXcCc95Wv0niEfipftnpej
         2wmSC3QSq/9mK+k6NQV8KryvW6NZAMiybpkl382SEOhcrO9mTsjAj7lgwLLBgv7Cpo/4
         DFb9VZoxHkbjVi3RA0uWGvSfU0Cv2yfNh9Wk3rzmn14zuoz2rztvl+SQYqgPqSlmPOjC
         oI8i/mhMZ8AwCMTwfrqF1IUh8zOjJlS6VWnVwsmZn34AC5XlV44O2MDKAGu3POxD8yYF
         S1NHFMtyaR9n4hzXUUhTJCcxbR6Xenb4IKPQDB5fHLCw4keXv7P9K0yQ3hOe8RF1h/Iq
         RnRA==
X-Gm-Message-State: APzg51A9EaSNX9VtZIKElWKTQRd/nPUAE/BQBbj+7xG2tn0Wi+fxgVVH
        ENxnMaIESZj0ldwACrVmUfM=
X-Google-Smtp-Source: ANB0VdYchKAfXuZAmKKSz/rFet09F1MPSHeCEqvyOeCQM1oPIEE+Moyb1eD5CNRsUL6chmUYIXL0mA==
X-Received: by 2002:a63:4f14:: with SMTP id d20-v6mr13434611pgb.121.1535400274821;
        Mon, 27 Aug 2018 13:04:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o21-v6sm148611pfa.54.2018.08.27.13.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:04:33 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH 0/3] ARM: NSP updates to support switch interrupts/SFP
Date:   Mon, 27 Aug 2018 13:03:41 -0700
Message-Id: <20180827200344.16158-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series updates the ARM NSP DTS and BCM958625HR in order to
support the SFP connected to port 5 on these reference boards.

I will be submitting the functional changes to drivers/net/dsa/b53 once
net-next opens back up, but this is largely independent from getting
these 3 patches out.

Thank you

Florian Fainelli (3):
  ARM: dts: NSP: Enable SFP on bcm958625hr
  dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
  ARM: dts: NSP: Wire up switch interrupts

 .../devicetree/bindings/net/dsa/b53.txt       | 23 ++++++++++++++
 arch/arm/boot/dts/bcm-nsp.dtsi                | 31 ++++++++++++++++++-
 arch/arm/boot/dts/bcm958625hr.dts             | 29 +++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.17.1

