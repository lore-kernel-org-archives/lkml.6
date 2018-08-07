Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0CC46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AC3208D5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AC3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbeHGUED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:04:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40786 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389098AbeHGUED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:04:03 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so24111855ita.5;
        Tue, 07 Aug 2018 10:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkrnJZPdG91EWUCLSqK/H/AfektTZJIKfWqsfeV6yw4=;
        b=P/rOw+WDqLZprY8FMxtFQLipg6eqxGSB/pgHQfvRTM9YJDaFeIUdv/hawdF3scNlzt
         U2WToliSIUOBUD5g092PNVtdGaxm3+WPIsrYmb1TIHaMwZIoXqWuJ/YFLo5FcrZlNXsd
         GYwXVslN9ycjS4+2MlF8HSdc9WPb8W9UqUolZv2oOr3hUBkcJ1q44UMut+ArOZ9nbF9d
         UTxGBDB1hZ2MXSBBrqta3YXO3r4lCDcQnUUGF0nladz50A+/3cPdIJWnB2mA1xCeIXIT
         002i8l6tMjlUkyqk1q+UL7mAm8W+F8oioSW9Nl7PrIujiSGIpRdLYOfrZZCpjO41bPYm
         VXVA==
X-Gm-Message-State: AOUpUlGrMeZIKmis9yC/vFRufGTfAnKGUxxbFgRVbAM1FthDwV+xkNE1
        e7bDm5GVfiZWBZFTyJa/0Q==
X-Google-Smtp-Source: AAOMgpc10GPw5EH7E5Y7xe03grunrqtXoMSdz8VoCWtMF8zw0SZYwAK/jz8pBoqgpK9tpOgpYHQqkw==
X-Received: by 2002:a02:9bc1:: with SMTP id f1-v6mr17848202jal.90.1533664116536;
        Tue, 07 Aug 2018 10:48:36 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 82-v6sm1244559itm.2.2018.08.07.10.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:48:36 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:48:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, lee.jones@linaro.org, arnd@arndb.de,
        linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com
Subject: Re: [PATCH v2 01/10] dt-bindings: clock: Add syscon support to
 Actions Semi Owl SoCs
Message-ID: <20180807174835.GA13777@rob-hp-laptop>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
 <20180801033915.15880-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801033915.15880-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:09:06AM +0530, Manivannan Sadhasivam wrote:
> Since the clock and reset management units are sharing the same memory
> map, document the clock bindings to support System Controller.

This is no reason to add child nodes. The existing node can be both a 
clock and reset provider.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/actions,owl-cmu.txt        | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
