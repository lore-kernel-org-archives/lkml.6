Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552EAC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146062154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146062154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeHNX0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:26:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbeHNX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:26:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so9775514pfh.2;
        Tue, 14 Aug 2018 13:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8rEKRd/tLk7evPe3n9vpXNqBRcPmviikRpQRpkA/fk=;
        b=o8QlAjCAjk4uY0myIcYyxRXnwky3FQ4Bc9xOU5p6ZDB2R8sExPon/Px5ES3xIuuk1y
         6qXM0EOl9gRZzxvQ2irVXHKi8d4ZkVxEoXrEyEhKNXF/e0iY7rRDwfRPfoSiSa3lWPo9
         UG7mXhLmpJSHTT1MDBs5J6muY/GittWcT2FU1kcWm1Ca20dLtF+ecuoPkKM0DMogrnV9
         A1QBEjkz+WqfSC0T9db+bBNQ4iwlsbfoJnIQDiOVgwBIHEU7oxCSrhLYDbLk72BGoHhy
         rk/mf0Q/N+7FoyoYS3+7JiyVGvyvaeLCjOAM06xauHB366arcuSqGk6sk7OelfsBHQOi
         jZkQ==
X-Gm-Message-State: AOUpUlGlIYTsCvF49qpdDwCRmlBVtv1L+BNJIOwqvjCdqYQFKqsJnWKv
        aMSJ7QmSr50fkuaCdGFiFsFQmjo=
X-Google-Smtp-Source: AA+uWPyPRu7hPRyq8U937UEvX2BaMkvZFD1AlZ7VFsQpeUKxldkkYkxBIr6G3PhXlTY+RO4oeVYs/g==
X-Received: by 2002:a65:60cd:: with SMTP id r13-v6mr22470226pgv.232.1534279061830;
        Tue, 14 Aug 2018 13:37:41 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id n80-v6sm48902370pfb.95.2018.08.14.13.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:37:41 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:37:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: s2mps11: Use existing defines from bindings for
 clock IDs
Message-ID: <20180814203739.GA27965@rob-hp-laptop>
References: <20180807161713.28073-1-krzk@kernel.org>
 <20180807161713.28073-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807161713.28073-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 18:17:13 +0200, Krzysztof Kozlowski wrote:
> The clock IDs must match between DeviceTree bindings and the driver.
> There is already a header file used by DeviceTree sources so include it
> in the driver to remove duplicated symbols.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/clk-s2mps11.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
