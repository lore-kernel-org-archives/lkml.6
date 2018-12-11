Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783A92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544564510;
	bh=xHi4lpOO3lC90Oo294ENJ/pMFYFPk7Ln0QsGmEFrxgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RvbvD/Q47G+fbhJYfNqfKQeNZVdh/OPQGklSd4BYRjsaeTsub3aBA3wrJ3fWtMeTJ
	 J8wznAmv8O7xf12kXDnKAIvrsNtT0MpmqtM1uXPDF6bKmMJ4teuNYaV73ctWZ7vE8R
	 6IksdMdyZX9/6wOM2syQVUw5sV4JC/kypl4zxb4Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLKVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:41:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40340 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeLKVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:41:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so13309165oie.7;
        Tue, 11 Dec 2018 13:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rx0UAdm3LWDNBOSZ1NleTjSLknBqsmE0E4kqeEqaVWw=;
        b=WvG6tx7jGJhkuA9dk/sSz11Nii9+tgNBAagp6X/X5WaCk2aBZRhgPnGFd7FJMS0Mmt
         +W8R/z6AiD0dI0LxumoyQJlBBn2xvxGY4ct4aNu6mtk5XNEz5HNEo/WWzGAuZslOXfAF
         Wr4jrTra2RgcmB113/8vE7wPzn4NiMEt9roAjV0uda3oKCHBkC4SrN6EKwCzz9u8YP3C
         trZVyFUDQ+vODkb6vxcIw7nDjcVb5AZLzYm+ZT2L0tboWqaiE0M8BIp01h9wGXoSvaY8
         O5ErMdsxmJwYNAA+KHPhKrlhGFykaFQqmWFafEpawZOZeWcLeWcW0gB4fHPvHZ0eM2I0
         /TOw==
X-Gm-Message-State: AA+aEWZdi6O8iZrf83BPRsBbZilCcCeaXuJVjgGk3Is6xxt/zs8alEWb
        q3Zazqb4GJURgX7G61hhkA==
X-Google-Smtp-Source: AFSGD/UD30k7690eyRkXINKR9Xq/X5EO1G1f74CW+cXfUhY0Sw/ZUM0RpaXWF2+mq56rD9PXtszubA==
X-Received: by 2002:aca:1716:: with SMTP id j22mr2128633oii.19.1544564508235;
        Tue, 11 Dec 2018 13:41:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h25sm7148298otj.27.2018.12.11.13.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:41:47 -0800 (PST)
Date:   Tue, 11 Dec 2018 15:41:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     zoro <long17.cool@163.com>
Cc:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: define vendor prefix for whwave, Inc.
Message-ID: <20181211214147.GA22533@bogus>
References: <1542968084-3982-1-git-send-email-long17.cool@163.com>
 <20181211213708.GA15257@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211213708.GA15257@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:37:08PM -0600, Rob Herring wrote:
> On Fri, Nov 23, 2018 at 06:14:42PM +0800, zoro wrote:
> > Introduce vendor prefix for whwave, Inc.
> > for SD3078 rtc device.
> > 
> > Signed-off-by: zoro <long17.cool@163.com>
> 
> Need a full name.
> 
> > ---
> >  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 4b1a2a8..7d2e9b01 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -423,6 +423,7 @@ vot	Vision Optical Technology Co., Ltd.
> >  wd	Western Digital Corp.
> >  wetek	WeTek Electronics, limited.
> >  wexler	Wexler
> > +whwave	Shenzhen whwave Electronics crop
> 
> crop or Corp?

Or Inc as the subject and commit msg say?

> 
> >  wi2wi	Wi2Wi, Inc.
> >  winbond Winbond Electronics corp.
> >  winstar	Winstar Display Corp.
> > -- 
> > 1.7.9.5
> > 
> > 
