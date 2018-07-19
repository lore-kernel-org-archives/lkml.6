Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0AA20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="NEFJMDPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0AA20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbeGSItC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:49:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43511 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbeGSItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:49:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so6422503ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ygSA0TisS1G9yDz0tiDVeJGinlDq21hTl6agLHlX5Fk=;
        b=NEFJMDPShLPuXndEYWYWJ5HTiG4EMoG/o6Rohaus6oRguuoiqqKRTGF5O5pWK/zoLF
         DrbAuhydw7TTKWDfVK4uhluOYftAwQMwWJ+f61amMBYkftd6WxAr73+8IJyl5of0P2K6
         RSilifL/MOZQKGq/h2ZjzS5IjQAF7FTE2feKgFUui3qUMQ0aQ5ZIlVboW4FIGiM/5T5K
         KFsugZbdQdmrJwxMZNzqYjeyTuO0aw5SBAG6Fu0tCaNy4jZtbLLIpE1jlTLbUML7G5iM
         wuYFJoS/cBl0TB5uqDMAvfYWCfBkpJWBKNcKfYn3QdTRqxFNFGTwZWRrbqzQ8JCt+ljm
         a6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ygSA0TisS1G9yDz0tiDVeJGinlDq21hTl6agLHlX5Fk=;
        b=pVG5q5cCbSjQor5INYQZzeA4fKRiFH6oPgpLdLH1DfMxzsyBF2Pog1icsfpp/cToT4
         lOenBrLJ1F00Hg4oloTzE0Lmfs0SnUTGfX9geBaM/y/pZZFdhq3qhE+vcNUQ3cx9iDZ8
         V7qb4j8P2aM33sNtIz9JaklHnVU+COmwhG+NtiWfCotaf6HJMfcAQZfJInyg86kb0q7f
         gparcuvtMZJ/gJqZK683QBF2lB69kX6C6ZjGOGXXJPK2GikfIatdoeGOQeDrXA639i9v
         Xu+yQyvhR15K32YRZFUUioU70j+fITZXiZHwsopHVV6zUFrrNDiAUta8oRbAVOwy1Osc
         m74A==
X-Gm-Message-State: AOUpUlHlCmj36cj+cktcG8l5nPq5D3Yno7a5io2YSNyEUdLi2H5LYLEi
        CxwLTzyH4XJ+JEATiHCu/eCE6Q==
X-Google-Smtp-Source: AAOMgpdQPgH91GP5mPyyFGWJplFK2ldUGq5XFaLqt+wTk+RpRfroBJCS3IZTwTx86D19/sZ1274wpw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7-v6mr6684856ljc.81.1531987625446;
        Thu, 19 Jul 2018 01:07:05 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.106])
        by smtp.gmail.com with ESMTPSA id b87-v6sm859884lfh.33.2018.07.19.01.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 01:07:04 -0700 (PDT)
Subject: Re: [PATCH v2 16/17] MIPS: JZ4770: DTS: Add DMA nodes
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
 <20180718182023.8182-17-paul@crapouillou.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b25df80b-2314-8ed1-6fdf-5bb9b49ec994@cogentembedded.com>
Date:   Thu, 19 Jul 2018 11:06:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718182023.8182-17-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/2018 9:20 PM, Paul Cercueil wrote:

> Add the two devicetree nodes for the two DMA cores of the JZ4770 SoC,
> disabled by default, as currently there are no clients for the DMA
> driver (until the MMC driver and/or others get a devicetree node).
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/mips/boot/dts/ingenic/jz4770.dtsi | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
>   v2: No change
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> index 7c2804f3f5f1..fda17beeb08b 100644
> --- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> @@ -196,6 +196,36 @@
>   		status = "disabled";
>   	};
>   
> +	dmac0: jz4770-dma@13420000 {

	dmac0: dma-controller@13420000 {

[...]

> +	dmac1: jz4770-dma@13420100 {

	dmac1: dma-controller@13420100 {

[...]

MBR, Sergei
