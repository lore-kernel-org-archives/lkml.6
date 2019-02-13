Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB049C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9DD222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550098594;
	bh=TXVcf/AA3SXMAATbrKZhIKgeSW+UzGxpyZpyXYNQu2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VfvO6HufHqub8ufvgY6J7FL+dmMi2CYnwvRyKElFuu0DrH9eVu/3ZgNS7BtcM+NUW
	 G2+s05he+kQtghoJl8p60VgHsmp3pxgB1+5LLpLF3re0d3JqH8cjwtdR+hkSvRmZ4l
	 OMZDv+Wgxapx5gcMUXYAnGRGNvdEdU4n6GRxtAHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbfBMW4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:56:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35035 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfBMW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:56:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so7329431otm.2;
        Wed, 13 Feb 2019 14:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vQVi44PgRSAYv5hBFPyy2w812kRyMyidLpbONnrDqw8=;
        b=GTg4lARswxzZfsj746Kvhd7JGs+IjMwELP5dxgKpmr2mv9lFmyWZLufqf1/JNNoZqj
         OrPgfQ9VIEFdO/pZ7AQ6sOVGELt/cohuE9EcMoEy3AhpVg1i4pzRyYrvCZ93T7JLUwF1
         fHDomqPkzqX0mih+WaeFPwBZO5ZNPdcoM0OWGj3iL2rbKCfe25RbXR5Iol4Nzad6UnLj
         D1769LPvJjUQWre2ff0FPoU4tFcXTqtmv3qAfXne00+Wd/747rAmXhbFM37m0Lwg9GAx
         5jRyZkK1dbKPmQ6B90NXZZ2GyVTvEjOBGkFkYBtJqr3oqq13Aj2fm2Nl3fQyzpzryO7b
         X4xQ==
X-Gm-Message-State: AHQUAuZ9fDudF9pbjLZ4qQG/mjqrx+KOlUVStyAXloyqGSmHxHB2jZ67
        cL0EqRosgeGvZiFcrfIBEw==
X-Google-Smtp-Source: AHgI3IZBurmdoM4/fjfYdeM+EyDBzLdKCTGeXC34JROVKO9so8UelbTw3FjfSDQo9aUZbEIiKC2gsA==
X-Received: by 2002:aca:3dc5:: with SMTP id k188mr364901oia.108.1550098591354;
        Wed, 13 Feb 2019 14:56:31 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c132sm259494oia.41.2019.02.13.14.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:56:30 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:56:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: Add loongson-1 clock bindings
Message-ID: <20190213225630.GA19462@bogus>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
 <20190201063540.19636-1-jiaxun.yang@flygoat.com>
 <20190201063540.19636-4-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201063540.19636-4-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 14:35:40 +0800, Jiaxun Yang wrote:
> Loongson-1 is a series of MIPS MCUs.
> This patch add the clock bindings for loongson-1b and
> loongson-1c clock subsystem.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../bindings/clock/loongson1-clock.txt          | 14 ++++++++++++++
>  include/dt-bindings/clock/ls1b-clock.h          | 17 +++++++++++++++++
>  include/dt-bindings/clock/ls1c-clock.h          | 14 ++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/loongson1-clock.txt
>  create mode 100644 include/dt-bindings/clock/ls1b-clock.h
>  create mode 100644 include/dt-bindings/clock/ls1c-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
