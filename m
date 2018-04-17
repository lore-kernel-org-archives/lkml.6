Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeDQIQX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:16:23 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51225 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeDQIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:16:21 -0400
Subject: Re: [PATCH v5 2/7] clk: meson: aoclk: refactor common code into
 dedicated file
To: Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
 <20180409143749.71197-3-yixun.lan@amlogic.com>
 <1523875084.2601.28.camel@baylibre.com>
CC: <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <759078f5-fcbf-9ef1-6945-67d9d951d8eb@amlogic.com>
Date: Tue, 17 Apr 2018 16:16:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1523875084.2601.28.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome

On 04/16/18 18:38, Jerome Brunet wrote:
>> +	 */
>> +	for (clkid = 0; clkid < data->num_clks; clkid++) {
>> +		data->clks[clkid]->map = regmap;
>> +
>> +		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +		(void *) data->hw_data);
>> +}
> Missing new line here. Please run checkpatch and pay attention to git warnings
> about whitespace errors.
> 


I think we actually need to avoid this extra new line, or what's the
benefits with new line?

and besides， I didn't see any complaint from checkpatch.pl ..

 ./scripts/checkpatch.pl
0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#235:
new file mode 100644

total: 0 errors, 1 warnings, 302 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

0002-clk-meson-aoclk-refactor-common-code-into-dedicated-.patch has
style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Yixun
