Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89127C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1686020855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MT3U/ci8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1686020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeKZTg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:36:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47080 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:36:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so15724263ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl/01wJdbl68kMZU3GUZfO6qYr4qR7b/e+82DOpA8Ao=;
        b=MT3U/ci82DhksDKqaZuW1aotSzNKh83h/ge6OUaIp+hNX12tfVt3DxHjLom2SWKu7X
         Q+TGPAAJS+mUtHsN/HDoXQeIp2o3hBoqPKlE1Muh7RHVSuje55qa29zye1aAgHQYzGFQ
         7KIpB0jxkkhPv/Pe/74H/cupm9YfqXfW9C9tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl/01wJdbl68kMZU3GUZfO6qYr4qR7b/e+82DOpA8Ao=;
        b=un5/BvMMQCxWyWyPm68aXBDGCjzuKzLi5roBKD0nsrh2vPy1DdbUQmDEfViPvPGNtP
         heuBrHm+qFeksaKYUPQrXvK6XNN6mF/KetJkFmG3wolE6nokWp7/njzVyrxrFRJA0bex
         VsIQ0h57pZz1AVLI6afMpqYrRIhYHd/tT6hj9H4Hb5bv8wJXUFF5OzCwC12DWMv6HjXv
         VCnVxvjmmDeRMcIwYUy5kdvWbpp8z1CWq6DwY49rB0O5lLN0E6LCuemLemHJJzWXheQk
         TM1Eoyv+Y8z/K/OCSyNgZMJb+YmH/znxROyb3qkqpGgL55ASmJOKg+JJOpe7DL3zaiyG
         p+ng==
X-Gm-Message-State: AA+aEWbUCwOsUNl9JU6PQQI+zkejHKgIhFIPDWVKnj8rJ8rk2ckVwOTb
        4pgPnFLtthUULYWFFK605jGFMiMpVyYNn19JGEKH3g==
X-Google-Smtp-Source: AJdET5eQUqLxLv2xNoVxZXchFCSjZGspKE7Cuw051rKDnamucTVAUBhSabrLB16XezWOLFKapicZw+QirGbs1r/tpH8=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr16153026ljg.23.1543221783527;
 Mon, 26 Nov 2018 00:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20181120111709.22128-1-phil.edworthy@renesas.com>
In-Reply-To: <20181120111709.22128-1-phil.edworthy@renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Nov 2018 09:42:50 +0100
Message-ID: <CACRpkdbaWRTiA5=Ost7TUWRuf5fT3UK9wz8kTf_g3jqZjB8Zfg@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Correct the DT node name in the example
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Hoan Tran <hotran@apm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:17 PM Phil Edworthy
<phil.edworthy@renesas.com> wrote:

> The sub-nodes should not be called gpio-controller, but simply gpio.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Patch applied.

Yours,
Linus Walleij
