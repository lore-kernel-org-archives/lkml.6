Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1744695-1521431054-2-13292501560521025290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521431053; b=DaLq1gJuNEIYxF9xiaYtoF7fRjU34ULEkfpujPM/FquLq1k
    H0NdRaGn7/N/bH2ytgrBUA19QqQlzrnsDff0mbNFGpFIxW5MrJoh9vQg7VdPScu+
    IDn0eQ7t2FGoRn0eTokffdV5beMy3rfZr1m45i/e9lHoNIfABhsDm0S7bl2eEVEY
    2nSWX+zA4YygbLjNIe2LQa4PiTPfcBVje3k2f9hfxoa00lEIiiDhDIF+ytcLdpwx
    pwVKKUsEe4z0f6hEpwEQCSqCj1PcZ/LwgfI0wD7y11LiIR0qX2YcvzKGlfNlIH5i
    znXcei0ocTn0PSF/9LtYbIpyCTjlVTpLH4VUgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521431053; bh=SQv4AUs
    acCCDPtwg4D8FNLigeY1D19PbzGZbIZ3xhq0=; b=oEuo62WLNb/sAIyqzI47uGE
    EoR1s4dzD9BsESla9LUtfueRIqa7O9yx1QpRqFohlkCn4L/llPNLiKeEqJiGWJUE
    vSCK7ht98rxJCaLepcI9/hpzEfKFNdfEhWettFpQ+TVV1MiTreyyAxBgsJ/9cNCC
    Jo0J5tDQyNGRBBcCZS5Zd0kafh90FPBmMHjINGRB14Lwfij4F2lCneaXkrDLqT3P
    5y04YpcO/PBPPljKnNOs3SZYuZQoT8XpZLhRDzZNfBqBeQc58azORHXYyL9t5GrJ
    Eo1OIWr4vTDzrp/hmU+lTkK/mM0NHnlrEl3i2e/ao4fhfspvS+UxqVcIZC4k3PQ=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L2ikv7lb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NVCcTl0C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=L2ikv7lb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NVCcTl0C;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbeCSDoM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 23:44:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36573 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeCSDoL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 23:44:11 -0400
X-Google-Smtp-Source: AG47ELtOw7zsdkAHXVubkfC2m1f8uLrYhQk25JUPj3ewDXWfG4PbN3xdkEVifk+09520WkqJ6pTPyw==
Date: Mon, 19 Mar 2018 11:44:08 +0800
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 056/109] clk: ti: clkctrl: add support for retrying
 failed init
Message-ID: <20180319034408.wi6wfosbcckw22j6@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180316152333.001660820@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180316152333.001660820@linuxfoundation.org>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 04:23:25PM +0100, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Tero Kristo <t-kristo@ti.com>
> 
> 
> [ Upstream commit 729e13bf58e643b9accd2a14c55b555958702fb0 ]
> 
> In case the clkctrl node contains assigned-clock-* entries, registering
> the provider can fail with -EPROBE_DEFER. In this case, add the
> provider to the retry_init clock list so it will be cleaned up later.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This fails to build for me on arm32:

$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm

...

../drivers/clk/ti/clkctrl.c: In function ‘_ti_omap4_clkctrl_setup’:
../drivers/clk/ti/clkctrl.c:497:27: error: passing argument 2 of ‘ti_clk_retry_init’ from incompatible pointer type
 [-Werror=incompatible-pointer-types]
   ti_clk_retry_init(node, provider, _clkctrl_add_provider);
                           ^~~~~~~~
In file included from ../drivers/clk/ti/clkctrl.c:24:0:
../drivers/clk/ti/clock.h:265:5: note: expected ‘struct clk_hw *’ but argument is of type ‘struct omap_clkctrl_prov
ider *’
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
     ^~~~~~~~~~~~~~~~~                                                                                             ../drivers/clk/ti/clkctrl.c:497:37: error: passing argument 3 of ‘ti_clk_retry_init’ from incompatible pointer type
 [-Werror=incompatible-pointer-types]
   ti_clk_retry_init(node, provider, _clkctrl_add_provider);
                                     ^~~~~~~~~~~~~~~~~~~~~
In file included from ../drivers/clk/ti/clkctrl.c:24:0:                                                            ../drivers/clk/ti/clock.h:265:5: note: expected ‘ti_of_clk_init_cb_t {aka void (*)(struct clk_hw *, struct device_n
ode *)}’ but argument is of type ‘void (*)(void *, struct device_node *)’
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
     ^~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [../scripts/Makefile.build:329: drivers/clk/ti/clkctrl.o] Error 1
make[3]: *** [../scripts/Makefile.build:587: drivers/clk/ti] Error 2
make[2]: *** [../scripts/Makefile.build:587: drivers/clk] Error 2
make[1]: *** [/home/drue/src/linux/4.14-rc/Makefile:1031: drivers] Error 2
make[1]: Leaving directory '/home/drue/src/linux/4.14-rc/build-arm'
make: *** [Makefile:146: sub-make] Error 2

> ---
>  drivers/clk/ti/clkctrl.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> --- a/drivers/clk/ti/clkctrl.c
> +++ b/drivers/clk/ti/clkctrl.c
> @@ -400,6 +400,12 @@ _ti_clkctrl_setup_subclks(struct omap_cl
>  	}
>  }
>  
> +static void __init _clkctrl_add_provider(void *data,
> +					 struct device_node *np)
> +{
> +	of_clk_add_hw_provider(np, _ti_omap4_clkctrl_xlate, data);
> +}
> +
>  static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
>  {
>  	struct omap_clkctrl_provider *provider;
> @@ -411,6 +417,7 @@ static void __init _ti_omap4_clkctrl_set
>  	struct omap_clkctrl_clk *clkctrl_clk;
>  	const __be32 *addrp;
>  	u32 addr;
> +	int ret;
>  
>  	addrp = of_get_address(node, 0, NULL, NULL);
>  	addr = (u32)of_translate_address(node, addrp);
> @@ -485,7 +492,10 @@ static void __init _ti_omap4_clkctrl_set
>  		reg_data++;
>  	}
>  
> -	of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
> +	ret = of_clk_add_hw_provider(node, _ti_omap4_clkctrl_xlate, provider);
> +	if (ret == -EPROBE_DEFER)
> +		ti_clk_retry_init(node, provider, _clkctrl_add_provider);
> +
>  	return;
>  
>  cleanup:
> 
> 
