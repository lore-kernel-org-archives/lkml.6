Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A5420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFCrgXQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A5420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIKUsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:48:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33671 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeIKUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:48:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so8145093wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sIne01WFO5xnZEEWzdA5Aldn0ENy8kSUCNoy5aGMhao=;
        b=BFCrgXQ4HA1Bt+7AjC96XEgqiaGaD9v8ERS/22Qf4E/cnQcnPfPbvBUnSn6ZXxaR+U
         K0j5NrJv6rs7DbqCl4tcUcpTntgYeshk6/t8z/qYY3oKES1BERv789OQKSIA9H/I+3aJ
         sH5glWXq31szKezNwo0WRy8I5UamxUPuVUSIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sIne01WFO5xnZEEWzdA5Aldn0ENy8kSUCNoy5aGMhao=;
        b=QiSPbojKJ2PAZSPX49/bCGqH+AWQBGcm7PdA174V2LelgExej+jM8tEDR4l2zYErh/
         8k2zZTzj0fFgWyjx4YlQ2Gk884Kp0c+k9PqhFi1hKfmCd/VYQmJ2wLPfgo5gb01OpE5e
         hl2dmg21fgD7XpdI2jZDZ2I+VRE2yd/6pwwj62P4sKA8nqloxJJ7gXZidMdCaQpydZZ8
         0tX/zossVVhFFqfeass9lF+K3k0dyb9C6/uwNGP5Qy7auBrxGKbwRah6uRFTVYTdns/y
         ZqJdock5u0lvaykDArPVh9OjQXL4gXFxc3k1rXiURak8iYgOXPbMR4oxjaCpuqpYJ9Cn
         m/SA==
X-Gm-Message-State: APzg51AeBsKaN4FSh75371ONJEB3Hr5grg1PF4Xi+vujBBFH73T34/51
        3OHzwK5FqFrkrUIu6eeoBPy1Hw==
X-Google-Smtp-Source: ANB0VdbXBT2w/vAeFOazE0TbUmhILwn1nBUN10ykzR0EmlRa4qY5GqTX7CY+GVLOk6BiuVX6EABDxg==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr1750660wmf.117.1536680892247;
        Tue, 11 Sep 2018 08:48:12 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id m68-v6sm2312187wmb.10.2018.09.11.08.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 08:48:11 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:48:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Message-ID: <20180911154809.GC4185@dell>
References: <20180425142922.128233-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425142922.128233-1-tony@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Tony Lindgren wrote:

> It currently only works if the parent bus uses "simple-bus". We
> currently try to probe children with non-existing compatible values.
> And we're missing .probe.
> 
> I noticed this while testing devices configured to probe using ti-sysc
> interconnect target module driver. For that we also may want to rebind
> the driver, so let's remove __init and __exit.
> 
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> This is OK to wait for v4.18 merge window as the related dts node has
> not yet been updated to probe via ti-sysc interconnect target driver.
> 
> ---
>  drivers/mfd/omap-usb-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
