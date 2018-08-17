Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2CBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728942152C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728942152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeHQSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:36:02 -0400
Received: from mleia.com ([178.79.152.223]:60142 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbeHQSgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:36:01 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 2B5A040FC3B;
        Fri, 17 Aug 2018 16:32:12 +0100 (BST)
Subject: Re: [PATCH] pinctrl: lpc18xx: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180815171035.GA17360@embeddedor.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <57a0c7c7-e2a2-3586-b683-f854120eeee7@mleia.com>
Date:   Fri, 17 Aug 2018 18:32:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180815171035.GA17360@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180817_163212_199416_6620D812 
X-CRM114-Status: GOOD (  13.25  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 08:10 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1292308 ("Missing break in switch")
> Addresses-Coverity-ID: 1292309 ("Missing break in switch")
> Addresses-Coverity-ID: 1309546 ("Missing break in switch")
> Addresses-Coverity-ID: 1357369 ("Missing break in switch")
> Addresses-Coverity-ID: 1357389 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pinctrl/pinctrl-lpc18xx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
> index 190f17e..a14bc5e 100644
> --- a/drivers/pinctrl/pinctrl-lpc18xx.c
> +++ b/drivers/pinctrl/pinctrl-lpc18xx.c
> @@ -844,8 +844,11 @@ static int lpc18xx_pconf_get_pin(struct pinctrl_dev *pctldev, unsigned param,
>  		*arg = (reg & LPC18XX_SCU_PIN_EHD_MASK) >> LPC18XX_SCU_PIN_EHD_POS;
>  		switch (*arg) {
>  		case 3: *arg += 5;
> +			/* fall through */
>  		case 2: *arg += 5;
> +			/* fall through */
>  		case 1: *arg += 3;
> +			/* fall through */
>  		case 0: *arg += 4;
>  		}
>  		break;
> @@ -1060,8 +1063,11 @@ static int lpc18xx_pconf_set_pin(struct pinctrl_dev *pctldev, unsigned param,
>  
>  		switch (param_val) {
>  		case 20: param_val -= 5;
> +			 /* fall through */
>  		case 14: param_val -= 5;
> +			 /* fall through */
>  		case  8: param_val -= 3;
> +			 /* fall through */
>  		case  4: param_val -= 4;
>  			 break;
>  		default:
> 

The code snippets are about a mind-blowing hyper-optimization, but I took
it as a chance to verify the correctness, and there are no issues found.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
