Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5296C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE292089F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pWKqCezr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE292089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbeKODQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:16:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36163 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKODQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:16:51 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so6592829ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zrH/Kuoo+Oh7wGIVxuKr4Wis8qiL5j5zeuNHIBI1q8M=;
        b=pWKqCezrySseVc+6MUT5dkUjyTV4UvU269Pc8ht8SOSyfyLpRY8GSO0i390EYDY1Pk
         MUNLnKPHdVc2a6ZepmtyaEH2Qe2o8cPkbQXIY74jSlw0hHyBvkGPl+ow7D0IX9wJQrkO
         hWKnXg7BypoIRoEyfGhgj0ac5cN6SH8AfPbo1gKY4A/Ot6VId+z8RGb4q9PLRSlJiDre
         lMkwMr4MdAw+QJOZjDNhO77PQRtLJ75SD4cwZuGCkqdL4OM5V4SuPdZq5/Gt9CxAhLFA
         BCmp+n4wFPwOGqPzFbPTZgZxicB47kXZGUVajsw07VKONsHcgr9jadKnBOq8XSpEtzxI
         MYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zrH/Kuoo+Oh7wGIVxuKr4Wis8qiL5j5zeuNHIBI1q8M=;
        b=Y1g2PjdyhKpHy8vNQnGfcMidbtAiPxirQxyQQWh7vnIatw8yqoXMPrU+1gDWt1biJu
         d5wuraTKiIjaHn5iChCGnAXJGwdNXHZnYQ87osF91NXKYOv99OpgjlMik+u6qeIENyHt
         WeOCQ8hz04WD8W3eW8zjX0BQ3OcHRvYtHzD1eoeRDEInxUJyPgcVsA26b7oQp1JqV4ha
         ndpUI6Zgo1LyhihqIAkLpBykprl1OyYR3jAUCIEiXJQL9hfuzGEx6BylX4gdl4lAOafF
         kNxYBLGdLk2ZK7gmvgCpQT8usFRCbRX88tX9QMNyyXq6I0RVcy56Hux9QHCMN4cfs6Sy
         p4SQ==
X-Gm-Message-State: AGRZ1gLGMJxj/w+DsSUF7bg0fUVVwZ60Qe+MR+Dd3ThGgikTSp+7Jn8e
        brkeqLe0KkZm8hcGlffPjh3KYeEb+vE=
X-Google-Smtp-Source: AFSGD/VEamOwl5ki/z9Cc3gpPgGbteVtiVv2E3sUmEPWQY09ovU9VgRpGXJLfwVTTgcfsU7WDusvtQ==
X-Received: by 2002:a6b:3945:: with SMTP id g66mr2063597ioa.131.1542215567241;
        Wed, 14 Nov 2018 09:12:47 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 142-v6sm8534436itw.40.2018.11.14.09.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:12:45 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181114004148.GA29545@roeck-us.net>
 <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
 <20181114045237.GA6456@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e0d80ea-4c81-3905-be0b-f84a0e9cca13@kernel.dk>
Date:   Wed, 14 Nov 2018 10:12:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114045237.GA6456@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 9:52 PM, Guenter Roeck wrote:
> On Tue, Nov 13, 2018 at 05:51:08PM -0700, Jens Axboe wrote:
>> On 11/13/18 5:41 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
>>>> NVMe does round-robin between queues by default, which means that
>>>> sharing a queue map for both reads and writes can be problematic
>>>> in terms of read servicing. It's much easier to flood the queue
>>>> with writes and reduce the read servicing.
>>>>
>>>> Implement two queue maps, one for reads and one for writes. The
>>>> write queue count is configurable through the 'write_queues'
>>>> parameter.
>>>>
>>>> By default, we retain the previous behavior of having a single
>>>> queue set, shared between reads and writes. Setting 'write_queues'
>>>> to a non-zero value will create two queue sets, one for reads and
>>>> one for writes, the latter using the configurable number of
>>>> queues (hardware queue counts permitting).
>>>>
>>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>>>> Reviewed-by: Keith Busch <keith.busch@intel.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> This patch causes hangs when running recent versions of
>>> -next with several architectures; see the -next column at
>>> kerneltests.org/builders for details.  Bisect log below; this
>>> was run with qemu on alpha. Reverting this patch as well as
>>> "nvme: add separate poll queue map" fixes the problem.
>>
>> I don't see anything related to what hung, the trace, and so on.
>> Can you clue me in? Where are the test results with dmesg?
>>
> alpha just stalls during boot. parisc reports a hung task
> in nvme_reset_work. sparc64 reports EIO when instantiating
> the nvme driver, called from nvme_reset_work, and then stalls.
> In all three cases, reverting the two mentioned patches fixes
> the problem.

I think the below patch should fix it.

> https://kerneltests.org/builders/qemu-parisc-next/builds/173/steps/qemubuildcommand_1/logs/stdio
> 
> is an example log for parisc.
> 
> I didn't check if the other boot failures (ppc looks bad)
> have the same root cause.
> 
>> How to reproduce?
>>
> parisc:
> 
> qemu-system-hppa -kernel vmlinux -no-reboot \
> 	-snapshot -device nvme,serial=foo,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
> 	-nographic -monitor null
> 
> alpha:
> 
> qemu-system-alpha -M clipper -kernel arch/alpha/boot/vmlinux -no-reboot \
> 	-snapshot -device nvme,serial=foo,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
> 	-m 128M -nographic -monitor null -serial stdio
> 
> sparc64:
> 
> qemu-system-sparc64 -M sun4u -cpu 'TI UltraSparc IIi' -m 512 \
> 	-snapshot -device nvme,serial=foo,drive=d0,bus=pciB \
> 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> 	-kernel arch/sparc/boot/image -no-reboot \
> 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
> 	-nographic -monitor none
> 
> The root file systems are available from the respective subdirectories
> of:
> 
> https://github.com/groeck/linux-build-test/tree/master/rootfs

This is useful, thanks! I haven't tried it yet, but I was able to
reproduce on x86 with MSI turned off.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8df868afa363..6c03461ad988 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2098,7 +2098,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 		.nr_sets = ARRAY_SIZE(irq_sets),
 		.sets = irq_sets,
 	};
-	int result;
+	int result = 0;
 
 	/*
 	 * For irq sets, we have to ask for minvec == maxvec. This passes
@@ -2113,9 +2113,16 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 			affd.nr_sets = 1;
 
 		/*
-		 * Need IRQs for read+write queues, and one for the admin queue
+		 * Need IRQs for read+write queues, and one for the admin queue.
+		 * If we can't get more than one vector, we have to share the
+		 * admin queue and IO queue vector. For that case, don't add
+		 * an extra vector for the admin queue, or we'll continue
+		 * asking for 2 and get -ENOSPC in return.
 		 */
-		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
+		if (result == -ENOSPC && nr_io_queues == 1)
+			nr_io_queues = 1;
+		else
+			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
 
 		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
 				nr_io_queues,

-- 
Jens Axboe

