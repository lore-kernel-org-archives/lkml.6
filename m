Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E81208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="YqkLh3vL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E81208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeGQHXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:23:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44616 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbeGQHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:23:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so266643edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=g5fq3I4yJdMLEA6+gi0X0YVe3B/C6wiHYj71KdeJzjY=;
        b=YqkLh3vLwI3I8l3PojKTivkZDLrcdztdD3yyw4qWlBkVGIGb1R+1e7YywUE/NKoOc2
         PKe5tsHfjNndyZWTnYMEF37LWwgBIbfW5VWlTEw6CR9rQIm5z2gQdtSFltag7rJiPC9V
         tp0qEc94QsjmDNxnUtGbV6jsdcZwPXmsVqOcry3I/XjsKj5nOSFf2j4YvWExiLI3rULA
         l7b4yfTnvjD/i6iIoa8NCrC/SRn6LVEEUGAoDOtmunmwYIKk/QKDe2QJOsVwG+muARIx
         I647/E1IbwbxEgP+6He5xcNQPEFG8Cyg/qpBhIPY1qDxPAarvkJYYSZQ9EFoqDMQVOsE
         lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g5fq3I4yJdMLEA6+gi0X0YVe3B/C6wiHYj71KdeJzjY=;
        b=RtS/wSO0jHJKC3ggUeXiKF6tiTNycLCvVL8JsVEGylCilik4YrSymW8CexE5OHjtEg
         6eXJD+qqBftGAgW1yphWjaGBCHd5xYcOFYEuvIWZWHQ9K71/aOFYeLmMVPCttAprfm+q
         cTudz9tYVnJvNd+dkZU4Z5nLzZRPbstEXp1cF2FwKbvumX/ZBBm/O/M0hlONrKIr/bM1
         Qd49vbaTHFWFIrnwdqeTfxltHjcGn9FUoddBYppl/MaqekzKrK+Gc0Pe3fS8Qt1Rp9nL
         BBv/kcDl81QNdVOY3obp2VFDd83ip7QWufKzXpV0EPCKNaiSUgmYFj24BBm1+LWy3FsI
         F6fg==
X-Gm-Message-State: AOUpUlFv47eoQZXS3LmXCbrHP7xFtNAxejX1sqLmlCH+aE9p1sWpD0tE
        KTkYfiqFFLVOGXEE+c3hd69hHg==
X-Google-Smtp-Source: AAOMgpeBvdh4gkV/lHfQcs+HpzKL60WFqJ81nCBsobhq3lWvd0FlosoTRsusW969Xhk7r79UrpwL9w==
X-Received: by 2002:aa7:c50d:: with SMTP id o13-v6mr958956edq.224.1531810353904;
        Mon, 16 Jul 2018 23:52:33 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id d15-v6sm192648edm.66.2018.07.16.23.52.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 23:52:33 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Tue, 17 Jul 2018 08:51:47 +0200
Message-Id: <1531810311-29915-1-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
but with the following differences:

 * Gigabit capable PHY
 * Extra USB hub, optional i2c control
 * lps3331ap barometer connected over i2c
 * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
 * 1GiB DDR3 RAM
 * RTL8723 Wifi/Bluetooth connected over USB

This series adds the Sancloud vendor prefix as well as the actual dts.

v6: Generic nodename for usbhub, was missed in v5
v5: Generic nodenames, lowercase hex numbers
v4: Add Robs Acked-by for 1/2
v3: Drop 1GHz Opp tweak
v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix barometer compatible string
v1: Initial submission, not the dts actually tested :/

Also double checked if the kbuild error has been fixed:

koen@beast:/build/pkg/linux-torvalds$ git describe
v5.18-rc4-71-gd69088d
koen@beast:/build/pkg/linux-torvalds$ ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- make am335x-sancloud-bbe.dtb
  DTC     arch/arm/boot/dts/am335x-sancloud-bbe.dtb
koen@beast:/build/pkg/linux-torvalds$ 

Same successful result on tmlind/for-next (which has v2 already) and robh/for-next

Koen Kooi (2):
  dt-bindings: Add vendor prefix for Sancloud
  ARM: dts: am335x: add am335x-sancloud-bbe board support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 146 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts

-- 
2.0.1

