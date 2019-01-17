Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB109C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B639B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="jndLnjtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfAQLG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:06:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37447 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfAQLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:06:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so7466832lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R5rlBaaxUUyySP7OfPdGYh4yQGBBV3PMnVzao62V3fQ=;
        b=jndLnjtgbFgGr/ihG+/Ifykc5QOMVV54MSp3ov911NS37p5w3W0Z8dRWQg8tPHv4SQ
         8NktgLPepB2X3yUwURtaW/8H5elgmuNTZpJXkFK0gDTmoOlxJOpZC/fAoY6CXZbAS5Kt
         BDVGAj69UJM2TKTqJDnzmitftaJfoxIQTmHL2Txh/fRfL9PdVenq5PvtPU670tZMqRg5
         c9vjK5h6f/3b/rkzJfb+TUv5I1r3Z01cZp1zmDsAfWvAd7Q4Fuwvrax2j/Vzcw5oCIPa
         OL1OvtvwiEG6JcVAasScLPqVoFXtbD+6LTbxwnrSohTFTFAfFRyjMJcR0SllcmFxKjnr
         nXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R5rlBaaxUUyySP7OfPdGYh4yQGBBV3PMnVzao62V3fQ=;
        b=NFmS8ZzA2GyANo6fZAaXBPz1OZ3RNEwOevJnjpQoP2ZZq00N1evXv+G1qsJld3Lgg9
         lyyHsuAGiwwfjAB66vXjPcJRI07bFP1mUGpH47ATn+vBNONYfX9G9Y20WmnUXYxMCJh6
         IQxciTq6bVRTGgRfnUWPtONt9IzcFUJEjDsdGzDRcGQZq6un+GmOlNo04WGmA3LO5vuu
         qIgpa6pjAzN8jEflPc3qZyHNvcjJrUDzGbmdis+rGZjFYmzY6GN6NtHZ2PAZsl5EgQCy
         wK8Hnv3pnWU+P+rJK6iV/12W9aFEHOfZuulgE9CBLDbXuOUufvMln8DIcAPSfyFumPfa
         WBkA==
X-Gm-Message-State: AJcUukeNRMj8MXEze+EXtuQHDaDW5JN2R32Z5ZnRJRGeggIvrZ35wRcD
        vIEk2Y+gjtiK1NTAePxtQVH4/A==
X-Google-Smtp-Source: ALg8bN6Uq2pO4WPxsF2zgnBv5Iwr9H5HJhQ9w/roWO9IdGXuKj/+uNTQZomvXMvJpVZfQ5xd21wCOA==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr9769670lfm.81.1547723184345;
        Thu, 17 Jan 2019 03:06:24 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.120])
        by smtp.gmail.com with ESMTPSA id t22sm249592lfb.0.2019.01.17.03.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 03:06:23 -0800 (PST)
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
To:     min.guo@mediatek.com, Bin Liu <b-liu@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
References: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
 <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <15fb900e-c665-8ebd-b2cc-54f47cc35734@cogentembedded.com>
Date:   Thu, 17 Jan 2019 14:06:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1547709348-17506-2-git-send-email-min.guo@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 01/17/2019 10:15 AM, min.guo@mediatek.com wrote:

> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..3e3f671
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,43 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +   the registers

   I'd indent it more to align with "specifies", else it looks weird.

> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"
> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +   refer to usb/generic.txt

  Same here...

> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +   each entry in clock-names

   Here...

> + - clock-names     : must contain "main", "mcu", "univpll"
> +   for clocks of controller

  And here.

> +
> +Optional properties:
> + - extcon : external connector for VBUS and IDPIN changes detection,

   ID pin, maybe?

> +   needed when supports dual-role mode.
> + - vbus-supply : reference to the VBUS regulator, needed when supports
> +   dual-role mode.
> + - power-domains   : a phandle to USB power domain node to control USB's
> +   MTCMOS
[...]

MBR, Sergei
