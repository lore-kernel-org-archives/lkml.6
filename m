Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2318607-1522918755-2-4408983376925229643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522918755; b=kEpENAJOu8F0i4z1kx39GVfxAj4B3+dbmWv56eS9Yn72zldCEq
    XteE8cTCN9o/2INFiPlD/O+ONgBIiPSB4vSXOWKMSOYTO+i9R1pr7VCyrCKCkinG
    wjNVKG23O0rLogz0WdSspFU4MZUR9YgAtmoX8C2we4m+VnX8VpdOcnAhT8h4+io/
    s1JnV+cS/cB84qWoDsWn/98J6MWnbc4681C1zBPFBuLyLBu79lPlo0JDeP3Jqe1b
    K1YM4HzB8zYN4AEoUn0FVXha3RAEwR6kTLx5mSkFrdL9IO7iPY6iO1YGkdZaZNHi
    opXtFeBF9dxxjAXMU2KZGHnYB/o0zV5djjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1522918755; bh=dv0If5jC5K3A8gD5ZFyBLT+
    zkKuDC3AQE8XnpNn+IM0=; b=CpLAZZf7x0UR1dFZaR4CKZVFgl+hPNGUeqH4Di6
    3UEAmhhxNZ4JXY5LsfbLST0JKqjCYi/yCRmt5Ac8vmNRLQ3iLu5c4JUVsqitanQL
    wj4jCyiY5faHs/jH6u7Kjo3gaaXXxg/4MhAN3eDTiP00Z9QP0cs2mezrF1ewqo3m
    V8wzcfwtMLbbJtz8eTKtOv8tLoF0ZVYfGng1T9BTCKb0iQXAOZzovQuOak8tpDAI
    s6ZRGvb2lGcb4Qd8VKak6lwfxTu+A4oZiTC8aPDlZlaE+fJYC9K1oZM94E3DF7MZ
    o7yNw34YxevUvMOK2lm8i3PAFFRFDS09LoOdtbFYEXiWxIA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNMY07o48FkBvbdGJUFsXCaUeY8+oQ6n1Tizq4KU/LQFcedmxu5FUA1Kd5GohBkvFeSRME8oTPMDEXqpX4WlkT3nmmsQZY/9C62+8CEzcPOoRKnQDkaR
    GEVl0oJnRyW5o+NV9StP55RhUXoEl0EjKUKsvKN52DXIS1BFB99/ODCcgFnMqiW+RAYIK98NV823OcrH4ouHkpoYnq0F8wm41jPpbnYIwXStEzLTDAeTDbuh
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=6ZF3mutI6AgA:10 a=8nJEP1OIZ-IA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8
    a=QyXUC8HyAAAA:8 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8 a=X2GXcJMMditoMMEn0gMA:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=T3LWEMljR5ZiDmsYVIUa:22
    a=AbAUZ8qAyYyZVLSsDulk:22 a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDEI7B convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 5 Apr 2018 04:59:01 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:42456 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDEI67 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 04:58:59 -0400
From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "Minas Harutyunyan" <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTxOD/EnRsRkoOHE2ZtYRlyd+fGg==
Date: Thu, 5 Apr 2018 08:58:54 +0000
Message-ID: <32EB88BF8EC1614E9FB18BD3718BE1A116412614@am04wembxb.internal.synopsys.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.104.144]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/26/2018 1:01 PM, Tomeu Vizoso wrote:
> devm_regulator_get_optional returns -ENODEV if the regulator isn't
> there, so if that's the case we have to make sure not to leave -ENODEV
> in the regulator pointer.
> 
> Also, make sure we return 0 in that case, but correctly propagate any
> other errors. Also propagate the error from _dwc2_hcd_start.
> 
> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
> Cc: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> ---
> 
> v2: Only overwrite the error in the pointer after checking it (Heiko
>      Stübner <heiko@sntech.de>)
> v3: Remove hunks that shouldn't be in this patch
> v4: Don't overwrite the error code before returning it (kbuild test
>      robot <lkp@intel.com>)
> ---
>   drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 190f95964000..c51b73b3e048 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
>   
>   static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>   {
> +	int ret;
> +
>   	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
> -	if (IS_ERR(hsotg->vbus_supply))
> -		return 0;
> +	if (IS_ERR(hsotg->vbus_supply)) {
> +		ret = PTR_ERR(hsotg->vbus_supply);
> +		hsotg->vbus_supply = NULL;
> +		return ret == -ENODEV ? 0 : ret;
> +	}
>   
>   	return regulator_enable(hsotg->vbus_supply);
>   }
> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
>   
>   	spin_unlock_irqrestore(&hsotg->lock, flags);
>   
> -	dwc2_vbus_supply_init(hsotg);
> -
> -	return 0;
> +	return dwc2_vbus_supply_init(hsotg);
>   }
>   
>   /*
> 

Reviewed-by: Grigor Tovmasyan <tovmasya@synopsys.com>
