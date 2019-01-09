Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93850206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfAII6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:58:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfAII6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:58:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDB22C0669AF;
        Wed,  9 Jan 2019 08:58:46 +0000 (UTC)
Received: from gondolin (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D88F7608DA;
        Wed,  9 Jan 2019 08:58:40 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:58:37 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, peterx@redhat.com
Subject: Re: [PATCH] vfio/type1: Fix unmap overflow off-by-one
Message-ID: <20190109095837.2dfdb4e0.cohuck@redhat.com>
In-Reply-To: <154696559827.32763.11706407320970225120.stgit@gimli.home>
References: <154696559827.32763.11706407320970225120.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 09 Jan 2019 08:58:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2019 09:40:06 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> The below referenced commit adds a test for integer overflow, but in
> doing so prevents the unmap ioctl from ever including the last page of
> the address space.  Subtract one to compare to the last address of the
> unmap to avoid the overflow and wrap-around.
> 
> Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Debugged-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
