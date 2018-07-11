Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDAFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50043208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50043208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbeGKPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:17:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43912 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbeGKPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:17:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so49836474oib.10;
        Wed, 11 Jul 2018 08:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=50gkmy20oVJWb3UTch/0GpOoZ3CtECekMd1zz8nNbbY=;
        b=gs+7bybOAl86I44VGpbgPh/R+9zBMxSfVGBaEY3CbeG5xQn5doMkmA45SP6w4WZHFf
         pYLSaxI1AN/ywwd/D4lHQGw6Hrgyq+1TikquU1Mn6DqmwvBnOUzZcp5Bhc3IRUIsaa9C
         5W6UXE1P5JWK6XgNzwnEUmarQwMjXGQR/hShjtz4CLCZXqcKg6BCQa8nswBtwEYZ03SF
         ZzWq0PxECQ0TMZrRGTttpM3BsEKtF6JbwD/8afNYmmWdcQVytg15OiQ4kGUBoL9IqmEG
         HLVh5+8SqctqBepKe5gbkkkvdhgaJKJg1U/xUOCxIsAT4PP7wlzktdMqGxjb6iPxib+K
         exiw==
X-Gm-Message-State: APt69E0QfHL046tT+aODNe37PT0RG2uvfURdl/xhKZgeOHIef6PgbUVg
        S7zazeyNHqLWXVxU6vJAxQ==
X-Google-Smtp-Source: AAOMgpeRRIjeZx4VF6uW1nbPv5f4nLzOsqLab/Aq4/UU7gjVV0OQTS72Hua4RvPRzgsDk2gsE6J0YA==
X-Received: by 2002:aca:e2d3:: with SMTP id z202-v6mr29227859oig.121.1531321958866;
        Wed, 11 Jul 2018 08:12:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r188-v6sm7124194oie.28.2018.07.11.08.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:12:38 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:12:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V4 3/8] backlight: qcom-wled: Add new properties for
 PMI8998
Message-ID: <20180711151236.GA646@rob-hp-laptop>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531131741-19971-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:52:16PM +0530, Kiran Gunda wrote:
> Update the bindings with the new properties used for
> PMI8998.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
> Changes from V3:
> 	- Removed the default values.
> 	- Removed pmi8998 example.
> 
>  .../bindings/leds/backlight/qcom-wled.txt          | 76 ++++++++++++++++++----
>  1 file changed, 62 insertions(+), 14 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
