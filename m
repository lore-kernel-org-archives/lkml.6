Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3194CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4322075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550846376;
	bh=ak13Vh7sZsbfsHDKN4WxsuJ4h7Ex0tFhWr+nZPBN/AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PZ/MSKvpE5RE7l1DOf5FWU14lbkdzGCF8MArzavXvsfZQFSbjpRAAG0jHc3jVuLTk
	 8cU1fE+DiRoxQA6NOOUH3UN+ibMquXbEzWPWYpjAy8X2HH5yEgPyGnvU80326zuAvy
	 p2CiUk5dsqrntf8ZMFwdIEDcBSh7vYihb57Q49Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfBVOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:39:34 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38091 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBVOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:39:34 -0500
Received: by mail-oi1-f174.google.com with SMTP id q81so1863426oic.5;
        Fri, 22 Feb 2019 06:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nu6VebetlhJ9cLzYds+vNaZz+y5MqaLXo4Gpxoo6zOQ=;
        b=sTIKtMQBmOYNQ6FtoMg3ujUH8IsMQqLfw0jCoukflCkRjtT57knyZzm7Yg7gKH4z21
         vkRLDsP5I+l0SE9NFFLhfwqXIu4khy94WFSOWQ+19JAQcRiZAFw0pbOJrO88BYaZGp2d
         T6eZYGNisoJDAQ5KIcVUyHUvrG7zmoYKzUWFsSYxyNn2P4T6+cjBJB/FGWQWnrlJd1f5
         ki9OMVDZREIHnX0R5Ylx+3aVXcy1pRzXPJ12IktMI0CLvTzgRSUvzBAwnYtSR/FdQtnl
         sjQUy8ncSImlZyXU4tLsE940+FOQEbA07HGF6bKHkGPl7QxIviOG09zqlRwBt+n41KZe
         9IAw==
X-Gm-Message-State: AHQUAuZGl6+11Tt3Z9Ldl91dOKaVXeJ2c8M7ZzLLlAoQPmJD3DyYkZsd
        PYYnTOAx/H+g7SQk6lV8tw==
X-Google-Smtp-Source: AHgI3IbxfDo6Ox2SU+yN/pMzkTo4t/ym2gfG9I+6DU8kSSPB3lLT0VdDR7VD9L1uicny/KC1cKkfcA==
X-Received: by 2002:a05:6808:315:: with SMTP id i21mr2776517oie.114.1550846373286;
        Fri, 22 Feb 2019 06:39:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 81sm639149oti.27.2019.02.22.06.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:39:32 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:39:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, andy.tang@nxp.com,
        linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yousaf.kaukab@suse.com, Peng Ma <peng.ma@nxp.com>
Subject: Re: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Message-ID: <20190222143931.GA17132@bogus>
References: <20190220085607.31582-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220085607.31582-1-peng.ma@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 08:56:05 +0000, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V6:
> 	- no changed 
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
