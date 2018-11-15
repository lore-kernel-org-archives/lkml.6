Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50235223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JU+ZPQjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50235223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeKPFwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:52:55 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42570 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:52:54 -0500
Received: by mail-io1-f67.google.com with SMTP id h19-v6so15313002iog.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2IAaKRvBOLEwAV3lpU/EeYBVDAuxI885OnAWYpKBWRM=;
        b=JU+ZPQjWmATEBVVA3N8UnsHRLrUJzzGWSZrB0lRV0tN0v42g+6iGWM9pQIL2YQcgbg
         q6iQYIjNHOkpvcpyvomUyGTpW0av5tG+OCS0XR3EZhf/JFR7Sf8SLQUThoex/znYjRPi
         1JeqaVksrDcObdFkayyfJ4hbwsn7z14FGB6+aw0Pj6L5GsHgCBMmzNN4q7JWHK/NBUsU
         PLgV5fz2ZWFnY9yvYivMhEQ/lI1Yr/eXprcWx1YAeYHEPMRK5KpChc9dj/SKgZD/9mZZ
         JDJPoOpcD07we4B0R273pp9F+l7m6QoHpKtpLdPqAN58eSIsAiG2xd+pHP0s5wLIWxen
         KrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2IAaKRvBOLEwAV3lpU/EeYBVDAuxI885OnAWYpKBWRM=;
        b=sw1N7eFRI+3LMTnP8THnvsddDtvBWqwQejdEwBw4E78vORbd/Ar1CwPNpJNl/wAehE
         tg5L3lldGVMPHAxtv0xb3zJdDuKkvhdxblV3DIz9mjmlIRyxn0oQfsoS6dSgTUglSdeD
         oPqMwvAXSIkowuUQSzpmW7rP+slkSpTDc2Pf4yNoT9U1EV2/jWVT74yXtvnjHdLaMqR9
         4OOwUWLEdpEx5XotO+tuWJA+Fw5RRkVKn5UXOhx6LpQQEPRdoNqaZUp4TCsWYmYjRMOa
         gW3ENcfbei3Nm11E4TYnHzZ7+38cKK4bqjKQxzatQqOx/RoV9WjIxHD3R4GlH8aWk0O5
         o3oQ==
X-Gm-Message-State: AA+aEWY/hCe9kwZ7JxgOyhqIyNbrKoVJ6I8ZUPd81bud8fOxlU9qSpFM
        FlT3bEsvSFUYVReVCgQv7tg+7FJEgYQ=
X-Google-Smtp-Source: AJdET5dKaVN28pzGWvTChNljlRq9QyU9Ap57Vomj32qg5kkSldoDxzwPmBxJdMzsguVtrcUMUIQemw==
X-Received: by 2002:a6b:be41:: with SMTP id o62-v6mr5838641iof.255.1542311023431;
        Thu, 15 Nov 2018 11:43:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id y5sm4657943itb.42.2018.11.15.11.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:43:42 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
From:   Jens Axboe <axboe@kernel.dk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181115191126.GA16973@roeck-us.net>
 <e7f72ebb-68e8-29f4-121b-4053ec8b537e@kernel.dk>
 <20181115193854.GA30639@roeck-us.net>
 <6fb23170-5029-f926-c063-77cefea37427@kernel.dk>
Message-ID: <8bb5c405-55f8-f330-85a5-b22163c83119@kernel.dk>
Date:   Thu, 15 Nov 2018 12:43:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6fb23170-5029-f926-c063-77cefea37427@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 12:40 PM, Jens Axboe wrote:
> On 11/15/18 12:38 PM, Guenter Roeck wrote:
>> On Thu, Nov 15, 2018 at 12:29:04PM -0700, Jens Axboe wrote:
>>> On 11/15/18 12:11 PM, Guenter Roeck wrote:
>>>> On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
>>>>>
>>>>> I think the below patch should fix it.
>>>>>
>>>>
>>>> I spoke too early. sparc64, next-20181115:
>>>>
>>>> [   14.204370] nvme nvme0: pci function 0000:02:00.0
>>>> [   14.249956] nvme nvme0: Removing after probe failure status: -5
>>>> [   14.263496] ------------[ cut here ]------------
>>>> [   14.263913] WARNING: CPU: 0 PID: 15 at kernel/irq/manage.c:1597 __free_irq+0xa4/0x320
>>>> [   14.264265] Trying to free already-free IRQ 9
>>>> [   14.264519] Modules linked in:
>>>> [   14.264961] CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 4.20.0-rc2-next-20181115 #1
>>>> [   14.265555] Workqueue: nvme-reset-wq nvme_reset_work
>>>> [   14.265899] Call Trace:
>>>> [   14.266118]  [000000000046944c] __warn+0xcc/0x100
>>>> [   14.266375]  [00000000004694b0] warn_slowpath_fmt+0x30/0x40
>>>> [   14.266635]  [00000000004d4ce4] __free_irq+0xa4/0x320
>>>> [   14.266867]  [00000000004d4ff8] free_irq+0x38/0x80
>>>> [   14.267092]  [00000000007b1874] pci_free_irq+0x14/0x40
>>>> [   14.267327]  [00000000008a5444] nvme_dev_disable+0xe4/0x520
>>>> [   14.267576]  [00000000008a69b8] nvme_reset_work+0x138/0x1c60
>>>> [   14.267827]  [0000000000488dd0] process_one_work+0x230/0x6e0
>>>> [   14.268079]  [00000000004894f4] worker_thread+0x274/0x520
>>>> [   14.268321]  [0000000000490624] kthread+0xe4/0x120
>>>> [   14.268544]  [00000000004060c4] ret_from_fork+0x1c/0x2c
>>>> [   14.268825]  [0000000000000000]           (null)
>>>> [   14.269089] irq event stamp: 32796
>>>> [   14.269350] hardirqs last  enabled at (32795): [<0000000000b624a4>] _raw_spin_unlock_irqrestore+0x24/0x80
>>>> [   14.269757] hardirqs last disabled at (32796): [<0000000000b622f4>] _raw_spin_lock_irqsave+0x14/0x60
>>>> [   14.270566] softirqs last  enabled at (32780): [<0000000000b64c18>] __do_softirq+0x238/0x520
>>>> [   14.271206] softirqs last disabled at (32729): [<000000000042ceec>] do_softirq_own_stack+0x2c/0x40
>>>> [   14.272288] ---[ end trace cb79ccd2a0a03f3c ]---
>>>>
>>>> Looks like an error during probe followed by an error cleanup problem.
>>>
>>> Did it previous probe fine? Or is the new thing just the fact that
>>> we spew a warning on trying to free a non-existing vector?
>>>
>> This works fine in mainline, if that is your question.
> 
> Yeah, as soon as I sent the other email I realized that. Let me send
> you a quick patch.

How's this?


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ffbab5b01df4..fd73bfd2d1be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2088,15 +2088,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 			affd.nr_sets = 1;
 
 		/*
-		 * Need IRQs for read+write queues, and one for the admin queue.
-		 * If we can't get more than one vector, we have to share the
-		 * admin queue and IO queue vector. For that case, don't add
-		 * an extra vector for the admin queue, or we'll continue
-		 * asking for 2 and get -ENOSPC in return.
+		 * If we got a failure and we're down to asking for just
+		 * 1 + 1 queues, just ask for a single vector. We'll share
+		 * that between the single IO queue and the admin queue.
 		 */
-		if (result == -ENOSPC && nr_io_queues == 1)
-			nr_io_queues = 1;
-		else
+		if (!(result < 0 && nr_io_queues == 1))
 			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
 
 		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,

-- 
Jens Axboe

