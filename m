Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28114C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71A206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d6ZShPbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA71A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJMXqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:46:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51553 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeJMXqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:46:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so14859143wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=ncsNHE4dHzdM39SyoSpdehaTlOLxwW2ain4AkyDnGIY=;
        b=d6ZShPbDdmzWYggNcgnHXG07ys/62FzFqpsBpM2qQFcdX+AM4HSd98h4qAWgEHpttI
         S+oA5DBLOseWSit8RHgpV29bt4gQXPuMuVIsdsvBHcNxSOC8pgbTCaH5ztStVG1D5Ja8
         fgbfn5aXH71VVmJ+g5QJ1OgsLQAEqih4jSp7wm4jUAquuH/nWNSFQscffqAFWy12Aj8O
         kp8CvSL7GDO8FIJamnuxH0sjtsQsaxLmO1GqSsDyyYgNeKORut8tZk2s0KNo+MHD1WLJ
         +OkYbXoFTrqSFDggLA1BEsHMeXImhZ1FcTN7zhdW02AUhi4c254ADBlMdSCO8iRMRj4c
         uiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=ncsNHE4dHzdM39SyoSpdehaTlOLxwW2ain4AkyDnGIY=;
        b=tWCCh2gjUuwcAht3cJxUt46JMfytweNGcHjMtxQOpAlgAnQ8cwNAg4OgavesVxx/J5
         DEA/QeD477iIxC4p/vLDq9i1oCfmv9XATqSEYjsNGlDk8brqwohPTephyvv2HzxeNeFO
         oJ/CM7L4hIDhyA9/OfnnFHTQzyUdYCoqzR6+0nwQscEGwYkJBhPWUGb53w66eHNQ+b+1
         PTA9ban0uxtge0Aung8+1Bz5TPGGgX5VsNhf9c7xUZqtdHZpBx/Pqu4s6h/UmGXaN2XE
         Aug40p447IIwG45iVQIToIpKLUaEVjeCSBK04KazWWw7G/jsTU1hhmnv7qG/rXrCnSof
         IGoA==
X-Gm-Message-State: ABuFfogqDexHdkVFy6R4QM6zMCo6DGJPMTVjGyEQGGhzMZyU9R+w0Gp5
        qVQ0KPs96RMJ2F8N7TXbIMTzbg==
X-Google-Smtp-Source: ACcGV63rvyAsLx6lS1G6K73wCyi+wJa4NT6bf/Q+FcXkEF/Xawy6tlGIuyyyp+6YTuP2oOALS43MPw==
X-Received: by 2002:a1c:2984:: with SMTP id p126-v6mr8879677wmp.5.1539446920586;
        Sat, 13 Oct 2018 09:08:40 -0700 (PDT)
Received: from localhost (176.143-204-14.abo.bbox.fr. [176.143.204.14])
        by smtp.gmail.com with ESMTPSA id e7-v6sm4043916wra.37.2018.10.13.09.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 09:08:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Christian Hewitt <christianshewitt@gmail.com>
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
Message-ID: <20181013160810.88481.14237@resonance>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Sat, 13 Oct 2018 18:08:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Hewitt (2018-10-13 12:04:46)
> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> with reboot; e.g. a ~60 second delay between issuing reboot and the
> board power cycling (and in some OS configurations reboot will fail
> and require manual power cycling).
> =

> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> Co-Processor seems to depend on FCLK_DIV3 being operational.
> =

> Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
> bad commit. This added support for the missing clock gates before the
> fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
> disabled all the unused fixed dividers, thus it disabled a critical
> clock path for the SCPI Co-Processor.
> =

> This change simply sets the FCLK_DIV3 gate as critical to ensure
> nothing can disable it.

I'm a bit skeptical of this. If FCLK_DIV3 is gated at run-time, there is
no side effect other than long and/or failed reboot?

Seems like someone should be managing this clock, and simply leaving it
on all the time isn't necessarily the right approach. Any chance that
you can dig into this behavior to better understand it?

It's easy to solve issues by leaving clocks on all the time, but this
becomes a problem later on when trying to tune a device for power.

Also, if this commit really is the right fix, it should include a
comment for FCLK_DIV3 stating why the CLK_IS_CRITICAL flag was set,
which may be helpful later on to know if it is safe to remove it. Same
is true for FCLK_DIV2 in c987ac6f1f088663b6dad39281071aeb31d450a8.

Regards,
Mike

> =

> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/clk/meson/gxbb.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 86d3ae5..4c8925d 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div =3D=
 {
>                 .ops =3D &clk_fixed_factor_ops,
>                 .parent_names =3D (const char *[]){ "fixed_pll" },
>                 .num_parents =3D 1,
> +               .flags =3D CLK_IS_CRITICAL,
>         },
>  };
>  =

> -- =

> 2.7.4
