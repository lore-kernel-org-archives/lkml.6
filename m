Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C4620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545082331;
	bh=aQcXsphE4I1ltd0Vk26s+R3Eu5iqDMFdWKSan87gZ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d7LkM2euYYESJJzsuQNEevgs8HOVQC+uhQhBHUg07d2mbxVLgiCtNtJ+E4NTrBZbN
	 WVjdzRfQJFW2FnDs6Jx0fYJlDjogbk1KvGU7sM+g2rOdXdKVGlgS/aVofQi2mkqNfO
	 OJkKFzxqgtv1+rolK9H8s8RYwq4xisT5c5Q4nqqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbeLQVcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:32:10 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33420 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389588AbeLQVcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:32:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so13675774otl.0;
        Mon, 17 Dec 2018 13:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dN+UJk5mZd9nLiMFvSDXADaV/w3LVk46gVuWPSmVOqw=;
        b=DTktADhTzfVNw8U5IBWpt//jDZpN4sf3uf7fR5TQ0/f+G7ce64LD3+NAg1rRFG+E9I
         agAkYYdG2o0l2zh12PP0oMv1gp3O3H1TFBpjnflS0f3vUoL0S0yt+jJggTkm1j6G5mpD
         7fvBpoGf0l0yX91HGNVFqtRPCJtT3cBQWLPDYgReHbjeNQch68km5RCBDudfhx581lBR
         GJmy4ybaJuFPe5HvuKDtOq38G0Nb7tctQCK8/Izq7/4suRR6Ln6na7JVR29iX+vmF2JS
         AIOomTB+/VZSb86plnLcAo10mxriwfBdtgvhifDX7cuTcwYHL2V4JR4rjyzHSUPTs5yu
         2zcg==
X-Gm-Message-State: AA+aEWaTA5PtDPCF9sBvMJ85CE7qI3OgSl+2uNMWTUiG/VuBCe8f8M4I
        3eCXcWdo+H3rj085qbhROw==
X-Google-Smtp-Source: AFSGD/WbKNyue7x0lnyBG9Lr9wtNnja3x0ZsroYOXTQwFNBlpYZrjAbJQrRccFNDVkwCFU/+Il+v5g==
X-Received: by 2002:a05:6830:1584:: with SMTP id i4mr9847661otr.116.1545082327400;
        Mon, 17 Dec 2018 13:32:07 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id h24sm6796482otq.11.2018.12.17.13.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:32:06 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:32:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: panel: Add Sitronix ST7701 panel
 documentation
Message-ID: <20181217213206.GA31758@bogus>
References: <20181211154358.25293-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211154358.25293-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 21:13:57 +0530, Jagan Teki wrote:
> Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel
> with inbuilt ST7701 chip.
> 
> The default regulator names in ST7701 chip is renamed in Techstar TS8550B
> so, add specific binding names for them.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v5:
> - found the chip from vendor, so added new chip binding
> - here is v4: https://patchwork.kernel.org/patch/10680333/
> 
>  .../display/panel/sitronix,st7701.txt         | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
