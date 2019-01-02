Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28008218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfABQrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:47:52 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:36656 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfABQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:47:51 -0500
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gejgM-0000wC-H6; Wed, 02 Jan 2019 16:47:50 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gejgK-0006am-1o; Wed, 02 Jan 2019 16:47:50 +0000
Subject: Re: [PATCH] um: writev needs <sys/uio.h>
To:     Christoph Hellwig <hch@lst.de>, richard@nod.at
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181227073324.10090-1-hch@lst.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys Limited
Message-ID: <887b21fe-e79a-7291-9527-c52a74ff02c8@cambridgegreys.com>
Date:   Wed, 2 Jan 2019 16:47:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227073324.10090-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/27/18 7:33 AM, Christoph Hellwig wrote:
> vector_user.c doesn't compile without this for me.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/vector_user.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index 3d8cdbdb4e66..41eefbcdc86f 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -25,6 +25,7 @@
>   #include <linux/if_packet.h>
>   #include <sys/socket.h>
>   #include <sys/wait.h>
> +#include <sys/uio.h>
>   #include <linux/virtio_net.h>
>   #include <netdb.h>
>   #include <stdlib.h>
> 
Acked-by: Anton Ivanov <anton.ivanov at cambridgegreys.com>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
