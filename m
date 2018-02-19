Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-96826-1519047005-2-16312783520625303457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519047005; b=EG+B711eeD8FmfIN0Em6jp5Llqhy4474oLRZPHEDtqOPPbc
    O9fF33Bvwnh/h/Mehxi4/jNgJxtm8ogNTez30jvOlyPHe7ZVZrOzPQT/N0C2UbO0
    5SC1B+4hHkLoWPEwrINHzQ0mHc/7eEtUij0qJ5uAWWLncjoZoNaINUhd0SVGgaRA
    9l2pj6w3fw3BKbpRakZj8xZXcsEPk+PEXS0HrxUR2tDmag0uoCirURx4joNhkZQK
    dsGcxbbbOv+DmQi43x1PSRNsiC5yo65VJVBZItuWgfc0NVh3hgTDBxlpwlvRlPg6
    GGB5PLMYaG1EbaX8gQb4z34oM3mMgx8B+fQXjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519047005; bh=KV6hLsib19Al85kfoIKhCiAbJtC7O08ifcpJdiMePec=; b=j
    sYrTVCzF0nOw4DH7zp9h91y0llKv6rs9NV8+3FFvfSNL/OeINsAX1sRVtx/nMNgK
    sG73QTqlf32G/GN9hH10+Y1/3cmIZGI+O+r4f4WVCyPcSDtw5wX9xP95idvMpRM6
    WNFs2okxgp2e8XGqYMDJ4QnQidGrL4haKsP10SKHsWVzM/MG8yhvsAWqHGFcw7SN
    kcSqjLiu6oZEPY5h+0bL/1jiccIMNlakktO3gaA/qmplLJoOl2jvNU7BYrmYTqrV
    1Nbe2cTl3Mv+rAip89y9V8vSZmJP08smxozk+ltPpEKAJ66v+YbZp+DWfQb7j3iY
    CBySKkDzi/jHQ6NLgGiKA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=miF8qKjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=miF8qKjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBSNaC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 08:30:02 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:48220 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSNaB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 08:30:01 -0500
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
To: Pawel Dembicki <paweldembicki@gmail.com>
CC: <stable@vger.kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <4e34938c-7dc7-07bc-9074-a726bd06d744@ti.com>
Date: Mon, 19 Feb 2018 07:29:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180218171927.6414-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/18/2018 11:19 AM, Pawel Dembicki wrote:
> In devices, where fdt is used, is impossible to apply platform data
> without proper fdt node.
> 
> This patch allow to use platform data in devices with fdt.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Good catch,

Acked-by: Andrew F. Davis <afd@ti.com>

>  drivers/w1/masters/w1-gpio.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
> index a90728ceec5a..7b80762941af 100644
> --- a/drivers/w1/masters/w1-gpio.c
> +++ b/drivers/w1/masters/w1-gpio.c
> @@ -112,17 +112,16 @@ static int w1_gpio_probe_dt(struct platform_device *pdev)
>  static int w1_gpio_probe(struct platform_device *pdev)
>  {
>  	struct w1_bus_master *master;
> -	struct w1_gpio_platform_data *pdata;
> +	struct w1_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	int err;
>  
> -	if (of_have_populated_dt()) {
> +	if (of_have_populated_dt() && !pdata) {
>  		err = w1_gpio_probe_dt(pdev);
>  		if (err < 0)
>  			return err;
> +		pdata = dev_get_platdata(&pdev->dev);
>  	}
>  
> -	pdata = dev_get_platdata(&pdev->dev);
> -
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "No configuration data\n");
>  		return -ENXIO;
> 
