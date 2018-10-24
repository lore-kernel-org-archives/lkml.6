Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CF0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDC22064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDC22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJXWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:23:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:23:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so4141193oic.3;
        Wed, 24 Oct 2018 06:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fiJT+PXuu5nSTtdksmSq/lMOiZtjPnbxTjw1oSyhdsA=;
        b=LcU38wSUzbrwQI0L6+TCQ2VjuBEw7SIs1+Z4UbaQrRjrkbNNzr66e3sIQBW+goEkSn
         nixrzCVx2yEvWgdb0zJ92ffXyQZtSsWq/7E+xAcGZqzXslgRtHSyIGRoAQXnUCgDNkCH
         6V+R9j64ALnEtK/I/uvS51dll3aaK162s6bCSu3Rj6mqi7rdAAVLrSeHFG4t841L8bua
         4DtW3EN0Xznofog2xbqV6DKsjTpqTdQmqbMgLiKDSaHg5blZVYQblNg3xVocD8UcCysh
         pLYratXQdSlFBQZP/2LJqiDoIEMJOm8GbiAA5fcWqBsznQZppsPMc9w224C/U2hcHRAi
         dFrw==
X-Gm-Message-State: AGRZ1gIZH2t6A5yzEoOAhkS9KfyRmjnjrpNb3DQWrRW5x/6u6nt7mvUY
        7GoMrO8GmixDtbaWo675vg==
X-Google-Smtp-Source: AJdET5di/uvVsA4y6AtBrVTpfMVTxr/dPgqYj1+XBoFjopseY84aGiOqY4slyqykYQPzohzYkHovSA==
X-Received: by 2002:aca:ed57:: with SMTP id l84-v6mr1413988oih.188.1540389345366;
        Wed, 24 Oct 2018 06:55:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83-v6sm1383073oia.9.2018.10.24.06.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 06:55:44 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:55:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO
 bindings
Message-ID: <20181024135544.GA31518@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-4-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-4-oskari@lemmela.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 21:53:22 +0300, Oskari Lemmela wrote:
> The AXP803 GPIO is compatible with AXP813 GPIO, but add
> specific compatible for it.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
