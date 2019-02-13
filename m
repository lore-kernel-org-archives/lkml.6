Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D23C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1284C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550089177;
	bh=5kmQby6RB2EyhuJ6J1JOcDfvk3GbqdZ+sAYwE4mVaT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RjTF4qbzsx4LrVnQvbJrwcMD8umFy4Tfxr8+x//6CDdjcHKsznz8+nsvvoXXgg/wa
	 I4isGktCyhttGaWXaLW8NF2CbvLPhkttHMe/n4zkm7hbZ2kxK8UPhC4Oo7ay3BAzBO
	 TT2yaUtdT70Uk5ugDmXmkjfyJKyieOtbA9ER9NpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbfBMUTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:19:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38697 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732209AbfBMUTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:19:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so6573220otf.5;
        Wed, 13 Feb 2019 12:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMay0Ox/p5VpcfWrb8jUlU02Ws2oh2aG5VLfXXUBtUc=;
        b=FB4J9oLAwfOWG5MigLVASejO/iyL6FE/G8v/DUM1ePBXtLH+SzFdP2PRFFMVQNImT6
         nbAGcMLBLM2RjWtB5GbI2GErh8UEtL9BdK/ypdnx8/z/6kT1pQvR4GqW3L/iuOgBh+Rm
         zR+KB5ka9CRkzdHPL+8gkamXlu+QdeUqUNyL2F5j/0HpcWzAUxJqdLvTDEwj0vTWVJ2A
         jnrRZHjKDZESUeqIco33M8JtI1lHmVTeHl+ktD/SVbxrVWYSjEvEoE4tR+QSU9w/0OYK
         L2lFt5VAjmbD22ZwL4O03glpxI0poAft56Mh4uypNyuW89LS1X4kubmPlIfwGxlUSLw/
         7ZhQ==
X-Gm-Message-State: AHQUAuYZGcUu9KB8PRLD6i96JiaJkqtHJmVIOsS0R/9dbv6+3WPZ445J
        tDI4m9ipOjlmODI3DZS7Ig==
X-Google-Smtp-Source: AHgI3IY2dzipQ5Pm7yoX3MTUlIdOsHxQvSOMiPydfe0aO9TXQm3hVkVZztXRV/INtTeG0WDNRbNJGA==
X-Received: by 2002:aca:f08b:: with SMTP id o133mr1316195oih.32.1550089173784;
        Wed, 13 Feb 2019 12:19:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n126sm111842oif.19.2019.02.13.12.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:19:33 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:19:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190213201929.GA21948@bogus>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> v4:
> Use standard names for reset-gpios and gnss-fix-gpios
> s/an/a UART
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt

Reviewed-by: Rob Herring <robh@kernel.org>
