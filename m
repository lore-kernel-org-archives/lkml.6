Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C56ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbeGTS1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:27:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44273 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbeGTS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:27:45 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so10557233ioh.11;
        Fri, 20 Jul 2018 10:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4uNkKfF2wQYspT1T79e8ha0T9ssudHsWh7oapPYfOcM=;
        b=iWaWsHNtF2Nvy5O38XiaMmKJKnzofXly+6ZheI+vrBt3TdbwktwdJFAqH9vINC/10W
         ACsfrkV0ltrutXi68W5T4aaspv023RZ4gY+hY3qMWK6zLYcVVNTkQ5F4eIdU4iClmG7M
         Ru09TohpfuzCA9t2M4gpGJOh9ANKVAJGYzxsJjas52DuU8irf9Qh8zSrqIAwGWHZY5sK
         QftrF2YqyIPIhgglewmVmpZW+OQADDRyUQcFmSkIugg+9BzgUz+T9LaEk3mNW3+l/A7R
         vn3NelBsj7561ahHw5dia9uTOfKXcHfzZonU+VEaZmpHD1uM1/5340zlSEQPPB8oGmaE
         c0Hg==
X-Gm-Message-State: AOUpUlHDhNQYKM9JzqJaQqk0TNEZljXrePY6yIQE97P/2g1ZD5TA7jNk
        C0JHaG0fhe/c2TogNUtovA==
X-Google-Smtp-Source: AAOMgpdSt/vpEmEWfBxMMEcYuCBqPHLb5YsWG2GO/anbR5vk3kbzn+95dxpoRq749tMnEGG99I0e0w==
X-Received: by 2002:a6b:1491:: with SMTP id 139-v6mr2449055iou.103.1532108307930;
        Fri, 20 Jul 2018 10:38:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m126-v6sm962267ioa.79.2018.07.20.10.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:38:27 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:38:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 5/7] iio: tsl2772: add support for regulator framework
Message-ID: <20180720173826.GA24398@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717084158.23532-6-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:41:56AM -0400, Brian Masney wrote:
> This patch adds support for the regulator framework to the tsl2772
> driver. Driver was tested using a LG Nexus 5 (hammerhead) phone with
> the two regulators and on a Raspberry Pi 2 without any regulators
> controlling the power to the sensor.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../devicetree/bindings/iio/light/tsl2772.txt |  4 +

This belongs with the binding patch. Bindings should be complete, not 
extended as a driver changes. 

>  drivers/iio/light/tsl2772.c                   | 82 ++++++++++++++++++-
>  2 files changed, 85 insertions(+), 1 deletion(-)
