Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3318384-1525186961-2-4498353538878243186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES rosk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525186960; b=dHlKKsqWc6/tDKFGD+g/LVHWyevgZoHXb7OKZ3caDI7sQmYID1
    dvikQc+sN1yZ7ym7fjiAXnhJRW7EqEmR+gTWzTB24sllUM3NgxoHaR+lnmXSY+x9
    UOc2qwNS3QGowNCLVA2nO+9NGmoDzKdKlGDLCg8riqertFtNwm5GK1RVegogPIUN
    SyfgR44e3L6nAWEfIshzCz4HnYhfdo8BdVL1G/jNqNYXNWIUXcGaDL8lfOAaneWD
    0GR/ZhINK2qfQHOBSg3lK4/IMNoF+RxaA9a62WmWIGa9pMhgeTBpZclDbK4cDddH
    RnEiLovbIGy513gN3PjwauaLgXaP3P+yZ23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525186960; bh=A9WmrwfKOaJXVW1yjvFGYbFzwOB0pt
    gSyxKytwdsEbU=; b=bZbT/V+9I6r6z1KaQnw9ciXCjw4wQRHdAg1v7pfmQ26QQd
    dUe3T3Ma8prOEwL3fHKYOyYfCHe3Rs46WExoEccOmOOEiNBgWoXThY2Xir15LoHG
    lQuU/5z0G+lQgv4oD3p/OT0+3q+MyTOf+T45Sl7HakSVaeD97lClTYcNBIwKQmc6
    IrF0t7BJsQALqJ6UQZ0UmZDa78f2qVEqf0INN//vmWSNg8/3qtvxEbodigunbvmr
    s+h/CEAj9LiOsYwKZA6yFEmzXsn6kTqYk59hJWKmuxy4eaCx7CamPwf0c8NGQpFx
    Owu7zGLvNqpn+hsLCYqTE7XrTD7a1Eqat5GS0PVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=UHiOFU9+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=UHiOFU9+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPn8YRBJhRuCaF7MfLEqZhXJTdUwfzuN3DqJRVwX31ANXWtDJKsXe1G367Lnu+gFhwhFmGqdOi55hANeoTjNt2Gyug0w3o9jnLc+V9DhJQGuSfVqzS9o
    ERPE6U4e7tBkjH8P0aUQGeORTL/vEbS6jOYb3nSuRe3ZAE2SV4E6BupY8ILpVbePUczHA74zSD4nETkvRykweVJFrGmFgFawuPmpQow/joKOBdsERgRMT1Lg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=V5REGkeJ_iDhcJ-YuxkA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755945AbeEAPCj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 11:02:39 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33165 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755443AbeEAPCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 11:02:38 -0400
X-Google-Smtp-Source: AB8JxZpdZ063la5S1NqrzRjdzRzBgFoPWe3RKKYeGkcLzadnM5Yxqd94VyAvCtjOkz/2iBWotk6Vmg==
Date: Tue, 1 May 2018 10:02:36 -0500
From: Rob Herring <robh@kernel.org>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
Message-ID: <20180501150236.GA15330@rob-hp-laptop>
References: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:22:32AM -0700, Jae Hyun Yoo wrote:
> This commit fixes incorrect setting of reset bits for PCI/VGA and
> PECI modules.
> 
> 1. Reset bit for PCI/VGA is 8.
> 2. PECI reset bit is missing so added bit 10 as its reset bit.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/clk/clk-aspeed.c                 | 4 ++--
>  include/dt-bindings/clock/aspeed-clock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 5eb50c31e455..2c23e7d7ba28 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -88,7 +88,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>  	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
>  	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
>  	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
> -	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
> +	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
>  	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
>  	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
>  	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
> @@ -297,7 +297,7 @@ static const u8 aspeed_resets[] = {
>  	[ASPEED_RESET_JTAG_MASTER] = 22,
>  	[ASPEED_RESET_MIC]	= 18,
>  	[ASPEED_RESET_PWM]	=  9,
> -	[ASPEED_RESET_PCIVGA]	=  8,
> +	[ASPEED_RESET_PECI]	= 10,
>  	[ASPEED_RESET_I2C]	=  2,
>  	[ASPEED_RESET_AHB]	=  1,
>  };
> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> index d3558d897a4d..8d69b9134bef 100644
> --- a/include/dt-bindings/clock/aspeed-clock.h
> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -45,7 +45,7 @@
>  #define ASPEED_RESET_JTAG_MASTER	3
>  #define ASPEED_RESET_MIC		4
>  #define ASPEED_RESET_PWM		5
> -#define ASPEED_RESET_PCIVGA		6
> +#define ASPEED_RESET_PECI		6

You can't really be changing these as they represent an ABI.

Is there no PCIVGA reset?

>  #define ASPEED_RESET_I2C		7
>  #define ASPEED_RESET_AHB		8
>  
> -- 
> 2.17.0
> 
