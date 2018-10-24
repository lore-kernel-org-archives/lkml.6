Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA3C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79C2207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79C2207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJXWXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:23:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36583 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJXWXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:23:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so5088246otg.3;
        Wed, 24 Oct 2018 06:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Nl0y1UPNgKfc5WvW4hMnxYZ1m9UgiwJEqe58xnAtm4=;
        b=dgJ33N98LWpjW7Brk7srmaA/M0EJmFF0tX6XIz0+jJg3np0zOAVUEwr0EhLAHffngn
         uV6mdt69XY7XDw8CGrnB3FNQuGxnG74omMlZbCkRRL6mu57gSFUG1BDm1vrfeOdD7v0p
         xuwC6sL4n4Q3QH9IXXAlnHijh2+syi58yCcZA+27XXFCHyDKmzBEZPrXVq8UKHKeeO+9
         f4YTf5HGmdnbNItkTA9UmbHmgQqFWWJIvrCnfl9+7EeKVIfk+tMqopxCqHez2wcW8jKw
         mW7cyxp1nkFZuDyWPmsOoACfE1ZZtkQP20G5YZPytViJAno2SRXdh7x7tzoJQA4gAIPE
         VxtQ==
X-Gm-Message-State: AGRZ1gIuVsT93bCTSylrvQAEEODIPzl8arGnlhLS7Zf+dKLRp/h0qBIL
        iwBQjAeiJWNISwF/aZMuzw==
X-Google-Smtp-Source: AJdET5dmKIybEDP90htBJ0BWMHU7x8YS/6RBQmocAohF38D6hobiqvjS8WYlrWfieSRkDc1Bf8ACmg==
X-Received: by 2002:a9d:50a0:: with SMTP id b32mr269955oth.323.1540389326235;
        Wed, 24 Oct 2018 06:55:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o63-v6sm1548204oia.36.2018.10.24.06.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 06:55:25 -0700 (PDT)
Date:   Wed, 24 Oct 2018 08:55:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803
 power bindings
Message-ID: <20181024135524.GA30329@bogus>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-3-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023185330.10472-3-oskari@lemmela.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:53:21PM +0300, Oskari Lemmela wrote:
> The AXP803 power supplies are compatible with AXP813, but
> add specific compatibles for them.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
>  .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
