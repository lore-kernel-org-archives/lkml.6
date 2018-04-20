Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeDTV50 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:57:26 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:46150 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDTV5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:57:25 -0400
Date: Fri, 20 Apr 2018 17:57:13 -0400
From: Rich Felker <dalias@libc.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sh: remove board_time_init() callback
Message-ID: <20180420215713.GT3094@brightrain.aerifal.cx>
References: <20180420154933.3235131-1-arnd@arndb.de>
 <20180420154933.3235131-4-arnd@arndb.de>
 <CAK8P3a2vh+BH_GJSPkc8D61+J2NK_e_HWJkuz6DVmb_Ln6ND0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vh+BH_GJSPkc8D61+J2NK_e_HWJkuz6DVmb_Ln6ND0Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:51:18PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 20, 2018 at 5:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > @@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
> >
> >  void __init time_init(void)
> >  {
> > -       if (board_time_init)
> > -               board_time_init();
> > +       timer_init();
> 
> Testing revealed this to be broken, the fix is:
> 
> diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
> index a29eb989d81b..8a1c6c8ab4ec 100644
> --- a/arch/sh/kernel/time.c
> +++ b/arch/sh/kernel/time.c
> @@ -39,7 +39,7 @@ static void __init sh_late_time_init(void)
> 
>  void __init time_init(void)
>  {
> - timer_init();
> + timer_probe();
> 
>   clk_init();
> 
> Let me know if you'd like me to resend the series with that typo fixed.

If there are no other issues to correct, I can fix this when merging.

Rich
