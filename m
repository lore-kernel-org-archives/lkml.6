Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1732082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1732082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeKBSZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:25:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36575 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:25:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so1140389lji.3;
        Fri, 02 Nov 2018 02:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKajEDCUUfGYjW9KmM0LTrwV5Iy9tOZeEY5tD1ICF6U=;
        b=U062+/IiLC74KmxNyQVWi65BPlo4/8ZVm8apeA6Omh/gdrvNmjNJ0O51KdT6wAllKO
         HaxwTNHd0bpnNIarx17lwT63IBlhp6eq3ZpJDvFvPp72HyubYKFUFdwlMzbIGgP2JQwE
         c7CBTrXV5/EqamTIBG/wa2UWG1mximcyPW48VxOBI/daMMKfBvcDr5P5HAa/xd+MUP1k
         2GqWu6UxIXdz/BHBF9XKapj1+ONUmVdU/n8TuLFfKtETwYe9Sb1LVjeaEc5NRDDl4tKq
         uCw+PAMSHnm2xfPLanvkkb7CMQc5VQZ+pXSzUNyv+hkCVVbWqjFCyT3JGDtw9rZYNgfJ
         GjVw==
X-Gm-Message-State: AGRZ1gL9XfvWD0kqlcoM+YXJUAUc24WeK1NHGH2cSMD7GlIEOHNAgAhF
        6Mhe8j1cWKaEcD42kaRnpmg=
X-Google-Smtp-Source: AJdET5eT82FjdHXe9S/c+vJuh6LX7a5UlsNcl0OBo2WneB5PS6fAOVGHM+JMhkS7EdsQZRG2XpiK9w==
X-Received: by 2002:a2e:9653:: with SMTP id z19-v6mr453914ljh.112.1541150309072;
        Fri, 02 Nov 2018 02:18:29 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2380329lja.8.2018.11.02.02.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 02:18:28 -0700 (PDT)
Date:   Fri, 2 Nov 2018 11:18:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, kgene@kernel.org,
        s.nawrocki@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>,
        andrew.smirnov@gmail.com, sre@kernel.org, linux@roeck-us.net,
        robh@kernel.org, sjhuang@iluvatar.ai, Akshu.Agrawal@amd.com,
        rafael.j.wysocki@intel.com, djkurtz@chromium.org,
        mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
Message-ID: <20181102091825.GB29664@localhost.localdomain>
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <8e396e22b328f35538a01193797fbd0d001f885d.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
 <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof!

On Fri, Nov 02, 2018 at 09:19:10AM +0100, Krzysztof Kozlowski wrote:
> On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> >
> > Use devm variant of clkdev lookup registration in order to avoid
> > clkdev lookup leak at device remove.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Driver has suppress_bind_attrs and it cannot be built as module so
> device removal should not be possible. There is no need to use devm.

This is exactly what I wanted to hear =) I will drop this patch from
series.

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
