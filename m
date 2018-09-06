Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA6B20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="soHjk24D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA6B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeIFXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:13:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeIFXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dsPkwDqkgPJNRtFkRW3tQYjUsU2sTvS4QHz1vIiUdm4=; b=soHjk24DVpP4Gc41A33pEoKQt
        wPZhZB9i4hUdvfM9699xpwJe1xz33dJ3IAI8im9o2KR5VMyBq7m5xmkwwa5EZzrjI4wfm/oLyYL5f
        j9iuiOt2ME3SZrTcL0UNLpvNaW8fxgtJRyxNYKjiZ2spNMif/ypFqPSS12MuYT00bYK1kW5F+J46e
        6Pwyt2u7klZyznrbVb6LixwwSElp9XMFmudaoMGAc+7m01xvKPB+Tftv8l74vl2H0FtIIeyz7OhGz
        RjXEumb9DJ7jPi3NkyjO0wfsuk+yTcTe47S/riflgNU0znI2CDof/+zfc8ptgMJl7PowIf1lsYsoA
        i+4RmSOPw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxz8x-00025G-Ix; Thu, 06 Sep 2018 18:36:39 +0000
Subject: Re: [PATCH 1/7] vfio/sdmdev: Add documents for WarpDrive framework
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-2-nek.in.cn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56f5f66d-f6d9-f4fa-40ca-e4a8bad170c1@infradead.org>
Date:   Thu, 6 Sep 2018 11:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-2-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/02/2018 05:51 PM, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> WarpDrive is a common user space accelerator framework.  Its main component
> in Kernel is called sdmdev, Share Domain Mediated Device. It exposes
> the hardware capabilities to the user space via vfio-mdev. So processes in
> user land can obtain a "queue" by open the device and direct access the
> hardware MMIO space or do DMA operation via VFIO interface.
> 
> WarpDrive is intended to be used with Jean Philippe Brucker's SVA
> patchset to support multi-process. But This is not a must.  Without the
> SVA patches, WarpDrive can still work for one process for every hardware
> device.
> 
> This patch add detail documents for the framework.
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>  Documentation/00-INDEX                |   2 +
>  Documentation/warpdrive/warpdrive.rst | 100 ++++
>  Documentation/warpdrive/wd-arch.svg   | 728 ++++++++++++++++++++++++++
>  3 files changed, 830 insertions(+)
>  create mode 100644 Documentation/warpdrive/warpdrive.rst
>  create mode 100644 Documentation/warpdrive/wd-arch.svg

> diff --git a/Documentation/warpdrive/warpdrive.rst b/Documentation/warpdrive/warpdrive.rst
> new file mode 100644
> index 000000000000..6d2a5d1e08c4
> --- /dev/null
> +++ b/Documentation/warpdrive/warpdrive.rst
> @@ -0,0 +1,100 @@
> +Introduction of WarpDrive
> +=========================
> +
> +*WarpDrive* is a general accelerator framework for user space. It intends to
> +provide interface for the user process to send request to hardware
> +accelerator without heavy user-kernel interaction cost.
> +
> +The *WarpDrive* user library is supposed to provide a pipe-based API, such as:

Do you say "is supposed to" because it doesn't do that (yet)?
Or you could just change that to say:

   The WarpDrive user library provides a pipe-based API, such as:


> +        ::
> +        int wd_request_queue(struct wd_queue *q);
> +        void wd_release_queue(struct wd_queue *q);
> +
> +        int wd_send(struct wd_queue *q, void *req);
> +        int wd_recv(struct wd_queue *q, void **req);
> +        int wd_recv_sync(struct wd_queue *q, void **req);
> +        int wd_flush(struct wd_queue *q);
> +
> +*wd_request_queue* creates the pipe connection, *queue*, between the
> +application and the hardware. The application sends request and pulls the
> +answer back by asynchronized wd_send/wd_recv, which directly interact with the
> +hardware (by MMIO or share memory) without syscall.
> +
> +*WarpDrive* maintains a unified application address space among all involved
> +accelerators.  With the following APIs: ::

Seems like an extra '.' there.  How about:

  accelerators with the following APIs: ::

> +
> +        int wd_mem_share(struct wd_queue *q, const void *addr,
> +                         size_t size, int flags);
> +        void wd_mem_unshare(struct wd_queue *q, const void *addr, size_t size);
> +
> +The referred process space shared by these APIs can be directly referred by the
> +hardware. The process can also dedicate its whole process space with flags,
> +*WD_SHARE_ALL* (not in this patch yet).
> +
> +The name *WarpDrive* is simply a cool and general name meaning the framework
> +makes the application faster. As it will be explained in this text later, the
> +facility in kernel is called *SDMDEV*, namely "Share Domain Mediated Device".
> +
> +
> +How does it work
> +================
> +
> +*WarpDrive* is built upon *VFIO-MDEV*. The queue is wrapped as *mdev* in VFIO.
> +So memory sharing can be done via standard VFIO standard DMA interface.
> +
> +The architecture is illustrated as follow figure:
> +
> +.. image:: wd-arch.svg
> +        :alt: WarpDrive Architecture
> +
> +Accelerator driver shares its capability via *SDMDEV* API: ::
> +
> +        vfio_sdmdev_register(struct vfio_sdmdev *sdmdev);
> +        vfio_sdmdev_unregister(struct vfio_sdmdev *sdmdev);
> +        vfio_sdmdev_wake_up(struct spimdev_queue *q);
> +
> +*vfio_sdmdev_register* is a helper function to register the hardware to the
> +*VFIO_MDEV* framework. The queue creation is done by *mdev* creation interface.
> +
> +*WarpDrive* User library mmap the mdev to access its mmio space and shared

s/mmio/MMIO/

> +memory. Request can be sent to, or receive from, hardware in this mmap-ed
> +space until the queue is full or empty.
> +
> +The user library can wait on the queue by ioctl(VFIO_SDMDEV_CMD_WAIT) the mdev
> +if the queue is full or empty. If the queue status is changed, the hardware
> +driver use *vfio_sdmdev_wake_up* to wake up the waiting process.
> +
> +
> +Multiple processes support
> +==========================
> +
> +In the latest mainline kernel (4.18) when this document is written,
> +multi-process is not supported in VFIO yet.
> +
> +Jean Philippe Brucker has a patchset to enable it[1]_. We have tested it
> +with our hardware (which is known as *D06*). It works well. *WarpDrive* rely
> +on them to support multiple processes. If it is not enabled, *WarpDrive* can
> +still work, but it support only one mdev for a process, which will share the
> +same io map table with kernel. (But it is not going to be a security problem,
> +since the user application cannot access the kernel address space)
> +
> +When multiprocess is support, mdev can be created based on how many
> +hardware resource (queue) is available. Because the VFIO framework accepts only
> +one open from one mdev iommu_group. Mdev become the smallest unit for process
> +to use queue. And the mdev will not be released if the user process exist. So
> +it will need a resource agent to manage the mdev allocation for the user
> +process. This is not in this document's range.
> +
> +
> +Legacy Mode Support
> +===================
> +For the hardware on which IOMMU is not support, WarpDrive can run on *NOIOMMU*
> +mode. That require some update to the mdev driver, which is not included in
> +this version yet.
> +
> +
> +References
> +==========
> +.. [1] https://patchwork.kernel.org/patch/10394851/
> +
> +.. vim: tw=78

thanks,
-- 
~Randy
