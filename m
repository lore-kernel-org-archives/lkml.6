Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A37E2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="TSQc/s3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A37E2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGMGie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:38:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34512 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMGie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:38:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id d3-v6so23739234edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jIwKznBAC4MWu+bpT7h5gxH3fsPndgau+utj6Bj82Uk=;
        b=TSQc/s3JPv74C1+gGKkeuBNz7C+9MrDdk0MJvubq7JdYL5RKPZyjLa/founX7ps3OY
         RjTOnzX3AcncB0vSrK0/1H7ouCIbyPn03GoVf+sOewV9xcIBFui+qClw+9UPl95/3p7o
         ixxjuSw/+Ah2QzVJph3XNdfNV1T9dw7DVOzcnAOfyW193aRM2Crb7tqN5wpZR3u6R+Cs
         wZW/+Qor39bA+tm5teKe+L3F2k2FX6QAfF1El1VS/TTJDVdosBc/rvAxQdO06K0+nD61
         1L1mTkexpIh/XaZ0rfVAb/efMCvO1yyAivVMv7lvJuQF3uPc95zaOs5iBq1TFDa/U5cl
         zXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jIwKznBAC4MWu+bpT7h5gxH3fsPndgau+utj6Bj82Uk=;
        b=WqOz3LEzSgnbSPqLdXcqP4MTCe2YiAzycf1qimv3UZFWuZzMzUzKbSH1gBaumgcarq
         Abpvrkri5uV80eV2gq9iNMjYSvJoJ0sSq7B9pcfZi1fRTS2chpQNElXqoVF6Rw479rBB
         cjmyhQ64fIdjfkL7PK4xYQAxVCrfJ9d24S6SZoZ/SZ/pzi81qzF/2biSbsc6hZo1bD1A
         PhbLI5ZjbXuVI6yB1yKWy2f8WuSmMSOP/KBLlrTKQrRMJTN8v02TG0GwJf5wJ0bh2MWM
         aiHT90DODRHH+gSASyhzV/3dsujd2w3B5jLg3LkBB0hOpGyAfp6BoU2kJRf3/9UngyPE
         j3Ew==
X-Gm-Message-State: AOUpUlEe2BiV6mYPh0dx5+v+dQXS0m4iEZagjrOZ2MFRDEoYCL7zBCIS
        IGSdk11jyEyUVuQjFOpRWboHVs3n
X-Google-Smtp-Source: AAOMgpd5fxrOE7KDtv0EFphEU9oAEV8+8TSG82VJXCnU0tOMPRH3XYw64JzSM/b8R5Qb1pHodSA9Sw==
X-Received: by 2002:a50:98e4:: with SMTP id j91-v6mr5678944edb.212.1531463125001;
        Thu, 12 Jul 2018 23:25:25 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id x40-v6sm16980103ede.23.2018.07.12.23.25.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:25:24 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Fri, 13 Jul 2018 08:25:18 +0200
Message-Id: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
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

v4: Add Robs Acked-by for 1/2
v3: Drop 1GHz Opp tweak
v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix barometer compatible string
v1: Initial submission, not the dts actually tested :/

Also double checked if the kbuild error has been fixed:

koen@beast:/build/pkg/linux-torvalds$ git describe
v4.18-rc4-71-gd69088d
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

