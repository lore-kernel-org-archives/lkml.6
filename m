Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7C2206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547668274;
	bh=kjZTked0qxycYR+LPbpRuQ8Bsp85Xn7WbJ6O7Zd3zFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYBpR5iyALYn8AABlwMOZhtXx8RMz9hlNnr34Oskn/6c15VeMoJoy9ekhYxgcT0M8
	 I1WoEx0agFanFVujW5lhUE8aqaq7bV3HunRSGeg3UfCeWFhK/2a2J0NByp8QXLOAcx
	 rKsOfoRGUAb6nxdK9pw+SYvBss9+9gwEKpbcluZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfAPTvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:51:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35180 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:51:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so4240923oif.2;
        Wed, 16 Jan 2019 11:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DngJ7jogi0avKt4x+ouaPjIDEe94KLx/q2bEgFNIhUM=;
        b=Aqh+V3xRIXcGuw8ytXVcZYWV1c1fQeM3CZDhIkUijxEqY4oI2mHdT/xFvHYNMB78do
         Zv0gbiVRP3TmRacrWgDKKzNEcoAU8fz6U7n6SbWBkvONZpN1xQ+tcKIFiPSi303ug0mk
         4LtPQC+CDpZnk8YF2/iWJxlfFtOYIZ9A8qFOoaaejkXVtO3MNXPOwhH5DwNjEJ8iFcJ9
         0V+3C7mhlsZeAUBw9PUN1IPX7WSk2ay4cyiaD6suKji8RCQe7o1FlT1emLAUL1t1WgXI
         pdGMuNy1d75AEpTnHe3thjBqBc+7fYe3mn2UAADdAawGXypcohTaUljfgb4sLx08umil
         X4zg==
X-Gm-Message-State: AJcUukfK/mvXYDB4nhj0P9XLl2gvx93+OgQElkRZO1DWc/BZx4cGqIUP
        tTYJBEVOkEaS4701r9iODg==
X-Google-Smtp-Source: ALg8bN57KUzM8e5Y0c7wAdxdY24dbQwp2aanC4A1MMuxfgJT6vBOuYP2tzebO4jbDUEf87s7AB9tjQ==
X-Received: by 2002:aca:4e92:: with SMTP id c140mr5674048oib.97.1547668270713;
        Wed, 16 Jan 2019 11:51:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h16sm2916937otl.29.2019.01.16.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:51:09 -0800 (PST)
Date:   Wed, 16 Jan 2019 13:51:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Peter.Chen@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: ci-hdrc-usb2: add property
 power-active-high
Message-ID: <20190116195108.GA18240@bogus>
References: <20190116105103.28842-2-philipp.puschmann@emlix.com>
 <20190116111133.31326-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116111133.31326-1-philipp.puschmann@emlix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 12:11:32 +0100, Philipp Puschmann wrote:
> The i.MX6q/dl USB controller may drive the usb power line directly, but the
> polarity depends on the board. Reset state of the polarity is low-active so
> add this property to allow it to be high-active.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
> Changes in v3: add description
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
