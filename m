Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF57C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365FC2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550868136;
	bh=7fVrrEiutr3ckOlpV3eO9FKOdNl4pAdlTPrWfhFO94U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hfYnyu85THWYPBS1OYb8vR/0+i+KeQxyjTe3/DftRhjjnsSv2ZAQLExuU3/nO3N3u
	 YSTGBNMxwnAgu1RbZGbUOmrXdQIOwHosIGbiINGgUpIjJSYxJn4Vhlat+fmhoOPv/6
	 NKY/os6JqNYWGkzxnaGFamCQsQaVEu9PbzKxjtVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBVUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:42:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40351 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:42:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id x187so2758422oia.7;
        Fri, 22 Feb 2019 12:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFi7L4s8T1xW8jC0I+2GIQ3aNYN50A8rveMXQ0PTdj0=;
        b=nTrdjBNQptybsdDeg3z8oIYZNqS7YqLoj4RIa3XDnIVwLt5haNpT63CJXXDvECb4qo
         Z057xB4nssxYFMlMelER6DqMKMbZ1XrH6zWYecxhsfO4tLVY/tnB6NUyTuUazCwHrvij
         JjQQkyR926amFYMK0Q9e5xUsFrRyuadcOw0H4kK6xAwqG6Ul7wm2UGkO+/XNYkosVj6Z
         DAB5cRBmam6Qk0fAt2nc4v7e/ug4n46l2slRpFfJDmjt2vISNFnwlSloFDtntZNSBS5s
         9nGQhnrUVb7+jOX1T5xL7JhUUtQnKQZEFMgSba1eiYRWxly9LPLpnWGSQjyPe5n/Ob5R
         vUdg==
X-Gm-Message-State: AHQUAub2W6dxv+kBT3wKopuBOnKTm47o7cArlE24JivxF9PT2FP8udM8
        bfqcCixEokI5p4XfVr/M6A==
X-Google-Smtp-Source: AHgI3Ibyn8rUOfMmYPKgygX/pb50Sixwskl36UC8LmZSrXn/MNokD4EwvpmWi5ZNPEVlUF5hqtp4QA==
X-Received: by 2002:a05:6808:315:: with SMTP id i21mr3809732oie.114.1550868133501;
        Fri, 22 Feb 2019 12:42:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm1042055oie.52.2019.02.22.12.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:42:12 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:42:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        eric.long@unisoc.com, broonie@kernel.org, baolin.wang@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dmaengine: sprd: Change channel id
 to slave id for DMA cell specifier
Message-ID: <20190222204212.GA26859@bogus>
References: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652a8ef9554890c254823ec39858b8d7413fd561.1550719757.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 13:34:40 +0800, Baolin Wang wrote:
> For Spreadtrum DMA engine, all channels are equal, which means slave can
> request any channels with setting a unique slave id to trigger this channel.
> 
> Thus we can remove the channel id from device tree to assign the channel
> dynamically, moreover we should add the slave id in device tree.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Remove channel id from DT.
> ---
>  Documentation/devicetree/bindings/dma/sprd-dma.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
