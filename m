Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B96C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD5E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD5E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbeFTSZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:25:28 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41256 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:25:15 -0400
Received: by mail-yw0-f193.google.com with SMTP id s201-v6so186307ywg.8;
        Wed, 20 Jun 2018 11:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uW3wf5dX+fWl7pxfY7quoO47GHNLAj96CEMrj0VYu1A=;
        b=Cu+TitI/NoqK0JwifNfRLZNpTCW7sq9+tZtWEWkPjrPlFaWEfB75BMV3PXofGl/g5b
         OxLhl+/UjTKDWTXvGax4T31MRz30xMnN3IWPmHt/59FIdh3xQ8it3/CtFvkzzLs/r6dR
         mK6O84DIjf2PCUpBQ481sFCqGcOS2kV4ToJmNDoBZAc0NDXq7hUM17c4hq+lanu0KY7c
         DT5oTNLjk+CtvPzPFZ8lIIugEiIpKEJ/gffC84hmIxcB/TY/6Ugse5cq3ub9D9vM6QVi
         jJinOBvU6Dmz+B+5SagS/J9PH7OJgJB0bGNuEDwB467web46cxAxX6Z59W+uXxXi4Rma
         moUA==
X-Gm-Message-State: APt69E1RWdUui5H+frF8+4afYwXVswwDJfkc3x7dGoBO/Caw5UJF7NWz
        ufZipuaw82+0eWhaCT5DQA==
X-Google-Smtp-Source: ADUXVKIUuyEqVFgXloUUTQ7tcdta0qn/VFkuHsnm48hrJM9fmOvdPJst7YO6eJ9AF/LYXONfCZr+tg==
X-Received: by 2002:a81:ee0d:: with SMTP id l13-v6mr10154520ywm.166.1529519114386;
        Wed, 20 Jun 2018 11:25:14 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1000316yws.24.2018.06.20.11.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:25:13 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:25:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maciej Purski <m.purski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: display: add DT bindings for BOE
 HV070WSA-100 panel
Message-ID: <20180620182512.GA14562@rob-hp-laptop>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619082000eucas1p1c5cc2b526583c3fd5e9fc13656ed4858@eucas1p1.samsung.com>
 <1529396370-18761-5-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529396370-18761-5-git-send-email-m.purski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:19:25AM +0200, Maciej Purski wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
> 
> The patch adds bindings to BOE HV070-WSA WSVGA panel.
> Bindings are compatible with simple panel bindings.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  .../bindings/display/panel/boe,hv070wsa-100.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> new file mode 100644
> index 0000000..9e8eea8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
> @@ -0,0 +1,28 @@
> +BOE HV070WSA-100 7.01" WSVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "boe,hv070wsa-100"
> +- power-supply: regulator to provide the VCC supply voltage (3.3 volts)
> +- enable-gpio: GPIO pin to enable and disable panel (active high)

enable-gpios

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

