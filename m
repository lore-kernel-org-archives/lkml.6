Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F73FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D840C20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TMT8KRpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D840C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLCU5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:57:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19087 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeLCU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543870659; x=1575406659;
  h=from:to:cc:subject:date:message-id;
  bh=XsUIGNmzENIAYjpU3aKCVQO+zkCeeIwT6CKwkdo1OmM=;
  b=TMT8KRpHIakGMOYNEMqdrIkYYbj8kAjC6KLinQQiBWZbv+9Rd9OnTrLw
   cc0n5TqZeIdPp0vmZwwJ9VXtb9kySgVcuQzoyw8M0q2UIfe4CLdKsmxK7
   4QrYy5dMmKzM6TEnVCX+YapPjwOw4IXbhG3nN8DqFtR+eND9mZZQzmRNb
   2cmAafxvY2zqeDPw1EdD24epRNymH/Kuseye0tJ0Oe2xjsJIgj6T9RBsN
   CSxvZnWavxadzF82kyWJ9b2qNBoEaR3WOxMqIuMs8xPX6oxO/Dz+QHtft
   vIYGnJGE6y1unag8PPk4orOVBJ054ZZDSaMzSUYbnskR0BJ7/NtpVqlqi
   g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100519854"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 04:57:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 12:39:54 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 12:57:39 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 0/4] Timer code cleanup. 
Date:   Mon,  3 Dec 2018 12:57:27 -0800
Message-Id: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series provides an assorted timer cleanups in RISC-V.

Atish Patra (3):
RISC-V: Support per-hart timebase-frequency
RISC-V: Remove per cpu clocksource
RISC-V: Fix non-smp kernel boot on SMP systems

Palmer Dabbelt (1):
dt-bindings: Correct RISC-V's timebase-frequency

Documentation/devicetree/bindings/riscv/cpus.txt |  4 ++-
arch/riscv/kernel/time.c                         |  9 +-----
drivers/clocksource/riscv_timer.c                | 39 ++++++++++++++++++++----
3 files changed, 37 insertions(+), 15 deletions(-)

--
2.7.4

