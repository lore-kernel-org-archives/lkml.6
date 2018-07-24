Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6A320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiMdu/uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6A320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeGXMiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:38:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43985 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388336AbeGXMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:38:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id r13-v6so3281129ljg.10;
        Tue, 24 Jul 2018 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fIOLANcyJGfuuLKH1lh29rpEjLBS/qkvuL0hBtdFHE=;
        b=GiMdu/uFubXCt1xWiTW2F+dHlqVdf59mVyveRsrBWJaL2excUu4WLEL1iPuhjmBXlm
         Pa/x1paP0IyeNSUL/IOy0z/rlWnQ+nMvKjCswuspBYQzRduw3ccG6MoEszZFJZMWZs5a
         VaJ9jE4dlm1byOqYsf1AB7hyn4dkgELWnxWT0kbPv7YIzob31cIK8h4VPgG8QwSR4CQM
         kXEcmonozj0KPpC22xLLZnggIkRyKKKN9qclOx+JsNSmWEQW9RLXzGUagcWJF9pSgEW9
         Ke2lYyzEF6Pa9NXmfHGspv8YgxvU3xxhkxUwPLqruZoGT3VPq6FyHAAjOKxISzFO7R5B
         izqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fIOLANcyJGfuuLKH1lh29rpEjLBS/qkvuL0hBtdFHE=;
        b=kpvSRCqCgJkvG1l1+35TVfxC2oF0AFbt7YZ+dKn59IeSQBlbUMX6bELncfuWydUavz
         Q5eHYkkFPycWFXk2u2FUzu+yfCUJgaZqX4AJ0v5YC8UXsD3ZLWu54VFxKqHN89/qi7pZ
         sgAZH9C7mgRrikssDbOHIq8L4sYIFQS7YP1rLnCD7D58vGSjLD1JU/jCE9qJXNuKMdwq
         0k4no3e/eirLayrf/OwO0vY+OBGhcqf4HWrUABlcediczh+tHHNxl263k6d3uRL1cx4M
         x29RaIXfBOfz9Y2uEY+Thg0s06pmK+A0EKdFUoH2ux06vpynJB1UezqjBh3kUWWGmIX9
         gcJw==
X-Gm-Message-State: AOUpUlEj4hLtTtkV4OiDNWSLlVxelDFRMF0NiwgPJIE47EQoLLdE8j6h
        NSavYug8belmBog2QZh/qR0=
X-Google-Smtp-Source: AAOMgpeCtKrgY6XpqnSaNx84CK3Xl5wyCo6PTfTLIYmBdEtocwdhMSO0sEmlzI/UWT3ViRslDROgjg==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr11608399lji.46.1532431919608;
        Tue, 24 Jul 2018 04:31:59 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m4-v6sm1762070lfc.48.2018.07.24.04.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 04:31:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, jonathanh@nvidia.co, thierry.reding@gmail.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
Date:   Tue, 24 Jul 2018 14:31:57 +0300
Message-ID: <16130866.kpFhQUNOMP@dimapc>
In-Reply-To: <6750449.onR3KBHYkZ@dimapc>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk> <20180720134532.13148-7-ben.dooks@codethink.co.uk> <6750449.onR3KBHYkZ@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 July 2018 16:05:21 MSK Dmitry Osipenko wrote:
> On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
> > The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
> > clocks by making a 2D and 3D mux, and split the divider into the
> > standard 2D/3D ones and 2D/3D idle clocks.
> > 
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >  drivers/clk/tegra/clk-id.h              |  4 ++++
> >  drivers/clk/tegra/clk-tegra-periph.c    | 23 +++++++++++++++++++++--
> >  drivers/clk/tegra/clk-tegra30.c         |  8 ++++++++
> >  include/dt-bindings/clock/tegra30-car.h |  7 ++++++-
> >  4 files changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
> > index b616e33c5255..0d202a70ce66 100644
> > --- a/drivers/clk/tegra/clk-id.h
> > +++ b/drivers/clk/tegra/clk-id.h
> > @@ -91,8 +91,12 @@ enum clk_id {
> >  	tegra_clk_fuse_burn,
> >  	tegra_clk_gpu,
> >  	tegra_clk_gr2d,
> > +	tegra_clk_gr2d_mux,
> > +	tegra_clk_gr2d_idle,
> >  	tegra_clk_gr2d_8,
> >  	tegra_clk_gr3d,
> > +	tegra_clk_gr3d_mux,
> > +	tegra_clk_gr3d_idle,
> >  	tegra_clk_gr3d_8,
> >  	tegra_clk_hclk,
> >  	tegra_clk_hda,
> > diff --git a/drivers/clk/tegra/clk-tegra-periph.c
> > b/drivers/clk/tegra/clk-tegra-periph.c index 47e5b1ac1a69..83967dac93f2
> > 100644
> > --- a/drivers/clk/tegra/clk-tegra-periph.c
> > +++ b/drivers/clk/tegra/clk-tegra-periph.c
> > @@ -263,6 +263,21 @@
> >  		.flags = _flags,					\
> >  	}
> > 
> > +#define GATE_DIV(_name, _parent_name, _offset,				\
> > +		 _div_shift, _div_width, _div_frac_width, _div_flags,	\
> > +			     _clk_num, _gate_flags,  _clk_id, _flags)	\
> > +	{								\
> > +		.name = _name,						\
> > +		.clk_id = _clk_id,					\
> > +		.offset = _offset,					\
> > +		.p.parent_name =  _parent_name,				\
> > +		.periph = TEGRA_CLK_PERIPH(0, 0, 0,			\
> > +					   _div_shift, _div_width,	\
> > +					   _div_frac_width, _div_flags, \
> > +				_clk_num, _gate_flags, NULL, NULL),	\
> > +		.flags = _flags						\
> > +	}
> > +
> >  #define PLLP_BASE 0xa0
> >  #define PLLP_MISC 0xac
> >  #define PLLP_MISC1 0x680
> > @@ -646,8 +661,12 @@ static struct tegra_periph_init_data periph_clks[] = {
> >  	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, 
> tegra_clk_epp),
> > MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0,
> > tegra_clk_host1x), MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60,
> > 0, tegra_clk_mpe), -	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 
> 21,
> > 0, tegra_clk_gr2d), -	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 
> 24,
> > 0, tegra_clk_gr3d), +	MUX("2d_mux", mux_pllm_pllc_pllp_plla, 
> CLK_SOURCE_2D,
> > 0, TEGRA_PERIPH_NO_DIV | TEGRA_PERIPH_NO_RESET | TEGRA_PERIPH_NO_GATE,
> > tegra_clk_gr2d_mux), +	GATE_DIV("2d", "2d_mux", CLK_SOURCE_2D, 0, 8, 1,
> > TEGRA_DIVIDER_ROUND_UP,21, 0, tegra_clk_gr2d, 0), +	GATE_DIV("2d_idle",
> > "2d_mux", CLK_SOURCE_2D, 8, 8, 1, TEGRA_DIVIDER_ROUND_UP, 0,
> > TEGRA_PERIPH_NO_GATE | TEGRA_PERIPH_NO_RESET, tegra_clk_gr2d_idle, 0),
> > +	MUX("3d_mux", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 0,
> 
> Now that the actual parent clock is specified by the "mux" clock, you have to 
> adjust the tegra_clk_init_table accordingly.
> 
> 
> 
> 

The 3d/2d clocks do not have a parent on T20 with these patches being applied.

# cat /sys/kernel/debug/clk/clk_summary 
                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
 clock                                0        0        0       32768          0     0  50000
 3d                                   1        1        0           0          0     0  50000
 2d                                   1        1        0           0          0     0  50000
 clk_32k                              2        2        0       32768          0     0  50000
    blink_override                    1        1        0       32768          0     0  50000
       blink                          2        2        0       32768          0     0  50000
    kbc                               0        0        0       32768          0     0  50000
    rtc                               2        2        0       32768          0     0  50000
...


Same on T30.

# cat /sys/kernel/debug/clk/clk_summary 
                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
...
 3d_idle                              0        0        0           0          0     0  50000
 3d                                   1        1        0           0          0     0  50000
 2d_idle                              0        0        0           0          0     0  50000
 2d                                   1        1        0           0          0     0  50000
 clk_32k                              2        2        0       32768          0     0  50000
    blink_override                    1        1        0       32768          0     0  50000
...



