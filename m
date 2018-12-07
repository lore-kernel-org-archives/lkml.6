Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985220882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544140868;
	bh=s9Bkqt0I0BDE0UbrhrcVZpIbvXLeu+w8VzrOv7UiwCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12wEvL5dbFCC29URCNdIlO6KDJU5zA/qlCaZ+D9NtUpnt/SQG519vARI9tonaMNtB
	 783difaZnTYti/01385YjfnI9uYcahK+NMkxBiighhJudRoTHYDowJwwcdJpB6gk7N
	 c2sH6hVxa4/bfXkSOcGar9xS1xMba9cuzmEkLHRc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4985220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLGABH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:01:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41723 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLGABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:01:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so1997549oii.8;
        Thu, 06 Dec 2018 16:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LwzlsoSLS1LyoW+7m+QbMfUGASe8IlJLO+Uqy7FOS14=;
        b=qPNBtvwzifOvBI5GfCZqN7KUe7kouUfLq8Js5Xc31l3QJIQu8fm/qSEcU7xw052rkl
         YNk3Rky1Nd/hc2y5hJrXkZaqn21Jp9+851hf4sOvkPrK4pwoQSp+OVqUktgcFnP+mHb1
         V4AlTXgmikv3zVGBgbIpzzFUQXX8B1MtoTmlEbjQgqQ+C6teFkyTEujRJTszaoVSYlZq
         EJEeyVcC6f4wn+AfyT5kUDV86G7Ac9CK8m7Pn+6wEjgih3KReSyWJo9BMDsDz/shbq8e
         JDQyX5qLjZXYNqxQj4K4pDFCr8KYGVO6i4Cqp5WWFsUzTuonOEtGXNvw6/RRaPyl0mRE
         R95A==
X-Gm-Message-State: AA+aEWaxdrlY/cFNQ9DD5YfNUcj/wFjYOZRRNxfRs28TnPGS07MGREzz
        nYgBeztc2WQ/RCqOhRXQt9g+S5w=
X-Google-Smtp-Source: AFSGD/VdUsbOgINvbHC8AQaZ3lh1/pErRPfWUHp2SebyuvhnHsvaKhyq2BJmke6R4Bd0QL9tI/9ZQw==
X-Received: by 2002:aca:5c87:: with SMTP id q129mr19498529oib.189.1544140865662;
        Thu, 06 Dec 2018 16:01:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z18sm672778otp.41.2018.12.06.16.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:01:04 -0800 (PST)
Date:   Thu, 6 Dec 2018 18:01:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
Message-ID: <20181207000104.GA10814@bogus>
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:06:56PM -0800, Paul Walmsley wrote:
> 
> For IP blocks that are generated from the public, open-source
> sifive-blocks repository, describe the version numbering policy
> that its maintainers intend to use, upon request from Rob
> Herring <robh@kernel.org>.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
> Hi Rob, please let me know if this document works with your
> requirements, or if some changes are needed.  - Paul

Looks pretty good to me.

>  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

Use the path that was suggested.

> diff --git a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> new file mode 100644
> index 000000000000..b899e5c6e00c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> @@ -0,0 +1,38 @@
> +DT compatible string versioning for SiFive open-source IP blocks
> +
> +This document describes the version specification for DT "compatible"
> +strings for open-source SiFive IP blocks.  HDL for these IP blocks
> +can be found in this public repository:
> +
> +https://github.com/sifive/sifive-blocks
> +
> +IP block-specific DT compatible strings are contained within the HDL,
> +in the form "sifive,<ip-block-name><integer version number>".

Really, my preference would be to add a '-v' in this:

sifive,<ip-block-name>-v<integer version number>

But given this ship has already sailed, I guess it is fine as is.

> +
> +An example is "sifive,uart0" from:
> +
> +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43

That's nice, but will be out of date as soon as someone adds or removes 
a line above it. Can you point to a tagged version?

> +
> +Until these IP blocks (or IP integration) support version
> +autodiscovery, the maintainers of these IP blocks intend to increment
> +the suffixed number in the compatible string whenever the software
> +interface to these IP blocks changes, or when the functionality of the
> +underlying IP blocks changes in a way that software should be aware of.
> +
> +Driver developers can use compatible string "match" values such as
> +"sifive,uart0" to indicate that their driver is compatible with the
> +register interface and functionality associated with the relevant
> +upstream sifive-blocks commits.  It is expected that most drivers will
> +match on these IP block-specific compatible strings.
> +
> +DT data authors, when writing data for a particular SoC, should
> +continue to specify an SoC-specific compatible string value, such as
> +"sifive,fu540-c000-uart".  This way, if SoC-specific
> +integration-specific bug fixes or workarounds are needed, the kernel
> +or other system software can match on this string to apply them.  The
> +IP block-specific compatible string (such as "sifive,uart0") should
> +then be specified as a subsequent value.
> +
> +An example of this style:
> +
> +    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
> -- 
> 2.19.1
> 
