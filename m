Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B0FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B531120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B531120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbeGaAvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:51:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34803 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbeGaAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:51:14 -0400
Received: by mail-it0-f68.google.com with SMTP id d70-v6so10671155ith.1;
        Mon, 30 Jul 2018 16:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ys3kF3EsQFVZjJf5oNrsAKJoQBpbgZL95sSmgNeEam8=;
        b=OTPufhtIb5urAa+2wQ0dBwY+Rz6GvvrMyQYL8NoP7GwRq82bLA0oYlajLEmR1tXth9
         9HdkvHIw7VaQUqUKAhpHbv9/5M66PjFPB0mx3sGW7KgfL94oON97KWvQQXhTvzeE165I
         c+iTGpmdxrpdunD4cZCxU5ZCUZ9SjFK2t66BEHWgLq27X8okCvFj2Ybl5HJUz5COKjos
         ksRG5PF8OEbWgqU8ohFi9ULulvECcZvp+cl26xNn4cyOzG7a83VHjBwxAzUmSTgGEg/G
         1yZRbXTLgv/6OW0CdU5hulHjwv8bvoH/JWcYViDF+M+PaWnbVwm92Ec7gVziSFZHoDoS
         iwRg==
X-Gm-Message-State: AOUpUlHF9+Z3fngnbHWxzk/idzd9KR0z+3WRe5mvGi/4PW3cVyGvvXVu
        s4/FikN35MSs6k4iA+MlxQ==
X-Google-Smtp-Source: AAOMgpetYvFwD8lgRmeNEoRjIVHDMjCbYF1WyKNH/FhUmo5cQHLZSHMaAccHrURV3cr0HovLwL8b6w==
X-Received: by 2002:a02:1506:: with SMTP id j6-v6mr18389081jad.30.1532992437607;
        Mon, 30 Jul 2018 16:13:57 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w199-v6sm483825itb.4.2018.07.30.16.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:13:57 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:13:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, coresight@lists.linaro.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 8/9] coresight: Cleanup coresight DT bindings
Message-ID: <20180730231356.GA6353@rob-hp-laptop>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
 <1532686537-12380-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532686537-12380-9-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:15:36AM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. This can
> cause duplicate ports with same addresses, but different
> direction. However, with the rules getting stricter for the
> address mismatch with the label, it is no longer possible to use
> the port address field for the hardware port number.
> 
> This patch introduces new DT binding rules for coresight
> components, based on the same generic DT graph bindings, but
> avoiding the address duplication.
> 
> - All output ports must be specified under a child node with
>   name "out-ports".
> - All input ports must be specified under a childe node with
>   name "in-ports".
> - Port address should match the hardware port number.
> 
> The support for legacy bindings is retained, with a warning.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 95 ++++++++++++---------

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/hwtracing/coresight/of_coresight.c         | 98 +++++++++++++++++++---
>  2 files changed, 143 insertions(+), 50 deletions(-)
