Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1786C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547585880;
	bh=31XMqDyo8MmERVsvSeKwUxcYLkv0sPqeS3nCa6s7cAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2vKMGLmNiaYIJoQBO8xI1+Mrn3n7jmo68khfY2bJaUWoqncnEaRX5YPxjCo0w3+N8
	 RCDsgP+FJ9RgQYbJlXepW60OLRrpWdhW57mQm8B3n2gfrkH7wcwnwpztFcHtJ66smk
	 gkNQWM1u77Bt0b3qyRlUcquXTSxN9CmVCxYt1zfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbfAOU56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:57:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40861 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbfAOU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:57:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so3848388oth.7;
        Tue, 15 Jan 2019 12:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u6pLGx/0+vlD0wl7xUqGgJTpR0eVUVsQyd1A8iOPGJ0=;
        b=UnaxucC5ygWhWmLEsoEYaej4vFuPaxdXzVi8IqQorefin+eTodJkFg771vLLBnM2L1
         ObAxc3nB1jRXTcRy5q0EK4Ht5/lm8DcNph2ciGvAybrhMgqrE3+P9kcY1PoBnK9fbURB
         zzz0/m8ktZ0gXEWcyKB4vzHqCAiTtjpRFt3hYoa14qAZ3KWyYo69wn0B6TXncC8gdjZe
         hEF9tqOGsh8PNDQFjeh21Ler3zfqzvIylX5y6AR7SSD++o9JZXYZjZKMgCvAom9gMaV9
         nvI9jQrXt5c8GDd70g1DKr9FTKyz62B7alZ9lmwaE7Qv//DYWV4LMmsM+M+ZSf+2Z1yY
         dpqQ==
X-Gm-Message-State: AJcUukex9Pkoi2LCLvraW1ztGym7Bq7Lmec+12zCgDkhI+hjpanlo7Tx
        mfL9mdf1F8qIcOOfUWDDyA==
X-Google-Smtp-Source: ALg8bN4DnB1ZctWsoIpCgu7SPhAARg68Cr1r0PsowhlSBI5gqsjqHrsrJM5VAEbY7eR/hsxtYH0c9A==
X-Received: by 2002:a9d:641:: with SMTP id 59mr3203321otn.215.1547585877058;
        Tue, 15 Jan 2019 12:57:57 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id 62sm1906363otu.42.2019.01.15.12.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:57:56 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:57:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Message-ID: <20190115205755.GA4022@bogus>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> Add the DT binding documentation for Audio Mixer
> machine driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> new file mode 100644
> index 0000000..6ac1230
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> @@ -0,0 +1,24 @@
> +NXP Audio Mixer (AUDMIX) machine driver.
> +
> +Required properties:
> +===================================
> +  - compatible		: Compatible list, contains "fsl,imx-audmix"
> +
> +  - model		: Short audio card description.
> +
> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.
> +
> +  - audmix-controller	: Must contain the phandle to the AUDMIX device node.

I don't think you need 2 nodes for this as this one is just a virtual 
device. Just add the dais property to the audmix node.

Rob
