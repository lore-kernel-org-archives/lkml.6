Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F94C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125B24899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="VfYV17mr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDy+p2iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0125B24899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbeGCHEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:04:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40895 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753596AbeGCHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B5F0B218B4;
        Tue,  3 Jul 2018 03:04:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Jul 2018 03:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=eb55P6e+P9E44e7hvt2CocvScxT2pp5aaSC7xlOo5
        vs=; b=VfYV17mrv4YTWDaF/vx75pveuL053QeNWOxn8SwLjdgwuwU/70ioIv7xq
        BoDtf0YsbjOeowzkVk1ApOMmp9A+4Lal4dxZ0AvqEdgSANkBEYKKgWF1YkWYn9Hy
        qKPJ2Gp8mb37IakyWEy1fzHEEh4QMptVpIikplfcLVxXKLF1zQ2zkQR7C5pyXzUb
        JuRc0OItyfDRqMdtoXhl4rh/8z3oZAmKZsoai7VDLdN1RTwGkuCNGMNy2Pp8j0do
        tu6q9LkNYxquKOES6unZcaNIGzd6bMIzBqRlul3GhCCbKrNK1RL0bPFf7nUY5xDF
        QQkhJ9ms4evu8Nwxop16PwugO9N5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eb55P6e+P9E44e7hv
        t2CocvScxT2pp5aaSC7xlOo5vs=; b=LDy+p2iYyyq3AOgbR0y2RcZe7mx18/iSr
        AdoPXpR63hj7kI51gNn8K8GTkQVATfDZjA1FQY5Kk02Ha6eqnvhXzKx7VJWdZ92C
        Fdr+UMLChbd9lgn9NWpOWvQgfh7E2OIDVTpPxku0p40WobiaLVBb4czZim+/AtJi
        Dssr7dFId4aFPxD6idTk6vQkDN+DYKaY+4NmVXQNK2KXyeuJaDyZWqVjd3J9pNdy
        ip1OpqTxdosahj56eKr7FS+3gjd3eEcUDuO+DNewrHnXaqp2Eldqav52cTjgQNKe
        wMmK1S1Ixmg31jUB8jOuBoNCTYe+cSZ012a/Oa/KWWpS1U3+ZJBIA==
X-ME-Proxy: <xmx:AiA7WxkJz1CQhwX_kXTwA4n8dhyUEpHWCyaYpJbWQZm4_-_FaS8tbQ>
    <xmx:AiA7Wzim3yoL2MrAlAA1t8i2uH6Of0YVGtMa6W6tyz1Tl5-UtFGiow>
    <xmx:AiA7Wx3k-328lZvUga1q7Zvf9eMJxlCUU5F4Gv0If0zL-EoUKUbxzw>
    <xmx:AiA7WyNM83prNP5UTYgfQazZmy-IdvGYf-rweAIgOSW-lyg8VXfUGA>
    <xmx:AiA7WzlmHE6wnFZXKgRxj5QgUvM1ja3XCx0n7j5-jPIZggWI1j2oCQ>
    <xmx:AyA7WwK0WsgSQITO1sEjWeJWIqJ6oi3fCnnz954uHym0y_yC9g92sg>
X-ME-Sender: <xms:AiA7W-lfSWnb5g5D2Fa298J3hLp_5ZBs64G9StOyoC7qBUIszXJUdg>
Received: from dave.bha-au.ibmmobiledemo.com (unknown [202.81.18.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id A672F1032F;
        Tue,  3 Jul 2018 03:04:29 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, gregkh@linuxfoundation.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/4] sysfs interface to miscellaneous BMC controls and fields
Date:   Tue,  3 Jul 2018 17:04:09 +1000
Message-Id: <20180703070413.28756-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Dons firefighting gear*

Hello,

This series introduces a bmc-misc-ctrl driver for exposing hardware interfaces
provided by the BMC (Baseboard Management Controller) for scratch register
communication between the host and the BMC, and other miscellaneous switches
controlling BMC hardware features that can be exposed to the host.

Previously Ben Herrenschmidt sent mail wanting to get some consensus on a good
way forward:

https://lkml.org/lkml/2018/4/10/222

To summarise Ben's points:

We have found that the controls we need to expose do not fit well into existing
driver models for several reasons:

1. Not exposing the fields to userspace would instead mean encoding policy
   affecting the host system into the BMC kernel (typically scratch registers)
2. Some controls are so unique as to defy integration into other drivers
3. Exposing specific, well-constrained fields feels less evil than falling back
   to devmem.

This series is one implementation of what we had in mind. My motivation is with
respect to ASPEED BMC hardware but Dell have also indicated they would also
make use of something similar for Nuvoton BMCs.

To those ends, the implementation of bmc-misc-ctrl introduced here:

1. Uses devicetree to describe the miscellaneous fields and switches
2. Exposes the fields in sysfs via value/mask/set/clear attributes
3. Adds a 'bmc' class for the fields to aid discovery in userspace

Now, the intent is bmc-misc-ctrl is used as a last resort. If features can
sanely be exposed in more appropriate drivers, then that should (obviously) be
done instead.

I'm sending this out as an RFC as I'm sure people will have feedback. I hope it
will be more constructive than 'NAK'.

Thanks,

Andrew

Andrew Jeffery (4):
  dts: misc: Add bindings documentation for bmc-misc-ctrl
  Documentation: ABI: Add sysfs-class-bmc documentation to testing
  misc: Add bmc-misc-ctrl
  dts: aspeed-g5: Add bmc-misc-ctrl nodes to devicetree

 Documentation/ABI/testing/sysfs-class-bmc     |  62 +++
 .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++
 MAINTAINERS                                   |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi              | 192 +++++++++
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/bmc-misc-ctrl.c                  | 363 ++++++++++++++++++
 7 files changed, 885 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-bmc
 create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
 create mode 100644 drivers/misc/bmc-misc-ctrl.c

-- 
2.17.1

