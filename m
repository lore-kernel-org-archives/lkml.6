Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F24EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CC520868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CC520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeJLXSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:18:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44540 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:18:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id p23so12772575otf.11;
        Fri, 12 Oct 2018 08:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNMcl54Y6Krk95hO65gPoH9kIGL4aQ/px4ov2SSS1fg=;
        b=lo+OhdKRugmsj1zf6c3QElLx2M9OlwUlZ/EnOqx/KEVs29xJg47Kf955NjvTsJBULE
         SulHo1n8DCL7f3omkkOvTgwpQQ1wjHEoei8j5c42TzN895cMIBpFiMrJ5p7gRubN8b9L
         IF1Fmg413DQh5/jgYZk7Uz62BMJ8otH80KjL3OY5I/Np/J2MIv02dg1MeqS74ZZ+ICgK
         TY7IB5rIAPPwMe/+/ppGVv59I5CNsj8JVVlOtImIGb8yQO2O9x0LIF5tMP8BXqIW9Aei
         5Mb+i9i3Ka0+EdKyhjykp520NT6oBgjqGaUrhBd/ZP0+EIdBx39gKtOlxmVmbBcUckFy
         uVgQ==
X-Gm-Message-State: ABuFfoiSEQXsOl3jGtNFsW1XxEwQSu55CcLj2KIQPUB/Z342giTmAhw3
        qpmyd+SYM+caUteeMPa8HQ==
X-Google-Smtp-Source: ACcGV60ZCzb0QIdBS8ERyTfnFZCAkh6EaI+pP4bFWv2ko7R7dQS/1GsJOidGS0UVbQY3LQdLkOjSHw==
X-Received: by 2002:a9d:805:: with SMTP id 5mr4076798oty.161.1539359096009;
        Fri, 12 Oct 2018 08:44:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w37sm426186oti.77.2018.10.12.08.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:44:55 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:44:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
Message-ID: <20181012154454.GA15048@bogus>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008181908.9456-2-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 21:19:02 +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
