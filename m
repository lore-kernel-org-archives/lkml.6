Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD2C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97002148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545944965;
	bh=xV/Jk3cOlRR+s2/rxUFitc2AsZTrqa+i6SySG1cA548=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f9dhKBE1AO8onyFyb/L3NCf+v/XxNBk4WGGLKKZdrhgmPrfCjq17Ew5uB+Bmc5K3s
	 vIedRGriqq8ArzACao1HCtWLIngkJKOz3w9gI6M/MSr721nRJeuRbz+y1CF9xMchff
	 +9x5L8r0ItfPRC4HRjezhTOqPm7MQ9iOl4N1vhjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeL0VJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:09:24 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36239 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbeL0VJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:09:22 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so25112212itj.1;
        Thu, 27 Dec 2018 13:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=weg7pla2q9bSgFWHonLZvXPSCtSpISrecsa2XwV6AhA=;
        b=K6swmPofP0f8gJezRZWFl9zD7Y5qJrCHULE/K/4fkD3xJdv6c4aA1FG2TC7Eu4dZc+
         SlZHa4kBs70y5NvM6ABqFmq5sJRDvvF1vhwldlzULqubvfQnQN1f+RJHePe5DF3rdqE+
         50tyflfhINCGJBPSF5aocN7M706E1aG5m8NaxG0qbEBl2NyYnEH0sSeT53mAfabIxcX2
         C91GV53U9i+Eo3OH9OeWXQRM2Sp8gwZvk0zI9WsqP76TZyTLBZtpbYUzvydb+859VwEv
         KPUf08PuVrIvOc1X0okrSiu1WLXFM4ToKhpk9aHJ2hNiyuoFmw4dET9uKpEDcJ1B0vKW
         jZCg==
X-Gm-Message-State: AA+aEWak/wa3ZsuAwWs6R9yaxHoMf1/ZCSCsTq1gyTwemuHbHQ19u3uI
        PRpJyIix/8bZNpbRxR2ZfA==
X-Google-Smtp-Source: AFSGD/WU+k20KlzA2v6QC0yru2HBYF0Ru3P+/c2xqN31sS+ZHmlXqNdY1ZgaAMi9yly/8lt4l3J/hQ==
X-Received: by 2002:a24:f2c1:: with SMTP id j184mr15672381ith.35.1545944960950;
        Thu, 27 Dec 2018 13:09:20 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id x79sm13849465ita.34.2018.12.27.13.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:09:20 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:09:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: iio: accel: mma8452: add power
 supplies  property
Message-ID: <20181227210919.GA25796@bogus>
References: <1545555462-16121-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545555462-16121-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2018 09:02:27 +0000, Anson Huang wrote:
> The accelerometer's power supplies could be controllable on some
> platforms, add property "vdd/vddio" power supply to let device tree
> to pass phandles to the regulators to driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V5.
> ---
>  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
