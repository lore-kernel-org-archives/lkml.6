Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2776495-1521725220-2-13006549348851731194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='ISO-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521725219; b=tbKMlpAXEcWEiClJAb66G51ZfHb2kPZ5NH9CYfr0k+BpfsR
    0NSh96yW35NKTqCvtTu3xup172AhxAEY/Xtsic0oySsxr7PA4Igh+tG2hj656a3j
    TERcKbZKPArj0FDqumQBXuqSyvJsyiNTx06G7ABOYhlYc4thjVodu+BdkxfK++O5
    5874nYawNMKeGCfVN3eKgFZ8euVPpEMZV9BwU+/z1uFKAaUnGgzaXNP+tMFgHS/Z
    vE/RrnGKAelnF+w9xJ5PD48EVBqoeAjBWuV8WB8xMBXjjihquOc6vXfXGynD+g3Z
    kMLJNMUlBz8D1UpKM41VpMZ1HfNbe0QLmo6Ne9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1521725219; bh=BcZCYb
    oO4hc4W4HaVYImz6fXOSsOs+vxIw8UjJYcHQo=; b=VJtwxPmVJWETgwWJ8iO3uD
    nvcRa3OG90WEaJUw7mp9AAcjxB1LH6BZj+9IcLR60r5a6bNY9VNi+MsFmldac8y6
    MrhTvmjQ2ziwBeyk//07NrlLZrhLX+tjX6UJOdh68eg/ekkGEqRx4Cykqeb7GfTW
    4Ph1JBPLvRCXJA0EcRmZpZoSGODfcFD94tr4c27VsqYmcKGJF8txR6VhCrPHdlWt
    mIHAqr9SibG3+oNlFoD1nhgVlQEmE+3X+tNu1tQohBcQfsk6Tmmjw3ISRXlcf+yx
    TKEwT2RZXB+rrxgcAENAKefNlrkLvP+w9zWRHuH+pFYRPhi3HST5bCvxJi2Wt1jA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCVN0m convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 22 Mar 2018 09:26:42 -0400
Received: from gloria.sntech.de ([95.129.55.99]:57092 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbeCVN0l (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 09:26:41 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 14:26:34 +0100
Message-ID: <1794463.c121CNJ3R4@diego>
In-Reply-To: <20180322131451.12631-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com> <20180322131451.12631-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Donnerstag, 22. März 2018, 14:14:51 CET schrieb Tomeu Vizoso:
> devm_regulator_get_optional returns -ENODEV if the regulator isn't
> there, so if that's the case we have to make sure not to leave -ENODEV
> in the regulator pointer.
> 
> Also, make sure we return 0 in that case, but correctly propagate any
> other errors. Also propagate the error from _dwc2_hcd_start.
> 
> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> ---
> 
> v2: Only overwrite the error in the pointer after checking it (Heiko
>     Stübner <heiko@sntech.de>)
> v3: Remove hunks that shouldn't be in this patch
> ---
>  drivers/usb/dwc2/hcd.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index dcfda5eb4cac..863aed20517f 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
> static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>  {
>  	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
> -	if (IS_ERR(hsotg->vbus_supply))
> +	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
> +		hsotg->vbus_supply = NULL;
>  		return 0;
> +	} else if (IS_ERR(hsotg->vbus_supply)) {
> +		hsotg->vbus_supply = NULL;
> +		return PTR_ERR(hsotg->vbus_supply);
> +	}

my personal cluelessnes, but can you use PTR_ERR without checking for
IS_ERR first?

I would've expected something along the line of

if (IS_ERR(hsotg->vbus_supply)) {
	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
		hsotg->vbus_supply = NULL;
		return 0;
	} else {
		return PTR_ERR(hsotg->vbus_supply);
	}
}

