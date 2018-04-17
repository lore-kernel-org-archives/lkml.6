Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeDQOPj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:15:39 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45125 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDQOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:15:37 -0400
X-Google-Smtp-Source: AIpwx49KlXm+uOCEmnoXdx941nYUyb0axGLsEoVnIn3bJWJQ1WPdMpzxUoIxZyMlu/elIRqegGiDLg==
Message-ID: <1523974533.2601.95.camel@baylibre.com>
Subject: Re: [PATCH v5 2/7] clk: meson: aoclk: refactor common code into
 dedicated file
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2018 16:15:33 +0200
In-Reply-To: <759078f5-fcbf-9ef1-6945-67d9d951d8eb@amlogic.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
         <20180409143749.71197-3-yixun.lan@amlogic.com>
         <1523875084.2601.28.camel@baylibre.com>
         <759078f5-fcbf-9ef1-6945-67d9d951d8eb@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-17 at 16:16 +0800, Yixun Lan wrote:
> Hi Jerome
> 
> On 04/16/18 18:38, Jerome Brunet wrote:
> > > +	 */
> > > +	for (clkid = 0; clkid < data->num_clks; clkid++) {
> > > +		data->clks[clkid]->map = regmap;
> > > +
> > > +		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > > +		(void *) data->hw_data);
> > > +}
> > 
> > Missing new line here. Please run checkpatch and pay attention to git warnings
> > about whitespace errors.
> > 
> 

Google this if you want, As far as I know the C language requires it and makes
things nice when I cat the file.

Anyway, I don't make those rules, It is just how it is.

> 
> I think we actually need to avoid this extra new line, or what's the
> benefits with new line?
> 
> and besides， I didn't see any complaint from checkpatch.pl ..
> 
>  ./scripts/checkpatch.pl
> 0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #235:
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 302 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or
> --fix-inplace.
> 
> 0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch has
> style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> Yixun
