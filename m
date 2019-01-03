Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EDAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB37A2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546550371;
	bh=osmW3A3RVkLbcCg7x0jcFG+8KFVrMDmLZ3GgRBIUowg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TiKt3KH+Mj/VGZzkL65UOvnX1xMLofpao8dZpPRTHLpoU4LL6vOy8RtuIUOX7bB9k
	 kDxxoYSDUzWaXE3AFtUkW2Vac4zHfmSIYj4kKuwRjMmICe2/FUGQoQydxNgnRiDLHX
	 /6/Tyu86Ui5VGpsZpmNHWykyxu+FcuRpxhGl2nLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfACVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:19:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32772 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfACVTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:19:30 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so42137039itk.0;
        Thu, 03 Jan 2019 13:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YoxD5EZeVYASwrmoudzMU0+gZwFYA+BTgpdoSi54dfw=;
        b=WCK645fTfCq6PDQWJOPX72TzIOhheU6dYGJBxKB5hRtNcP5E2BZg5tWiXajyxKpCj+
         /frny/C1RiNaYaQKqU+HhS/E1EEgkKbF0FiGvYpPj25e9J8mnFsPDQBllyCr/90zIMm3
         aW0QX+Iz6JfLKz+w4S6Q+ojiMsSyF/IirQMJVm1kCJ+DHGZlpLBfHlgsOWbaPvsH2BQ+
         ByDJG3BO2/PInipYfXerXI41YMLQlMNm7gy7eL9V52MjVsiLYxiMSr0+pcj16oAXwTBm
         dNv6H7N75VtvT+rK8mKhe9OoTMYVMKhh83MB6VjwkOHhmrwezkhXu5XePWuR1RodTRDx
         E9LQ==
X-Gm-Message-State: AA+aEWb3sJq9HX2tAjTEkrKZPSf83yLZBFS1MiWrgyjzPYkyJy0v2bDa
        F15NA3wSVRshUECB1liP3A==
X-Google-Smtp-Source: AFSGD/Wd2MaHzdxJWHSS9bfBHsaDJ6oyWXZFtVE2PnUEaPsYDnvVZH3fF7Cg7eikgvG1v2rxxJA5cg==
X-Received: by 2002:a24:784a:: with SMTP id p71mr35945684itc.158.1546550368955;
        Thu, 03 Jan 2019 13:19:28 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id e10sm24833968ioa.65.2019.01.03.13.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:19:28 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:19:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,1/5] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190103211926.GA7622@bogus>
References: <20181226075330.82462-1-pihsun@chromium.org>
 <20181226075330.82462-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226075330.82462-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 03:53:09PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../devicetree/bindings/remoteproc/mtk,scp.txt         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> new file mode 100644
> index 0000000000000..b07e5c4ca9af1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> @@ -0,0 +1,9 @@
> +Mediatek SCP Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +Mediatek SoCs.
> +
> +Required properties:
> +- compatible		Should be "mediatek,mt8183-scp"
> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)

Seems like this is going to be incomplete considering this used for the 
CrOS EC.

Rob
