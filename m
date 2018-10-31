Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D93C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeJaWrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:47:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42930 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:47:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so11673456lfh.9;
        Wed, 31 Oct 2018 06:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3V5Plx9/dwtLa19kcNGTp3GLjGHwao6UZTFezL9clXs=;
        b=SiZ9o3co9yzOIIE/aMXndaYBjqHzTpn7kqSGejSN5HmOJI1IBnkbgKU+M/5sGn8jyS
         hi39tGYoodbM/iMwDeY9WHGxqjWR0PeN6o3m1FyE2YL+0vLNtKrB8v8SeDdRlgv3mOlg
         ZoCOUlcPapz+LSBWGK49aRleI/J28E22TvG8RRNkALf6tvlvZKj8i0rAaBcWrM9r/18f
         kZGzYCCQrV+99j/2xd/qW7OgwE63qi/ffNhEgJk71TZyPZkiN7oQm1UfbTbme/yYf5hg
         rGEBO4hfeK3PnErjbDCu5dNgTBerrraBvzhYJGKoYiFsJEMn0OnVRLquJclQMT6sDkql
         PNlg==
X-Gm-Message-State: AGRZ1gIrHlPZzVJsNpXN6+aD7gO4HY3h+W5jm2mLMuAQv1RjAa4gr5SE
        ojpldJEz9vHMsAZws0DhhiM=
X-Google-Smtp-Source: AJdET5d8RuN3mn6hU2t7YVXPv2CD4WBfE5EXKPs+B+JdYd6vnFCVdMtG4K7jEWW0ieEXArAHuWT2VQ==
X-Received: by 2002:a19:690d:: with SMTP id e13mr1893069lfc.84.1540993738707;
        Wed, 31 Oct 2018 06:48:58 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e14-v6sm469230ljl.43.2018.10.31.06.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 06:48:57 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:48:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Message-ID: <20181031134847.GA29664@localhost.localdomain>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
 <b3954431df109827c71d25d390adf22f6991a6df.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3954431df109827c71d25d390adf22f6991a6df.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:30:34AM +0200, Matti Vaittinen wrote:
> With MFD devices the clk properties may be contained in MFD (parent) DT
> node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> subdevice not to MFD device (parent). Add
> devm_of_clk_add_hw_provider_parent to tackle this issue.
> 
> Also clkdev registration lacks of managed registration functions and it
> seems few drivers do not drop clkdev lookups at exit. Add
> devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> releasing at exit.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

//snip

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 60c51871b04b..94c7bf471c31 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -916,6 +916,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>  			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
>  						 void *data),
>  			   void *data);
> +int devm_of_clk_add_parent_hw_provider(struct device *dev,
> +			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> +						 void *data),
> +			   void *data);
>  void of_clk_del_provider(struct device_node *np);
>  void devm_of_clk_del_provider(struct device *dev);
>  struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,

Right. Didn't spot the 
#ifdef CONFIG_OF
in clk-provider.h. So patch lacks of stub functions for non OF
architectures. The 0-Day test system spot this. Tomorrow I'll send v2
where the inlined stub functions for non OF architectures are added.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
