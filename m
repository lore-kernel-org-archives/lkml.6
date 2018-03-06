Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933295AbeCFTkT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:40:19 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:56560 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeCFTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:39:17 -0500
Subject: Re: [PATCH 3/3] media: vb2-core: vb2_ops: document
 non-interrupt-cantext calling
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <1519856687-5568-1-git-send-email-luca@lucaceresoli.net>
 <1519856687-5568-3-git-send-email-luca@lucaceresoli.net>
From: Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <f41167ac-83dc-4a2f-2461-4145b8d8781c@lucaceresoli.net>
Date: Tue, 6 Mar 2018 20:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519856687-5568-3-git-send-email-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed a typo in the title:
cantext -> context

I will fix in v2.

On 28/02/2018 23:24, Luca Ceresoli wrote:
> Driver writers can benefit in knowing if/when callbacks are called in
> interrupt context. But it is not completely obvious here, so document it.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  include/media/videobuf2-core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index f20000887d3c..f6818f732f34 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -296,6 +296,9 @@ struct vb2_buffer {
>  /**
>   * struct vb2_ops - driver-specific callbacks.
>   *
> + * These operations are not called from interrupt context except where
> + * mentioned specifically.
> + *
>   * @queue_setup:	called from VIDIOC_REQBUFS() and VIDIOC_CREATE_BUFS()
>   *			handlers before memory allocation. It can be called
>   *			twice: if the original number of requested buffers
> 


-- 
Luca
