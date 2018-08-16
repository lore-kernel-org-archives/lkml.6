Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F26EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8C2147E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 06:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCi25LQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC8C2147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbeHPJJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 05:09:20 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39027 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeHPJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 05:09:19 -0400
Received: by mail-wr1-f51.google.com with SMTP id h10-v6so3031543wre.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=y6ZQPyyjy+0erFv79IBWZTcjLXQSHw1XbjsGJP29ByI=;
        b=dCi25LQaNKtRDosxSR4QCAgm87fJWn7dhgyCGh1ANG5qhmDJP3lq99sNnhdyzifqR1
         dYba6cM2uabDV/XUVdAdgBKK0csS3leigRyQsGBDAlEfm2l7RzDHT9tEVeb6f6w0J23F
         zVcI53qD9ewSW0CzjzW9z2CxD5bR1ryY6T1MdcS8VGulieJpf7eAIeJByjRRF3z+WcQK
         m2Ik1ba2ORF2Olh6kwwV7pvJptY7s72S6k8UGWQ/D3REtyezUxSg7Ef3qnkHLxe1Nryf
         NNh2brJbXT5vkj/ihLHQLdrhazxD+da84kr8bfTzosa/CeK/QzqjOD2ZNMWjBG/UvIiX
         93dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=y6ZQPyyjy+0erFv79IBWZTcjLXQSHw1XbjsGJP29ByI=;
        b=MqzjxrswPa5SonmO4IUCSgRxuIryq5JX12rCusup2wjbWZhJYadeZZb67SMbeR4BJv
         wHbfGjQnmh9uQpT9QjE8Jr4+upNbNPXBa/JlAfzvItSOTHRnml/ZQqhLLfBK8+srCZ4O
         yraSGSnmAyZVDONuktJjuGcHJtyaAnvkESX1J7uXu4gdAxzjzF5/hYQuX80uXngHnIXj
         zrg/o8fWCtm8Uu4F7PcEtyNrCax8c9eZOfa0wjrtfwVz9EVzbj+6ITIrRb5MwOiD/2Sj
         6Czv+utzykJJR2uAJJND3IpmffQv7oDkCA6CJEmwz1CtQ1Sw5civauzO/8aKlxvmZOBL
         wZxg==
X-Gm-Message-State: AOUpUlHRmwD3esFktx3bDD4tO5xJIXswire9Pv7fWytHd+AY++6tXC3X
        /uLPh9Iub05Jm2b5BCiydeuQI2SI
X-Google-Smtp-Source: AA+uWPwNjQZFpPSflIkajm50VqG5Xu7Gn+KQCSYFwNNRKEwlyMgbC0mk0UQRdtXmZhJB8WcV+nk05A==
X-Received: by 2002:a5d:54cb:: with SMTP id x11-v6mr19028734wrv.104.1534399991413;
        Wed, 15 Aug 2018 23:13:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:b172:33d8:124c:91c0? (p200300EA8BD4D600B17233D8124C91C0.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:b172:33d8:124c:91c0])
        by smtp.googlemail.com with ESMTPSA id f17-v6sm17899439wrs.1.2018.08.15.23.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 23:13:10 -0700 (PDT)
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may have
 revealed another problem
Message-ID: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
Date:   Thu, 16 Aug 2018 08:13:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to get warning "NOHZ: local_softirq_pending 202" and
I think it's related to mentioned commit (didn't bisect it yet).
See log from suspending.

I have no reason to think the fix is wrong, it may just have revealed
another issue which existed before and was hidden by the bug.

Rgds, Heiner

[   75.073353] random: crng init done
[   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
[   78.619564] PM: suspend entry (deep)
[   78.619675] PM: Syncing filesystems ... done.
[   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   78.656094] OOM killer disabled.
[   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   78.658177] Suspending console(s) (use no_console_suspend to debug)
[   78.663066] nuvoton-cir 00:07: disabled
[   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   78.672210] sd 0:0:0:0: [sda] Stopping disk
[   78.786651] ACPI: Preparing to enter system sleep state S3
[   78.789613] PM: Saving platform NVS memory
[   78.789759] Disabling non-boot CPUs ...
[   78.805154] NOHZ: local_softirq_pending 202
[   78.805182] NOHZ: local_softirq_pending 202
[   78.807102] smpboot: CPU 1 is now offline
