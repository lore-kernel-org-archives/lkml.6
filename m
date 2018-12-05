Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28120851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBtEISKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLEI1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeLEI1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:27:30 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49CC52082B;
        Wed,  5 Dec 2018 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543998448;
        bh=4bgy+e3deoxq9Y9P2TbrKO8J5FuY/oovPON9+Cl2Pnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jBtEISKlk+Frm0yKMvT7FuWoblbpZFqQoySiZda38yoTKOY3ZXcXxtbpsorJ9bjeh
         wX1uUMLaznWV/tuPQiOSx2rLJi3rKakXd7BZ6dYqeWjdc1qUjeJh4gydvapbT1AI/4
         0HEocEoU5QZ1ASuuRI+KwZaFoQ/fWoiBBggjIBRs=
Date:   Wed, 5 Dec 2018 13:57:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
Message-ID: <20181205082719.GF2847@vkoul-mobl>
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130154249.3222-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 10:42, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
> such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
> code.

Spaces after full stop and comma please

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/dma/amba-pl08x.c     | 14 ++------------
>  drivers/dma/mic_x100_dma.c   | 22 +++-------------------
>  drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
>  drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------

Do you mind splitting it per file.

>  4 files changed, 23 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 97483df1f82e..fc8c2bab563c 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -2505,24 +2505,14 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
>  	return 0;
>  }
>  
> -static int pl08x_debugfs_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, pl08x_debugfs_show, inode->i_private);
> -}
> -
> -static const struct file_operations pl08x_debugfs_operations = {
> -	.open		= pl08x_debugfs_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(pl08x_debugfs);
>  
>  static void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
>  {
>  	/* Expose a simple debugfs interface to view all clocks */
>  	(void) debugfs_create_file(dev_name(&pl08x->adev->dev),
>  			S_IFREG | S_IRUGO, NULL, pl08x,
> -			&pl08x_debugfs_operations);
> +			&pl08x_debugfs_fops);
>  }
>  
>  #else
> diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
> index adfd316db1a8..6a91e28d537d 100644
> --- a/drivers/dma/mic_x100_dma.c
> +++ b/drivers/dma/mic_x100_dma.c
> @@ -676,7 +676,7 @@ static void mic_dma_dev_unreg(struct mic_dma_device *mic_dma_dev)
>  }
>  
>  /* DEBUGFS CODE */
> -static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
> +static int mic_dma_reg_show(struct seq_file *s, void *pos)
>  {
>  	struct mic_dma_device *mic_dma_dev = s->private;
>  	int i, chan_num, first_chan = mic_dma_dev->start_ch;
> @@ -707,23 +707,7 @@ static int mic_dma_reg_seq_show(struct seq_file *s, void *pos)
>  	return 0;
>  }
>  
> -static int mic_dma_reg_debug_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, mic_dma_reg_seq_show, inode->i_private);
> -}
> -
> -static int mic_dma_reg_debug_release(struct inode *inode, struct file *file)
> -{
> -	return single_release(inode, file);
> -}
> -
> -static const struct file_operations mic_dma_reg_ops = {
> -	.owner   = THIS_MODULE,
> -	.open    = mic_dma_reg_debug_open,
> -	.read    = seq_read,
> -	.llseek  = seq_lseek,
> -	.release = mic_dma_reg_debug_release
> -};
> +DEFINE_SHOW_ATTRIBUTE(mic_dma_reg);
>  
>  /* Debugfs parent dir */
>  static struct dentry *mic_dma_dbg;
> @@ -747,7 +731,7 @@ static int mic_dma_driver_probe(struct mbus_device *mbdev)
>  		if (mic_dma_dev->dbg_dir)
>  			debugfs_create_file("mic_dma_reg", 0444,
>  					    mic_dma_dev->dbg_dir, mic_dma_dev,
> -					    &mic_dma_reg_ops);
> +					    &mic_dma_reg_fops);
>  	}
>  	return 0;
>  }
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 825725057e00..8e1e1b07d32f 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -189,7 +189,7 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param);
>  #include <linux/uaccess.h>
>  #include <linux/seq_file.h>
>  
> -static int dbg_show_requester_chan(struct seq_file *s, void *p)
> +static int requester_chan_show(struct seq_file *s, void *p)
>  {
>  	struct pxad_phy *phy = s->private;
>  	int i;
> @@ -220,7 +220,7 @@ static int is_phys_valid(unsigned long addr)
>  #define PXA_DCSR_STR(flag) (dcsr & PXA_DCSR_##flag ? #flag" " : "")
>  #define PXA_DCMD_STR(flag) (dcmd & PXA_DCMD_##flag ? #flag" " : "")
>  
> -static int dbg_show_descriptors(struct seq_file *s, void *p)
> +static int descriptors_show(struct seq_file *s, void *p)
>  {
>  	struct pxad_phy *phy = s->private;
>  	int i, max_show = 20, burst, width;
> @@ -263,7 +263,7 @@ static int dbg_show_descriptors(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int dbg_show_chan_state(struct seq_file *s, void *p)
> +static int chan_state_show(struct seq_file *s, void *p)
>  {
>  	struct pxad_phy *phy = s->private;
>  	u32 dcsr, dcmd;
> @@ -306,7 +306,7 @@ static int dbg_show_chan_state(struct seq_file *s, void *p)
>  	return 0;
>  }
>  
> -static int dbg_show_state(struct seq_file *s, void *p)
> +static int state_show(struct seq_file *s, void *p)
>  {
>  	struct pxad_device *pdev = s->private;
>  
> @@ -329,10 +329,10 @@ static const struct file_operations dbg_fops_##name = { \
>  	.release	= single_release, \
>  }
>  
> -DBGFS_FUNC_DECL(state);
> -DBGFS_FUNC_DECL(chan_state);
> -DBGFS_FUNC_DECL(descriptors);
> -DBGFS_FUNC_DECL(requester_chan);
> +DEFINE_SHOW_ATTRIBUTE(state);
> +DEFINE_SHOW_ATTRIBUTE(chan_state);
> +DEFINE_SHOW_ATTRIBUTE(descriptors);
> +DEFINE_SHOW_ATTRIBUTE(requester_chan);
>  
>  static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
>  					     int ch, struct dentry *chandir)
> @@ -348,13 +348,13 @@ static struct dentry *pxad_dbg_alloc_chan(struct pxad_device *pdev,
>  
>  	if (chan)
>  		chan_state = debugfs_create_file("state", 0400, chan, dt,
> -						 &dbg_fops_chan_state);
> +						 &chan_state_fops);
>  	if (chan_state)
>  		chan_descr = debugfs_create_file("descriptors", 0400, chan, dt,
> -						 &dbg_fops_descriptors);
> +						 &descriptors_fops);
>  	if (chan_descr)
>  		chan_reqs = debugfs_create_file("requesters", 0400, chan, dt,
> -						&dbg_fops_requester_chan);
> +						&requester_chan_fops);
>  	if (!chan_reqs)
>  		goto err_state;
>  
> @@ -375,7 +375,7 @@ static void pxad_init_debugfs(struct pxad_device *pdev)
>  		goto err_root;
>  
>  	pdev->dbgfs_state = debugfs_create_file("state", 0400, pdev->dbgfs_root,
> -						pdev, &dbg_fops_state);
> +						pdev, &state_fops);
>  	if (!pdev->dbgfs_state)
>  		goto err_state;
>  
> diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
> index 3bdcb8056a36..9523faf7acdc 100644
> --- a/drivers/dma/qcom/hidma_dbg.c
> +++ b/drivers/dma/qcom/hidma_dbg.c
> @@ -85,11 +85,11 @@ static void hidma_ll_devstats(struct seq_file *s, void *llhndl)
>  }
>  
>  /*
> - * hidma_chan_stats: display HIDMA channel statistics
> + * hidma_chan_show: display HIDMA channel statistics
>   *
>   * Display the statistics for the current HIDMA virtual channel device.
>   */
> -static int hidma_chan_stats(struct seq_file *s, void *unused)
> +static int hidma_chan_show(struct seq_file *s, void *unused)
>  {
>  	struct hidma_chan *mchan = s->private;
>  	struct hidma_desc *mdesc;
> @@ -117,11 +117,11 @@ static int hidma_chan_stats(struct seq_file *s, void *unused)
>  }
>  
>  /*
> - * hidma_dma_info: display HIDMA device info
> + * hidma_dma_show: display HIDMA device info
>   *
>   * Display the info for the current HIDMA device.
>   */
> -static int hidma_dma_info(struct seq_file *s, void *unused)
> +static int hidma_dma_show(struct seq_file *s, void *unused)
>  {
>  	struct hidma_dev *dmadev = s->private;
>  	resource_size_t sz;
> @@ -138,29 +138,8 @@ static int hidma_dma_info(struct seq_file *s, void *unused)
>  	return 0;
>  }
>  
> -static int hidma_chan_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, hidma_chan_stats, inode->i_private);
> -}
> -
> -static int hidma_dma_info_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, hidma_dma_info, inode->i_private);
> -}
> -
> -static const struct file_operations hidma_chan_fops = {
> -	.open = hidma_chan_stats_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> -
> -static const struct file_operations hidma_dma_fops = {
> -	.open = hidma_dma_info_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(hidma_chan);
> +DEFINE_SHOW_ATTRIBUTE(hidma_dma);
>  
>  void hidma_debug_uninit(struct hidma_dev *dmadev)
>  {
> -- 
> 2.17.0

-- 
~Vinod
