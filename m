Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1508CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A5820658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzSEHnTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A5820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIEGXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:23:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40225 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeIEGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:23:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so2486615plp.7;
        Tue, 04 Sep 2018 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=62G4hrLolyuYkhLapSplxjFK015+EGCLxMWTMlHQGpo=;
        b=kzSEHnTobsIbSepIj4py2lpleAaXtbkEtOquBtECJlUhJ+7rPMfX1hYQTvBCy3SL8l
         EDb3KFcKlfacCkqHQx7jNiL2oOh37ohywP80IC+PgenOMihg8BtmfKGMQDArO5kflNtk
         tzV512aOMn10J9N+O1qZWPHNfNQ0HuXS0Je7SEfvOO5C0LxW2uiOPVYWC0IPKFNin7TN
         S2Qbci5HdRCYfjyQS1dEKhlfAxassE8BFZXuO3B3HRqIOu/I96d9UH6Vl+oami0OcuhD
         0M6BBnDeuk/FeTsdsXcQIehdARcChGn6oafM/tsqkG+KpePQb3FCvIc6XLDfD6jgAuHH
         +Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62G4hrLolyuYkhLapSplxjFK015+EGCLxMWTMlHQGpo=;
        b=PoVIo5dIONpSqO9sIy7TRnTbBn3IAGFjMpLOeTJPLxq6+sNQ4s9WrfGiebXQUTCbA2
         7uxVaXahJS/MTfUErjcFMDVZrlCafA8+QTxg59OpAtGxaib/OGZWgMF3mydqeErmELfA
         WlpY/bG+lYdaKwlxZayjMyXGeKYdyW46aRVIm6AFONGnxTCDvv/+pm8SwHgcBtxdhCd6
         +xVmm+lH9gCrGDwmz9FIlchxhS0Gq8zGt9+7QbEI/3cmgy6gsV63NKGZm8WCrcP56IAs
         xEVmVZO6d0mcEFe1yRBY8awONI/vawepF9rn7l/Kg6enVy4++xPfx/4Ii+BIRaRMnGNH
         3igg==
X-Gm-Message-State: APzg51AvogydeMeP1y1izyhgMkTfuTHozSqJHbqE97wAVPhnxVxahyl9
        eTuLYUPR4u6YBspdPh+kR94=
X-Google-Smtp-Source: ANB0VdZeR7g3ksAtkEiHwmHC0na4pX/sWNAEC3av7OTotJ+lEoSRAVSCpqIuph8/DUZ8Sthr5f2sDQ==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr36347907plb.172.1536112527639;
        Tue, 04 Sep 2018 18:55:27 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id x23-v6sm317116pge.61.2018.09.04.18.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 18:55:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] of: make default address and size cells sizes private
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-4-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <35247ddc-303b-89d0-53b5-231c1a293721@gmail.com>
Date:   Tue, 4 Sep 2018 18:55:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830190523.31474-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/18 12:05, Rob Herring wrote:
> Only some old OpenFirmware implementations rely on default sizes. Any
> FDT and modern implementation should have explicit properties. Make the
> OF_ROOT_NODE_*_CELLS_DEFAULT defines private so we don't get any outside
> users.
> 
> This also gets us one step closer to removing the asm/prom.h dependency on
> Sparc.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/sparc/include/asm/prom.h | 3 ---
>  drivers/of/of_private.h       | 8 ++++++++
>  include/linux/of.h            | 6 ------
>  3 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Frank Rowand <frank.rowand@sony.com>


> diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
> index d955c8df62d6..1902db27ff4b 100644
> --- a/arch/sparc/include/asm/prom.h
> +++ b/arch/sparc/include/asm/prom.h
> @@ -24,9 +24,6 @@
>  #include <linux/atomic.h>
>  #include <linux/irqdomain.h>
>  
> -#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
> -#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
> -
>  #define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
>  #define of_prop_cmp(s1, s2)		strcasecmp((s1), (s2))
>  #define of_node_cmp(s1, s2)		strcmp((s1), (s2))
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 216175d11d3d..5d1567025358 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -27,6 +27,14 @@ struct alias_prop {
>  	char stem[0];
>  };
>  
> +#if defined(CONFIG_SPARC)
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
> +#else
> +#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
> +#endif
> +
> +#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> +
>  extern struct mutex of_mutex;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 506beca9588d..49d85f670c75 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -247,12 +247,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
>  #include <asm/prom.h>
>  #endif
>  
> -/* Default #address and #size cells.  Allow arch asm/prom.h to override */
> -#if !defined(OF_ROOT_NODE_ADDR_CELLS_DEFAULT)
> -#define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
> -#define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> -#endif
> -
>  #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
>  #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
>  
> 

