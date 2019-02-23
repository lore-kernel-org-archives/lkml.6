Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DBE20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550882632;
	bh=Qycc4diKcN12eW8uEI2BQzr3X5ZjDNpoYpx5DZ1TD+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohcS7RFiadX31RryewvWwCUBHilfWHkBM5mAxGIHal3f79hm4OxpjQme+Ie2u8zi+
	 2wBsJkEl4dHQzCJ8IunsCdsSNu3T9ndOhM0k3JPMST87Agso88aZyXSBlVK16UbKGd
	 puuLAb6G+I+CR+mBJLFjItiIkaoNIOmMFXVbGNAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBWAnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:43:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46481 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBWAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:43:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id j135so3143077oib.13;
        Fri, 22 Feb 2019 16:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKX2e3QzlkFWdb2TpRaQ3+MIgBmL1NkoK4cD8vAY5Sg=;
        b=RxynB1hQkByms8BDJ4TItGibpvMC/NCMTiCylMlWOJ6oxFiKehTrymvVfUOE9vzMSV
         2n7B/t3d1D6JvOuLxJk/2jYFPsxnkO29fSGAiyOY5s/OFmEja8sJmlnrXstiZwVh26el
         AEcqcgwZowSGihaYOi6e6nK4E+6E+worDnntGsRxazZZWABp+9TOQoaEHJpC03rI3kkb
         5oJJyv4Yfse/X8z4yJUcNOaUMB3BczsIO8ed+t1bjrD3kBicJAhmeV+coDJlCaez6SL6
         RbOVM5fjTCy3BncvHo9WQuNp8megSfeUCahSZeGSRf8v8jTYlcwjUUb/sUsI81iAxRrj
         XA4Q==
X-Gm-Message-State: AHQUAuZLl/BFvpfm/pWmiKo6vZCyIto9VuLL3/lNjH1aLz7UHsg9MolP
        VsfTBtPA4fdrEneoQBx/GQ==
X-Google-Smtp-Source: AHgI3Iab/0D3CXpgc6XFjXzdwSEMrnhmdCunbcFMc9232dvFBsBlsfi2jQJk2ZHMo+i9/DGqDxnduw==
X-Received: by 2002:aca:5807:: with SMTP id m7mr4227281oib.71.1550882629897;
        Fri, 22 Feb 2019 16:43:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f15sm1194062otq.65.2019.02.22.16.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:43:49 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:43:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: sitronix-st1232: add compatible
 string for ST1633
Message-ID: <20190223004348.GA6783@bogus>
References: <20190128084449.16070-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128084449.16070-1-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 09:44:47 +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> The st1232 driver gains support for the ST1633 controller too; update
> the bindings doc accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  .../bindings/input/touchscreen/sitronix-st1232.txt          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
