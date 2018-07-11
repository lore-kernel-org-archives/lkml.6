Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84025C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1070D2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="KrpyvOmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1070D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeGKHfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:35:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeGKHfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:35:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so18417181edi.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6Z0ElU+NTVckRWzNqDFJ+ng40UeBtYoFGoQG9i2w+Ps=;
        b=KrpyvOmv8HFnkGymo0MfawoVD/HLebIi/LVhRtezDAS+CEzz0//UnbTssAhqnMo3iy
         acSxRRUEFIZGCsntS+Tnhe4sOeRlDJ6wqhc7sHWA+wVIan5zJCerWlMNrtHxKPyopfbU
         HgGLBj37vuSr408gm8LudZ1vdcmbnkKlGQFKc0KZUNTeTouorihBnKgDjupLkkITXm0l
         sp2xmyWb3t/MkPCw9rq+YMN6ELQ78Xlysi5CkGApvxY3h+J4x/XB7ffDZIB1XOrkvUFi
         sFiI9E6wH0YRK8FT7m5Cy1MkWGEQmuJpGCtIJHiYpAMiho3Kywbfln/uvdCobYWKkc/Z
         LGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Z0ElU+NTVckRWzNqDFJ+ng40UeBtYoFGoQG9i2w+Ps=;
        b=hVtr0Ohm6RDKZ7jIEA24XdP2GhrKbYc1fgLAInuC9WclDhTA+6DD+kc6qcPZWDe4+W
         R/5aEak2/BAyz1pD/H5+rN20AYphvtZiBTaVExHRrBh6cEMfL4dsOIm6zrA0CxUhEKsa
         H4hCgJuDa0eNqjYqUlVx5NYHnqXc3qLyvU9GHHgaK6zB69JS+Cj92Xly3HY6fp7viTpR
         kS/KxUYly7VD/evXWxSgvVgPzgH9yBxf+cmOYPsheZKDkDKXuSyWsAtmAGuztntbzqF5
         LXB8SCrVpI1sjl9I+sNeHXt6RyDrMdDwjU1xEWXnPcNiaXf23hepxc8blvjAdh6uK1CR
         jTFQ==
X-Gm-Message-State: APt69E110P1k102TmTV3sJUkW+csEALq4bmwAzlSOW10rnurZl8hvGil
        t6zWL0Wn7sfNdRnnaaohbobErw==
X-Google-Smtp-Source: AAOMgpdZhcRMrAhN3BhSqYFbXLVBGOWQ0ECmP4M9LkPpmHqE3aidbekQArG3szRHI3GIrsIcV3XbXA==
X-Received: by 2002:a50:86f6:: with SMTP id 51-v6mr29323980edu.312.1531294365537;
        Wed, 11 Jul 2018 00:32:45 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id i89-v6sm8958816edi.10.2018.07.11.00.32.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:32:44 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Wed, 11 Jul 2018 09:32:27 +0200
Message-Id: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
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

v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix barometer compatible string
v1: Initial submission, not the dts actually tested :/

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

