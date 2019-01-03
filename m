Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5012073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfACJ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:26:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfACJ0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:26:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 727492DA9AE;
        Thu,  3 Jan 2019 09:26:18 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CCD45D75C;
        Thu,  3 Jan 2019 09:26:14 +0000 (UTC)
Date:   Thu, 3 Jan 2019 10:26:12 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v1 0/2] virtio-balloon: tweak config_changed
Message-ID: <20190103102612.0226e6dc.cohuck@redhat.com>
In-Reply-To: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 03 Jan 2019 09:26:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 13:31:00 +0800
Wei Wang <wei.w.wang@intel.com> wrote:

> Since virtio-ccw doesn't work with accessing to the config registers
> inside an interrupt context, this patch series avoids that issue by
> moving the config register accesses to the related workqueue contexts.
> 
> Wei Wang (2):
>   virtio-balloon: tweak config_changed implementation
>   virtio-balloon: improve update_balloon_size_func
> 
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 

A quick test (various 'balloon <num>' in the QEMU monitor) with a
virtio-balloon-ccw device seems to work fine here.
