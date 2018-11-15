Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6845C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC82245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tGEQcURb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EC82245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbeKPFsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:48:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42347 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:48:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so5705515pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MbDTxJPpBu1K5zpFj6ejK2iDzd3pVaEQ0l0sTvKE0hg=;
        b=tGEQcURbiWBA+2jiXEcE7wUjdJ77hAeTx5KVxI5JckAA5UPSRBdGHN3AGUS8ioauLz
         rx9bXA9n+4GfVk7wEbuBtqiA+qBhWKc50jjbZvaga18NUHHR4q91yF9fsNaaZiGNDAmq
         8EFsdxUAtKCgSMJI/PqI76Dp8bUeEQEvQaiJ/K4jOO2FNB0NVmS/9bPtv4BDQ2VZMnAy
         md5Ye1IKGLYuCrNYhJ6UvNmpNov5pxrqF4YTyqVQw6WYRrQdoDMmd8smXcg/SCdai/El
         X/BGoUWcV+/4OUbS+UCMLrbhXdqsO0rbdnHp5zccX/SX8QupeBAXLl0kbyIgeKcmpIGV
         reWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MbDTxJPpBu1K5zpFj6ejK2iDzd3pVaEQ0l0sTvKE0hg=;
        b=dhfyxjM3LisEC8UiQU4uSakXZzx3jCnEveUDPsmNeWVv1wkycvZl2LHivDIGYxw8de
         H017xLvCP7NPq/jRn0N4TNliN7GxlxU8tPT1gaKqzd21en4HyJ70yFv9GE30VpjhSNAP
         xzx9hAXvPEewR++Vhv6meHuDP24J/0mP5JeoJ2N05fQTIqzSKArqDw3IzlCWfugYb57u
         utQrrhR6bwKunkovjz+hhUtp9JtjyrfIf7vslYs+CNvYrvigZ0Y6lakx/khnvN3bqEGR
         LQV+tdHKd9oDo00DkFSeaIwYq0fqTfmGCmCeBlxZIyjCuWJ8vkrxImAB/8gdU7nVsdIp
         vqkA==
X-Gm-Message-State: AGRZ1gKU7rzxb5nGNKfpaRynEJEMNFODUwjTszuYlxmVUvDCOlELfbVa
        m8dQeSj+wlHWr0Ts27TAauXRN0LUcu0=
X-Google-Smtp-Source: AJdET5f+5to4XMtwFQW5Txb+m4wBObO9vMot90UbNe/qoaA4ZYrCk1ppKTpbAVoOCHxf1VhlMniBMQ==
X-Received: by 2002:a65:5286:: with SMTP id y6mr6992826pgp.439.1542310772897;
        Thu, 15 Nov 2018 11:39:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id y10-v6sm5691414pfa.136.2018.11.15.11.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:39:32 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115191126.GA16973@roeck-us.net>
 <20181115193658.GA7921@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bbc8187-2f99-c1e3-bec9-817fa3ead18f@kernel.dk>
Date:   Thu, 15 Nov 2018 12:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115193658.GA7921@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 12:36 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018 at 11:11:26AM -0800, Guenter Roeck wrote:
>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
>>>
>>> I think the below patch should fix it.
>>>
>>
>> I spoke too early. sparc64, next-20181115:
>>
>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>> [   14.263496] ------------[ cut here ]------------
>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>> [   14.264265] Trying to free already-free IRQ 9
>> [   14.264519] Modules linked in:
>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>> [   14.265899] Call Trace:
>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>> [   14.268825]  [0000000000000000]           (null)
>> [   14.269089] irq event stamp: 32796
>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>
>> Looks like an error during probe followed by an error cleanup problem.
>>
> On sparc64, pci_alloc_irq_vectors_affinity() returns -EINVAL (possibly
> because the controller doesn't support MSI).
> 
> [   16.554753] nvme nvme0: pci function 0000:02:00.0
> [   16.622894] nvme 0000:02:00.0: pre alloc: nr_io_queues: 2 result: 0
> [   16.623814] nvme 0000:02:00.0: post alloc: nr_io_queues: 2 result: -22
> [   16.625047] nvme nvme0: Removing after probe failure status: -5
> 
> ... and, as result, allocating a single (legacy) interrupt isn't even tried.
> 
> I didn't try to track down the cleanup failure.

OK, then this isn't a new failure in terms of whether the nvme device will
work, it's just a cleanup issue.

That's less severe than the previous hang :-)

-- 
Jens Axboe

