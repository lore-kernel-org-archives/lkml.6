Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8AFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4E20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4E20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389056AbeGKP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:56:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40321 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbeGKP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:56:01 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so50112333oie.7;
        Wed, 11 Jul 2018 08:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PiYk45zQgYWSvmrtrYw+2sCTOfNFzj+eSr2h44GjOn0=;
        b=nuTFI8rlXiq+5tx9uOVd8afIWnoFB8zrO9hEBOsAsxoQB3saFMUa6rKv0loinalrwc
         dR4Nl2njmnmI5I8KApgMbTqXSJ/pFcqV2GkKqj33MKjGhGkpoi/S6T5nNy4DUBCJWOoS
         Am2wNuzKPtJFqegsP51XXl2kah4PEBd1KrM1WR+gz97qoVaYNmMQKNQce95YgmXpr99V
         60S1mZmUxBwfZoy5XKVSQdo9T0kG/FkLFPVFoB1IeE2VZ5I4aU0thEGtMfc8KFsgY2c5
         AXGEihpxSq8R+cVv2dsH6lUiqqH8yXoE3JUVtCMQh5xMb5/lWTZvmFbYVmlaLlKQo1Gs
         VsvA==
X-Gm-Message-State: APt69E0TH6d6/rbsjQP40Dao4nIxhpvlQ6gzcIsXJxbUiyopVIn4XAUI
        amwpHZnxV3eB7aLo9oUNtUFmt/E=
X-Google-Smtp-Source: AAOMgpd730XkfKchpP+tlBh0/rxPQMf2O2ecnBpXCtB6vUHe8VI7qtOXVpVXV3X+NZUTbhJsTlI5vQ==
X-Received: by 2002:a54:4f8e:: with SMTP id g14-v6mr6891602oiy.306.1531324263862;
        Wed, 11 Jul 2018 08:51:03 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id w8-v6sm8365094oiw.10.2018.07.11.08.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:51:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:51:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] mfd: as3722: disable auto power on when AC OK
Message-ID: <20180711155102.GA12132@rob-hp-laptop>
References: <20180703150411.29709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703150411.29709-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:04:11PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> On ams AS3722, power on when AC OK is enabled by default.
> Making this option as disable by default and enable only
> when platform need this explicitly.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Reviewed-by: Bibek Basu <bbasu@nvidia.com>
> Tested-by: Bibek Basu <bbasu@nvidia.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Document device tree property as suggested by Stefan.
> - Rename SEQ1 to SEQU1 as per datasheet as suggested by Stefan.
> - Drop reference to downstream commit as suggested by Lee.
> 
>  Documentation/devicetree/bindings/mfd/as3722.txt |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mfd/as3722.c                             | 12 ++++++++++++
>  include/linux/mfd/as3722.h                       |  3 +++
>  3 files changed, 17 insertions(+)
