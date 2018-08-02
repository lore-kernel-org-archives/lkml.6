Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EBE21537
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih2EwSp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EBE21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeHBU3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:29:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33524 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeHBU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:29:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so1820648pfn.0;
        Thu, 02 Aug 2018 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mHekL8ekTtNYZ92tCM3UbMcQxLzQr6v6UqusMmHzEkI=;
        b=Ih2EwSp5DtKOQqPDfecXAb2YNFy9tCnyUUvrMYh9lE4jSpL/nxIt6ht7AcX2/GKMok
         SEx8t1bWiqosX06kwIWm4jGMTCz5yhx4lsHpiRWz53ebuRcNcD6nuCONCTh4P+KqbJZl
         p2MXxMPDXRWzAkIGmGoCM7ARu2AYmMF9oQZZMVl66vpz5/tYsPqF/m9w49WJb4wfUGv2
         uJ/C3FOoz892e7mp50sAJMsGHN/d4kFLCVC5U+x0IjzNvVZDMNfHVCEiyAYL4J9PXZGR
         sOhoZikpSYR8iLYyByHPm896UsctnxiY5IcX4XS/5vCCO/17h/5s6UGTQ42PZ0dCgYuE
         5Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mHekL8ekTtNYZ92tCM3UbMcQxLzQr6v6UqusMmHzEkI=;
        b=gKRH/rhDAqoOKtquKQ+VObjrT56cHlGeZapV2QeSf9eI0PeNsCvFRaiSfvBS79CdAe
         504PdiWvbZ+DUtI3FxtFiWvIahBRUA05ZYDfp7DPlGUP7olErIWv4PJ8WCOBTkf8cDST
         g4kQNs8PvAinrAL7NbRpko7yce5ql42yQnVWWHV1TfRhpHL58qyvlJ3Rf6zDmgt1ZE6b
         gE7aOwO2zXQG5qsF01uVw0xcy7ZEIH4wymkRc5Bzfs2v4ETRoDZEtlRItggdYmPfj2qE
         gFXt4q8u7ZkBgRjuX2MUcdapHtlkyE0MSjPkFLe0MvlR+GRGmlmp3ie9eq+wqDXRqYX6
         qK1w==
X-Gm-Message-State: AOUpUlE8/ce9tqXN9mE/3evs6Hi64dr2W7gWu4Kk/oZjrIaKO6OEzybA
        cNX1L+592A00etYHzrM9abM=
X-Google-Smtp-Source: AAOMgpcmaF9wsGAQT2/7ekMoA/LV9szORuv/YEFbFpdxnOmvREQ/nQZrCrJAfmHhPNAzhB2kZpT16Q==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr568223pgq.392.1533235042426;
        Thu, 02 Aug 2018 11:37:22 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g5-v6sm2369932pgn.73.2018.08.02.11.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 11:37:21 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:37:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] blk-mq: fix blk_mq_tagset_busy_iter
Message-ID: <20180802183720.GA19280@roeck-us.net>
References: <20180802174937.15444-1-ming.lei@redhat.com>
 <20180802174937.15444-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802174937.15444-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 01:49:37AM +0800, Ming Lei wrote:
> Commit d250bf4e776ff09d5("blk-mq: only iterate over inflight requests
> in blk_mq_tagset_busy_iter") uses 'blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT'
> to replace 'blk_mq_request_started(req)', this way is wrong, and causes
> lots of test system hang during booting.
> 
> Fix the issue by using blk_mq_request_started(req) inside bt_tags_iter().
> 
> Fixes: d250bf4e776ff09d5 ("blk-mq: only iterate over inflight requests in blk_mq_tagset_busy_iter")
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matt Hart <matthew.hart@linaro.org>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Hannes Reinecke <hare@suse.com>,
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
> Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Mark Brown <broonie@kernel.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Test builds (with both patches applied):

Building mips:malta_defconfig:nosmp ... running ..... passed
Building mips:malta_defconfig:smp ... running ..... passed
Building x86_64:q35:Broadwell-noTSX:defconfig:smp:sata:rootfs ... running .....  passed
Building x86_64:q35:IvyBridge:defconfig:smp:nvme:rootfs ... running ..... passed
Building x86_64:q35:SandyBridge:defconfig:smp:usb:rootfs ... running ......  passed
Building x86_64:q35:Haswell:defconfig:smp:usb-uas:rootfs ... running ......  passed
Building x86_64:q35:Skylake-Client:defconfig:smp:mmc:rootfs ... running ......  passed
Building x86_64:q35:Conroe:defconfig:smp:scsi[DC395]:rootfs ... running .......  passed
Building x86_64:q35:Nehalem:defconfig:smp:scsi[AM53C974]:rootfs ... running ....... passed
Building x86_64:q35:Westmere-IBRS:defconfig:smp:scsi[53C810]:rootfs ... running ...... passed
Building x86_64:q35:Skylake-Server:defconfig:smp:scsi[53C895A]:rootfs ...  running ...... passed
Building x86_64:pc:EPYC:defconfig:smp:scsi[MEGASAS]:rootfs ... running ......  passed
Building x86_64:q35:EPYC-IBPB:defconfig:smp:scsi[MEGASAS2]:rootfs ... running ..... passed
Building x86_64:q35:Opteron_G5:defconfig:smp:scsi[FUSION]:rootfs ... running ..... passed
Building x86_64:pc:phenom:defconfig:smp:initrd ... running ..... passed
Building x86_64:q35:Opteron_G1:defconfig:smp:initrd ... running ..... passed
Building x86_64:pc:Opteron_G2:defconfig:smp:sata:rootfs ... running ..... passed
Building x86_64:q35:core2duo:defconfig:smp:usb:rootfs ... running ...... passed
Building x86_64:pc:Opteron_G3:defconfig:nosmp:usb:rootfs ... running .......  passed
Building x86_64:q35:Opteron_G4:defconfig:nosmp:sata:rootfs ... running ......  passed

Guenter
