Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7472AC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E97B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085636;
	bh=VwomZMXEQHNNEVJw7R83oDTqrKSTWbrersmV/HcvOEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NCEkAGsZ6pX04SZ19RnfY4IbILBL3oqAbbfabC3+wh3DtQ9CAis8TjNw7RXEu4Zbs
	 VfrXFMMIhTmaH48HZh42yISFGyaFOkayJ5DaaxeOeomYw8JX4qoo6LghivzafLvwZZ
	 bgD7Y/nqq8CHF2Y+/Fe6uhUFJD4TwDU+JTiyNVOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfAUPrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:47:14 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34740 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbfAUPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:47:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id r62so14913877oie.1;
        Mon, 21 Jan 2019 07:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5Cag2bb1igmx1hitA5tXhWs1KMAnmvIryUl8ESliuY=;
        b=cEa+uI9kWoV2tF0XbETnqgUlbBiRutVElczo9BLJuzB1xu36hJJDvOiwX4Aq+8hyjw
         tNZF1xgRYUhy9LPYgoT1fWvvvkXel1UJORvw5Aw8exz5cMDmjWLottktySnWa9wb+dci
         z/rHJh6KboD/cf3TFZZRGWBBTKhb7DIxG+bNbzguIKvS0y2aiglNwXSgYH/iE3+n+8ja
         hOCGM0Z8s/hjBn4JF6k+HVl/3vxbXGdCCPePg7O8GC88StNiv8NxAbjvD+VEMn5hpvbU
         TvhouWLqToxnshYO4nQ16FOBiAvxBbtZM8L3yUVo6ex9UnaT2ShpBWN1HgPF/D6OZRZj
         hTGA==
X-Gm-Message-State: AJcUukeZ+VnkUzZTr4I9QqBefVPCaAbEgRyANU4hNE/4F24Kx+Njaj5C
        RhTW6tx8h6KSuImr20wG1Q==
X-Google-Smtp-Source: ALg8bN56MBiQdIRF1ImH0EjENgrD0JFR079S5Qr81gZVBfJlAcbU1SH+5Cessza7vQjhuWACNVTdkQ==
X-Received: by 2002:aca:88a:: with SMTP id 132mr6117440oii.224.1548085631296;
        Mon, 21 Jan 2019 07:47:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm5933640otm.63.2019.01.21.07.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:47:10 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:47:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michals@xilinx.com, RAJANV@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, JOLLYS@xilinx.com,
        chinnikishore369@gmail.com, robh+dt@kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
Message-ID: <20190121154710.GA31999@bogus>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
 <20190121173835.21173-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121173835.21173-6-nava.manne@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 23:08:34 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Added nvmem node as child of FW. Since nvmem driver is a provider.
>   
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
