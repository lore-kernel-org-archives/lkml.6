Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B342EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AC020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AC020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbeGaWiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:38:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51813 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeGaWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:38:25 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so6578759itf.1;
        Tue, 31 Jul 2018 13:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrgpsJauJdW4grJ6LrlYoqYUtCEcOOBGs9Xg0pFrtUA=;
        b=kG6OLgQ/BsLS/qYxG0BUxV9HIRPEVKC7yuGLa/W/Hi0mp8gok97rQZQywzEMGxCmJi
         UAQOcwbvNeRL7IRTfkZ5Ruq5ONhe3xunqMTYBCvV2jjrjXyNfzc4l/Ywl95Za8JPaeZE
         XFNlx+6oja8mdDXZIizwtbVMdNuLKd9aSQGe4Rqib+rGeQ1zW+OfDGrvr4ns3SaWELhZ
         Un/hIhBnNH1k9QnhWnYkFuWfHioga0cxV8Ea+2KU1j5goeZ7S3cTFRBwfADQlpQ2kG6y
         KN8umBrMYIoFhX1z2c319lORrbGnBneRzB1OiijrsMPWbarNKFd8y5Cz+Nz+9wOYmOWm
         Mg8Q==
X-Gm-Message-State: AOUpUlEXCJizgwpFkWxau54vSqi3XuXeHLwgNqdsdY99j3f7u51xmiWc
        A9Mwfu1VodNZ9Xq+UFnO2NIN5Y0=
X-Google-Smtp-Source: AAOMgpfKE9JoLr4lkeJoBLa+EUUHB/+HgYV5XGDdXUsfhCVnGZoFKuMYvgQcvnhFvQYfbwn+ivze5A==
X-Received: by 2002:a24:14d8:: with SMTP id 207-v6mr1198213itg.41.1533070575681;
        Tue, 31 Jul 2018 13:56:15 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 203-v6sm1977328itv.32.2018.07.31.13.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:56:15 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:56:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/5] dt-binding: dwmac-sun8i: add H6 compatible string
 (w/ A64 fallback)
Message-ID: <20180731205614.GA25776@rob-hp-laptop>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722053955.25266-2-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 01:39:51PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
> in A64.
> 
> Add a compatible string for it with A64 fallback compatible string, in
> this case the A64 driver can be used.
> 
> The "internal" PHY is not internal from the perspective of the H6 main
> die, instead it's on the co-packaged AC200 chip, and connected to the
> main die with RMII at the in-package Port A PIO bank. So from the SoC
> driver side it needs no special treatment.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
