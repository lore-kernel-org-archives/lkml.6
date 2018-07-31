Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE926C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FFC20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FFC20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbeGaXbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:31:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34619 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:31:43 -0400
Received: by mail-it0-f66.google.com with SMTP id d70-v6so13608078ith.1;
        Tue, 31 Jul 2018 14:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E3zYQKzG7HpJO5TlZcAjRI7pukLYcB7UYB+GJOGE/uo=;
        b=uXtNo1B4h5FQNhs0SG0R2W0KVvPpnycRDF9s/qDanwt1EEWJBN8WzP8g9cHmcW3BUO
         UvMqnTrW2tXqrXio3fN/SprjXiVgNYdrWZFt58gewL6TFPGwdiWlbP+65brOKfyiWmGf
         Q1PenwVRLwsriUkMXtRrnN5g0OHQgGaO9fJgTERvppoPorUaCZROrcZBXen1ROi274Dd
         nuRWWfBJxVD2TYGlHIZUQK8oGXyYu8WAzZ+GgKXH7JvMmiA6vIf7QyIKPrReqbgLAZOR
         DuI6fk0CFh0cJa9cIbPOuA5xtujkWyOtcAYhE7BBRRYlP1ysxBBJs9Vaon4B6od+HKto
         BQkA==
X-Gm-Message-State: AOUpUlGjdBKVGO0rdYMLjes2+hd5uvaFJ+ChSDiguQLBsqZ52OaLPlB2
        ITWe+Dw9n2yZLIUHOvLFdz2sBz3+FA==
X-Google-Smtp-Source: AAOMgpdX116GKzZizb/gGrJYkfZkOWi3C9SO5FiREQ8xO5wHWpIXl5Mbmi8pHNk+wSMG3pJf+Yx/RA==
X-Received: by 2002:a24:24d7:: with SMTP id f206-v6mr1351518ita.117.1533073761769;
        Tue, 31 Jul 2018 14:49:21 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u23-v6sm4607976iob.0.2018.07.31.14.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:49:21 -0700 (PDT)
Date:   Tue, 31 Jul 2018 15:49:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
Message-ID: <20180731214920.GA20796@rob-hp-laptop>
References: <20180724111600.4158975-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:13:25PM +0200, Arnd Bergmann wrote:
> Almost all files in the kernel are either plain text or UTF-8
> encoded. A couple however are ISO_8859-1, usually just a few
> characters in a C comments, for historic reasons.
> 
> This converts them all to UTF-8 for consistency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/net/nfc/pn544.txt     |   2 +-
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts     |   2 +-
>  arch/arm/crypto/sha256_glue.c                 |   2 +-
>  arch/arm/crypto/sha256_neon_glue.c            |   4 +-
>  drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
>  drivers/iio/dac/ltc2632.c                     |   2 +-
>  drivers/power/reset/ltc2952-poweroff.c        |   4 +-
>  kernel/events/callchain.c                     |   2 +-
>  net/netfilter/ipvs/Kconfig                    |   8 +-
>  net/netfilter/ipvs/ip_vs_mh.c                 |   4 +-
>  tools/power/cpupower/po/de.po                 |  44 +++----
>  tools/power/cpupower/po/fr.po                 | 120 +++++++++---------
>  12 files changed, 103 insertions(+), 103 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/nfc/pn544.txt b/Documentation/devicetree/bindings/net/nfc/pn544.txt
> index 538a86f7b2b0..72593f056b75 100644
> --- a/Documentation/devicetree/bindings/net/nfc/pn544.txt
> +++ b/Documentation/devicetree/bindings/net/nfc/pn544.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties:
>  - compatible: Should be "nxp,pn544-i2c".
> -- clock-frequency: I²C work frequency.
> +- clock-frequency: IÂ²C work frequency.

I'd prefer just plain ASCII 'I2C' here, but either way:

Acked-by: Rob Herring <robh@kernel.org>

Rob
