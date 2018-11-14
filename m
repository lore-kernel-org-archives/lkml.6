Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D180C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1891F21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3JoBAeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1891F21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeKNOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:54:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:54:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id g7-v6so7245350pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9d9P7idAYlbZ/SsvBLr6K2Xvp3cwtGkn+tnNwPb2bYE=;
        b=k3JoBAeg0hGagwwqHqxM315pkdGVUzdH6slh5IHAxR2BoUp34c/qs63qdENpb//+hJ
         Pae7IUuqflWWRMSu41MoWoaPzyxd7RqYJS6ecLnOUeb4HL2/id7FDfFY8FSiAmtyxZ6z
         zTabmZvUxC2r1ig0BQVHVwlJAczoHsRxDuz/o3DYPnw+mJOonTt+z90Uj+XoGgvvZJPT
         N/8xeNnj3nWx4jvrkkVyN8liabAnhZYcjN9FNgm58LwXv7rri76gDpUksnAwyAFop+vR
         PT5LDwdddyzpFRPzCZHv4q6XgloedCdi8TDHIBnQMRobGJjNrW6IfXy8iIE4d2HHnW0q
         di/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9d9P7idAYlbZ/SsvBLr6K2Xvp3cwtGkn+tnNwPb2bYE=;
        b=AmtEN+tWEpxNBSV1ITxxtmCqFbW3IHAQrGCVYMopa3TR1twfi1CB05DeNuBOrlB8jM
         wy/25fYECVvtS3UsSmz+PIxMSEATSe+rnb+8ellRVtNakeG30R8BSJAhLkAsDnbaJ1at
         gbonOxYrNbqen2gkJd5oiWhTTql+U+oWwsIvkYT3em8npLVJfGvXyRzFOkXlxzkqNQn8
         LkNZsUILNLEb2FsDwQOYSO+p5X6RYVEW40fH/DBgv9sWpkWJws/pe2st0zoT/Y164gxZ
         4Ytaq9c3Xxlbn4Oz3En8IadURZZGSHNhq+09PB9scOsp4FlhtPQqB20HAzDLZjXLcW7W
         h/fg==
X-Gm-Message-State: AGRZ1gJ6tnxA1WYuS+Fp24gyVic7pSjmcInEdVFtbhwLbL5DZjWVg9HN
        qgMGqcH6tbVN3dwdUz9Zj3s=
X-Google-Smtp-Source: AJdET5e0EAeAupzze8MbPHPUr1OOy9XQHLaF/k7usjR8pQdFMEYmB4umYg7wYabmV+r7KOopbQA9FA==
X-Received: by 2002:a63:561b:: with SMTP id k27mr373834pgb.271.1542171160324;
        Tue, 13 Nov 2018 20:52:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f22-v6sm20857827pfn.177.2018.11.13.20.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:52:39 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:52:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181114045237.GA6456@roeck-us.net>
References: <20181114004148.GA29545@roeck-us.net>
 <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 05:51:08PM -0700, Jens Axboe wrote:
> On 11/13/18 5:41 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
> >> NVMe does round-robin between queues by default, which means that
> >> sharing a queue map for both reads and writes can be problematic
> >> in terms of read servicing. It's much easier to flood the queue
> >> with writes and reduce the read servicing.
> >>
> >> Implement two queue maps, one for reads and one for writes. The
> >> write queue count is configurable through the 'write_queues'
> >> parameter.
> >>
> >> By default, we retain the previous behavior of having a single
> >> queue set, shared between reads and writes. Setting 'write_queues'
> >> to a non-zero value will create two queue sets, one for reads and
> >> one for writes, the latter using the configurable number of
> >> queues (hardware queue counts permitting).
> >>
> >> Reviewed-by: Hannes Reinecke <hare@suse.com>
> >> Reviewed-by: Keith Busch <keith.busch@intel.com>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > This patch causes hangs when running recent versions of
> > -next with several architectures; see the -next column at
> > kerneltests.org/builders for details.  Bisect log below; this
> > was run with qemu on alpha. Reverting this patch as well as
> > "nvme: add separate poll queue map" fixes the problem.
> 
> I don't see anything related to what hung, the trace, and so on.
> Can you clue me in? Where are the test results with dmesg?
> 
alpha just stalls during boot. parisc reports a hung task
in nvme_reset_work. sparc64 reports EIO when instantiating
the nvme driver, called from nvme_reset_work, and then stalls.
In all three cases, reverting the two mentioned patches fixes
the problem.

https://kerneltests.org/builders/qemu-parisc-next/builds/173/steps/qemubuildcommand_1/logs/stdio

is an example log for parisc.

I didn't check if the other boot failures (ppc looks bad)
have the same root cause.

> How to reproduce?
> 
parisc:

qemu-system-hppa -kernel vmlinux -no-reboot \
	-snapshot -device nvme,serial=foo,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
	-nographic -monitor null

alpha:

qemu-system-alpha -M clipper -kernel arch/alpha/boot/vmlinux -no-reboot \
	-snapshot -device nvme,serial=foo,drive=d0 \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
	-m 128M -nographic -monitor null -serial stdio

sparc64:

qemu-system-sparc64 -M sun4u -cpu 'TI UltraSparc IIi' -m 512 \
	-snapshot -device nvme,serial=foo,drive=d0,bus=pciB \
	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
	-kernel arch/sparc/boot/image -no-reboot \
	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
	-nographic -monitor none

The root file systems are available from the respective subdirectories
of:

https://github.com/groeck/linux-build-test/tree/master/rootfs

Guenter
