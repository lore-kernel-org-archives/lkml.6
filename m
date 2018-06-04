Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeFDUqa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:46:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:46:28 -0400
Subject: Re: [PATCH v2 6/9] xen/gntdev: Add initial support for dma-buf UAPI
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-7-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <29c1f1fb-2d52-e3df-adce-44fdee135413@oracle.com>
Date: Mon, 4 Jun 2018 16:49:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601114132.22596-7-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2018 07:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Add UAPI and IOCTLs for dma-buf grant device driver extension:
> the extension allows userspace processes and kernel modules to
> use Xen backed dma-buf implementation. With this extension grant
> references to the pages of an imported dma-buf can be exported
> for other domain use and grant references coming from a foreign
> domain can be converted into a local dma-buf for local export.
> Implement basic initialization and stubs for Xen DMA buffers'
> support.


It would be very helpful if people advocating for this interface
reviewed it as well.


>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/Kconfig         |  10 +++
>  drivers/xen/Makefile        |   1 +
>  drivers/xen/gntdev-dmabuf.c |  75 +++++++++++++++++++
>  drivers/xen/gntdev-dmabuf.h |  41 +++++++++++
>  drivers/xen/gntdev.c        | 142 ++++++++++++++++++++++++++++++++++++
>  include/uapi/xen/gntdev.h   |  91 +++++++++++++++++++++++
>  6 files changed, 360 insertions(+)
>  create mode 100644 drivers/xen/gntdev-dmabuf.c
>  create mode 100644 drivers/xen/gntdev-dmabuf.h
>
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 39536ddfbce4..52d64e4b6b81 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -152,6 +152,16 @@ config XEN_GNTDEV
>  	help
>  	  Allows userspace processes to use grants.
>  
> +config XEN_GNTDEV_DMABUF
> +	bool "Add support for dma-buf grant access device driver extension"
> +	depends on XEN_GNTDEV && XEN_GRANT_DMA_ALLOC && DMA_SHARED_BUFFER


Is there a reason to have XEN_GRANT_DMA_ALLOC without XEN_GNTDEV_DMABUF?


> +	help
> +	  Allows userspace processes and kernel modules to use Xen backed
> +	  dma-buf implementation. With this extension grant references to
> +	  the pages of an imported dma-buf can be exported for other domain
> +	  use and grant references coming from a foreign domain can be
> +	  converted into a local dma-buf for local export.
> +
>  config XEN_GRANT_DEV_ALLOC
>  	tristate "User-space grant reference allocator driver"
>  	depends on XEN
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index 3c87b0c3aca6..33afb7b2b227 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -41,5 +41,6 @@ obj-$(CONFIG_XEN_PVCALLS_BACKEND)	+= pvcalls-back.o
>  obj-$(CONFIG_XEN_PVCALLS_FRONTEND)	+= pvcalls-front.o
>  xen-evtchn-y				:= evtchn.o
>  xen-gntdev-y				:= gntdev.o
> +xen-gntdev-$(CONFIG_XEN_GNTDEV_DMABUF)	+= gntdev-dmabuf.o
>  xen-gntalloc-y				:= gntalloc.o
>  xen-privcmd-y				:= privcmd.o
> diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> new file mode 100644
> index 000000000000..6bedd1387bd9
> --- /dev/null
> +++ b/drivers/xen/gntdev-dmabuf.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Xen dma-buf functionality for gntdev.
> + *
> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#include <linux/slab.h>
> +
> +#include "gntdev-dmabuf.h"
> +
> +struct gntdev_dmabuf_priv {
> +	int dummy;
> +};
> +
> +/* ------------------------------------------------------------------ */
> +/* DMA buffer export support.                                         */
> +/* ------------------------------------------------------------------ */
> +
> +/* ------------------------------------------------------------------ */
> +/* Implementation of wait for exported DMA buffer to be released.     */
> +/* ------------------------------------------------------------------ */

Why this comment style?

> +
> +int gntdev_dmabuf_exp_wait_released(struct gntdev_dmabuf_priv *priv, int fd,
> +				    int wait_to_ms)
> +{
> +	return -EINVAL;
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* DMA buffer export support.                                         */
> +/* ------------------------------------------------------------------ */
> +
> +int gntdev_dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
> +{
> +	return -EINVAL;
> +}
> +
> +/* ------------------------------------------------------------------ */
> +/* DMA buffer import support.                                         */
> +/* ------------------------------------------------------------------ */
> +
> +struct gntdev_dmabuf *
> +gntdev_dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
> +			  int fd, int count, int domid)
> +{
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +u32 *gntdev_dmabuf_imp_get_refs(struct gntdev_dmabuf *gntdev_dmabuf)
> +{
> +	return NULL;
> +}
> +
> +int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
> +{
> +	return -EINVAL;
> +}
> +
> +struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
> +{
> +	struct gntdev_dmabuf_priv *priv;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return priv;
> +}
> +
> +void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv)
> +{
> +	kfree(priv);
> +}
> diff --git a/drivers/xen/gntdev-dmabuf.h b/drivers/xen/gntdev-dmabuf.h
> new file mode 100644
> index 000000000000..040b2de904ac
> --- /dev/null
> +++ b/drivers/xen/gntdev-dmabuf.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Xen dma-buf functionality for gntdev.
> + *
> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#ifndef _GNTDEV_DMABUF_H
> +#define _GNTDEV_DMABUF_H
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/types.h>
> +
> +struct gntdev_dmabuf_priv;
> +struct gntdev_dmabuf;
> +struct device;
> +
> +struct gntdev_dmabuf_export_args {
> +	int dummy;
> +};


Please define the full structure (at least what you have in the next
patch) here.


> +
> +struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void);
> +
> +void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv);
> +
> +int gntdev_dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args);
> +
> +int gntdev_dmabuf_exp_wait_released(struct gntdev_dmabuf_priv *priv, int fd,
> +				    int wait_to_ms);
> +
> +struct gntdev_dmabuf *
> +gntdev_dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
> +			  int fd, int count, int domid);
> +
> +u32 *gntdev_dmabuf_imp_get_refs(struct gntdev_dmabuf *gntdev_dmabuf);
> +
> +int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd);
> +
> +#endif
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 9813fc440c70..7d58dfb3e5e8 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c

...

>  
> +#ifdef CONFIG_XEN_GNTDEV_DMABUF

This code belongs in gntdev-dmabuf.c.

> +/* ------------------------------------------------------------------ */
> +/* DMA buffer export support.                                         */
> +/* ------------------------------------------------------------------ */
> +
> +int gntdev_dmabuf_exp_from_refs(struct gntdev_priv *priv, int flags,
> +				int count, u32 domid, u32 *refs, u32 *fd)
> +{
> +	/* XXX: this will need to work with gntdev's map, so leave it here. */

This doesn't help understanding what's going on (at least to me) and is
removed in the next patch. So no need for this comment.

-boris

> +	*fd = -1;
> +	return -EINVAL;
> +}
