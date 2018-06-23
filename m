Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8970C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE9424C48
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvFq7lCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE9424C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFWPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:39:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46596 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFWPjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:39:00 -0400
Received: by mail-ot0-f195.google.com with SMTP id v24-v6so10682623otk.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nuo/Kibd1dNvU4IGz2LwWCVl2WvP9YCv9ijTni7VxZc=;
        b=RvFq7lCFoz4nNHjnd9VMJORT1UTV5BzZYP0P5DGBN43q6/fcuP818CdwmML2fiWj0c
         UiVh3Nk48fQZwikpacSD3yPWryHTIzh1nFp1qAumckMlHwGzWG67DgV/PdbcmO2o7U5B
         9Y2plGbwvYCav3YGw92sUaqG2yAL/6nMiESoAVm07SYt5kzI2IoMAruPfeSLOXwWdkxr
         4sa5jyx6mm+odRDlrmuUXlbcsZQGSCcPwIPL8We1KKim7VJeTHibKkyTSvDX5jhZu3+z
         5t1edR8+Fgzz4mweKGnYng/eRz4UVXknLU9jK4E0faWa2HNjvfduP1DR8ZITiO+XaKq0
         upSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nuo/Kibd1dNvU4IGz2LwWCVl2WvP9YCv9ijTni7VxZc=;
        b=g/f3yCtqYXlBBPhw8AJUntLQVRjs+ea7Q8QKtM7GFxNE/roPBdRc0D5C3/a5PHRYwM
         i+TuUd6k2NLi6mvWVik2YObyaTwF9GXSJ7g2/Lb3bmb0QEuyKP8+M/fJDW7YOuElLU5m
         NhqlJ3n0RF9vSQhupkahUD1yOYUBN7LrKguNJdn20GBFFX7PZKliniEDu3fnrJIoqMmT
         JCob4RD33PewJNFatZr+7ipO2pc9gDrqP7HnxF4UTS098uDstoqkkk2TVOwkZf6izf7C
         89Iciltc/dBzahV64H2WA6vMCs/TMJjLsSyE1/psVebQALN0xWKFePo6X4is2RsZihKC
         6mXg==
X-Gm-Message-State: APt69E3EuF/z+oALWoprWPCgvpbqYaftbDEvuYCu8RKp67P573h6iSv+
        2rnHvzz711f1rVyLvUQgTywTQ0nuDV+uaN8h+cA=
X-Google-Smtp-Source: ADUXVKLUd1rC5kqEOYvUCtpBHFndGhF5c+xolwAdDexQ0mHKcxOjhSgErMRv3N8iYm7mCbkyEUko1PagN8aCQz2rQEM=
X-Received: by 2002:a9d:1813:: with SMTP id b19-v6mr3709654ote.128.1529768339321;
 Sat, 23 Jun 2018 08:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 08:38:58
 -0700 (PDT)
In-Reply-To: <1529636119-4076-1-git-send-email-chakra@openedev.com>
References: <1529636119-4076-1-git-send-email-chakra@openedev.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 12:38:58 -0300
Message-ID: <CAOMZO5DJGCESqtSqbEw4O0Vxv3noUoCrTgbRCmwB2fJdVvu0RQ@mail.gmail.com>
Subject: Re: [PATCH] Fix for clk disable issue on imx6ul
To:     Chakra Divi <2chakrass@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chakra Divi <chakra@openedev.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Yongcai Huang <anson.huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chakra,

On Thu, Jun 21, 2018 at 11:55 PM, Chakra Divi <2chakrass@gmail.com> wrote:
> isiot engicam board is not booting after the
> commit cf091ee994ec266e33c3a305d6fc8c5ccb1f8acd
> done by <robin@protonic.nl>. Modified the
> commit to support imx6ul based SOMs too along
> with imx6ull processors
>
> Signed-off-by: Chakra Divi <chakra@openedev.com>
> ---
>  drivers/clk/imx/clk-imx6ul.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index ba563ba..69ec9f0 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -80,7 +80,7 @@ static struct clk *clks[IMX6UL_CLK_END];
>  static struct clk_onecell_data clk_data;
>
>  static int const clks_init_on[] __initconst = {
> -       IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
> +       IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2, IMX6UL_CLK_AIPSTZ3,
>         IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
>         IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
>  };
> @@ -358,7 +358,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>         clks[IMX6UL_CLK_GPT2_SERIAL]    = imx_clk_gate2("gpt2_serial",  "perclk",       base + 0x68,    26);
>         clks[IMX6UL_CLK_UART2_IPG]      = imx_clk_gate2("uart2_ipg",    "ipg",          base + 0x68,    28);
>         clks[IMX6UL_CLK_UART2_SERIAL]   = imx_clk_gate2("uart2_serial", "uart_podf",    base + 0x68,    28);
> -       if (clk_on_imx6ull())
> +       if (clk_on_imx6ul())
> +               clks[IMX6UL_CLK_AIPSTZ3]        = imx_clk_gate2("aips_tz3",     "ahb",          base + 0x68,    30);

Looking at the CCM_CCGR0 register (address: 20C_4068) there is no
aips_tz3 clock gate in bits 31-30.

Bits 31-30 are gpio2_clocks and Anson has recently sent a patch adding
support for it:
https://patchwork.kernel.org/patch/10481351/

Please test Anson's patch as it should fix the problem you had.

Regards,

Fabio Estevam
