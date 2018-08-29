Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E99FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD3F2082A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="giK6omZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD3F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeH2Qri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:47:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59360 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2Qri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:47:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180829125049euoutp0250156965ad45e7638efcdaae2e48d5af~PW_fSxyE42818728187euoutp02G;
        Wed, 29 Aug 2018 12:50:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180829125049euoutp0250156965ad45e7638efcdaae2e48d5af~PW_fSxyE42818728187euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535547049;
        bh=+rIHGMrExdAxSt0ysvuX1sSucOF8g+fJ7tyDyanjBXA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=giK6omZFUB8H5wa9kbA0f+p2YaEAmUFH1IE1yokuSz8mwPUx5xqgpCWU9BJNc8hf7
         q4LDM1KogHwclBDo+YMUjJjQow+4qIEkwCqKG2PAsFjhwtMHXzfo80YL2h65nhSAMl
         M0ubPFyUw8cFX/qV25klKfwQS00PlalpKUiXlcDE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180829125048eucas1p2dfa9c612ad346299247a2b243e62c3ed~PW_e4bpRG2725927259eucas1p2r;
        Wed, 29 Aug 2018 12:50:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.58.04441.8A6968B5; Wed, 29
        Aug 2018 13:50:48 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180829125047eucas1p2111f1e1678948ea0fb9be6d1a0ace923~PW_eBEcgo0417704177eucas1p2Z;
        Wed, 29 Aug 2018 12:50:47 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-cb-5b8696a8dbbb
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.9F.04128.7A6968B5; Wed, 29
        Aug 2018 13:50:47 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PE800J0N3ONAC50@eusync4.samsung.com>; Wed, 29 Aug
        2018 13:50:47 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rafael.j.wysocki@intel.com, chanwoo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
Date:   Wed, 29 Aug 2018 14:50:46 +0200
Message-id: <3263263.FggQa7iA9D@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djPc7orprVFG2ybLmox8cYVFovrX56z
        WpxtesNucXnXHDaLz71HGC1uN65gs3i84i27xYKNjxgdODwW73nJ5LFpVSebR9+WVYwenzfJ
        BbBEcdmkpOZklqUW6dslcGW8+DiVqWAtX8X5f51sDYyPubsYOTkkBEwkZn5axNjFyMUhJLCC
        UaLn5hw2COczo8T6gz/YYapeT50IlVjGKPFjwQyolt+MEucXvAOrYhOwkpjYvooRxBYR0JCY
        +fcKWBGzwG5GiZVnb4MlhAWcJSYuf88CYrMIqEq8m36YDcTmFdCU2NO/GmyQqICXxJZ97Uwg
        NqeAm8SkM9vYIWoEJX5MvgfWyywgL7Fv/1RWCFtH4uyxdWDLJAT2sEk03N/DDHG3i8Te6RvY
        IGxhiVfHt0D9IyNxeXI3C0TDdEaJN7+WQjnrGSXWnDnGBFFlLXH4+EWoFXwSk7ZNB5rKARTn
        lehoE4Io8ZDoWt/IBAmLmYwSLztmsU1glJmF5NpZSK6dheTaBYzMqxjFU0uLc9NTiw3zUsv1
        ihNzi0vz0vWS83M3MQLTwul/xz/tYPx6KekQowAHoxIPL0dwa7QQa2JZcWXuIUYJDmYlEd4g
        g7ZoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx8WmnRQgLpiSWp2ampBalFMFkmDk6pBsY889O+
        Zice+bJ5r/i75uxd01eJ5+q/uOvG2HUaROVv4px/NF3p96LrUQoVAumdep8PzlRLchaaI/FN
        ynj/3bc3zFiP7pyVFDKpvLZCb/eK4kWVM3Ys8LzT8+bUdnf3Ne4G8/9Y8az8WrT6h57RgxMy
        F9Y7XBVMuHDuto6kx1bjxyunv9zV5qarxFKckWioxVxUnAgA82ksRgcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t/xa7rLp7VFGxz/LmUx8cYVFovrX56z
        WpxtesNucXnXHDaLz71HGC1uN65gs3i84i27xYKNjxgdODwW73nJ5LFpVSebR9+WVYwenzfJ
        BbBEcdmkpOZklqUW6dslcGW8+DiVqWAtX8X5f51sDYyPubsYOTkkBEwkXk+dyNbFyMUhJLCE
        UeL3id+sEM5fRonlrR+YQKrYBKwkJravYgSxRQQ0JGb+vcIIUsQssJtR4u7/XywgCWEBZ4mJ
        y9+D2SwCqhLvph9mA7F5BTQl9vSvZgexRQW8JLbsawcbyingJjHpzDZ2iG2zGSWWds9ih2gQ
        lPgx+R7YIGYBeYl9+6eyQthaEut3HmeawMg/C0nZLCRls5CULWBkXsUoklpanJueW2ykV5yY
        W1yal66XnJ+7iREY0NuO/dyyg7HrXfAhRgEORiUe3sTQ1mgh1sSy4srcQ4wSHMxKIrxBBm3R
        QrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhgnGPzo/frc
        ZdfZOQKOYueMpm39cVVev+LtNIekzqVXGH6p2WzeHHUp4gb/4zuNQaGb9G9+KIj9cbEg6qnD
        v7OtDYEHYgrYOibJquz2V/l/J/XAgVgN/qbIE6qyl9XmN870l9OSvLA75Rw/f7zr6ktai/Zd
        MJ3xMZV37+OeZMmu7khp/53NPuZKLMUZiYZazEXFiQDDMCgVZAIAAA==
X-CMS-MailID: 20180829125047eucas1p2111f1e1678948ea0fb9be6d1a0ace923
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
        <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chanwoo,

On Wednesday, August 29, 2018 04:34:06 PM Chanwoo Choi wrote:
> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
> sysfs") changed the node name to devfreq(x). After this commit, it is not
> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
> 
> Add new name attribute in order to get device name.

Could you please describe the issue encountered in more detail
(what the old device name is needed for)?
 
> Cc: stable@vger.kernel.org
> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 11 +++++++++++
>  include/linux/devfreq.h   |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1330b5..2145563d5ee5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
> 
> +	devfreq->name = dev_name(devfreq->dev.parent);

It seems that 'dev' can be used instead of 'devfreq->dev.parent'.

> +	if (IS_ERR_OR_NULL(devfreq->name))

Error values are not encoded into pointer returned by dev_name()
(drivers/base/ code is only checking for pointer being NULL).

> +		return -EINVAL;

This leaks 'devfreq' object and doesn't encode return value into
pointer returned by devfreq_add_device(), it should be replaced by:

	err = -EINVAL;
	goto err_dev;

>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

