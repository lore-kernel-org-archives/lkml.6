Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4FmOK+LvG1trSAAAmS7hNA
	; Sat, 09 Jun 2018 15:29:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1FFF9608C8; Sat,  9 Jun 2018 15:29:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 87FE2608BA;
	Sat,  9 Jun 2018 15:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87FE2608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeFIP3l (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:29:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753241AbeFIP3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA6E2401EF02;
        Sat,  9 Jun 2018 15:29:38 +0000 (UTC)
Received: from w520.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 201E22026DEF;
        Sat,  9 Jun 2018 15:29:37 +0000 (UTC)
Date: Sat, 9 Jun 2018 09:29:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: mbochs: add DMA_SHARED_BUFFER dependency
Message-ID: <20180609092937.1c317550@w520.home>
In-Reply-To: <20180530213801.731288-1-arnd@arndb.de>
References: <20180530213801.731288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 15:29:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sat, 09 Jun 2018 15:29:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'alex.williamson@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 23:37:31 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> The new bochs vbe sample fails to link when DMA_SHARED_BUFFER is
> disabled:
> 
> ERROR: "dma_buf_export" [samples/vfio-mdev/mbochs.ko] undefined!
> ERROR: "dma_buf_fd" [samples/vfio-mdev/mbochs.ko] undefined!
> 
> This uses a 'select' statement to enable that framework, like all
> other users do.
> 
> Fixes: 8021194eb3da ("sample: vfio bochs vbe display (host device for bochs-drm)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  samples/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 3aeaaca77831..bd133efc1a56 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -135,6 +135,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
>  config SAMPLE_VFIO_MDEV_MBOCHS
>  	tristate "Build VFIO mdpy example mediated device sample code -- loadable modules only"
>  	depends on VFIO_MDEV_DEVICE && m
> +	select DMA_SHARED_BUFFER
>  	help
>  	  Build a virtual display sample driver for use as a VFIO
>  	  mediated device.  It supports the region display interface

Almost missed this one.  Applied to my next branch for v4.18, also
updated the referenced commit ID as I've had to rebase to account for
a reverted patch in the base.  Thanks,

Alex
