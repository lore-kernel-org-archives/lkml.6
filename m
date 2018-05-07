Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeEGLEq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:04:46 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:34720 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751400AbeEGLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:04:43 -0400
Subject: Re: [PATCH v9 08/15] cobalt: set queue as unordered
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180504200612.8763-1-ezequiel@collabora.com>
 <20180504200612.8763-9-ezequiel@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <de63cac5-b344-c220-bcae-33faddcb61ea@xs4all.nl>
Date: Mon, 7 May 2018 13:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504200612.8763-9-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH/daySrRoSJwZOBfaCgVyLHn0HNdOqQivDrUX+ciqIzPHzOt3tOoHcIC2KpNgcct52zv5HIQaZpCXiXjEwlog0vOMq45VX13D73E4umCWR39LTe/5EE
 fPY14KOiZrMU1UVG/KQfF9tSpVJ8IC6sqShtIvRW1uQ3rC5gGKB8yyGlX8Gqcn6U/zRzfWtENtgogUg/OeL6puMqpKIybLQts7i3kR8W8ekE2+nYymzaMD8B
 iFeoTjCteFJXq1XWn2I4MEEH3X35JatlFGIwFauusy9To4NzwW1Kl+2hupx7hg4J/uLPC7A9TmobsgsvnImlSTn7B2oLsHmcgG2Vrf7Var7c4C01P878VNXv
 9FNcGbMUC9fN82UPm2zwYpNlMC9hxrDWo1tnxFct2sFTfDyza6er76EKCyhJQDacevKWKSP3gqgpZpjr7sEh7YTYY0+HVgrIyJ3CEhf69CUfENk9fBFZ5jQZ
 HnKH9EYbJj2QZf5wAkYda0SI02orhGMzAanzI9c6VACg3ReTduhSgmVWrQqEtfUzw26kKZgyvri5afquNd3Fqwnm93k8wr7HeooeLftlGl96KHgZ3DswSuzh
 cQUKJFa7yCCBMI8UTnFxt4e+
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 22:06, Ezequiel Garcia wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> The cobalt driver may reorder the capture buffers so we need to report
> it as such.
> 
> v3: set unordered as a property
> v2: use vb2_ops_set_unordered() helper
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/media/pci/cobalt/cobalt-v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
> index e2a4c705d353..8f06cc7f1c81 100644
> --- a/drivers/media/pci/cobalt/cobalt-v4l2.c
> +++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
> @@ -1236,6 +1236,7 @@ static int cobalt_node_register(struct cobalt *cobalt, int node)
>  	q->min_buffers_needed = 2;
>  	q->lock = &s->lock;
>  	q->dev = &cobalt->pci_dev->dev;
> +	q->unordered = 1;
>  	vdev->queue = q;
>  
>  	video_set_drvdata(vdev, s);
> 

As mentioned in my review of v8 of this patch, you also need to mark all formats
in this driver as unordered.

Regards,

	Hans
