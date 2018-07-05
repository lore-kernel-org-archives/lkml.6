Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F257DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9E723C23
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9E723C23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeGEUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:39:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33991 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeGEUjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:39:25 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so19416290ois.1;
        Thu, 05 Jul 2018 13:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPD2RD2v79Hnw8WXEZux6rFv8Qo+pGauTrm+qe+4Ud4=;
        b=M45YtKK6dNLb2xO/uxb72muc1rp4WVy3Zg1nTFUoFHRrKs1ZFlKq57NhmTc1m6qWLn
         uXR31NncXfrFu9gubqFFn538NTeautxNmDg08fke5I5qtO2shNoF8QPGnl4izbXB72pz
         L+M9WOAn6QDHfI1whSKk9UNcNhBRPQJY7yATyBk+8PTgRSxB5R7C6VE4et8yLug14r5k
         8b4FFbXcKSjb/2NbkfLo/yacsyxd9enATCuR12LruL4RZ/ZaDo6aZrFKCKCVzrLSRnpr
         Tcx/keDvwaPCoq65BX0QiwUNKdw/JnZ6yhs21nwAynwt1OtYBmNz5as0wIXt5IlMRe8E
         l0/g==
X-Gm-Message-State: APt69E1u77koqJsSTvwvT3ak1bCxYp8wLb4eQU+3JhsUu/oeqNx4EDLw
        vz9qa3M9LslgSv+OUXvPMA==
X-Google-Smtp-Source: AAOMgpdomzwx6Cw8j4aBYT6IcDfdyea7KworvYd5YqrAKwZ18Z3yXeTwEb5M0pgJMSkj63a33w2rCA==
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr7855149oig.221.1530823164566;
        Thu, 05 Jul 2018 13:39:24 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id t204-v6sm4411561oig.24.2018.07.05.13.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 13:39:23 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:39:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v10 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180705203921.GA28410@rob-hp-laptop>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <8ef84806b7152a4da2bffa0456052e98f4c6e1c6.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef84806b7152a4da2bffa0456052e98f4c6e1c6.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:32:58PM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

Reviewed-by: Rob Herring <robh@kernel.org>
