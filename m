Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4052E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4052E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeLLWph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:45:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbeLLWph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:45:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B8FA30820D8;
        Wed, 12 Dec 2018 22:45:37 +0000 (UTC)
Received: from x1.home (ovpn-116-92.phx2.redhat.com [10.3.116.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3018E6090A;
        Wed, 12 Dec 2018 22:45:37 +0000 (UTC)
Date:   Wed, 12 Dec 2018 15:45:36 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Paolo Cretaro <paolocretaro@gmail.com>
Cc:     kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/mdev: add static modifier to
 add_mdev_supported_type
Message-ID: <20181212154536.3f76dfaf@x1.home>
In-Reply-To: <20181113084543.9543-1-paolocretaro@gmail.com>
References: <20181113084543.9543-1-paolocretaro@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 12 Dec 2018 22:45:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 09:45:43 +0100
Paolo Cretaro <paolocretaro@gmail.com> wrote:

> Set add_mdev_supported_type as static since it is only used within
> mdev_sysfs.c.
> This fixes -Wmissing-prototypes gcc warning.
> 
> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
> ---
>  drivers/vfio/mdev/mdev_sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
> index 249472f05509..ce5dd219f2c8 100644
> --- a/drivers/vfio/mdev/mdev_sysfs.c
> +++ b/drivers/vfio/mdev/mdev_sysfs.c
> @@ -92,8 +92,8 @@ static struct kobj_type mdev_type_ktype = {
>  	.release = mdev_type_release,
>  };
>  
> -struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
> -					  struct attribute_group *group)
> +static struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
> +						 struct attribute_group *group)
>  {
>  	struct mdev_type *type;
>  	int ret;

Applied to vfio next branch with Cornlia's review.  Thanks,

Alex
