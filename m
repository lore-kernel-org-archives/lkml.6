Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CBAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BF721905
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIfXcROn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbeLUCY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:24:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34419 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732301AbeLUCY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:24:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so1836556pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X6F7WHewRmSB+0zYUOGks/Qs3AJ8DVric08tIiEoe54=;
        b=XIfXcROn0Jt/yJJzX9jVnEen3RYkTNPcn16h3neo5cCez7uqraJz8zvNNigm6nsPkt
         6Ee4ZNrmKaTOad12Il5x63wG6qgMfvzRXq4Z/uO8pSFSaibrWXrbsu0LtClYvsgZg67L
         Oy0hGOIwViH6FlU6+BtF23mqzl1hSI7W5GBSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X6F7WHewRmSB+0zYUOGks/Qs3AJ8DVric08tIiEoe54=;
        b=pLLObxLLbzupZclLNhZnFflJyfpHOGSgqInHKuz4ZXpH7d5LptON3iHM/AjQVZw1BH
         RyRrG+K13o1xd49HlZMFlbwwOLfLXgZHw6TVN0rUHhOzjJPfuCmooQUq1DQx2fCPCLh4
         aFh1HwYb/xagl9ypSwIeWFxhyLpkRb0vPV1clcRyvyJIKqdVYuBUfs0PurV9AZQ+5ccK
         erhYLxG2fMhDp7ePiySuDNzTOC2t/kiGiIkpX9OVp5fkc0kx9bjTmq1m0Vr0KuDvnEaL
         ZCGLM4Vz+Q5zRBMQlpH3RCyQUthIevkd7OgDfnCcm3jpcMBtsNg5fj/rSPNBVboi916o
         9DGQ==
X-Gm-Message-State: AJcUukdL8dq4M7jjxBVuW+w3hJb+Vd2vJdnEy14dXrxBdPVtDy9lwnI8
        tVRSVIDuQ0QlkCDxYp3KuAbu
X-Google-Smtp-Source: ALg8bN6fXi2DBsVSwHbHDjv5g5zYgUgkZWuBwJ4lq0k57Z1U7gpLGUQSpyH2ClLEwesWHgkL/fx5hQ==
X-Received: by 2002:a63:4819:: with SMTP id v25mr631328pga.308.1545359095690;
        Thu, 20 Dec 2018 18:24:55 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:810:d868:55e9:25e8:dbda:255b])
        by smtp.gmail.com with ESMTPSA id l5sm23272380pgp.82.2018.12.20.18.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 18:24:54 -0800 (PST)
Date:   Fri, 21 Dec 2018 07:54:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Message-ID: <20181221022444.GA3233@Mani-XPS-13-9360>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
 <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
 <20181220171244.GA22403@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220171244.GA22403@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Dec 20, 2018 at 11:12:44AM -0600, Rob Herring wrote:
> On Fri, Dec 07, 2018 at 11:21:49PM +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> > similar to HI3660 SoC with almost same IPs. Only major difference interms
> 
> s/interms/in terms/
> 

Ack.

> > of UFS is the PHY. HI3670 has 10nm PHY.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > index a48c44817367..a327c1e24365 100644
> > --- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > +++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
> > @@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
> >  Required properties:
> >  - compatible        : compatible list, contains one of the following -
> >  					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
> > -					host controller present on Hi36xx chipset.
> > +					host controller present on Hi3660 chipset.
> > +					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
> > +					host controller present on Hi3670 chipset.
> 
> From the description, sounds like having "hisilicon,hi3660-ufs" as a 
> fallback would be appropriate?
> 

I don't think so. As per my understanding, fallback should be only used
when it can make the device functional. But in this case,
"hisilicon,hi3660-ufs" will not make the HI3670 UFS functional. So, I
will stick to "hisilicon,hi3670-ufs" only.

> >  - reg               : should contain UFS register address space & UFS SYS CTRL register address,
> >  - interrupt-parent  : interrupt device
> 
> Don't document interrupt-parent. It is implied.
> 

Ack.

Thanks,
Mani

> >  - interrupts        : interrupt number
> > -- 
> > 2.17.1
> > 
