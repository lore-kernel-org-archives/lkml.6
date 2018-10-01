Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74BD2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="YXjlDB9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74BD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJATqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:46:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39180 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJATqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:46:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id c25-v6so13815008qtp.6;
        Mon, 01 Oct 2018 06:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sN6qgHQbBHrUmuDtCtmsZllNbHpjUOLdVMSTJazRv0=;
        b=YXjlDB9j00p+XC53RfC0wtBOpHR6BBQPqMVL22m7SF/E+FhVWLUrmZK2AXwZ9F0gc5
         1wjFRSFyuwlLjCzVwlcXEL7LKxmQeWHFuCdo6UC9gI7j+K3QBHX1S+sjo9GjNOxjNfUq
         3lfCDI3aTiGv1CC3PQ8LklzvGc4kZ3WgUH8bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sN6qgHQbBHrUmuDtCtmsZllNbHpjUOLdVMSTJazRv0=;
        b=draUTZGWW6MxEnhBhA6LZj1+vB7PlcrA8UIJxb+peMPnALG4xIVTqOfgtSuw/yHGIP
         FHS1OPzU8A9iIJmmBGx3OeJL2xKu7gihn26Plk+fQFPpn1YL6JvGUvpWC8SluPfnVRhz
         KJ1G73Htajx74GyjrdclD91d+jdeOkPL9+6gMeSQHr1/J9hFysBCD4GNjzqGEq05nYMp
         w61BLqI1PalpxFwWaGWzozIi44MPGnKpEbaCZPP4i9aa5UjldfMoLudaUy/jlflVdDD0
         YTtEhWs5jUWuh9rbYw2cbAmofbzUL7HZSSRq3Lc+J6RYADbYxBtWnTS5zk0NCAnF1/PM
         3YHQ==
X-Gm-Message-State: ABuFfoiaKNd3AsoxTofVXaqv71I8Z5doZeqEimTpLNqwU9t8VQL2lb5L
        kMy/tCecFX3aeXiKHfUOkljCOqhIL3txHn9HwzY=
X-Google-Smtp-Source: ACcGV609VmPJ/ZxzT0dE3d/BV/hydIk9oIPLdmV+HyxH54b8H5QYm1dys+mzh45S6Zh5BRDsb0pWsIYjVFYfM/unIbE=
X-Received: by 2002:aed:38c7:: with SMTP id k65-v6mr8728774qte.84.1538399331284;
 Mon, 01 Oct 2018 06:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <1537903629-14003-1-git-send-email-eajames@linux.ibm.com> <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1537903629-14003-2-git-send-email-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 1 Oct 2018 15:08:38 +0200
Message-ID: <CACPK8Xd0MhrFQqiM=u-Rv5u7RJRo5R-pAejH4dmeTrYSWE0AZA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: media: Add Aspeed Video Engine
 binding documentation
To:     eajames@linux.ibm.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        mchehab@kernel.org, hverkuil@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 at 21:27, Eddie James <eajames@linux.ibm.com> wrote:
>
> Document the bindings.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>
> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
> new file mode 100644
> index 0000000..f1af528
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
> @@ -0,0 +1,26 @@
> +* Device tree bindings for Aspeed Video Engine
> +
> +The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
> +capture and compress video data from digital or analog sources.
> +
> +Required properties:
> + - compatible:         "aspeed,ast2400-video-engine" or
> +                       "aspeed,ast2500-video-engine"
> + - reg:                        contains the offset and length of the VE memory region
> + - clocks:             clock specifiers for the syscon clocks associated with
> +                       the VE (ordering must match the clock-names property)
> + - clock-names:                "vclk" and "eclk"
> + - resets:             reset specifier for the syscon reset associaated with

associated

> +                       the VE
> + - interrupts:         the interrupt associated with the VE on this platform
> +
> +Example:
> +
> +video-engine@1e700000 {
> +    compatible = "aspeed,ast2500-video-engine";
> +    reg = <0x1e700000 0x20000>;
> +    clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
> +    clock-names = "vclk", "eclk";

Did you end up sending the clock patches out?

Cheers,

Joel

> +    resets = <&syscon ASPEED_RESET_VIDEO>;
> +    interrupts = <7>;
> +};
> --
> 1.8.3.1
>
