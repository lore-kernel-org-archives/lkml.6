Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87EE20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfBUPJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfBUPJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:09:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26174C057F46;
        Thu, 21 Feb 2019 15:09:18 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 958B360BF4;
        Thu, 21 Feb 2019 15:09:12 +0000 (UTC)
Date:   Thu, 21 Feb 2019 16:09:10 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: Re: [PATCH v3 1/1] s390: vfio_ap: link the vfio_ap devices to the
 vfio_ap bus subsystem
Message-ID: <20190221160910.5bf34f04.cohuck@redhat.com>
In-Reply-To: <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
References: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
        <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Feb 2019 15:09:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 15:14:54 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Libudev relies on having a subsystem link for non-root devices. To
> avoid libudev (and potentially other userspace tools) choking on the
> matrix device let us introduce a matrix bus and with it the matrix
> bus subsytem. Also make the matrix device reside within the matrix
> bus.
> 
> Doing this we remove the forced link from the matrix device to the
> vfio_ap driver and the device_type we do not need anymore.
> 
> Since the associated matrix driver is not the vfio_ap driver any more,
> we have to change the search for the devices on the vfio_ap driver in
> the function vfio_ap_verify_queue_reserved.
> 
> Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> 
> Cc: stable@vger.kernel.org
> 

I'd kill the two empty lines.

> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
>  drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
>  drivers/s390/crypto/vfio_ap_private.h |  1 +
>  3 files changed, 38 insertions(+), 11 deletions(-)

Otherwise, still looks good.
