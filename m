Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCXA1S (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 20:27:18 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:34169 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCXA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 20:27:16 -0400
X-Google-Smtp-Source: AG47ELuD6YbZkk3SBrroxjsk6oRuho9c26o+Cy1dOd+uDVgMcxx099dM/0EFR96W/5mRgcSNjLacJ6c1PATrNmD15Wg=
MIME-Version: 1.0
In-Reply-To: <20180323094937.5wx5exah6tfyl43u@fsr-ub1664-175>
References: <20180323094937.5wx5exah6tfyl43u@fsr-ub1664-175>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Mar 2018 21:27:14 -0300
Message-ID: <CAOMZO5Da0GbkC1vjjbyNmG77gvd-KO8HC-2oBYxAffNHCtEDKw@mail.gmail.com>
Subject: Re: Return checks for clock calls
To: Abel Vesa <abel.vesa@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Adriana Reus <adriana.reus@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abelvesa@linux.com" <abelvesa@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Fri, Mar 23, 2018 at 6:49 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> Hi Shawn, Fabio,
>
> I'm trying to get the imx clks changes upstreamed. To that end, I reached this
> old commit that adds some wrappers over the generic clk API. Here is the commit
> message:
>
>         ARM: imx6: add return check for clock calls
>
>         There are a bunch of clk_enable_prepare, clk_set_parent and clk_set_rate
>         calls in imx6 clock driver's initialization.  They are called without
>         retunr check.  If there is something going wrong with the calls, they
>         will just fail silently.
>
>         The patch creates a set of helper functions imx_clk_enable_prepare,
>         imx_clk_set_parent and imx_clk_set_rate, and use them instead from clock
>         initialization to check the return and print error message to tell
>         failures if any.
>
>         Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>
> And it adds the imx_clk_set_parent, imx_clk_prepare_enable and
> imx_clk_set_rate which basically just print an error message if the generic
> functions have failed.
>
> The only plus of these wrappers is that we at least see that the generic
> functions have failed, but the behaviour is not changed in any way.
>
> Question is, do we want this upstreamed considering that we need to replace the
> calls throughout all the older imx socs ?

IMHO we should not introduce these new helper functions.

We can simply explicitly check for errors with the existing clock
functions when needed.
