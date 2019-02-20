Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE461C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDABB2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za7rEmow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBTNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:39:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44886 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:39:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id c4so7214095pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UaaXUKzsUOf1c5d8fiFyQA0m8c1fiRWn7dV/WgaDouY=;
        b=Za7rEmowVPpPwewDNHAtGrminUQoLhzPkPyQmXB9Sbxsv6mb3UJL21q7S+Lg1fhE3f
         eMEIjTYJBgEwGg1jewfmBUdz6bGdVcAMo96NWfLfAVARm1Jy9X+URVYYVEGlF2W06pVg
         oj+tUBwYGuj+WBTnltlo4Ut6Ixqb2r+1GZdFA5DsOcZBG1WvjRfTiGjP+LdASoZaVEge
         ZoOdKREUn0SDLIimf4SHvyntkDJt4T/gNrLNzFosU7bSSaAXkEuC/9z8q9QFATx24DNW
         136q7FX9a5JLPrZjOmjL7FXlbA0Sc492Wa0BkMAuFy/nO9A9zZTBBI0euAXr8HF4g7D7
         RMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UaaXUKzsUOf1c5d8fiFyQA0m8c1fiRWn7dV/WgaDouY=;
        b=STCSpT7NHeTWRbjGNwHDSFtsmphnWGSAbyRBV3YRk5ubqhw+tnr1eNj7Tk4Q+0GU5s
         3SqxOpc3gqbqcF/nNEyqE6ZlFUq6TNKAanPLK1LmKtLqrSK2HTjIIiePdT1RAKE1ts4P
         sSCVZCv0ZbXDtV5NI5jYEVyGZqrIq55t7ce9FwMQGjFbfR0vnjg9uV0oJhKbPVYI7lZ9
         JRNZUuu1Xe9oepqNVxGsdBpPGWTmbrQ4+cWCWNqTwo8nFXMFGU6eWvosbNlFvuyAEl1B
         DGRtlAOW5DQj0M5oxiAhI21PMwhk0O0viLCDDpxcl3fyykJr5MSiPaH/yUsAWYkqKIJz
         O9GA==
X-Gm-Message-State: AHQUAuY4ud1TnAlfbX62Gk9mlaimbWMW4AvGDILtjoOUzIOfIDdq/1Iy
        lSCgvEDUgQl1AYUecCzBF/DARCdr
X-Google-Smtp-Source: AHgI3IaDyW0OpmEgj3QOJAHfZo/Nz+egduleTeGUYl2YRdUU0ZSEUJKEtmqkxNh0bBK7evw52qO1bw==
X-Received: by 2002:a17:902:282a:: with SMTP id e39mr37050585plb.26.1550669962562;
        Wed, 20 Feb 2019 05:39:22 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j68sm12242448pfc.64.2019.02.20.05.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:39:21 -0800 (PST)
Subject: Re: [PATCH 2/3] iommu: Document iommu_ops.iotlb_sync_map()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Baoquan He <bhe@redhat.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190220130053.784-1-geert+renesas@glider.be>
 <20190220130053.784-3-geert+renesas@glider.be>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2fff24cd-5591-8ac9-3665-6d9a6e1689c1@gmail.com>
Date:   Wed, 20 Feb 2019 16:39:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220130053.784-3-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2019 16:00, Geert Uytterhoeven пишет:
> Add missing kerneldoc for iommu_ops.iotlb_sync_map().
> 
> Fixes: 1d7ae53b152dbc5b ("iommu: Introduce iotlb_sync_map callback")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 848fb07026b67169..3ed5d372b090af54 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -169,6 +169,7 @@ struct iommu_resv_region {
>   * @unmap: unmap a physically contiguous memory region from an iommu domain
>   * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
>   * @iotlb_range_add: Add a given iova range to the flush queue for this domain
> + * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>   *            queue
>   * @iova_to_phys: translate iova to physical address
> 

Pretty sure there was a kerneldoc in some version of the original patch that introduced the iotlb_sync_map(), but probably it got lost after a rebase. The kerneldoc comment is correct, thank you! BTW, for some reason gmail marked this series as a spam, maybe you need to check the email headers and whatnot.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
