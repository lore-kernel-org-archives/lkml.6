Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F162C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA692190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545416721;
	bh=U+LgE9l/VPj0JM5FucyVfIagpPvD0CiqhS0TZ2AXaj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G9f9SKrdFMfWvZOtwtwZdI3gnzF1HZ0sN10oCyDcu5WCJ3MHzR7X2ssVDkEiHTI5I
	 T4iJpbyGH93tZ1qTk4QR6VD6nfpi3tx5MEW04t3+WJ4byOVqY6Bmzo0X1on5keeTe8
	 LNgf9JAjmPJKf/aUt4riGQPogBmnjuyAEhQWCB84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbeLUSZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:25:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44741 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbeLUSZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:25:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so5905424otl.11;
        Fri, 21 Dec 2018 10:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnv9jUXgk30zxmuYJX7EViK68oqsu0CngVr3vKAQyFQ=;
        b=S+Sikd/z5kQDp93F4X2H68cTsWrW8C1ZmKE4x3FHvH6NyScKk6ge23Uizn89m0pxXQ
         Qd/Rq9JBIU+BZHy8SJhcIhoTBjB7Fsf7ZV9QfAQuOk8YRd+TCiNnE5ZeoidZWa0oFNcs
         vX6ktQT4lXU23GW/sp31D31EuJZPDH5SeAJZDwwuvKTQq3aZYrmWqOXfWjZx5Ai6y7pu
         Bl6iGG6Xm/IeeJxAduhz/SxhExnlaG3sXTEjRjgDL/8gAP28qIXPuL6AZp0dI3/Vphn5
         MwYSgg8ZeGeLyq0mCYaQieJ0oZxo1CqO3hHkxiM7EPmAXw3MWHWvSSzu9aVFwmLboqRs
         5WAQ==
X-Gm-Message-State: AJcUukev4X7TNQd7AHAKelMjKgEVompbTly86tXN3LuGa2Ec7eNQGY1/
        bwpEMT64vmqdAi9LydkjiLf5Bu4=
X-Google-Smtp-Source: ALg8bN4Yh2IvPYPf3f3hnBkLlqZFGQds/veTkjWTyBnajbn3Anfvr8DHJUZ79vglPDmqAOXduoDy7g==
X-Received: by 2002:a9d:14e:: with SMTP id 72mr2489882otu.54.1545416719180;
        Fri, 21 Dec 2018 10:25:19 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
        by smtp.gmail.com with ESMTPSA id b12sm11120812otp.75.2018.12.21.10.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 10:25:18 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:25:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 6/8] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181221182512.GA8531@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-7-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-7-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 14:46:35 +0100, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. This also corrects
> a typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> We need to use the naming stmpe_adc in devicetree because this is given
> by the mfd device.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Cleared note about precedence
>  - Changed example to a full STMPE811 device with MFD, touchscreen, and the new
>    stmpe_adc driver.
>  - Added Jonathan Cameron's Reviewed-by
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++
>  .../bindings/input/touchscreen/stmpe.txt      | 88 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 +++
>  3 files changed, 98 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
