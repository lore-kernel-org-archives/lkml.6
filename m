Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF75C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E7D218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGJ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:59:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfBGJ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:59:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 909497FDE7;
        Thu,  7 Feb 2019 09:59:47 +0000 (UTC)
Received: from gondolin (ovpn-117-74.ams2.redhat.com [10.36.117.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD30117CFF;
        Thu,  7 Feb 2019 09:59:44 +0000 (UTC)
Date:   Thu, 7 Feb 2019 10:59:40 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com,
        akrowiak@linux.vnet.ibm.com, oberpar@linux.ibm.com,
        sebott@linux.ibm.com
Subject: Re: [PATCH v2] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190207105940.19b34df1.cohuck@redhat.com>
In-Reply-To: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
References: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 07 Feb 2019 09:59:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Feb 2019 16:31:26 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The current AP bus implementation periodically polls the AP configuration
> to detect changes. When the AP configuration is dynamically changed via the
> SE or an SCLP instruction, the changes will not be reflected to sysfs until
> the next time the AP configuration is polled. The CHSC architecture
> provides a Store Event Information (SEI) command to make notification of an
> AP configuration change. This patch introduces a handler to process
> notification from the CHSC SEI command by immediately kicking off an AP bus
> scan-after-event.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   | 11 +++++++++++
>  drivers/s390/cio/chsc.c      | 13 +++++++++++++
>  drivers/s390/crypto/ap_bus.c | 11 +++++++++++
>  3 files changed, 35 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
