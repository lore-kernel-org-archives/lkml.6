Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6015CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF422133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gys+j5wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF422133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388852AbeKPFt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:49:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38674 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:49:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4-v6so9952396plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tl2Bxc9Q28/Dt4p/tv/cTEkL7UvKB8OyUUuRck8ZlUw=;
        b=Gys+j5wUL0RRsUj6QXX3VdobNQC2dkiucnDxncEO4HrEZ0Nod1npNAmG+AFbUc1TWp
         A5Ct8Lqoj1vkWw+4BJEW8czqdl99A4iS9iR6LpCNOM9Lx9beSkL3aWrlrZNGA+SyxMYj
         L90gJgvld0FNQ+tPhyrMWGB4uoWAn/nN3jPUNM7uxRB+4VWJ13/3wqAGaCQILWHamXZC
         LPrSCgn3OJTsf93dtK+OFbYnJvtn8IdJhDCUnN5tAK2ER6EBV+PmGOmJ8lluLlgmYQFy
         MeLi/ESnyN+ESj14GUqeH8OqdErmb/KG+Wj+dOfNtsHxJwhYcbv1PpfX7nJYZsmflNbO
         ryuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tl2Bxc9Q28/Dt4p/tv/cTEkL7UvKB8OyUUuRck8ZlUw=;
        b=sDBjqcBe2uwfbdFxBd60jwWd00SEg5fg485uvxYITbCb6Pq4tLd51eynMGI36D1bjm
         AcSsLNaiycPU+x/k7nN9j9Gq22CABz3sUdKZ5XDhx4WEd1+AVLjfPF+UxH+vKu1iTshB
         nZpZgiRzOkO2s8oplxM5rEh9dsQGLp75mGnQLVvVRS0dqQ1OfhF3RLp1Ai16oUdkRni5
         Xy5tHDVoMhhbRpNa4iPry4Al9mSQOJjVJvNbu8S2tGd45TulZWolkzDqUmTwkKw2nt+t
         gvBfFiausja8ig7J3vjpLdxb6lnPWwAoW7i6SENjcwRCIyTNeA2M3ZT9zAgyHOOkE92l
         iJ7Q==
X-Gm-Message-State: AGRZ1gJd9XokxrdyQ0FBOVYDv3CwacyU4lEuVz4TCYuU0eBuBK2pnjpz
        WvbjJ1BsMkxde1pwvVMzlrDocoGtyOw=
X-Google-Smtp-Source: AJdET5cBwmZD04710a/7zF0xpRd9CO4ZTfKz7MzUImZ8IDQK4gRss/cATfmPVtEWZkFc+q6eSVuWmg==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr7573637pln.340.1542310818505;
        Thu, 15 Nov 2018 11:40:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id b2sm25198712pfm.3.2018.11.15.11.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:40:17 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115191126.GA16973@roeck-us.net>
 <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
 <20181115193854.GA30639@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fb23170-5029-f926-c063-77cefea37427@kernel.dk>
Date:   Thu, 15 Nov 2018 12:40:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115193854.GA30639@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 12:38 PM, Guenter Roeck wrote:
> On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
>>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
>>>>
>>>> I think the below patch should fix it.
>>>>
>>>
>>> I spoke too early. sparc64, next-20181115:
>>>
>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>>> [   14.263496] ------------[ cut here ]------------
>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>>> [   14.264265] Trying to free already-free IRQ 9
>>> [   14.264519] Modules linked in:
>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>>> [   14.265899] Call Trace:
>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>>> [   14.268825]  [0000000000000000]           (null)
>>> [   14.269089] irq event stamp: 32796
>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>>
>>> Looks like an error during probe followed by an error cleanup problem.
>>
>> Did it previous probe fine? Or is the new thing just the fact that
>> we spew a warning on trying to free a non-existing vector?
>>
> This works fine in mainline, if that is your question.

Yeah, as soon as I sent the other email I realized that. Let me send
you a quick patch.

-- 
Jens Axboe

