Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeCNCsh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 22:48:37 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:46075 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932970AbeCNCsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 22:48:36 -0400
Subject: Re: [PATCH v8 06/13] [media] cobalt: add .is_unordered() for cobalt
To: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180309174920.22373-1-gustavo@padovan.org>
 <20180309174920.22373-7-gustavo@padovan.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f544c0e7-9955-e095-c5f6-7bdedb2c1718@xs4all.nl>
Date: Tue, 13 Mar 2018 19:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-7-gustavo@padovan.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHC3BbbAhAK5tBwYK9h5ObPWi3B57Y/751GvMlHs1R8/yDROmyT7BomUvR7RTM+EfnC8La3nXWAJYfw00RWcSxCVrHeYvy+r9dS8wMZMxXNNKp/clq0N
 cgV/hEerETi9RGsx91Z8VScBx4YG6iqHCGzpDWEW2Zy7zDSlVlPnwYCxy6BrH247MzMzBqZNOhASVqS0C4SEbpwIhr2ml2hWaAtvBrI+GBrua0ZlF5ocyUzq
 gRLoMzcSKcX+SvZLPu9mRC1F3+cNoWglKiJFWMhReqAmJ0Dh26a7yzSrwQdMAp+Z+1f22u/LOELUCHihrQCWeNxrP88QepV6k0x3q4a5LZdbbNAPyvumNaoc
 6KMlQ2CeDHA3ko9vPKFDz3fomvrScdQGsPNTbTBV1YY8RSINZRJ+ToWVg5buOW0UocnVwsWlnTFyeIOyoETLAVSH3G4agJ9LCsh6pBqXfyswu2vVbIHdWxlr
 c0RenYmLTk1HU6HV
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:49 AM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> The cobalt driver may reorder the capture buffers so we need to report
> it as such.
> 
> v2: - use vb2_ops_set_unordered() helper
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  drivers/media/pci/cobalt/cobalt-v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
> index e2a4c705d353..6b6611a0e190 100644
> --- a/drivers/media/pci/cobalt/cobalt-v4l2.c
> +++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
> @@ -430,6 +430,7 @@ static const struct vb2_ops cobalt_qops = {
>  	.stop_streaming = cobalt_stop_streaming,
>  	.wait_prepare = vb2_ops_wait_prepare,
>  	.wait_finish = vb2_ops_wait_finish,
> +	.is_unordered = vb2_ops_set_unordered,
>  };

If you do this, then you should also set the UNORDERED format flag for
all formats used by cobalt.

Regards,

	Hans

>  
>  /* V4L2 ioctls */
> 
