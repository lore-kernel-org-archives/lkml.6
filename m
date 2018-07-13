Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A123ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FC620843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="x7mgt0MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FC620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeGMGfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:35:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45917 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeGMGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:35:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id i20-v6so10690656eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TkDlPn+ZgA7bOzS0GnyvTFWQPgO4nbXYZPzfNILOZsM=;
        b=x7mgt0MJXVi5u49n/HdRD3HiVBFsrZ6reAKp7yHTvfOuPI4SWzgmTaCMnbMoyHcG+r
         Xxek6jxfDpnWa7bAxoyxy+N40B+r3ZB5akfnAZErFPzedFzTXrXQ1rweTE+nzKSPqtge
         SYrdoEvjc+b3PKa9zCP1IFWzdZkx9VNiMxfA+TTdDRGwA2z+qCE2vDPvmZujrr1lxbyH
         G+3qTYZ/TTq6sUlyYeWCV9b1JwdzpToFfEFhZtYPYDYxfqyIph0TNUofCI7nacGF02AZ
         NxcJ6aZI9TxaMppkzG76SsbjTq1FEtE8HOysHPZPhxGve1AZLjcDo22QggSUI4tSbVIc
         JlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TkDlPn+ZgA7bOzS0GnyvTFWQPgO4nbXYZPzfNILOZsM=;
        b=h4sa07HVwHwb04vAA04KDK63uySUqPf5ejUTKJKKgo2AKnTcf0+n1Bbw8S5kGbOh4K
         pLiQik65A1RQKf36kJlfoKf1BbAL1cxwKJ90xC53Q499j2X2rubGk/JZ7cJASsoAyimP
         7HJo2757rZAMD0OS259cFSDGvRtz4Wf3rPg72e1s4SizHq64sJIRswHQBermPmF52juE
         bGRMvcCR9I7rm+e51UIhb8Xzg1EGWCNnvvpTd17HX/VPfvxMrIA5u0VXQ4ap7/EAOvDf
         oEUDSh4zmcQGZjaSuX8ys6YbguTXw3VxM3+FOKhPe+rFgEczsbdxtLyYQ40BIR4FFa5P
         LX/A==
X-Gm-Message-State: AOUpUlEd6a8rs9fbcigxmpzbaWnIopqCR9mTCcENjShkF/yNlo5OgyWi
        dFLJsR9EUNChXX/YnxYq/lDILcUz
X-Google-Smtp-Source: AAOMgpd3tjD7gEXMbNx+xXWPRuEFgqlPfE53kMNQZ9Gw3LHrt6df8zcq51KcEyoNsx+Ommr/yGEocQ==
X-Received: by 2002:a50:9943:: with SMTP id l3-v6mr5418072edb.272.1531462949308;
        Thu, 12 Jul 2018 23:22:29 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id e2-v6sm10342779edn.11.2018.07.12.23.22.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:22:28 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Fri, 13 Jul 2018 08:22:19 +0200
Message-Id: <1531462943-26226-1-git-send-email-koen@dominion.thruhere.net>
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

