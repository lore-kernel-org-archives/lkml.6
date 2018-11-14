Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0241DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0286214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNqkO97F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0286214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeKNSXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:23:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:23:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so4698758pln.9;
        Wed, 14 Nov 2018 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=llBiLMgR6kf3KmBqZ+Xhu1UZ2vuYADUzibVoX/bVeds=;
        b=LNqkO97FQB5ZKZEx4FB/ezgJ2S+QBvVHTywJTFhCLRUxWHuByHRxCA+mSn4zIozLwN
         LlPgmVQDmBUGFLFeWPof7BGvQyIt8VaXdqPIjRbZRnhlbRrpmQ4iM3W0Bl0tw4YLm6Y2
         MA+GE6uHOeSjbPzXHVj4BG4Km9f8mKYbMEJEAnp1fLYsHhCa6X3GdeagDLsyC1MUl3Vp
         m+ligB0DNN5RWzTDXpsgL/xydMEo4ylNtRpha3ASUNxdFrXVNhBpA4+FrCABKrfKzQNw
         OZqL8IpL0KCLFzY2LSqlYMw75cxiT8O8YJUa8lfiNpygE1OHKHY1f4MiCVRI0uXWh3bK
         L4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=llBiLMgR6kf3KmBqZ+Xhu1UZ2vuYADUzibVoX/bVeds=;
        b=P00E4ka/ry/+E2gyY5md2DWfICJvHH7TZ5SRipJVBY20YIGDjfE3wGZqcAe9/UFfZg
         gcokr9/9Wm/Zo430SX83oPYIGNr79YFdlk1GEGLIZPoR9qmF6cJBH36qO0KL8xtrwds0
         BC8zLfPqGkj2UBllUDs79UOL4jAqJ4BtTWODwZhvZA345uwsvs3BcIGNtECdhTyDQwNb
         /7zHOZu1FMLFDfNUHI/YVAy0oIdJG+ecI/qr7xZr71179nYouGDxhJkL1Ivh7R1bjBnT
         wfsR1/QJFUkoFSFvM3i3BSAfRgcui4s4AJzdrOPl+jndrIad6KWmLpOLBRnRtwiNqaCT
         oi7A==
X-Gm-Message-State: AGRZ1gIOZHQpFDuhKeZqJDNUgR6ws/SBngEr+6+ihNwoBUhAZ/pfiCVp
        PPBNFeTccqPVseqDbM+/YTI=
X-Google-Smtp-Source: AJdET5c+YixSNpg3+0O1jMZwdKQ0Prr0dL2UJFR9KULPGx0Z0aq8kzqyxCaIiky/qFXVpaU6QPo8GQ==
X-Received: by 2002:a17:902:d90c:: with SMTP id c12mr1007947plz.52.1542183670309;
        Wed, 14 Nov 2018 00:21:10 -0800 (PST)
Received: from arx-s1 ([114.95.230.67])
        by smtp.gmail.com with ESMTPSA id f6-v6sm28467622pfg.128.2018.11.14.00.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 00:21:09 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:20:33 +0800
From:   hao_zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        wens@csie.org, icenowy@aosc.io
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io
Subject: [PATCH v0 0/2] Initial Allwinner T3 support.
Message-ID: <20181114082033.GA20712@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Allwinner T3 support.

Allwinner T3 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU, and a
Mali400 MP2 GPU from ARM. It is a not-pin-compatible quad core sucessor
of the A20). It's also known as the Allwinner R40 for In-Car
Entertainment usage.

hao_zhang (2):
  ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.
  Documentation: ARM: sunxi: Add Allwinner SoC T3.

 Documentation/devicetree/bindings/arm/sunxi.txt |   3 +-
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts        | 226 ++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts

-- 
2.7.4

