Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2601871-1521718778-2-10167899309743255037
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
    t=1521718777; b=suhv6DBiLAqfL6N9b02vEaF77FdTbUNZbbe7j3HehGFedTv
    FkshtI3NJ8e6yvWXFJ4/hgQiNF0bjXI2RIMORCzvkFCV4XvbzLubWHTdyPJrIUGz
    ie6PGsGahRQ9iJqGjp4ObDjxfnylfu2VzN8x3a0lZCcZiSD2B5QS85GyxmkcGV6t
    JvVsnC/DGh7L1DP24b4knujBSciOa9lF+Wu6TBFJr75uPJsrOXlTXYnn96X4mL5r
    2gq1Qv24MQlf6pJzQ/CRPbdeJGNXAJuZcK3zX6mrSnIUU6U13yTLIGj3wo5ojnSa
    XZcCCd6lHidHcfhXN6/CQ/Y5XDEgO3SfP7GJoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1521718777; bh=JCBij7
    DNm0uIcOsplDKGQOw3zE1O0t062Ef7Acgi+aw=; b=oTuxzqrg5G5U7il31apsNC
    RCCBup8nI+jU8X1gcRWTz19nQXGk2g8ftqq4+EkzAuZezF1Fpsp3Pd7i5Q/9hKBo
    Hw94Xv17RWshOQzduBoXkvwRLPxqfEbcy0z9GYDKtSJVINtN6PdUfzakLsT4kdw+
    ekOiJlO0AF4EKbtqQYgAwSDeH7T58HgW4D1PGx6HkJIegt08rdKpvDGXyR+WXbLi
    Em57PFRzauqfb2PNsewBZBUUQkMI+VRunZ+dcqrie6OP4gIfSqN8C17YJbXC9um6
    RMX3fEUK4/gxm40IykxHmy3jupBOVb0EQ1JzL6a0AaStKNnTWGJgqoVe2SFDJycQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1752180AbeCVLjY convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 22 Mar 2018 07:39:24 -0400
Received: from gloria.sntech.de ([95.129.55.99]:55428 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751875AbeCVLjX (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 07:39:23 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 12:39:13 +0100
Message-ID: <1711886.RiDBCvOSMq@diego>
In-Reply-To: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Donnerstag, 22. März 2018, 10:39:43 CET schrieb Tomeu Vizoso:
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

Thanks for catching that oops in your tests.
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index dcfda5eb4cac..4ae211f65e85 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
> static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>  {
>  	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
> -	if (IS_ERR(hsotg->vbus_supply))
> -		return 0;
> +	if (IS_ERR(hsotg->vbus_supply)) {
> +		hsotg->vbus_supply = NULL;
> +		if (PTR_ERR(hsotg->vbus_supply) == -ENODEV)
> +			return 0;
> +		else
> +			return PTR_ERR(hsotg->vbus_supply);
> +	}
> 
>  	return regulator_enable(hsotg->vbus_supply);
>  }
> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
> 
>  	spin_unlock_irqrestore(&hsotg->lock, flags);
> 
> -	dwc2_vbus_supply_init(hsotg);
> -
> -	return 0;
> +	return dwc2_vbus_supply_init(hsotg);
>  }
> 
>  /*


