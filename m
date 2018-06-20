Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30722083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFDK9noP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30722083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754276AbeFTXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:02:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754166AbeFTXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sh475lby0zRKDeKNTwD+nnTB9ZSh0bM5uxfZTlln87w=; b=dFDK9noP+wtHGM8Eas74TcrP9
        ggsenhDZBQOSAkY8/gV8o7Z1TQqIrcuEX//oF6T2HG2Cif6sE7UHuVbmHRb4v9K8lLr+Z1prMpC7b
        HazZ2/6nwkPGQ/+twynN+VHGMftYLj4r8KLy3Ec+5kBjK1aBk4s7HSHe4ZUejjpS28lIZqB9JO54F
        wDvEm+1uEC9t4x/wr9OWPy/gE9wbRx3HOYnhcwxsDc9AzKQmkUw9X1MMyIxKOBJ2N7HfQIZKCmWmp
        iu+yLYlOlQ44kLNMIaQ9MGc4BoS/ni33EFeqTSBve1IUTqe6YKv/C5stUo3Mt+qZayiDi/jckIbyX
        l9IA/3uXQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVm6z-00077q-Jm; Wed, 20 Jun 2018 23:02:01 +0000
Subject: Re: drivers/media/platform/cadence/cdns-csi2tx.c:477:11: error:
 implicit declaration of function 'kzalloc'; did you mean 'vzalloc'?
To:     kbuild test robot <lkp@intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <m.chehab@samsung.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <201806180714.gwQUkLIy%fengguang.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e6e7b2a-1624-4c15-85ff-3796e0104a3b@infradead.org>
Date:   Wed, 20 Jun 2018 16:02:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201806180714.gwQUkLIy%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 04:29 PM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ce397d215ccd07b8ae3f71db689aedb85d56ab40
> commit: 6f684d4fcce5eddd7e216a18975fb798d11a83dd media: v4l: cadence: Add Cadence MIPI-CSI2 TX driver
> date:   5 weeks ago
> config: x86_64-randconfig-s5-06180700 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 6f684d4fcce5eddd7e216a18975fb798d11a83dd
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/media/platform/cadence/cdns-csi2tx.c: In function 'csi2tx_probe':
>>> drivers/media/platform/cadence/cdns-csi2tx.c:477:11: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
>      csi2tx = kzalloc(sizeof(*csi2tx), GFP_KERNEL);
>               ^~~~~~~
>               vzalloc
>>> drivers/media/platform/cadence/cdns-csi2tx.c:477:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      csi2tx = kzalloc(sizeof(*csi2tx), GFP_KERNEL);
>             ^
>>> drivers/media/platform/cadence/cdns-csi2tx.c:531:2: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
>      kfree(csi2tx);
>      ^~~~~
>      vfree
>    cc1: some warnings being treated as errors

From 2018-06-08:

https://patchwork.kernel.org/patch/10455245/
or
https://marc.info/?l=linux-kernel&m=152849276709302&w=2

I marked it as for linux-next, but it does need to be applied to mainline.


> vim +477 drivers/media/platform/cadence/cdns-csi2tx.c
> 
>    470	
>    471	static int csi2tx_probe(struct platform_device *pdev)
>    472	{
>    473		struct csi2tx_priv *csi2tx;
>    474		unsigned int i;
>    475		int ret;
>    476	
>  > 477		csi2tx = kzalloc(sizeof(*csi2tx), GFP_KERNEL);
>    478		if (!csi2tx)
>    479			return -ENOMEM;
>    480		platform_set_drvdata(pdev, csi2tx);
>    481		mutex_init(&csi2tx->lock);
>    482		csi2tx->dev = &pdev->dev;
>    483	
>    484		ret = csi2tx_get_resources(csi2tx, pdev);
>    485		if (ret)
>    486			goto err_free_priv;
>    487	
>    488		v4l2_subdev_init(&csi2tx->subdev, &csi2tx_subdev_ops);
>    489		csi2tx->subdev.owner = THIS_MODULE;
>    490		csi2tx->subdev.dev = &pdev->dev;
>    491		csi2tx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>    492		snprintf(csi2tx->subdev.name, V4L2_SUBDEV_NAME_SIZE, "%s.%s",
>    493			 KBUILD_MODNAME, dev_name(&pdev->dev));
>    494	
>    495		ret = csi2tx_check_lanes(csi2tx);
>    496		if (ret)
>    497			goto err_free_priv;
>    498	
>    499		/* Create our media pads */
>    500		csi2tx->subdev.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
>    501		csi2tx->pads[CSI2TX_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
>    502		for (i = CSI2TX_PAD_SINK_STREAM0; i < CSI2TX_PAD_MAX; i++)
>    503			csi2tx->pads[i].flags = MEDIA_PAD_FL_SINK;
>    504	
>    505		/*
>    506		 * Only the input pads are considered to have a format at the
>    507		 * moment. The CSI link can multiplex various streams with
>    508		 * different formats, and we can't expose this in v4l2 right
>    509		 * now.
>    510		 */
>    511		for (i = CSI2TX_PAD_SINK_STREAM0; i < CSI2TX_PAD_MAX; i++)
>    512			csi2tx->pad_fmts[i] = fmt_default;
>    513	
>    514		ret = media_entity_pads_init(&csi2tx->subdev.entity, CSI2TX_PAD_MAX,
>    515					     csi2tx->pads);
>    516		if (ret)
>    517			goto err_free_priv;
>    518	
>    519		ret = v4l2_async_register_subdev(&csi2tx->subdev);
>    520		if (ret < 0)
>    521			goto err_free_priv;
>    522	
>    523		dev_info(&pdev->dev,
>    524			 "Probed CSI2TX with %u/%u lanes, %u streams, %s D-PHY\n",
>    525			 csi2tx->num_lanes, csi2tx->max_lanes, csi2tx->max_streams,
>    526			 csi2tx->has_internal_dphy ? "internal" : "no");
>    527	
>    528		return 0;
>    529	
>    530	err_free_priv:
>  > 531		kfree(csi2tx);
>    532		return ret;
>    533	}
>    534	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
