Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-923211-1522742433-2-7625105784054160731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522742432; b=drH76De6apUCMzexzUKKQOZQRAnkfNRB1lxgdb5/P4sMgPIjoO
    SRsGvIBsxiPV3qAbbTDNt8mTZkQwoGW+/O5wsLeNUzDs9AphqF4iWVgJEUo6hXiN
    wexd+ftoLouiy7OTYElCmXWO+F5Ogj2wiac59KJNle+UEG3QUjw3xbRhWoUtV177
    yw5pde+1brwUrpS+mBANqBNJTk3jIARGpkMbuSzAXtPxaLAhMcNUSE2ZA+M/KgP+
    C1voHAKMVFHH1Cms9N/KUTffQYy7BJAfchq0zXa6cyfnoYiGcBQRCVkgmcxqKlQ/
    diRuGqJZGwW4ukjDPYCjAeD+INRYmj7Gv1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522742432;
    bh=C4QDGVL/fzV982r6ZX2Fm4V9tMpFh5w+FgPd1gYvvS8=; b=vPNBCFocmUnK
    BguGlLLKSYsHCikfBhYQA7u074O1yL4LBdsu9rLTUALA+ETakiocvZhUL9t3PP+/
    Hh3j5VY+nhzLlUz/6VOb6w7mYbSIWCF0foVE2Igl0ELJvuYx5KyKElB59HsEhfrK
    +mLxHgeHLs23QZOOh9NGRM6sDrfx3frGN1XGp/rZBEDurH/R/bsvVcTOnw3OO/nQ
    vwX4Q4d3RmUVNca/+j0u79+7fz27wi8gShWEZyTLBMT6Ee/LsKs8vXumAmqbF3iJ
    xqwDQ1zbqsXAMP6BgKf96wl9zcpGgLDKMYfNm9GQqckBDvoFS9aH9Vv8TLwjWMpQ
    GtuzfgHSDw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGK60LufInTtZk1qmycfr1X5HJsr8x2CMLBZA0GLeZS4C1zD4M5cNgh3jL77HQak+H/gx2HAv42mDyc4MdDy4F84RBIFdYrXF8hEkboiST3Paqhk6ngl
    Aj1kZyqcz58fy9EryGCFYTHTgJ3gf7fvihv8/vSxY0mGwAXmM8KL6D35pcKGmz5wQBIJu0TVM9LY4gd78pH1h8qtUxcHmcjbYccbDciAgey/m6YQqdH25gpR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=7G0kO3H3RDkZq6OZ0yoA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeDCIA3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 04:00:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54447 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeDCIA3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 04:00:29 -0400
Message-ID: <1522742421.5089.1.camel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset
 control
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 03 Apr 2018 10:00:21 +0200
In-Reply-To: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-usb@vger.kernel.org
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
> This driver handles the reset control in a common manner; deassert
> resets before use, assert them after use.  There is no good reason
> why it should be exclusive.

Is this preemptive cleanup, or do you have hardware on the horizon that
shares these reset lines with other peripherals?

> Also, use devm_ for clean-up.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> CCing Philipp Zabel.
> I see his sob in commit 06c47e6286d5.

At the time I was concerned with the reset_control_array addition and
didn't look closely at the exclusive vs shared issue.

>  drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e54c362..bd6ab65 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, simple);
>  	simple->dev = dev;
>  
> -	simple->resets = of_reset_control_array_get_optional_exclusive(np);
> +	simple->resets = devm_reset_control_array_get_optional_shared(dev);

>From the usage in the driver, it does indeed look like _shared reset
usage is appropriate. I assume that the hardware has no need for the
reset to be asserted right before probe or after remove, it just
requires that the reset line is kept deasserted while the driver is
probed.

>  	if (IS_ERR(simple->resets)) {
>  		ret = PTR_ERR(simple->resets);
>  		dev_err(dev, "failed to get device resets, err=%d\n", ret);
> @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  
>  	ret = reset_control_deassert(simple->resets);
>  	if (ret)
> -		goto err_resetc_put;
> +		return ret;
>  
>  	ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
>  						"clocks", "#clock-cells"));
> @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  err_resetc_assert:
>  	reset_control_assert(simple->resets);
>  
> -err_resetc_put:
> -	reset_control_put(simple->resets);
>  	return ret;
>  }
>  
> @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
>  	simple->num_clocks = 0;
>  
>  	reset_control_assert(simple->resets);
> -	reset_control_put(simple->resets);
>  
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);

Changing to devm_ changes the order here. Whether or not it could be a
problem to assert the reset only after pm_runtime_put (or potentially
never), I can't say. I assume this is a non-issue, but somebody who
knows the hardware better would have to decide.

regards
Philipp
