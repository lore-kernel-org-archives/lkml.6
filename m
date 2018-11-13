Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFDA2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q69XpwXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFDA2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeKNChZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:37:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56166 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeKNChY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:37:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id i73-v6so7321290wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=7MG5r7Nv5624ysYT6CvIGEmOuqvNrvLFPOiLJJlAmxs=;
        b=q69XpwXhVlOFlLDP6mSHI2mRi3+IlOnt8w91k+YE95heAk1d8FCBo4rqc4lfZ1BilC
         fkxaOlM4x9OpwA5Y8XkA0/tyIDg/y+IblutJpR08CoUbXrmSHrLbp9+/gesMXELlRLGH
         aa0KfB1S2XOVhGK/kGfih/Rproa39CRz5c1LppWRMMXKjFWIFc7czbuK3vC8TAuFjrn2
         bs01kMmTDSUn4lxQ8A5F4csnenLK7XaFFVJ0qvFHobfTyG2Qk4zMWMzcwJIWUon3iqwl
         EFOoqH1tnBt5RMnW5GudFJVqNWdqsTQK/Hk7qQ+ATNB0zuZ8Yk0kOxh0iNzAVzbXISnW
         XGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=7MG5r7Nv5624ysYT6CvIGEmOuqvNrvLFPOiLJJlAmxs=;
        b=LFJWrE4Q60bWQdOHjd/+zOox6UPRAAGZ15ZH14ylAj/QIdrkIPsYYmPhv0xySOMs9S
         80npMV+n+m+o+tJ/3SpPpr82CUCsInXF9RzYkLv9wQID+6UVXPdgrnKwmZ2ZWDdcLJxB
         jqluCU0MYmeyKR6u2+uxsJEhu/KvvfDyRXXglV1J3BNIhhul6UNlR+nf84G5WnjoU72Q
         mZIGZ+IPomycsDuw4vZ6tO0/9kEd+ijULie9rTRhH3XKeI1jUBq5yMFmZOGY7uJwH/6m
         adXm8TMr40Yt3o+JJLMVSr5J4ZRVhy2egy2hSCllibMeCMpUZxhljThgK8jk08PG7vTs
         QZwg==
X-Gm-Message-State: AGRZ1gIb2SvNLDCiPpEpj7WcwY8WaZk0x5HCmJ+otQEFnZ2mvRin00au
        jCvV2vdkIgAS8M3j/eJAQAsdVPz77s8=
X-Google-Smtp-Source: AJdET5e9JJiPZMLhtw0/UFVW33w2MyZJEqnvF3R5wDh8Kam6PTQbqTIXkBVo7Vtcplgv4WLGkc9NEg==
X-Received: by 2002:a1c:b60a:: with SMTP id g10-v6mr4056574wmf.138.1542127111143;
        Tue, 13 Nov 2018 08:38:31 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local ([2a01:cb1d:4ce:ea00:2c41:ee84:3757:1dd3])
        by smtp.gmail.com with ESMTPSA id b5-v6sm15181592wma.17.2018.11.13.08.38.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 08:38:30 -0800 (PST)
Message-ID: <5BEAFE05.9070905@baylibre.com>
Date:   Tue, 13 Nov 2018 17:38:29 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     stable@vger.kernel.org
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
References: <20181105230820.3562-1-jbrunet@baylibre.com>
In-Reply-To: <20181105230820.3562-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stable team,

Le 06/11/2018 00:08, Jerome Brunet a écrit :
> From: Christian Hewitt <christianshewitt@gmail.com>
> 
> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> with reboot; e.g. a ~60 second delay between issuing reboot and the
> board power cycling (and in some OS configurations reboot will fail
> and require manual power cycling).
> 
> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> Co-Processor seems to depend on FCLK_DIV3 being operational.
> 
> Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> meson: add fdiv clock gates"), this clock was modeled and left on by
> the bootloader.
> 
> We don't have precise documentation about the SCPI Co-Processor and
> its clock requirement so we are learning things the hard way.
> 
> Marking this clock as critical solves the problem but it should not
> be viewed as final solution. Ideally, the SCPI driver should claim
> these clocks. We also depends on some clock hand-off mechanism
> making its way to CCF, to make sure the clock stays on between its
> registration and the SCPI driver probe.
> 
> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>


Could this patch go into the next 4.18 stable release since it hit linus master with commit id e2576c8bdfd462c34b8a46c0084e7c30b0851bf4 ?

Thanks,
Neil

> ---
>  drivers/clk/meson/gxbb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 9309cfaaa464..4ada9668fd49 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -506,6 +506,18 @@ static struct clk_regmap gxbb_fclk_div3 = {
>  		.ops = &clk_regmap_gate_ops,
>  		.parent_names = (const char *[]){ "fclk_div3_div" },
>  		.num_parents = 1,
> +		/*
> +		 * FIXME:
> +		 * This clock, as fdiv2, is used by the SCPI FW and is required
> +		 * by the platform to operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) The SCPI generic driver claims and enable all the clocks
> +		 *    it needs
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };
>  
> 
