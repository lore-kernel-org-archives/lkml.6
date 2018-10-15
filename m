Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CE1C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E020842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2E020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJOVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeJOVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F7C2C0C054E;
        Mon, 15 Oct 2018 13:39:51 +0000 (UTC)
Received: from gondolin (ovpn-117-88.ams2.redhat.com [10.36.117.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EBD578DDF;
        Mon, 15 Oct 2018 13:39:49 +0000 (UTC)
Date:   Mon, 15 Oct 2018 15:39:46 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/cio: make vfio_ccw_io_region static
Message-ID: <20181015153946.6c9b0e49.cohuck@redhat.com>
In-Reply-To: <alpine.LFD.2.21.1810151328570.1636@schleppi.aag-de.ibmmobiledemo.com>
References: <alpine.LFD.2.21.1810151328570.1636@schleppi.aag-de.ibmmobiledemo.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 15 Oct 2018 13:39:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 13:31:39 +0200 (CEST)
Sebastian Ott <sebott@linux.ibm.com> wrote:

> Fix the following sparse warning:
> drivers/s390/cio/vfio_ccw_drv.c:25:19: warning: symbol 'vfio_ccw_io_region'
> was not declared. Should it be static?

Hm, it seems my workflow needs more static checkers.

> 
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index f47d16b5810b..edbf542d82af 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -22,7 +22,7 @@
>  #include "vfio_ccw_private.h"
>  
>  struct workqueue_struct *vfio_ccw_work_q;
> -struct kmem_cache *vfio_ccw_io_region;
> +static struct kmem_cache *vfio_ccw_io_region;
>  
>  /*
>   * Helpers

Thanks, applied.
