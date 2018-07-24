Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0315520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SIYUy9fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0315520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbeGXH36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:29:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28320 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbeGXH36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:29:58 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180724062503epoutp01aaa17988462ccd9562065d96b571b650~EOfY-k4Xh0418504185epoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 06:25:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180724062503epoutp01aaa17988462ccd9562065d96b571b650~EOfY-k4Xh0418504185epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532413503;
        bh=4dUXGz+QezV6WXyypbtmodw/Pbymtql71bzEsd/ztuw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SIYUy9fwvtcSDnu+iVyk5G0xxKBz/zPc99WCBdnHDYmo2TFV9UcuV/ieeLeY0mZQx
         OeuWCkAPvXaVFOEVZpEtIlx4tG2HFRr2eclhydBF4bvRpdeYid6Wfk74umK8jNxoJk
         127aQ3U1djNT8J3ko/r+FfLp6Ok0yIliU5aAy89U=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724062500epcas1p1b675c8bd5260d53af596c356653cd604~EOfW-KG5K1415314153epcas1p1U;
        Tue, 24 Jul 2018 06:25:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.CC.04176.C36C65B5; Tue, 24 Jul 2018 15:25:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180724062459epcas1p1bf9f47eaccd54be8a8f9e18a18d23550~EOfVjI_Gy1414414144epcas1p1q;
        Tue, 24 Jul 2018 06:24:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180724062459epsmtrp24df297c2bfcc699985e1fc7364ba0779~EOfVhsHNj0200802008epsmtrp2D;
        Tue, 24 Jul 2018 06:24:59 +0000 (GMT)
X-AuditID: b6c32a37-6c5ff70000001050-02-5b56c63cd9d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.B7.03889.B36C65B5; Tue, 24 Jul 2018 15:24:59 +0900 (KST)
Received: from [10.113.62.206] (unknown [10.113.62.206]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180724062458epsmtip25ad17165459a32e504a7eaa6b602659b~EOfU3ffcj2338323383epsmtip25;
        Tue, 24 Jul 2018 06:24:58 +0000 (GMT)
Date:   Tue, 24 Jul 2018 15:24:58 +0900
From:   Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
MIME-Version: 1.0
To:     Souptick Joarder <jrdr.linux@gmail.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        ajitn.linux@gmail.com
CC:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
In-Reply-To: <20180718204957.GA14132@jordon-HP-15-Notebook-PC>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgl+LIzCtJLcpLzFFi42LZdljTQNfmWFi0wcsJkha9504yWay53sJo
        ceXrezaLa1cbmC1e3LvIYtH/+DWzxfnzG9gtzja9YbfY9Pgaq8XlXXPYLGac38dkMWPySzYH
        Ho+ds+6ye2xa1cnmsf3bA1aP+93HmTw2L6n36NuyitHj8ya5APaoBkabxKLkjMyyVIXUvOT8
        lMy8dFul0BA3XQslhYz84hJbpWhDQyM9QwNzPSMjIz1jy1grI1MlhbzE3FRbpQpdqF4lhaLk
        AqDa3MpioAE5qXpQcb3i1LwUh6z8UpDv9IoTc4tL89L1kvNzlRTKEnNKgUYo6Sd8YMz4ceYf
        S8FLpYqvh5+wNDDOku1i5OSQEDCReHRrBXMXIxeHkMAORomrrb/ZIZxPjBIfzh9lgnC+MUqc
        7+xmh2npWD6JBSKxl1Hi28UFUFVvGSUmbNrJDFLFIqAqca97KxuIzQZkT1xxH8wWFYiQ2Dn/
        G9gkXgFBiZMzn4BNEhE4wShx6f9ssEnMAn2MEjvv7WcEqRIWCJTo7lrDCmJzCthJLN8yESzO
        LCAv0bx1NtjpEgLN7BIntv8DSnAAjS2T2DcfzJQQcJHYuUkJ4mxhiVfHt0C9ICXx+d1eNojW
        dkaJn382MUIkehgllu/JgLCNJZ4t7GICmcMsoCmxfpc+RFhQ4vS1bmaIE/gk3n3tYYVYxSvR
        0SYEUaIkceziDaiJEhIXlkxkgyjxkLj8hAskLCQwkVFi1y/pCYwKs5BCYhaSv2Yh7F3AyLyK
        USy1oDg3PbXYsMAYOZI3MYLTs5b5DsYN53wOMQpwMCrx8FZ8CY0WYk0sK67MPcQowcGsJMJb
        OjssWog3JbGyKrUoP76oNCe1+BBjMjCiJjJLiSbnA3NHXkm8oamRsbGxhYmhmamhIZKwibGB
        gREwfZpbmhvjEFYS5zXyC44WEkhPLEnNTk0tSC2C2cLEwSnVwCjnv6Tb88zxnw+aTAOeTRP+
        n7r7R9LqYz+qUicEh9g6B/gwKbZdP6LgcXJO50ytOn7TlrRvfKe+npYzjp7xruaFv2hFcd3b
        uyzb98T9N/g/PVmSt/GwovevSs0HV/yWb/lrxaT9etWr/m4N3qOTLv+1t6i2epDf2bvPm3e9
        6+Q7vjM6hQqF/iqxFGckGmoxFxUnAgD5JRIJEwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXtf6WFi0wZZeHovecyeZLNZcb2G0
        uPL1PZvFtasNzBYv7l1kseh//JrZ4vz5DewWZ5vesFtsenyN1eLyrjlsFjPO72OymDH5JZsD
        j8fOWXfZPTat6mTz2P7tAavH/e7jTB6bl9R79G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8aP
        M/9YCl4qVXw9/ISlgXGWbBcjJ4eEgIlEx/JJLF2MXBxCArsZJXonnGDsYuQASkhIbNnKAWEK
        Sxw+XAxR8ppRYt2Kt8wgvbwCWhLb735kA7FZBFQl7nVvBbPZgOyJK+6D2aICYRLTfj9nhagX
        lDg58wnYLhGBk4wSl9+tBxvELDCBUWLyRBOQZcIC/hIXrvtDLOtnlDh06jkjSA2ngJ3E8i0T
        wW5jFlCXWD9PCKJVXqJ562zmCYyCs5CsmIVQNQtJ1QJG5lWMkqkFxbnpucWGBUZ5qeV6xYm5
        xaV56XrJ+bmbGMFRpKW1g/HEifhDjAIcjEo8vBe+hUYLsSaWFVfmHmKU4GBWEuEtnR0WLcSb
        klhZlVqUH19UmpNafIhRmoNFSZxXPv9YpJBAemJJanZqakFqEUyWiYNTqoFxGaOiVUPhzJKU
        LBG9cuZfjzd7LeUpYRLWYJ1bsqLv1nq3DUce3S1ROxol9uKro+PeVQs9n31/5s1zItPfVbB1
        w+4fL18HrjDnfyfgckhE93Prqsjjj8UfGlhfDwtz+Mz1YpnoQo7pP7Z2vd79uID97PMbVn8E
        Zns+Zyo6VSK42+qpcczknsmsSizFGYmGWsxFxYkAoHvFip4CAAA=
Message-Id: <20180724062459epcas1p1bf9f47eaccd54be8a8f9e18a18d23550~EOfVjI_Gy1414414144epcas1p1q@epcas1p1.samsung.com>
X-CMS-MailID: 20180724062459epcas1p1bf9f47eaccd54be8a8f9e18a18d23550
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718204725epcas3p1b98f118ad386fbb551ba1f4c10ac2531
References: <CGME20180718204725epcas3p1b98f118ad386fbb551ba1f4c10ac2531@epcas3p1.samsung.com>
        <20180718204957.GA14132@jordon-HP-15-Notebook-PC>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018년 07월 19일 05:49에 Souptick Joarder 이(가) 쓴 글:
> convert drm_atomic_helper_suspend/resume() to use
> drm_mode_config_helper_suspend/resume().
> 
> exynos_drm_fbdev_suspend/resume can be removed
> as drm_mode_config_helper_suspend/resume has
> implement the same in generic way.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_drv.c   | 32 ++++++++++---------------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 ----------------
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>  3 files changed, 10 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> index a81b4a5..1996ff7 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> @@ -151,39 +151,27 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>  static int exynos_drm_suspend(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct exynos_drm_private *private;
> +	int ret = 0;
>  
> -	if (pm_runtime_suspended(dev) || !drm_dev)
> -		return 0;

You removes '!drm_dev' not related to this patch.

> +	if (pm_runtime_suspended(dev))
> +		return ret;
>  
> -	private = drm_dev->dev_private;
> +	ret = drm_mode_config_helper_suspend(drm_dev);

Just return drm_mode_config_helper_suspend(drm_dev);

>  
> -	drm_kms_helper_poll_disable(drm_dev);
> -	exynos_drm_fbdev_suspend(drm_dev);
> -	private->suspend_state = drm_atomic_helper_suspend(drm_dev);
> -	if (IS_ERR(private->suspend_state)) {
> -		exynos_drm_fbdev_resume(drm_dev);
> -		drm_kms_helper_poll_enable(drm_dev);
> -		return PTR_ERR(private->suspend_state);
> -	}
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int exynos_drm_resume(struct device *dev)
>  {
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
> -	struct exynos_drm_private *private;
> +	int ret = 0;
>  
> -	if (pm_runtime_suspended(dev) || !drm_dev)
> -		return 0;
> +	if (pm_runtime_suspended(dev))
> +		return ret;

Ditto. You removes '!drm_dev' not related to this patch.

>  
> -	private = drm_dev->dev_private;
> -	drm_atomic_helper_resume(drm_dev, private->suspend_state);
> -	exynos_drm_fbdev_resume(drm_dev);
> -	drm_kms_helper_poll_enable(drm_dev);
> +	ret = drm_mode_config_helper_resume(drm_dev);

Ditto. return drm_mode_config_helper_resume(drm_dev);

With this patch, you could remove 'int ret' declaration including one from exynos_drm_suspend.

Thanks,
Inki Dae

>  
> -	return 0;
> +	return ret;
>  }
>  #endif
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> index 132dd52..918dd2c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>  	private->fb_helper = NULL;
>  }
>  
> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
> -{
> -	struct exynos_drm_private *private = dev->dev_private;
> -
> -	console_lock();
> -	drm_fb_helper_set_suspend(private->fb_helper, 1);
> -	console_unlock();
> -}
> -
> -void exynos_drm_fbdev_resume(struct drm_device *dev)
> -{
> -	struct exynos_drm_private *private = dev->dev_private;
> -
> -	console_lock();
> -	drm_fb_helper_set_suspend(private->fb_helper, 0);
> -	console_unlock();
> -}
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> index b338472..6840b6a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
> @@ -19,8 +19,6 @@
>  
>  int exynos_drm_fbdev_init(struct drm_device *dev);
>  void exynos_drm_fbdev_fini(struct drm_device *dev);
> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>  
>  #else
>  
> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>  
>  #define exynos_drm_output_poll_changed (NULL)
>  
> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
> -{
> -}
> -
> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
> -{
> -}
> -
>  #endif
>  
>  #endif
> 
