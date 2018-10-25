Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F58FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="J1yTflMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A6420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJZCkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:40:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39876 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeJZCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:40:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id g10-v6so10974418qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u0iJ2siYHZBnkMnzMv2PqSQAbuoyMCoidY+RK7NyJ+A=;
        b=J1yTflMgIW5NWba37CyB9vOBXa9q8qQSstfrVMwDYUD3lROeuXzmGZnf7u6b8+HM2V
         8Fu+QT2+ZoeA5gavfnucBHn5UvdXpukCH8qrX/YWG2/n6zTCm0qaRTC0o6eQF69hax8L
         +0QEYdnQXrcjP5Tiyp4C1XjASx6g616ancE25T7Nb1QrA1PGlM0n00PlE98Jhdc/w/JM
         zqrD08dTG9IWty9EFPXooVMjRw0QD1+Zfbp0K0GYxbrKXbxRdKYtWLptunS3B/b5QF0V
         uGzk+ROvMk1Xb4+Yhe44GYYCMNYohW14NcrqNg8m+BdmvU0ielC2gzgNM8uJ1ApNlNa5
         yGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u0iJ2siYHZBnkMnzMv2PqSQAbuoyMCoidY+RK7NyJ+A=;
        b=b3bQNdMTVUGBP3n8nfuAyo5WY4OngcD1fwShJx5jMCCqB2KZF567X0C2jb/JXxPq+y
         jV6ltWJK+MQH1mvMTSikPwdkeMmi1JGWIC8EPLobW0KPGqMKz/jESLf4EiX/LtyYHiyU
         aMl/YgOEhnLRyV0+Bd8oCK9mjm0bs7r8q7TZPAbKrEVqiORIaBwwTyu/OHs+gZK9EjC/
         Psq19YR0peqqFMdOWHRR9svmp5NNcR4RajCrdBZXbwoHsSP+nLeQe5/qQWlE9wMda+JH
         LJjokoJE5d0BX+CD/blwVK2SRlNcxpWXZp6ENFXK9WyESgUbkQM7T2jU9XxidvdJl4z7
         F7XQ==
X-Gm-Message-State: AGRZ1gID3vHKGYsAVzbbfoDdMDpOG/H8nLS9e6knE7zQTj19/pOWQ1xU
        muuhbd+KuNm1QAmiAzGB8sWi8g==
X-Google-Smtp-Source: AJdET5dn1XtINbR0sJUpAOhdyww28jHAJ2ROXuIgal4ujkTkmtJAmvJPbDChGosDfj4AlhGDCw4J1Q==
X-Received: by 2002:aed:3923:: with SMTP id l32-v6mr264095qte.378.1540490784064;
        Thu, 25 Oct 2018 11:06:24 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm4840829qkc.75.2018.10.25.11.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:06:23 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:06:22 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/6] dt-bindings: drm/panel: simple: Add no-hpd property
Message-ID: <20181025175118.GJ154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:34PM -0700, Douglas Anderson wrote:
> Some eDP panels that are designed to be always connected to a board
> use their HPD signal to signal that they've finished powering on and
> they're ready to be talked to.
> 
> However, for various reasons it's possible that the HPD signal from
> the panel isn't actually hooked up.  In the case where the HPD isn't
> hooked up you can look at the timing diagram on the panel datasheet
> and insert a delay for the maximum amount of time that the HPD might
> take to come up.
> 
> Let's add a property in the device tree for this concept.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
>  .../devicetree/bindings/display/panel/simple-panel.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index 45a457ad38f0..b2b872c710f2 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -11,6 +11,9 @@ Optional properties:
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
>  - enable-gpios: GPIO pin to enable or disable the panel
>  - backlight: phandle of the backlight device attached to the panel
> +- no-hpd: This panel is supposed to communicate that it's ready via HPD
> +  (hot plug detect) signal, but the signal isn't hooked up so we should
> +  hardcode the max delay from the panel spec when powering up the panel.
>  
>  Example:
>  
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
