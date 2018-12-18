Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC45C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C22A21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151966;
	bh=hMr0MJtdThV0P1MbAGx1ezoFFcekGMtnzQFtRmbUHB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnyQ2W7HIhAdl69kzh83CuRrC+nfpdQHDUAJOhhHFgKkykJx7ODrVMVDF8DtSPtbf
	 AIm3u7DMiaQ/doh6DIxC9re0Vfxi7Khej/eIQgELpRQ6qP3xboR0v/7i7Q+RYG/s3g
	 q8DSOMW8I3gnoSGdYLB41CNgnc/KiBSOnpul+COQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeLRQwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:52:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34198 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLRQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:52:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so2521261oig.1;
        Tue, 18 Dec 2018 08:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C25xjk4Ep75w0ECg//k1t7iuMcnantPZudd6ZQLjdmI=;
        b=J4zPbQsOQr8HtF/YCDaqebJGlaGOL8qjWolu9FKmEuKvisL3lRP1fLYjNfZbWSUWFe
         1E2LFfaqEJg5II0+JnnitEqbUuOeY8j0yjgCtXHSHtlUmyHMZ3QDRlhcyeiiBJ2IYqyQ
         qVoEw0dfuRIYKPxYyviEgDVClY7rUIDRr/yERTlFk4/huIRJBK6CaLxA90YsUH/HF7oV
         VHjmiUM9avAE14Trpjyjt8rr7RB2etFAPoFTTGcIENtjznX+jX14BPF9YUfvixH7oQ+A
         Tx+tSLZvNNaKC7tmxwZaH+M3oT2NU1dBq49o+g4m3hp5qHV5zw2HFOOlJcJUerWHjwdE
         P0WQ==
X-Gm-Message-State: AA+aEWaCs0nUmvvA1Ni+k/nEbbPTCRZ4xdgXOZwmoVyjbF5X6k+uG8a/
        /ms/cS4HvCc4heqG/XHQ0w==
X-Google-Smtp-Source: AFSGD/Uh3HN94xMBGL4GQAXU0hZTMeRFoIbZr3dv3P6yyLpBhQs+AN3hl052jgqfM7UVlLSdhLs7vQ==
X-Received: by 2002:aca:308f:: with SMTP id w137mr8650576oiw.49.1545151963654;
        Tue, 18 Dec 2018 08:52:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w108sm8658120otb.6.2018.12.18.08.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 08:52:42 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:52:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        stefan.wahren@i2se.com, eric@anholt.net, agraf@suse.de,
        afaerber@suse.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: Add Raspberry Pi Touchscreen
Message-ID: <20181218165242.GA2809@bogus>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
 <20181211112408.9524-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211112408.9524-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 12:23:53 +0100, Nicolas Saenz Julienne wrote:
> Adds device tree documentation for Raspberry Pi's official 7"
> touchscreen.
> 
> This binding is meant to be used as an overlay.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
