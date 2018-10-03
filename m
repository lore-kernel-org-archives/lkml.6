Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7490EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395912082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqz3DZ/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395912082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJCUHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:07:08 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:41130 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:07:07 -0400
Received: by mail-pl1-f179.google.com with SMTP id q17-v6so3479223plr.8;
        Wed, 03 Oct 2018 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=1HrS7jCfo0OoLt0wl4l3mg6qXrfo3QdkDeoH8TlPt4M=;
        b=pqz3DZ/D9SmSvgk5mdfg+H3VXYWNuDnagLLbwJDgKBim3QovqilHMBpUTC/iDpzivg
         dhnM3nBvNYQmUUKwYpydtcnNcoiUWB+Eisw0se3c4tpLtgn+t6xugNdu90gpBTUhEgQl
         rY85PNzL2eu8NiN9/thMG0JeEwYzYH5+EKATwM5pUnJAuTVPUgQEyhXtRgPYH3jU9nV1
         KYj0G8KBPo0h1cMHN43AO4ReMI12VC5oUVt4nqGD8FmUTl65747fsgSUkbmBj+iTFO1i
         iPK9cI9xaSvVcZWSibb1WUWO2RKlmHFL06D/RyqMXomWRS6LrqlV1QL3yklFt4BMGO5h
         Gdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=1HrS7jCfo0OoLt0wl4l3mg6qXrfo3QdkDeoH8TlPt4M=;
        b=aMButM9B/OEY3ZcXFcuQsDIwx3CLe2Z5XVGNuhkaSlfyTUROkkZxK0xufgFHhXtZRc
         NOdXZAI250rButNdMQ9YFPI5nf+l7GC0SeLN7mXxqf+Iwewg2x3GhO/WPdZnGqyN6pu5
         WL21H/nXvdK2D3XnO+Pnso/pMYItbUlkZ1huNzJD+MjyInpPlUs2BJS13wa/1agtNGsq
         Bd8d2R/UTSD45f98VMkDadx6uB13v5aTAmhU9T6yWf0Fj+9uwfdi1bdzpTAuyq2ayAs7
         3jeHST99MW74X9/MmorMpkIDD1jVWvuDjmnrEIqv25eL+YKH+BohQU5997LByB2jKb9B
         oDmw==
X-Gm-Message-State: ABuFfoj0EyQkc8vK1GOQcRGH0leNyW8IzgHGzrY9Zn9aXuLUFyiVlAdc
        WMwslHKiycW1WVzHvteL0upsae3i
X-Google-Smtp-Source: ACcGV61/k59Bcb7gEkUBnb8K9kYm3NvzkgqEZ3SLcuTyXrp7iJH9RMLeIc/5DW4w0TZY+IYJmGd54w==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12-v6mr1623178plq.165.1538572725314;
        Wed, 03 Oct 2018 06:18:45 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id 19-v6sm4087969pft.97.2018.10.03.06.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:18:44 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [REPORT] net: e1000e: possible data races
To:     jeffrey.t.kirsher@intel.com, davem@davemloft.net
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1b02ad06-ff89-3540-ca85-17f826acfadc@gmail.com>
Date:   Wed, 3 Oct 2018 21:18:41 +0800
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

CPU0:
e1000e_get_stats64
     line 5944: spin_lock()
     e1000e_update_stats
         line 4949: hw->mac.tx_packet_delta = er32(TPT); [WRITE]

CPU1:
e1000_watchdog_task
     e1000e_update_adaptive
         line 1762: mac->tx_packet_delta [READ]
         line 1763: mac->tx_packet_delta [READ]
         line 1776: mac->tx_packet_delta [READ]

As for mac->tx_packet_delta, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operations in CPU1 are performed
without holding this spinlock, so there may exist data races.

These possible races are detected by a runtime testing.
I do not find a good way to fix these races, so I only report them.


Best wishes,
Jia-Ju Bai
