Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF3C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B595420839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW15IUSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B595420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeILKip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:38:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45023 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeILKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:38:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so544162wro.11;
        Tue, 11 Sep 2018 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jT5+7JtWPBJBZZZG4eQIh3AZac3EnhQZE2+KTuHbuTM=;
        b=KW15IUSoqFxS1S6G2oefemWnpJnNcuV2in6KAFs74LeStoErilQKi2oRGikOK51qNK
         V2jQMXqxfqlVu07YEQJrh2RFSikf/klYm8gF0k46IML+eCUsXFYtG1QCzD1JqAruajK8
         m0EqJx5a8NYmaYyvy8gif9XUnyuKhcsKwHlnETRmyK2bWdSq8w9eLpI8X1Uff+rSW31v
         3iLGMJoo3siw9AdVHwlIjhpVO0K61qdWRruq1BQ7WZdOuw7wKsDT6iLK2A9O6/PgwoE6
         u2Y/sT50xaJRKhbl8pVwxrWnvwsJIGS0OXPzoiFESxK/yIZ6mjDjhETlJdC8YEuJSMJ9
         wkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jT5+7JtWPBJBZZZG4eQIh3AZac3EnhQZE2+KTuHbuTM=;
        b=VIv9trDN4YcxolnlURbNKVJ5yLAlpiuVCTBA430JWBV+rublS2xgcfO7qbkfwYZ06h
         g9/bRe6nNjQ8igNXsZmPXq0W9/UvGq5NqdkGB45e8J+koHxDVpZLk333ND/YpHkfORim
         P5uepT7AVqYzIr+M3K4RNpB2aujDRnIq2EtE+mhdFmCA/uZj2oRuUQ68i753sOOXe7+v
         mBzrAdNyMKKHvmiYCzSefgvAVV0xDvO2a9nPB9c/Q9inP93h5U5dHeoRamz+Lnjdr2ea
         6VURU3SwqkmmPTYcYpRSU7SWzgIx6lzVKQjMxn3T0i04HrUZnwcwF+pFNHVxW8GE1aIs
         BzXg==
X-Gm-Message-State: APzg51A4mPtnTtZ2ufdbfYorT7awfVeIDsi51ZH38yopnuPGrWngu/rd
        gIpMNRr2GiLpWC5EaU1iH1o=
X-Google-Smtp-Source: ANB0VdYqGbo/An4uDDkoVOj5gtA+M4ICiI89UwMfxZvDtEowliOe31bStnxsx9xGLgfa6uxe+fUR0w==
X-Received: by 2002:adf:f608:: with SMTP id t8-v6mr156662wrp.186.1536730553666;
        Tue, 11 Sep 2018 22:35:53 -0700 (PDT)
Received: from foobar (211.red-88-7-211.staticip.rima-tde.net. [88.7.211.211])
        by smtp.gmail.com with ESMTPSA id x16-v6sm23846003wrm.69.2018.09.11.22.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 22:35:52 -0700 (PDT)
Date:   Wed, 12 Sep 2018 07:35:50 +0200
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com, blogic@openwrt.org, neil@brown.name,
        peter.vernia@gmail.com, oliver.huebers@web.de,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] staging: mt7621-pci: Use PTR_ERR_OR_ZERO in
 mt7621_pcie_parse_dt()
Message-ID: <20180912053550.GA17293@foobar>
References: <1536720608-106123-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536720608-106123-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 02:50:08AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index ba1f117..d2cb910 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -396,10 +396,7 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>  	}
>  
>  	pcie->base = devm_ioremap_resource(dev, &regs);
> -	if (IS_ERR(pcie->base))
> -		return PTR_ERR(pcie->base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->base);
>  }

This patch looks good but the 'mt7621_pcie_parse_dt' function is not completed at all.
There is a lot of missing for each pci node to be parsed yet and some patch series which
are doing this have not been tested yet so those patches are not included.

Please see: 
    http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-September/125937.html

Best regards,
    Sergio Paracuellos

>  
>  static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
> 
> 
> 
