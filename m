Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253F320879
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253F320879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeLDXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:16:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42319 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:16:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so16878633otk.9;
        Tue, 04 Dec 2018 15:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UL2J76qJXqjw7YRqc6/qr2U0W/xJv06W6yFunJq1Grc=;
        b=Vw95DO9gm8Gzly4zCvrM7Bh/cqg7sQyQasxKUI6DQH+RqfKsEUfsM1tk4cUXp8Ac8d
         ro16bafq6IkKxWOtM7Lnp3xL/fE/UtN3wNDUcjwqwdZvTwPtSkWRnz4jC9ztLiiDiWey
         2BP6QH2k1gSroYXTIIAT422HAO+FrG8e6L4tYeJlVJwWAxPjMhkJCiLub4kktadzAyPt
         DQoR3JY7QtVMitoE02NcdlyAm2nZmiOqB90b3P0ExxfrlSfzxTwK2iovN0ptpngn7W0L
         muYpA58B0YAi0fB1pj+B7Zr/Mq9nfboklOaQgZOLA4IdbV/3z/ar7l1x7wZR0O5g0sbg
         lXsg==
X-Gm-Message-State: AA+aEWaOJc6uVxS6g+BQQaatueKOl+wBSpeks2SrNWjmC5K7bAiQGdCN
        r9BiXxM/BDvmhzyJWoWP0A==
X-Google-Smtp-Source: AFSGD/VpRmhh+vxY50JdGT/Q1NfUo7kQI2w3ZkKcxcBqQfNwblpjgzSoWZLGOAlGofEowQ0Uajhpww==
X-Received: by 2002:a05:6830:1005:: with SMTP id a5mr13249227otp.113.1543965368506;
        Tue, 04 Dec 2018 15:16:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm6881315otq.80.2018.12.04.15.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:16:07 -0800 (PST)
Date:   Tue, 4 Dec 2018 17:16:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
Message-ID: <20181204231607.GA16737@bogus>
References: <20181119094509.22542-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119094509.22542-1-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 15:15:09 +0530, Vignesh R wrote:
> AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> handle AM654 SoCs. Also, it seems that existing compatible strings used
> in the kernel DTs were never documented. So, document them now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
