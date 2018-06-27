Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39EEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEA521C3D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0pN94tkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEA521C3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965868AbeF0Q73 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:59:29 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38726 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965267AbeF0Q71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:59:27 -0400
Received: by mail-wr0-f179.google.com with SMTP id e18-v6so2761094wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XCn5k2/fmFWezQ2c7kROCz/j0evoe5AvNY8khfp5tnY=;
        b=0pN94tkpFJo30bv21m9pvlRCKSHO4zEGIV5lFVYxNYhjCSQbcrvN1WTRDbNk9tEoxy
         ZruDcAXecYq676ZBo/FMPhLpObfvkNzTYO6OJpzCg4xtBSOqG+5wkeS1aZAwhBRPP89U
         tB2zoSgAgb293hEDr2g06mRmX22rNc0lgSYVl9/vqHaOr25rK8ly989u9f3P/tBZM1RB
         fiApQIfs6n5STzfqtlU0IEwSKGSOkF0AqKJEBUQD4L6ygiUUg/kGBHm98Bx7pUmVh6b2
         0pzb6Oez91h4RY6/iJh2+04/EgD4kr4OSG5kLPU1LbXtYhHOjjJyC8VKjr2WC6VrzGjH
         XQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XCn5k2/fmFWezQ2c7kROCz/j0evoe5AvNY8khfp5tnY=;
        b=tciUKGxztECahQiJZKpLMdrt5zSk1KE82FV5Xg/5N+7rR9RgJ9FjsHnr6mCmhtDe0b
         zQn/opzPj4GAsMn6TukgJtjjzvX67eOocKSW53cNSg2oQ5NFklJ8OmpZuNToZMSK0ijp
         H4aG1WEGBP05w+dV3+Evelp2a8buptwgfIS7OeSXI69HPKOY5vZvkR2pUWu4dNuLw1GG
         OaS2yv7cAVlqj7QiuM019js+KSbYVib9Odd6JwxpGnre6aYwaAoRXljFfibw6+sgikvB
         7zWjwQl0VI8AFOsHGNXqBO9PXyz5UHYZug6Vi+gJDcIlLdABNn5C2KsrbXCUT1iu7dGW
         NlFg==
X-Gm-Message-State: APt69E1k+UEuUecnhikMUg1qsz+0ZHUZyORwV46w0poI2vJr+GpSYus9
        Tt99hlawLIs7brOtJjtFrCgkhQ==
X-Google-Smtp-Source: AAOMgpcQNIpXi/VmFwJi5yXGMuvXtnw2zQADa5RfoLA5DMt9Ms18bQtEUGW04J848B3iKfSrXSeg+g==
X-Received: by 2002:adf:de8e:: with SMTP id w14-v6mr2479915wrl.72.1530118765849;
        Wed, 27 Jun 2018 09:59:25 -0700 (PDT)
Received: from [192.168.112.17] ([89.249.64.228])
        by smtp.gmail.com with ESMTPSA id l6-v6sm3263626wmh.41.2018.06.27.09.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:59:24 -0700 (PDT)
Subject: Re: [1/3] ARM: dts: imx51-zii-common: create common include dtsi
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1529603100-31958-2-git-send-email-andrey.gusakov@cogentembedded.com>
 <5a3490a5-ee5c-a4da-8b54-b5234b7e50d0@yandex.ru>
 <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <72694ec0-45ee-6f57-ebbf-249d4a0b23bc@cogentembedded.com>
Date:   Wed, 27 Jun 2018 19:59:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqH0o2rsVJWccR6dBXQCnp2-mmLNTNOi0uAOO2SSdz0+xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are three boards that share that configuration almost to a T,
> with the only difference is the particular GPIOs used. Putting it into
> a common file avoids repeating the boilerplate and makes it explicit
> to the reader that those settings are shared.

I'd agree if that boilerplate was 100 lines.

But here it is small, and mostly containing lines that are required for
any i2c-gpio definition. It does not any value of itself.

Saving 5 lines at cost of loose of integrity is not something I agree with.

> There are at least two boards that use that UART2 as is. Same as above
> this was done to reduce boilerplate.

Here have choice between two logical blocks - definitions of uart2 in
two boards that use them, and two logical blocks - definition in dtsi
and undo in board that does not use it.

You trade a couple of saved dts lines against keeping things consistent.

Nikita

P.S.
In case of these zii boards I doubt that dtsi worths at all. Despite of
all being imx51 boards from ZII, these boards don't seem to have large
common logical blocks. Perhaos RDU1 and babbage have more in common - so
what, create a dtsi for them?
