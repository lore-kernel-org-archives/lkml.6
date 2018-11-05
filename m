Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE121C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808572085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808572085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbeKFHbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:31:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43324 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:31:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id k9so9553097otl.10;
        Mon, 05 Nov 2018 14:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIkSDe1E0IxE+LPaMufftU+y5+pyuk3cLT1ctaYn4G8=;
        b=ied9sgDcIDYZYHMSiuerSuSsjpxlf2hHP/p/9vwHxq3HCK4+2klUOPOSzlC9sXgO4L
         AGPSlLLCJWDavzMspnlrWUy91w0tPx8JbVxjJPjrqv3YmzUFK8na/DjBl1xZ/T+M/DHD
         fsxVqRNHUE6ApbN/2x6t08xF8tLaC2UJZDf17v84xCOg9p5+UaqE5wBqJLJ7n+fh+mCb
         2LggPfVDCYdVgZ3cbKzvSNRRBG1k4I2wOY+w4LmrwQF2qjtTdfPEpyy0M9DAl53GqUAS
         UkQayGWNNRE5D+wQfGQW/OntG/NLnhMSvPlRi1F8+2Am0j4HWRO7KLyGrUH1GCzcKEWa
         al9A==
X-Gm-Message-State: AGRZ1gI5rRt1BEfqvemVvdWTZgIlHUZi/O/oOtVnDuRq9TWm8kPmC75t
        Fipfz78WX7RwdYWex7kjvQ==
X-Google-Smtp-Source: AJdET5c6xkuXckf0NSO3isiPAu3j7vm0w+KmohWKe/qHAiT6s6NUhBrJ+C6QrNZ8HckoF7Ob0wGcOg==
X-Received: by 2002:a9d:5c88:: with SMTP id a8mr3831856oti.251.1541455751050;
        Mon, 05 Nov 2018 14:09:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a64-v6sm10669466oif.56.2018.11.05.14.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:09:10 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:09:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 4/7] dt-bindings: Add bindings for the LeMaker
 BL035-RGB-002 LCD panel
Message-ID: <20181105220909.GA24283@bogus>
References: <20181101200045.6078-1-contact@paulk.fr>
 <20181101200045.6078-5-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101200045.6078-5-contact@paulk.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 09:00:42PM +0100, Paul Kocialkowski wrote:
> This adds the device-tree bindings for the LeMaker BL035-RGB-002 3.5"
> QVGA TFT LCD panel, compatible with simple-panel.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../bindings/display/panel/lemaker,bl035-rgb-002.txt       | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> new file mode 100644
> index 000000000000..22cff3eb1b8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> @@ -0,0 +1,7 @@
> +LeMaker BL035-RGB-002 3.5" QVGA TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "lemaker,bl035-rgb-002"

No power supply or backlight? You need to enumerate exactly which 
properties you are using.

> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 2.19.1
> 
