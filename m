Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3F475C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001462089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001462089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933429AbeFLT3F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:29:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43603 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbeFLT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:29:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so43779pfm.10;
        Tue, 12 Jun 2018 12:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PXZgGT8NZg6RW+0cNLbOg6bKPi/2/MFWxVqa/8ngDd8=;
        b=LCbB6Wi7BSGX0tG8Mtw/ApZpO2rjd5y96SP5rJoQHUlbvpoHeUt3iamdLZtm39Hvqf
         +ESgzo+h/I+FG1iFCHW0feryC8y21BIxMTllWmMVy+jq9riUzugfpthSsLDVID1XPkvc
         npUi5ybaRxoR7o9QhNLKZA+gBlmWJS3AjxZ3oZ/wCTjTiPl6tpGdT/CFrCBQCfdjpav+
         vyFidJpKfnsJw8BUinubx5wASfKeSFpmdB8A9ewtm6tT9TPtXoXnfOXdnXD9Ul0BTlWm
         JZibYxQ+DJ5R68j6I8EUHhEXYW2kh7+A5jbGHs5ZoDtVbaKjgWzUbcCcRVxlPJa3wjWf
         ev/g==
X-Gm-Message-State: APt69E2/TpQi727rDRG/4bstBU3Sr/bb3cVSMmANC/WbvbFcsvUUYjM8
        gsv9Z5LMwFMUw0eGGZBcUg==
X-Google-Smtp-Source: ADUXVKJ/v5YIQv5eI9++y5YanEINIg0OHjL3YmXYWiXwA7gUY6i8ErLWRWKGiEH0mtlf1arUyABUfg==
X-Received: by 2002:a63:b147:: with SMTP id g7-v6mr1402482pgp.379.1528831742562;
        Tue, 12 Jun 2018 12:29:02 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o87-v6sm1165737pfa.106.2018.06.12.12.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:29:01 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:28:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
Message-ID: <20180612192859.GA14933@rob-hp-laptop>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:54:56PM +0300, Amit Kucheria wrote:
> SDM845 uses the TSENS v2 IP block
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/thermal/qcom/Makefile                            |  2 +-
>  drivers/thermal/qcom/tsens-sdm845.c                      | 15 +++++++++++++++
>  drivers/thermal/qcom/tsens.c                             |  3 +++
>  drivers/thermal/qcom/tsens.h                             |  5 ++++-
>  5 files changed, 24 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/thermal/qcom/tsens-sdm845.c
