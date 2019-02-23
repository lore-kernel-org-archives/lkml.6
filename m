Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37203C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AE42075C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550882226;
	bh=e3RbFfGgFO9TWgs0jwHdzWml1VCnRC25ZnXoBi/wYJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rkw7K9dPlP3hgJEPMt/LnIX8guToG6mzuKSVXSUbuGac699i9+vp7224YoPFU54kC
	 UYjPbC22394lsMn+BmRc18eNo3yGSJOaAGu6gpDVjyc+VN8nR65rOJJJucQxe/jTbc
	 0OLGfX2wzshs81tfBhRQsdDh7d8hi5i1LgNV4pF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfBWAhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:37:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37721 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfBWAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:36:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so3434334otp.4;
        Fri, 22 Feb 2019 16:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MgmoelFdZTP/wGgcU16+Qr/C9iTYBtbpM07BYv/EG/I=;
        b=OGsrV+HqlORgra+jsXepbYnxMogM7eND8qYYezMCM5JGfrgFyjeJSRm0VCuEZQNILT
         K63K+lgiqgn6+vMrJpswI700OR2jLfGLoX20FX6+3v59F+tlcLYxGooAf9zQiXYEq2EH
         dVcewtJ+t/ohNELRT00qNhR7utqZiRJ/4Rj9V/J6Yycqpmu/TF+oD9AkQTKQHL8oyXYM
         CbMkP9BKgylPgMkpbO//+qfJH5U+bRM03nHfx/8r57S2kARbvjngMuWYZnKKWszDTcU9
         mFbTMya1+Kg5THEERNuneYRQZcMKCNZgl4Z8Zru/s3rGTlcaMZVR/hXJGGHLnM8e/CQL
         rvAg==
X-Gm-Message-State: AHQUAuZC8kai3khWzKTD1sGpZlWSdduw+P5XrjpP+mLZNBHczlu+9k7P
        /Chp8pS21edQ5EVmUUZc1A==
X-Google-Smtp-Source: AHgI3IZfEOiIR/Afwg/1hdt6Sop19+1ENt9RI47H4XfLH4+EqtAffY8hhvGKKXBajFloxwXvLKFvgg==
X-Received: by 2002:a9d:6f10:: with SMTP id n16mr4361878otq.105.1550882212764;
        Fri, 22 Feb 2019 16:36:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e138sm1429247oih.27.2019.02.22.16.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:36:52 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:36:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: usb: xhci-tegra: Add Tegra186 support
Message-ID: <20190223003651.GA29316@bogus>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:30:08 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Extend the bindings to cover the set of features found in Tegra186.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/usb/nvidia,tegra124-xusb.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
