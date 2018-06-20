Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13990C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C409720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeFTS3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:29:21 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42427 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeFTS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:29:19 -0400
Received: by mail-yb0-f194.google.com with SMTP id m199-v6so203189ybm.9;
        Wed, 20 Jun 2018 11:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onHZiM2LIvrjz4IzLMUB4bHg4QmswzBUqSeMTpW/Q5o=;
        b=dt0oWVLNQWhhLUPCM1v3owvD+fye0IFHpqBS1abwh5wc+sGGtLGAaVGc38kF8Ed/z4
         NE2sZz99s1vEsNkEdASRQzZhPqH6Y1sMANdYnmMpICx/Yzl3Wluu2tvhGK41OjNZkUVz
         b1yHgENt3W7qMu5eVMjtTdu8ph4F9c7b87dhsB8XwMD9c5KWXgHC1S7czeGFGGEnWJ0m
         MtX3l5kaYAJlqAcdAkBxHLCgmLIlLNGRrCYzTVQKKWKifc8FqD2WFoKAwPiyLH9kAeMD
         Z4IXgP+jbbJn291NUNrlxorYI00lau83GwbWAm5JaUlkGZ+sm+s4Mfjp5pQQKV4yower
         9hNQ==
X-Gm-Message-State: APt69E0hEO/1RaW+HrSh48Rq5+63goX3fmBNFf79a2CJt2YGMwdxQI0c
        KOhb81SfZk6ddJhdD/4fbw==
X-Google-Smtp-Source: ADUXVKLFy7LhSeUT4UoAOQDgXTu0xRQyZLe3P07qzlB71ClVbkHYwW1XR3WLwj89EH57ltmKx0Rpyw==
X-Received: by 2002:a25:4f8b:: with SMTP id d133-v6mr10993461ybb.359.1529519358973;
        Wed, 20 Jun 2018 11:29:18 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r64-v6sm1118750ywg.47.2018.06.20.11.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:29:18 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:29:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V3 2/7] backlight: qcom-wled: restructure the qcom-wled
 bindings
Message-ID: <20180620182917.GA18262@rob-hp-laptop>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529406822-15379-3-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:43:37PM +0530, Kiran Gunda wrote:
> Restructure the qcom-wled bindings for the better readability.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 110 ++++++++++++++++-----
>  1 file changed, 85 insertions(+), 25 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

