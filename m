Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF341C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA620862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FA620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeK0DAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:00:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45064 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0DAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:00:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id b141so16266746oii.12;
        Mon, 26 Nov 2018 08:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnOkNwoS0mwUyURy9wh4nMluYP6Vku84DtcEFXCTe1Y=;
        b=dm+VL3r/PAxqj7qSyufTLGYEEE212dYmVoC8OkbszyHXxdvpjyccGt3Sj+AikGyNQE
         IAm38VtCFcA3LZgCAZf5v62GtL7RG91ZJqDFIecDndJ1G2J8doyrkv3vNhpzlm70iuZd
         jyklXFrRgP9PHfZ1oKaUQ97vJy+Uu7PuL7qPjObPUqR0GXcLe84pZQ3T/brPHStb5y/9
         BchW0sa23jbNGVByjFV8TMu7H6Q2vHig5FDmu8AHNMsiFzlYipnSgH7DwXzqj353irxT
         abdXO7CiRnZqtaKemZMVvnv0WB6tW9z5iyFIsd0xLLJe4UN8+I/lfB5QbzYbT6uzpI9Z
         VJBw==
X-Gm-Message-State: AGRZ1gKNFhB1kLn1zRDDXOYXEJtCAkxis8D3c2W/nlz8k9ES+ek6QIj0
        Lhkz9NJTAIhNDuB2uMb3Qg==
X-Google-Smtp-Source: AJdET5d4hUW4HCB54QKZweqTV0MzcEkdy5U18GTPHVNpeY4sLl7Kr4vjDkM/2IxiEABLktdgdJA/Kg==
X-Received: by 2002:aca:490c:: with SMTP id w12mr16242295oia.8.1543248360541;
        Mon, 26 Nov 2018 08:06:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z7sm408690otm.63.2018.11.26.08.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 08:05:59 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:05:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
Message-ID: <20181126160559.GA8094@bogus>
References: <20181118135024.30720-1-narmstrong@baylibre.com>
 <20181118135310.31458-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118135310.31458-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 02:53:10PM +0100, Neil Armstrong wrote:
> The Amlogic Meson SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Rob,
> 
> I didn't take your v2 Reviewed-by since I changed the compatible list,
> tell me if i can still keep the tag.

Reviewed-by: Rob Herring <robh@kernel.org>

>  
> Thanks,
> Neil
> 
>  .../bindings/soc/amlogic/clk-measure.txt       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
