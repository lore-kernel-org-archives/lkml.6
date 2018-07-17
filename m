Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05B5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328CA20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="Bn/ynK73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328CA20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeGQG4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:56:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37871 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeGQG4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:56:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so219796eds.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jWsECuCnfEVrAmCltkMzv44Nru+KOvwvjM0YqOBM9s0=;
        b=Bn/ynK73TXfupSClS+u/zQx6Xv4z/VSbzcc3APLedd7SJJLiuxFujvUVDa5t8Hweqa
         HNl1jwj3BWnWdXOI8NGn3HSJhOAjlYiAhyKa0DqAEBk/+FHTHBfjAhMFmkZdIhtiunld
         gQ5ZLjrF1ascT/5W7fhf51Iv7AZO4FG1bW8Kq0+Os/ZhFVMIbdGtdmYk8KRrIv1P4hE+
         qCAUSAQKWC3NU9OLR8SeZnS9mmjFb3aBvzpjTIdxkTdbhm4+4qS3IPAdYu2w9YOMdtai
         mmteb7o+SDq4Y+DYJBwO6oSPwaSnghCXvpibaQBCu05ASCgFhu2Dv7MpLCNFc8BZ//nf
         pj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jWsECuCnfEVrAmCltkMzv44Nru+KOvwvjM0YqOBM9s0=;
        b=X1nZ9GyEFIcB2bemv4Ym6Xke8aQ3FICI4l4XddoKoaXaejrkYMz1fqRu+UpNdhTsn9
         Js1qKgsswR+9VvYlojCm3su67N/4k95Ea0jZ45rgix3f1r45cBthcUDLS0s84mmntF7u
         oBZjXEWfKrRd2v3JpK9tv5MpCHMJhnh+Q+I3vP/+luPHhaxlnUtW+UUG9tVR5fS/d/Xs
         XtjvhYftAaVbc+CqjcwtwW0o9oWUc3d+wXMnTwj8cCgbjBilwQkYg8dVdEX0h7+Iz23q
         x7wJCxW18y9Qh4XPrVUCLDmdfVIpdonbYQoZhrJspJ6bAkOAOVa5EIj3bDLs3ZQf9EmF
         B1Hg==
X-Gm-Message-State: AOUpUlEmQHAV2Ei1JmpsIv8hG5Bi72ZwOQn7DMPAj/RKUoXu/DgTVP/N
        gDNJ67Rzwt/qPtI7vwlVgcrM0gyj
X-Google-Smtp-Source: AAOMgpf5Qgr6HlZpNDEj2zxN1IWQhT93rSOu0ksHXLt1qlhBj5jqDMLbclHjwfxmsHtn2OwuqiAeNA==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr847456eds.302.1531808702209;
        Mon, 16 Jul 2018 23:25:02 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id z5-v6sm140939edq.88.2018.07.16.23.25.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 23:25:01 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Tue, 17 Jul 2018 08:24:44 +0200
Message-Id: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
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

