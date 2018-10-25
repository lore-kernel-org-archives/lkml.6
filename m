Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D79ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959120834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8959120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJZG3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:29:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35632 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:29:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id 14so10663081oth.2;
        Thu, 25 Oct 2018 14:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EjMLax3c555Ry+NJoc5+/RVUeiiSXA/qvnvNxrLAUQ=;
        b=ZVl5DtSDFhstdBEtkYsEmm7kF+gafbGp4bnfM7Ob0a+zmG+Upk7OmouHSMpjNeZoP5
         53jYEwaoZ7TQvk7iEGeAeIK0Re/s5/dYI5+/BYyAv1oqCXrKL3p+GUVuZ0WAsmN7aReA
         In1uzsoBI+QriF1FBZKkB+SHK3pGIKp3cJRwOjPK7SsdI+ZgUI/8x6VFvSmj1IAXvLEM
         FXiDbzUCGgmkNkUKOagZ4rhTclQccNBf0KL7nKygJeb1PQeTSa6r5KOyfFhSHzDrkmyF
         Q0m6ZU5VhLfu0JJUfAx8Atqy8ZvxxmXSPievcS1VEGCNXG0Vd03wfG2j90gQldy6c/Ix
         Yk2Q==
X-Gm-Message-State: AGRZ1gK2vhIeYIsC/hiAsTexMCZ9qwolPuZFqw+oJCftqJq0CeryVAx0
        DaB+DeFmGq8YKWSVvuSHSzFE9b0=
X-Google-Smtp-Source: AJdET5dgQ5ZzfCAIk5Udzq/IWrHSOaOeohuqk156Q364rOHYUliZ7gnroEvuO9iTFv4cHCaEvjmv4w==
X-Received: by 2002:a9d:48f:: with SMTP id 15mr662142otm.20.1540504486924;
        Thu, 25 Oct 2018 14:54:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r143-v6sm1917031oie.27.2018.10.25.14.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:54:46 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:54:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20181025215445.GA16550@bogus>
References: <20181025132937.24405-1-poeschel@lemonage.de>
 <20181025132937.24405-2-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025132937.24405-2-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:29:33PM +0200, Lars Poeschel wrote:
> Add a simple binding doc for the pn532.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> Changes in v3:
> - seperate binding doc instead of entry in trivial-devices.txt
> 
>  .../devicetree/bindings/nfc/pn532.txt         | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt
> 
> diff --git a/Documentation/devicetree/bindings/nfc/pn532.txt b/Documentation/devicetree/bindings/nfc/pn532.txt
> new file mode 100644
> index 000000000000..a2df72a5f504
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nfc/pn532.txt
> @@ -0,0 +1,31 @@
> +NXP PN532 NFC Chip

What about the PN533?

> +
> +Required properties:
> +- compatible: Should be
> +    - "nxp,pn532" Place a node with this inside the devicetree node of the bus
> +                  where the NFC chip is connected to.
> +                  Currently the kernel has phy bindings for uart and i2c.
> +    - "nxp,pn532-i2c" (DEPRECATED) only works for the i2c binding.
> +    - "nxp,pn533-i2c" (DEPRECATED) only works for the i2c binding.
> +
> +There are no additional properties provided by the driver at the moment.

I2C requires reg.

> +
> +Example uart:
> +
> +uart4: serial@49042000 {
> +        compatible = "ti,omap3-uart";
> +
> +        pn532: nfc {
> +                compatible = "nxp,pn532";
> +        };
> +};
> +
> +Example i2c:
> +
> +i2c1: i2c@0 {
> +        compatible = "ti,omap3-i2c";
> +
> +        pn532: nfc {
> +                compatible = "nxp,pn532";
> +        };
> +};
> -- 
> 2.19.1
> 
