Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A3C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Zj5J2oqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A3C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGSIpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:45:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43158 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeGSIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:45:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so6412485ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VPZVd+fUq/bD+V2j984rZodY8nOpjk0ASaORDcPzYkE=;
        b=Zj5J2oqbg0bEuwCUifDAwAL9SFkKLo9Yx2FjIeu7mhbaWx7dTV6wsfcHhD2dUXHA67
         t3qCwZVGyGftAWTB6SV6IKhb2WJiS7iJdHLZaJAGwBZemkEkoaAkz+KTRSWPgR5VGNjX
         elMGtAHkERsCRNT/1GUxrGFcONMRhG8uLPnbMN91mbDjcI1i8JvCubYbAmzy6Z9pRjQk
         3uH93dBe/FhDDOjq9CEr1i1+3Du19iJskPfH/6AhADSQrG2rh/kufuDos9/714B9COlV
         DGm6GJHZDl2/X5m6NxaazRJvEsHy+54wtN2PgD48whaAdMsiyGgQ8Q/nZwk8LDj0dsro
         hncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VPZVd+fUq/bD+V2j984rZodY8nOpjk0ASaORDcPzYkE=;
        b=sthqB2D06UVhoObMm/4fqI3WkIaklImNQuGZpTqRcb5g0165gGPzc5Az53lsF3GUdJ
         BZrJ1PI6Ac26NnFQBekDjh8NPDNwpHa0EQOaA3Z0DcXxIUpxa6iqUS61FaeD1oHVbsND
         M1NFLc5g02nnGrpTg/da70OZV78dArwCxE9uvAcIo74OkjWN4H305qToD/g1lTO+t+i/
         HdrQBnOeUHw+JCimwjZtdQrHNv0yCzWsj260OW4WUkfda06h5bl/UkYQE6GIGHnu3YR9
         XUtnFz6eA66pnACnDO/dPRqYV5ownE6ibneTLsYU1yq5j5EmYK1X50y235CqYqNTy+hO
         ul5w==
X-Gm-Message-State: AOUpUlHlOqTO41Al7f2KvjEZMGAh7CpVufpz7kf8ld3jEigZAAAwV9Q8
        mbDeXiaW8zWhxm87/IGlx5lpbw==
X-Google-Smtp-Source: AAOMgpdaNqnBmXxvDnnsNDaZgzDzAI02E7JrbDz+UNenDs7ivFj9qvn4Fji4SvxtNd9HTBcbLvo/Ig==
X-Received: by 2002:a2e:4701:: with SMTP id u1-v6mr7207079lja.54.1531987392061;
        Thu, 19 Jul 2018 01:03:12 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.106])
        by smtp.gmail.com with ESMTPSA id g2-v6sm864599lfb.52.2018.07.19.01.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:03:11 -0700 (PDT)
Subject: Re: [PATCH v2 17/17] MIPS: JZ4740: DTS: Add DMA nodes
To:     Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20180718182023.8182-1-paul@crapouillou.net>
 <20180718182023.8182-18-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d4a95b78-0fdf-a341-3fe9-91cb94ab164b@cogentembedded.com>
Date:   Thu, 19 Jul 2018 11:03:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718182023.8182-18-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2018 9:20 PM, Paul Cercueil wrote:

> Add the devicetree nodes for the DMA core of the JZ4740 SoC, disabled
> by default, as currently there are no clients for the DMA driver
> (until the MMC driver and/or others get a devicetree node).
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/mips/boot/dts/ingenic/jz4740.dtsi | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
>   v2: New patch in this series
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index 26c6b561d6f7..47d93f2597af 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -154,6 +154,21 @@
>   		clock-names = "baud", "module";
>   	};
>   
> +	dmac: dma@13020000 {

    The node must be named "dma-controller@13020000" according to the DT spec.

[...]

MBR, Sergei
