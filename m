Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB4A26937
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb0LgQYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB4A26937
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbeF0Bsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:48:30 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:46211 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeF0Bs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:48:29 -0400
Received: by mail-pl0-f45.google.com with SMTP id 30-v6so215970pld.13;
        Tue, 26 Jun 2018 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=2jDMy2Aa92eSdF31yQy1Bhq4bdyrptsybH1UuKtnhto=;
        b=eb0LgQYoi+yrWc5WJBP6leFINg3BDiUeVmgzXlm62jWZfBd6BbZmeO+Jl8ZpU7m5nf
         Lmxhc6Ymjn6C0zygeU44n/wTCsgO6PSls7sTcMcCpRX1hcJIsMudcF/65bzWG9/fnsJ7
         R5hy0vZomrchXJX9rm/OmsVMKzU/LjuLObzfjJVSQuQweGyjM+tMMxZHMKY127y2Kmo7
         eb3drAr/AcFNSPYSv3gBT0MeHD6+0QThdzxfZl+MotPWvgUvE5sVrrcrOCseVsptCUQK
         hpc/LlG5XHrm9mxXRhN8o+qjmQRiNIyBnGTPh9bEuSHhZ/jj4PGpLahe/4o3sJLPZRNL
         pLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=2jDMy2Aa92eSdF31yQy1Bhq4bdyrptsybH1UuKtnhto=;
        b=ZS5M4eoSMyftM18S6ZgOMSbvzqDEyYrPHjA0kLsQyE/dXesF95Z8uHbP/V5dIncGJ3
         GiTXj+/u6GWUDI1hPzDdnFeTERRFEC8c2LMzuRWGOUFBQePVKnui1ArvrwK5e0jj/EeH
         QP8R5ltnCOiwi2Lybw8qEI4AhV0lU8A8DY7LYmoa/IRBZ++DltTF+XzTZtyv9n+vg9vE
         7zO/V647BSqF7U66zVPkPb6aebsdB/mFA1+xE59lIQFMTyz0xRhrrSi5e41Qvs8SsZY+
         ocyTQaAEnWfJCfowNXrYbEVI05CGT2FBrs7nMdtsYqt/IEXoS9UBG4jZsph6WelFPmQd
         FBbQ==
X-Gm-Message-State: APt69E0+u+ymz8e/rUS3MEB3jrx5stCKZ+bFTuGxpox5/j+BB77WtygS
        4s28eRmqu7T+Cfg+VqRsFeBYuNxt
X-Google-Smtp-Source: ADUXVKKyQs3OzAjZDWZG2xSluZP3LezJhT4QUw/DQMbracMb7eVMBttfC5/381OT4Peu4R0YR3xrSA==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr4060956plc.310.1530064108761;
        Tue, 26 Jun 2018 18:48:28 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.42? ([2402:f000:1:1501:200:5efe:a66f:462a])
        by smtp.gmail.com with ESMTPSA id l8-v6sm4681407pfb.102.2018.06.26.18.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 18:48:28 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: tg3: two possible data races
To:     siva.kallam@broadcom.com, prashant@broadcom.com, mchan@broadcom.com
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c82bddf5-4ade-1a01-1587-25e8673301af@gmail.com>
Date:   Wed, 27 Jun 2018 09:47:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call paths in Linux 4.16.7 that may raise the first data race:

CPU0:
tg3_open
     tg3_start
         line 11611: spin_lock_bh()
         tg3_enable_ints
             line 1023: tp->tnapi->last_tag [READ]

CPU1:
tg3_poll
     line 7341: tnapi->last_tag [WRITE]

The READ operation in CPU0 is performed with holding a spinlock (line 
11611), but the WRITE operation in CPU1 is performed without holding 
this spinlock, so it may cause a data race here.
A possible fix may be to add spin_lock_bh() in tg3_poll().

-----------------------------------------------------------------------

The call paths in Linux 4.16.7 that may raise the second data race:

CPU0:
tg3_open
     tg3_start
         line 11611: spin_lock_bh()
         tg3_enable_ints
             line 1023: tp->irq_sync [WRITE]

CPU1:
tg3_interrupt_tagged
     tg3_irq_sync
         line 7341: tp->irq_sync [READ]

The WRITE operation in CPU0 is performed with holding a spinlock (line 
11611), but the READ operation in CPU1 is performed without holding this 
spinlock, so it may cause a data race here.
A possible fix may be to add spin_lock_bh() in tg3_irq_sync().

I am not sure that whether the possible fixes are correct, so I only 
report the data races.


Best wishes,
Jia-Ju Bai


