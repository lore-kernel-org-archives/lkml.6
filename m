Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C628C24076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C628C24076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeGEToe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753636AbeGETod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3489730E4E8A;
        Thu,  5 Jul 2018 19:44:33 +0000 (UTC)
Received: from t450s.home (ovpn-116-113.phx2.redhat.com [10.3.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D27A17DDC;
        Thu,  5 Jul 2018 19:44:32 +0000 (UTC)
Date:   Thu, 5 Jul 2018 13:44:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svptas.linux@gmail.com,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com,
        ajitn.linux@gmail.com
Subject: Re: [PATCH] sample/vfio-mdev: Change return type to vm_fault_t
Message-ID: <20180705134432.17609cc7@t450s.home>
In-Reply-To: <20180704153014.GA26121@jordon-HP-15-Notebook-PC>
References: <20180704153014.GA26121@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Jul 2018 19:44:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 21:00:14 +0530
Souptick Joarder <jrdr.linux@gmail.com> wrote:

> convert mbochs_region_vm_fault and mbochs_dmabuf_vm_fault
> to return vm_fault_t type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  samples/vfio-mdev/mbochs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 2960e26..7743fbc 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -657,7 +657,7 @@ static void mbochs_put_pages(struct mdev_state *mdev_state)
>  	dev_dbg(dev, "%s: %d pages released\n", __func__, count);
>  }
>  
> -static int mbochs_region_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t mbochs_region_vm_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mdev_state *mdev_state = vma->vm_private_data;
> @@ -695,7 +695,7 @@ static int mbochs_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> -static int mbochs_dmabuf_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t mbochs_dmabuf_vm_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct mbochs_dmabuf *dmabuf = vma->vm_private_data;


Looks good to me, I'll include this in my vfio for-linus branch for
v4.18. Thanks,

Alex
