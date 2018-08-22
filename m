Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6C208A1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZH4kJQVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6C208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHVVHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:07:53 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33553 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeHVVHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:07:53 -0400
Received: by mail-pg1-f176.google.com with SMTP id t14-v6so1256510pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SX939PcJXMKhqm4/wnT2sL6f6PWUl0plhD5eZn5V//U=;
        b=ZH4kJQVFuktbmCp6rVCkqtqD70YuwS5k/+D/xkAokhyBcZ6wJkFhbfmDIHp8lD1x3N
         d1uPW0beTMibZbQsWhtc7estQetE4K4XsQXzVYkvzGd25+2fTabxmLJBMCWLs3tj0Wzk
         UtYt2PD3HVPeuWNv0qqwwCyOQ32S1OF+mfMn6RJr1LJ8nQ7H/pdNu8HeydUeUWB/OT6k
         yM3n3BTn78WtIk8Uj36Ik7QorIkioVlhR9xuV1l0fTfEKLH0WTikVuzwCsOYHBg4mvP3
         ApwlCqQQ0NUYNu9MNhYjczrkLdJyWTZaQ5eYUu1dSnGhgMPsKbTPJD6naKNRoXKs2/iB
         UQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX939PcJXMKhqm4/wnT2sL6f6PWUl0plhD5eZn5V//U=;
        b=KNieHjlUjx09/siaBdMXl0/FBw+vfOyVPeEvRBvE+fP/YyC6NKN2YdDR10DsiSXF/U
         0dJl3q10kv42jWgoDBsIe110qZpADZ7LvUDb7S5T/CZhFT8VP/QTVZJ/U4ZPaj5+ptCc
         cFX1YJ3tFczaYu9K9fmkos7F6zlTFLciL7bbddba/mDNaCRk0Ul6hwRvBToMEFK/DTqZ
         SNsJjXkXxTuHyojGKQArjnAS1hzUDdd7gn3BXn0pb689EjlomNqjkTjOz2PAZAVB6YY1
         QmbAHBZmmKMYMzRUOO5TLmcUTf2fioTG1Y2Xt2finrkKTZYWMznhe6PRFL7wFq46iUoz
         z7Cg==
X-Gm-Message-State: AOUpUlGvgI/2bPGSDC6NKlU+hJQYaZzrcx9k5b7kWPUe9T4e3r/FBQ+m
        fIHIP6qx14758+qvHxwZIXxzTZF+Gs0=
X-Google-Smtp-Source: AA+uWPxmPcnUizX1OQQJEi5EfYfIA8PO4JkS909nF1bWGUxx9Sc2zbwtfGbbta5J/rD0jBWl7f8W2Q==
X-Received: by 2002:a62:25c5:: with SMTP id l188-v6mr58146750pfl.179.1534959723059;
        Wed, 22 Aug 2018 10:42:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1130::1153? ([2620:10d:c090:180::1:bf4f])
        by smtp.gmail.com with ESMTPSA id v4-v6sm2385051pgr.36.2018.08.22.10.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:42:01 -0700 (PDT)
Subject: Re: MQ-BFQ crashing on battery mode
To:     Massimo Burcheri <massimo@burcheri.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
References: <1534926011.18658.29.camel@burcheri.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
Date:   Wed, 22 Aug 2018 11:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1534926011.18658.29.camel@burcheri.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 2:20 AM, Massimo Burcheri wrote:
> Hello,
> 
> 
> I got a kernel trace when unplugging the power supply, switching to battery
> mode. I get the same kernel trace when booting on battery.
> Both making the system unusable or breaking the boot.
> 
> The kernel call trace with symbols:
> 
> ? blk_mq_requeue_request+0x...
> ? __scsi_queue_insert+0x...
> ? ata_scsi_var_len_cdb_xlat+0x
> ? __blk_mq_complete_request+0x...
> ? ata_scsi_translate+0x...
> ? ata_scsi_queuecmd+0x...
> ? scsi_dispatch_cmd+0x...
> ? scsi_queue_rq+0x...
> ? blk_mq_dispatch_rq_list+0x...
> ? kyber_dispatch_cur_domain+0x...
> ? kyber_completed_request+0x...
> ? blk_mq_sched_dispatch_requests+0x...
> ? __ blk_mq_run_hw_queue+0x...
> ? __blk_mq_delay_run_hw_queue+0x...
> ? blk_mq_run_hw_queue+0x...
> ? blk_mq_run_hw_queues+0x...
> ? blk_mq_requeue_work+0x...
> ? process_one_work+0x...
> ? worker_thread+0x...
> ? process_one_work+0x...
> ? kthread+0x...
> ? kthread_flush_work_fn+0x...
> ? ret_from_fork+0x...
> Code: ...
> RIP: sbitmap_queue_clear+0x...
> 
> Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
> Kernel config: 	https://bpaste.net/show/870004e55123
> 
> Kernel: 4.17.11-ck
> 
> Setup:
> 
> btrfs-on-bcache-on-luks
> btrfs options (rw,noatime,nodiratime,compress-
> force=lzo,nossd,noacl,space_cache,autodefrag)
> 
> Using mq bfq scheduler for the hdd backing and kyber for the ssd caching device
> 
> 
> Failed tests:
> Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry for not
> including the vanilla sources in the test, I can provide if required.
> Skipping services in the boot process didn't help, any next service leads to the
> same trace.
> Switching off the laptop-mode-tools daemon didn't help.
> Switching all devices to "none" scheduler did not help.

Any chance you can try 4.18 at least?

> Workaround:
> After some tests and due to the *mq* call stack I was able to workaround by
> disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and switching all
> devices to cfq scheduler.
> However with the MQ enabled kernel, only bfq, kyber and none are possible, while
> the non-mq kernel can only set cfq. I guess this is intentional as the current
> bfq implementation is a MQ only version and CFQ is a non-mq only version?

Schedulers are specific to the queuing infrastructure, so certain types
will only be available with MQ and certain types will only be available
on !MQ.

-- 
Jens Axboe

