Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0165C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E94C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E94C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeGSKZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:25:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbeGSKZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:25:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2041980D;
        Thu, 19 Jul 2018 02:42:54 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0E6E3F246;
        Thu, 19 Jul 2018 02:42:52 -0700 (PDT)
To:     linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
Date:   Thu, 19 Jul 2018 11:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

running v4.18-rc5 (plus still missing "power: vexpress: fix corruption 
in notifier registration", otherwise I get this rcu_sched stall issue) 
on TC2 (A7 boot) with vanilla multi_v7_defconfig plus 
CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:

...
  CPUX: Spectre v2: incorrect context switching function, system vulnerable
...

messages.

Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.

-- Dietmar
