Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BFC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E0C20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E0C20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389344AbeGKUKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:10:49 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38447 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeGKUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:10:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so51564626oie.5;
        Wed, 11 Jul 2018 13:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQ8H2HVFwVfDiaJrxri6wk8T+W0EVfKM0qsQ/mg1e4Y=;
        b=pwQUSlH4J8mdcc9/Oq6rjU9yzOR7vdoN8INPQA98EvTeHzlGYqooOT/vvqY+tQYJen
         I6MhYSAF2K4M7yVt1tZ80kQV/X3tq+EPh+MXpdxJXtiqGoemtcB93GPPzQ+n9uSNIJLe
         ncsLW/5KaE/OoiDTVWC2uyNoaQYsaSUJasE1m74/xyGDGlSI9keF3IFD8z+qzT7kwSav
         nC+OsF6SS4HMe4qD8m13yCPIdw263jXTfLm+sOq0TdcG3q3aC01O5mUg5SffClfWfTZ3
         WKijVujpXvnGyVSEfJ5TV3y+yxx+y5CK23sLY88e+M8gom6aJERmgwWpaSCBtIKVyMbI
         398g==
X-Gm-Message-State: AOUpUlFoJ12H7V8XY6MuQFROhHlMYtQDSGhHvuFMyfmnZWfeDhehr8Fl
        nsIpLa5xKbmsm1z6b14ll4o0oCk=
X-Google-Smtp-Source: AAOMgpcossIziFliTJNBpzDoAjSHXatxr1HTjquuNYHlE5izi2IsKzDcaTvIXlxp1wkwWkqpix6LHg==
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr100787oia.156.1531339492590;
        Wed, 11 Jul 2018 13:04:52 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d8-v6sm17792777oif.39.2018.07.11.13.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:04:51 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:04:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        gregkh@linuxfoundation.org, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Message-ID: <20180711200450.GB17291@rob-hp-laptop>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711053122.30773-2-andrew@aj.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> provide remote management of (primarily) server platforms. BMCs are
> often tightly coupled to the platform in terms of behaviour and provide
> many hardware features integral to booting and running the host system.
> 
> Some of these hardware features are simple, for example scratch
> registers provided by the BMC that are exposed to both the host and the
> BMC. In other cases there's a single bit switch to enable or disable
> some of the provided functionality.
> 
> The documentation defines bindings for fields in registers that do not
> integrate well into other driver models yet must be described to allow
> the BMC kernel to assume control of these features.

So we'll get a new binding when that happens? That will break 
compatibility.

> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> 
> Since RFC v1:
> 
> * Add a commit message
> * Minor changes to documented labels
> 
>  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 258 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> new file mode 100644
> index 000000000000..2c869fcc7ef2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> @@ -0,0 +1,252 @@
> +BMC Miscellaneous Control Interfaces
> +====================================
> +
> +Baseboard Management Controllers (BMCs) often have an array of hardware
> +features that need to be described but are awkward to sensibly expose.
> +
> +This bindings document provides a generic mechanism for describing such
> +features, covering read-only (RO), read-modify-write (RMW) and
> +write-1-set/write-1-clear (W1SC) semantics.

If we wanted a generic mechanism for single register bits/fields in DT, 
we'd have one already. A node per register bit doesn't scale.

Maybe this should be modelled using GPIO binding? There's a line there 
too as whether the signals are "general purpose" or not.

Rob
