Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4968EC10F0B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E657222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393047AbfBOJhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfBOJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6174C0D7F08;
        Fri, 15 Feb 2019 09:37:20 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4135D705;
        Fri, 15 Feb 2019 09:37:18 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:37:16 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v3 3/9] s390: ap: new vfio_ap_queue structure
Message-ID: <20190215103716.00cd40db.cohuck@redhat.com>
In-Reply-To: <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-4-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 15 Feb 2019 09:37:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 14:51:03 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The AP interruptions are assigned on a queue basis
> and we need some information neloging to the queue

s/neloging/belonging/

> to handle interuptions.

s/interuptions/interruptions/

> 
> We add a new structure vfio_ap_queue, to hold per
> queue information useful to handle interruptions.
> 
> - apqn: AP queue number (defined here)
> - isc : Interrupt subclass (defined later)
> - nib : notification information byte (defined later)

So, you basically simply want quick access to these? Makes sense.

> 
> The vfio_ap_queue structure is allocated when the vfio_ap_driver
> is probed and added as driver data to the ap_queue device.
> It is free on remove.

s/free/freed/

> 
> The structure is linked to the matrix_dev host device.

Hm, I don't quite follow?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 23 ++++++++++++++++++++++-
>  drivers/s390/crypto/vfio_ap_private.h |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Patch looks reasonable; might make sense to squash it with later
patches (still need to read).
