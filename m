Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E84BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00492077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550857092;
	bh=pwPD0KHKTfSFrrVfIeyfLFe7gPROnXEvKM7sLdJai+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9nxUf8abHkKy1JLSXrtE+sYg1oiaDStM6JufKqlzEEC1WhlDPH14PCwz75yM9Ica
	 kyaDHjbKP8JHqLXH6IBQef2fn54E8s6FdCkhjyQvTl0HdxsOqEn1NgwsdmtfPShCrP
	 a2oTnIori3VY27UEP8+MmuppNH5h19ibEE5aHVyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfBVRiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:38:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42442 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBVRiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:38:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id s16so2324073oih.9;
        Fri, 22 Feb 2019 09:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pGKE0LTWlBkzciALxi/Hk8127jnmY/o2lVvGMar+8NY=;
        b=Ks2NbaCLGHoq9mgAwyV/woOLaWfpvo+DlDMy4F9okGA3MQ5EfSwPnW9dLh9e2BIKlO
         uBzWp9aOdyNgkThm2KE0YHPLyYUdPmcOC9McplWA21tQizTd1Goocrq5CxTpCE4ZHQgt
         Y+a0OspLD5MTKhZ0O2thUPqa7R2N8KyRzqXlMdJjwi7wAKUYAWHwnxhkd6/wUls/iuzG
         orVfHp9Ngc/PD+1I9cGPhlZTCAmjUgbD8xsO8y89+BNPAAIoXcYSHPz0Jwlq3dXFSvOX
         Yf9o+j9niO+6A17gzsf+mqJtvl+QMVefSc1ZjW5sJ1V9KuV1G6lF5Bq1w+KPmgiRHfTh
         aMZg==
X-Gm-Message-State: AHQUAuZxsBaL/sia7Ijw/ODHEa0d4Jfyf4PY8OQkZ08qFl/hg6Dtkka0
        WWb0CUEIpExrccY9HY8pAQ==
X-Google-Smtp-Source: AHgI3IbxrNqBwXIiWfYgZSy8/4/qUGZjt2ODmIusngYJDU8IwG2XO1tYEIpIAQbz3y1KXAW/Q4FaMA==
X-Received: by 2002:a54:4613:: with SMTP id p19mr3313954oip.88.1550857089030;
        Fri, 22 Feb 2019 09:38:09 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e89sm1073290otb.30.2019.02.22.09.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:38:08 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:38:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V4 2/4] dt-bindings: irq: imx-irqsteer: add multi output
  interrupts support
Message-ID: <20190222173807.GA3023@bogus>
References: <1550662447-8565-1-git-send-email-aisheng.dong@nxp.com>
 <1550662447-8565-3-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550662447-8565-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 11:40:43 +0000, Aisheng Dong wrote:
> One irqsteer channel can support up to 8 output interrupts.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3->v4:
>  * no changes
> v2->v3:
>  * fix a typo
> v1->v2:
>  * remove one unnecessary note.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
