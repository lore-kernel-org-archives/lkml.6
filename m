Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16571C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9362082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9362082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeJaKNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:13:50 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44710 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:13:49 -0400
Received: by mail-pg1-f170.google.com with SMTP id w3-v6so6518353pgs.11;
        Tue, 30 Oct 2018 18:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kf1tQkHjOQj6grhbaPi1B5JhjlG9EPb+r4dhd4jKSyKg8FOKk3yCnQ7AvQ0l2O8Vbd
         KVE6u6VtYxmJcNJ/W5Lv2VOFi7vT4LbH2jdL7rxTCwijhCiR8DFPtQNvE3hiP5JF+D3+
         fzKFubW3Ms+SI4exIR8bRMfMRk64UtAm/Rjm7Z0aGSUmwP98uuLcsTI39ukxSRm9Y9/r
         EPJPiMCJJiQQ2GDLtVds/yYeGWSvbPC08CJSPO1/EHZ0fIFPoQ5xFcy2BVrDQaIl2Fus
         aJXv8pgLuCAY41ZsMrLtKPx0lVet/9k4g1WDnPytFNF6S0IaZ6A/xaTid9W6OHMyMKRz
         IDvw==
X-Gm-Message-State: AGRZ1gIqj2kH/HGoBGa83O+LGrJ8OR6BoeScPgzOqWPQ9QKS5KEo71nV
        ic3nlCACu1AhigiJtS9vktM=
X-Google-Smtp-Source: AJdET5f+ByJoqb45xa0zwzqKJh0h8PhEyFpl4Q1x8g/YB8N51CtqpOLwfJ+teBXKoMR+mweip6fO+w==
X-Received: by 2002:a62:8288:: with SMTP id w130-v6mr1121795pfd.68.1540948680297;
        Tue, 30 Oct 2018 18:18:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id d197-v6sm42339813pga.1.2018.10.30.18.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 18:17:59 -0700 (PDT)
Subject: Re: [PATCH 13/16] irq: add support for allocating (and affinitizing)
 sets of IRQs
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-14-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e401081-afe6-aa09-2dea-c0c9c1bc294d@grimberg.me>
Date:   Tue, 30 Oct 2018 18:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-14-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
