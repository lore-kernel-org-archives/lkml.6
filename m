Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F4C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8267020873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8267020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeG3J2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:28:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59399 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbeG3J2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:28:54 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42811493"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2018 15:54:57 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 3637D4B69E17;
        Mon, 30 Jul 2018 15:54:55 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Mon, 30 Jul 2018 15:54:57 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 0/2] Two cleanup patches
Date:   Mon, 30 Jul 2018 15:54:19 +0800
Message-ID: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 3637D4B69E17.AFADA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two cleanup patches, When I test the early boot time stamps
with tip tree today.

Dou Liyang (2):
  x86/tsc: Avoid a double call if tsc can initialize earlier.
  x86/kvmclock: Mark kvm_get_preset_lpj() as __init

 arch/x86/kernel/kvmclock.c |  2 +-
 arch/x86/kernel/tsc.c      | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

-- 
2.14.3



