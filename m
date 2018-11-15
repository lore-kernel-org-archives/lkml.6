Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C66C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18CF21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byCmyqwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18CF21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbeKPEhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:37:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:37:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so2300729plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cn20GRusdWaz0ZLHIh2L0lNds5w5/KnsUy4KR8f4Oco=;
        b=byCmyqwiDaKBdnkTOWjKNKeZlXjy96SXrefgcrc/SFFBUPX/FvHnqS01KzURCSaTD0
         m6e4sVpZleisXJ/OR/AqpFaW8TQFarewx2BLSaof4uQeX5ZjUmIbw968pgt8k/kKxE0Z
         FpvLctgsHX7cEzik8UvMABsRipLpcy4donU3dq2Qint8OZlR1AMUAD++concgi4RRAUp
         MKdH5fCLn22EGr2gmfarxFxPNOXvnwcBsabWDlqn96PYOdeaxt7MWqRLYbKS4P62J2Sn
         Uup5rzJpHi1QWUNpkJ1+42t0Y/6Qm5GgCwWUiy1qjQiVQu9uKb3yBRS2YrcA/Z5AUr26
         0JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=cn20GRusdWaz0ZLHIh2L0lNds5w5/KnsUy4KR8f4Oco=;
        b=ALDEePCbnaPGwgus0b5/+MOHc3yMK0p9hLPNyNzYtC+urG60sl6oltrkiP28refrSS
         q2Vg9X/2V2XLx5lx4urEu7onluf/fRlPxZPsIWlJaAfffu+gW4nRhn2daxABQzEpd49U
         aRNFUb71/QkGw09nJXOvDNxlBmFPgQs/IYrW6udpkGsVpx3Exl2YK85QkFgWtvPlm0dj
         6YsdkJcqkqPDvxw318rRn7UZcbqllR1g5QbKMdCM5uasvyksWRs2HjPjj+Z140xjfyo+
         78a6wI1yvduXOs5CvxrY7klznWFxbe+6QHQ8OFHT5Zs7go8zvGOdvbx8syAlqRXQiFP5
         g3Sg==
X-Gm-Message-State: AGRZ1gLBQ0F4hOgHsWE5mo7ftmmE3m2tWTcuREWa8ozXJivII0chU3+A
        mUc6sbFeonRBQyIBicLu/cw=
X-Google-Smtp-Source: AJdET5fT3sB9Foy8bn/fo3Lg0BdgIAwsuqdJSMEDhqcvkEJmkWBWwgJpQKIYH7P115v9P5S9K4Xe7g==
X-Received: by 2002:a17:902:7a2:: with SMTP id 31-v6mr7250196plj.277.1542306516474;
        Thu, 15 Nov 2018 10:28:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-v6sm37539638pfb.44.2018.11.15.10.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:28:35 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:28:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
Message-ID: <20181115182833.GA15729@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Nov 14, 2018 at 10:12:44AM -0700, Jens Axboe wrote:
> On 11/13/18 9:52 PM, Guenter Roeck wrote:
> > On Tue, Nov 13, 2018 at 05:51:08PM -0700, Jens Axboe wrote:
> >> On 11/13/18 5:41 PM, Guenter Roeck wrote:
> >>> Hi,
> >>>
> >>> On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
> >>>> NVMe does round-robin between queues by default, which means that
> >>>> sharing a queue map for both reads and writes can be problematic
> >>>> in terms of read servicing. It's much easier to flood the queue
> >>>> with writes and reduce the read servicing.
> >>>>
> >>>> Implement two queue maps, one for reads and one for writes. The
> >>>> write queue count is configurable through the 'write_queues'
> >>>> parameter.
> >>>>
> >>>> By default, we retain the previous behavior of having a single
> >>>> queue set, shared between reads and writes. Setting 'write_queues'
> >>>> to a non-zero value will create two queue sets, one for reads and
> >>>> one for writes, the latter using the configurable number of
> >>>> queues (hardware queue counts permitting).
> >>>>
> >>>> Reviewed-by: Hannes Reinecke <hare@suse.com>
> >>>> Reviewed-by: Keith Busch <keith.busch@intel.com>
> >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>
> >>> This patch causes hangs when running recent versions of
> >>> -next with several architectures; see the -next column at
> >>> kerneltests.org/builders for details.  Bisect log below; this
> >>> was run with qemu on alpha. Reverting this patch as well as
> >>> "nvme: add separate poll queue map" fixes the problem.
> >>
> >> I don't see anything related to what hung, the trace, and so on.
> >> Can you clue me in? Where are the test results with dmesg?
> >>
> > alpha just stalls during boot. parisc reports a hung task
> > in nvme_reset_work. sparc64 reports EIO when instantiating
> > the nvme driver, called from nvme_reset_work, and then stalls.
> > In all three cases, reverting the two mentioned patches fixes
> > the problem.
> 
> I think the below patch should fix it.
> 
Sorry I wasn't able to test this earlier. Looks like it does
fix the problem; the problem is no longer seen in next-20181115.
Minor comment below.

Guenter

> > https://kerneltests.org/builders/qemu-parisc-next/builds/173/steps/qemubuildcommand_1/logs/stdio
> > 
> > is an example log for parisc.
> > 
> > I didn't check if the other boot failures (ppc looks bad)
> > have the same root cause.
> > 
> >> How to reproduce?
> >>
> > parisc:
> > 
> > qemu-system-hppa -kernel vmlinux -no-reboot \
> > 	-snapshot -device nvme,serial=foo,drive=d0 \
> > 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> > 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0,115200 ' \
> > 	-nographic -monitor null
> > 
> > alpha:
> > 
> > qemu-system-alpha -M clipper -kernel arch/alpha/boot/vmlinux -no-reboot \
> > 	-snapshot -device nvme,serial=foo,drive=d0 \
> > 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> > 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
> > 	-m 128M -nographic -monitor null -serial stdio
> > 
> > sparc64:
> > 
> > qemu-system-sparc64 -M sun4u -cpu 'TI UltraSparc IIi' -m 512 \
> > 	-snapshot -device nvme,serial=foo,drive=d0,bus=pciB \
> > 	-drive file=rootfs.ext2,if=none,format=raw,id=d0 \
> > 	-kernel arch/sparc/boot/image -no-reboot \
> > 	-append 'root=/dev/nvme0n1 rw rootwait panic=-1 console=ttyS0' \
> > 	-nographic -monitor none
> > 
> > The root file systems are available from the respective subdirectories
> > of:
> > 
> > https://github.com/groeck/linux-build-test/tree/master/rootfs
> 
> This is useful, thanks! I haven't tried it yet, but I was able to
> reproduce on x86 with MSI turned off.
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8df868afa363..6c03461ad988 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2098,7 +2098,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>  		.nr_sets = ARRAY_SIZE(irq_sets),
>  		.sets = irq_sets,
>  	};
> -	int result;
> +	int result = 0;
>  
>  	/*
>  	 * For irq sets, we have to ask for minvec == maxvec. This passes
> @@ -2113,9 +2113,16 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
>  			affd.nr_sets = 1;
>  
>  		/*
> -		 * Need IRQs for read+write queues, and one for the admin queue
> +		 * Need IRQs for read+write queues, and one for the admin queue.
> +		 * If we can't get more than one vector, we have to share the
> +		 * admin queue and IO queue vector. For that case, don't add
> +		 * an extra vector for the admin queue, or we'll continue
> +		 * asking for 2 and get -ENOSPC in return.
>  		 */
> -		nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
> +		if (result == -ENOSPC && nr_io_queues == 1)
> +			nr_io_queues = 1;

Setting nr_io_queues to 1 when it already is set to 1 doesn't really do
anything. Is this for clarification ?

> +		else
> +			nr_io_queues = irq_sets[0] + irq_sets[1] + 1;
>  
>  		result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues,
>  				nr_io_queues,
> 
> -- 
> Jens Axboe
> 
