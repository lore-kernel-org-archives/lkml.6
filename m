Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39579208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39579208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbeKPVKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:10:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPVKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:10:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6F9F307CDD4;
        Fri, 16 Nov 2018 10:58:46 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5858600C2;
        Fri, 16 Nov 2018 10:58:44 +0000 (UTC)
Date:   Fri, 16 Nov 2018 11:58:42 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Petr Tesarik <ptesarik@suse.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390: vfio-ap: include <asm/facility> for
 test_facility()
Message-ID: <20181116115842.62879dd1.cohuck@redhat.com>
In-Reply-To: <20181116114748.590dfb45@ezekiel.suse.cz>
References: <20181116114748.590dfb45@ezekiel.suse.cz>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 16 Nov 2018 10:58:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 11:47:48 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> The driver uses test_facility(), but does not include the
> corresponding include file explicitly. The driver currently builds
> only thanks to the following include chain:
> 
>   vfio_ap_drv.c
>     <linux/module.h>
>       <linux/elf.h>
>         <asm/elf.h>
> 	  <linux/compat.h>
> 	    <asm/uaccess.h>
> 	      <asm/facility.h>
> 
> Files should not rely on such fragile implicit includes.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 7667b38728f0..31c6c847eaca 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -11,6 +11,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <asm/facility.h>
>  #include "vfio_ap_private.h"
>  
>  #define VFIO_AP_ROOT_NAME "vfio_ap"

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
