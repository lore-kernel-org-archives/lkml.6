Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694472077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 03:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHUsro75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694472077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIEIYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:24:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34126 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeIEIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:24:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so2632982plo.1;
        Tue, 04 Sep 2018 20:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ciAwn3IIVv6+wuAF5k9PHA/y8ixxUAE4cv4B+WenSow=;
        b=MHUsro75lJPcPAdxQwkPGnpZMyq96daNfVnoIHJ+kK/ZQaXLp9XRZ/Oa2NUf7pc23h
         okwNlfJx2t6+fOPCoBUFEsD3pAe+ZESUfeblkM4qx+1WEzcBfGS/A3S2R1B/ROiCtLTZ
         vWrnOK6L9kDjamydWtcl8APCDcTuSbKenGYpm7vVoOEWgqLtybWox7vr6ckOQtNFPVNd
         Jlt4RRWldOUtKm0ovX8MN/nyBuCIFGfH9BtpyMyQ3Hkcme5QjNzCIdMmceWtmr6NFRoa
         ntL/m/s7YU67E/6DcNd74qyxfYU5Ed9bavRPVBR1Vg+VpLwUidyczJBTjmAPKkBCsoIF
         9RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ciAwn3IIVv6+wuAF5k9PHA/y8ixxUAE4cv4B+WenSow=;
        b=DSd5dohNatWVNy0ItJFCLt3sPerR7fRCe+atKveQqDYHb3Temrx+DMbKnT2WRiudlT
         xIo1ttYyjYH0le+rZKdsqqUdtykXIH1otwLHs7lKnrCxYaxSZ9KPF1E7gyQRcX8LsoCh
         7rGHUO7VkGFlddRk9/fIvtcBiprOEGIZBdqZo6SBsIQZjbLEhOju2aUv5w/M1XXNdgIy
         uYsjVCHDYu0Y9E6qRULLsE8Izm+L5KZc2u9jCzDjwfLTLewXAKXNVELA384FPCejH5t2
         /43+3tFMqtikmX6yVl8qQX6mdErXeGACGgoxtSCoLBU6/sbdcXO+siOk0zLH5ECVzVbn
         7hxQ==
X-Gm-Message-State: APzg51DIo85IoYLyTztxVMvXza88ugRbhgzNzwpNeVakV6qO0RUxJKND
        5jzEGswGw6dn/8/6i0tUFCOe4Nrq
X-Google-Smtp-Source: ANB0VdZjV6guxzYedRLWKEQXvUnsTFabPLF11MlHjHXwgn3zY4ZfQCeR6/Xa1yFEQcNSliihYoscYw==
X-Received: by 2002:a17:902:b702:: with SMTP id d2-v6mr37313884pls.12.1536119751074;
        Tue, 04 Sep 2018 20:55:51 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n22-v6sm778321pfj.68.2018.09.04.20.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 20:55:50 -0700 (PDT)
Subject: Re: [PATCH] of: Add device_type access helper functions
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180830185229.20393-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4253073f-5ddf-a01c-4d3e-5c6a13068903@gmail.com>
Date:   Tue, 4 Sep 2018 20:55:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185229.20393-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 11:52, Rob Herring wrote:
> In preparation to remove direct access to device_node.type, add
> of_node_is_type() and of_node_get_device_type() helpers to check and
> retrieve the device type.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  include/linux/of.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a40f63a36afa..506beca9588d 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -980,6 +980,18 @@ static inline struct device_node *of_find_matching_node(
>  	return of_find_matching_node_and_match(from, matches, NULL);
>  }
>  
> +static inline const char *of_node_get_device_type(const struct device_node *np)
> +{
> +	return of_get_property(np, "type", NULL);

I'm a little confused.  The patch comment says "remove direct access to device_node.type.
device_node.type is set to the value of the property "device_type" in populate_node(),
but of_node_get_device_type() is looking for property "type".


> +}> +
> +static inline bool of_node_is_type(const struct device_node *np, const char *type)
> +{
> +	const char *match = of_node_get_device_type(np);
> +
> +	return np && match && type && !of_prop_cmp(match, type);
> +}
> +
>  /**
>   * of_property_count_u8_elems - Count the number of u8 elements in a property
>   *
> 

I'd like to see one or two examples of how you plan to use of_node_get_device_type()
(outside of of_node_is_type()) and examples of planned use of of_node_is_type() so
I can better understand anticipated usage.  Complete, clean patches not needed for
the examples, just enough text for me to see the resulting code change where the
helpers are used.

-Frank
