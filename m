Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A41C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6A218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfADHfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:35:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:39120 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbfADHfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:35:08 -0500
X-IronPort-AV: E=Sophos;i="5.56,437,1539619200"; 
   d="scan'208";a="51268127"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jan 2019 15:35:06 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 4FB134B7D66F;
        Fri,  4 Jan 2019 15:35:06 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 4 Jan 2019 15:35:07 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: question about reserve_bios_regions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <f8f1e21b-197b-78fc-dc03-606e98c7d783@cn.fujitsu.com>
Date:   Fri, 4 Jan 2019 15:35:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 4FB134B7D66F.A9EE4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I am looking into these code via find_trampoline_placement, and I have
some questions still not clear after lots of investigation, hope to get
some hints.

1. How is the value of BIOS_START_MIN(128k) determined? I don't find any
clue about it until now.

2. BIOS_START_MAX is define as 0x9f000U(636k), but both the comments say
640k, is that a quirk or just typo?  I thought the 4k difference is the
quirk, but later I guess the real quirk lies in latter judgment of :

  if (ebda_start >= BIOS_START_MIN && ebda_start < bios_start)


I have checked out commit edce21216a8: ("x86/boot: Reorganize and clean
up the BIOS area reservation code"), still no clue.

-- 
Sincerely,
Cao jin


