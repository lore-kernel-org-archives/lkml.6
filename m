Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822AA2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549298062;
	bh=d0hXMA3Yn6eT7Sa4/HSvUipz2MUBghOtn/C2pF+CHkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FeATJILkjeoSe6JB421j8UjKyCuhoTwQ4tLcPXLtU7m2vlzCoD/oXFQgyAbl+X1Pg
	 t4vRMSHjVlmibrQNd8RfTEzBqCELDaIBuM+eOSDi8eWitUuTfJy63vX7w40wTjJF+5
	 PsovxjKKyFYs79nWmcLOwz+qbIn6GTVJy2VplZh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbfBDQeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:34:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40591 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfBDQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:34:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so146997pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCdal3sOb0VjUF3OKL+qIv7JGKFCeicstFN/24b/fig=;
        b=Q5RMKF8dxe07Qdsc8PNoei459b/++L21xayWHMEnG4bFIKe69wu4TrccEUxQpnnGlZ
         biXhU5LINkNXOhIcs/8JJYXlEHmvOCHiGKJC9bkPHt9uY9Ng7BjUzLvp/Fevv6NtFcU6
         pceuEycGlht7NYs040PoHxxdmBl+yiM35Vn300A3HfCUPojkPutlFQpGywpJMM8x/YcF
         Fn7pDi4xX9PY8JnOIPajNhTwwAEmrxV0UL1hHRXJVXEWXnHQewZ8Qnyh4BrInaxo7qgI
         YFaATemt5FqwmTUi4o4AtT8+S8kqPQnuyByTjarpugGhJZmxV09vuRxLheytDtA+ysJf
         D2AA==
X-Gm-Message-State: AHQUAuY8YRliS5UcqXDBoU1JmSibv7rqRi37XUK8+LKM+zRR4HNx5jix
        II4P0xjHEG6gt4jJ18n1aY+8OA==
X-Google-Smtp-Source: AHgI3IZIjtqKjmUw/C7wUnTyhOzN2n2Ucs2UOXMG/T8yC7geGdXm7LmhVnxYDXJjpGv/SnKzAo4HPw==
X-Received: by 2002:aa7:80d7:: with SMTP id a23mr255919pfn.86.1549298059145;
        Mon, 04 Feb 2019 08:34:19 -0800 (PST)
Received: from localhost (c-107-3-167-237.hsd1.ca.comcast.net. [107.3.167.237])
        by smtp.gmail.com with ESMTPSA id l74sm731530pfb.145.2019.02.04.08.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 08:34:18 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:34:17 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        davem@davemloft.net, alex.williams@ni.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [net-next RFC/PATCH] net: nixge: Make mdio child node optional
Message-ID: <20190204163417.GA2157@archbook>
References: <20190202025048.14772-1-mdf@kernel.org>
 <20190204145854.GD22111@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204145854.GD22111@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:58:54PM +0100, Andrew Lunn wrote:
> On Fri, Feb 01, 2019 at 06:50:48PM -0800, Moritz Fischer wrote:
> > Make MDIO child optional and only instantiate the
> > MDIO bus if the child is actually present.
> > 
> > There are currently no (in-tree) users of this
> > binding; all (out-of-tree) users use overlays that
> > get shipped together with the FPGA images that contain
> > the IP.
> > 
> > This will significantly increase maintainabilty
> > of future revisions of this IP.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Rob Herring <robh+dt@kernel.org>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks.
> 
>     Andrew

I'll resubmit as a series together with the fixed-link change.
Since Dave has applied Alex' patches I'll need to rebase anyways,
otherwise it doesn't apply anymore to net-next.

Cheers,

Moritz
