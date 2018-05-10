Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966085AbeEJA4z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:56:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45737 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966061AbeEJA4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:56:53 -0400
X-Google-Smtp-Source: AB8JxZoXK0XLIbMZRlyV6JGqS6fHz1fGEwlOqvxBlfxRrQwDSWs9v3SQLAe6SB2k01okE3FDe7+N9w==
Date: Wed, 9 May 2018 17:56:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 06/13] remoteproc: introduce rproc_add_carveout
 function
Message-ID: <20180510005650.GH29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-7-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-7-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> This patch introduces a new API to allow platform driver to register
> platform specific carveout regions.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++++
>  include/linux/remoteproc.h           |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 4c92b7d..91aa22b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -758,6 +758,20 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  }
>  
>  /**
> + * rproc_add_carveout() - register an allocated carveout region
> + * @rproc: rproc handle
> + * @mem: memory entry to register
> + *
> + * This function registers specified memory entry in @rproc carveouts list.
> + * Specified carveout should have been allocated before registering.
> + */
> +void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
> +{
> +	list_add_tail(&mem->node, &rproc->carveouts);
> +}
> +EXPORT_SYMBOL(rproc_add_carveout);
> +
> +/**
>   * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
>   * @dev: pointer on device struct
>   * @va: virtual address
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 59b60f1..4aa30bd 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -536,6 +536,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  int rproc_del(struct rproc *rproc);
>  void rproc_free(struct rproc *rproc);
>  
> +void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
> +
>  struct rproc_mem_entry *rproc_mem_entry_init(struct device *dev,
>  		void *va, dma_addr_t dma, int len, u32 da,
>  		int (*release)(struct rproc *, struct rproc_mem_entry *),
> -- 
> 1.9.1
> 
