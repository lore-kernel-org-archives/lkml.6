Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB8C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889852084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544582382;
	bh=YVZzUFCZJbohUj0QD5V3/KTPks2WxGzR5fciMex7g00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OCbahh9ZdPdGipu9br/0RsoyiHiY4vFN1FpgJ4UTm00OdsRjK+5I7PMQuQ/7JrvyN
	 V21LExSGxAuDLpwz8CD7qjca9Q1+5oskE6sa05f0+VxfF5ly2a3x7d+zK3ROthKOTq
	 smT80cmE+AbHaeN7BjVLypnuyFCFjXmUa8jDZveE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889852084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLLCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:39:41 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38980 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:39:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so13840848oia.6;
        Tue, 11 Dec 2018 18:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYsT2CcvPELrCvNdzqBEsZtEOnyoWcx+SF0FJ3mPoU8=;
        b=ZTAk2LD40BoMfOn7LXOwWV5keAFJzu1rUQPF2mPsLrt/wbaZkyk1xH4Op2zEWMM4zx
         l3GkAtWcrajZXTNlkuCeVZRTydJ1f349l1dEmFsuy+zxsIX6ZDNu6Tt1jdOKe6bhEhaY
         f0f2FJeHsYZA880GcCXa8n1FJI7+xR26aClYb0BYLicEB691gA4FGvbRGj8txKYAKI7D
         YGDqSqJzriy3wrvhWm9ujQahSkLhxLE4uGG8wrx0gMvy9p49CkDus0yw9kG4n9CU8MTd
         +0KgpePoX2jnOPYWCt7fxYGPnV2diyHh6POneVB7ddm/l1Fu5nbnC/fX8uQQnbsxE5lc
         F1Wg==
X-Gm-Message-State: AA+aEWbs+jB/L2fK4QaAHEnXd5HofbSZmPG3gidB15JPhYpENPToMYuO
        grEU24aZzVDVkNLaNsp+xBk4aNU=
X-Google-Smtp-Source: AFSGD/XH6v1k/OYe1YZot50G41xYgJa1IJO4C6AP1FbxmywFdTT4I69lDj2EHcONcRvaD/94gtEkbg==
X-Received: by 2002:aca:5d57:: with SMTP id r84mr222079oib.243.1544582379374;
        Tue, 11 Dec 2018 18:39:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm11440771otj.2.2018.12.11.18.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:39:38 -0800 (PST)
Date:   Tue, 11 Dec 2018 20:39:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: mrvl: amend Browstone compatible string
Message-ID: <20181212023938.GA15888@bogus>
References: <20181202114008.2861-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202114008.2861-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 12:40:08PM +0100, Lubomir Rintel wrote:
> The Brownstone board is compatible with "mrvl,mmp2". The actual DTS
> already contains the string -- add it to the binding doc as well.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob

