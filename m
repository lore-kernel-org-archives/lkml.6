Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3765319-1523363341-2-17691679840744698853
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523363340; b=F3/OTYeOdO9DWW+av/byfBoiU2ECLjPckbV/Zp/vvfxmbArpD+
    l7F2gIwIzKoNsQ5Y/gnX9Wq863n/m8eUoYT91Li8l5kw+k0aa8mFr4x24Mjm1AoE
    64llo2WRUsT3AQpKfx/v1mgnZaj0UOIvcNmPWe7T9TUWNj/RwaMEsDaS3imEoGl3
    1P2dBQd3gdVFye+62F+n2Kx8WxtUkzIkxpJjj54Vinnc++8t4rMiO6VJ0Qbpvzjk
    0SdrVV46H6QEOgWOHhkhCOW3x2/oUrRMypmTSZY2qM1Giu0hyW8faokl/vWUP0R7
    IquAhF7NA5gwrVOs7Q2Yghi5BQd27sLlOLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1523363340; bh=1hnDvGI/qd
    TTsGbqXqq/3JCswnPZcfj3S+khKgLygN8=; b=qFaGT7EO7xqxIqMXIqFiMkzmD1
    0x6dvmJSRJNSB2X+DwKpASjIJtr+XleT74hbP5FmSS87MENVS8Dc8VUhHCqzRC8D
    kc/pwtVr5IXXkW4GrTSQoY5Myakismz/Tj743DSG6GrFmO8WyapWvrpebKbjJqUE
    OYrMkM5ctwYenXn/4Xw/AQAHJ/4AIY7BoAtyOJt0HsKHcN4nAbx9G6AqNki0UOxI
    V72+41mjs7sLAACQS8CSMzKmiWt7WXJ4/JVFGqjmUy2CahzTYOzp3P4wk9tMPI83
    pQB86ewVuWVUmcUf4P4vcJsI27ehFA8CmWJRW5B6DapLe8nCqPqieMAS8rsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBzWgf8dKzFFfTz4LhAlbfXF1LVOsmz+IYivC3V/ZKJbG4Bdk0QxpoyW4XbDhwEh9XUEsmArnYXWxF6tKqmmbTLo32M6To1RLGZc60/T9Ox92c/cRcXI
    aoVD9X4Pt4B9ntMYL8nVdq2W8XNHpx0gxFsrsSpKo7Aep4KXBF40ukqR0oMsYdTwKFFlnWloylgS9h3f0juUI/vDd8Ojhk3qnrtr4pXN58xQbrbzKyflBCS0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=gfBjbcEdvxrFtqnv1gQA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=T3LWEMljR5ZiDmsYVIUa:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDJM2t convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 10 Apr 2018 08:28:49 -0400
Received: from gloria.sntech.de ([95.129.55.99]:53236 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeDJM2s (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 08:28:48 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Tue, 10 Apr 2018 14:28:35 +0200
Message-ID: <4613360.AXT7q7Ng0i@phil>
In-Reply-To: <20180326090001.57627-1-tomeu.vizoso@collabora.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com> <20180326090001.57627-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, 26. März 2018, 11:00:01 CEST schrieb Tomeu Vizoso:
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

The patch that gets fixed here also breaks display-output on dwc2-based
Rockchip devices (likely even more), probably due to making the regulator
framework hickup.

With this patch applied, apart from not seeing the NULL-ptr, I also get
display output on my rk3288-veycron Chromebook again, so

Tested-by: Heiko Stuebner <heiko@sntech.de>


> v2: Only overwrite the error in the pointer after checking it (Heiko
>     Stübner <heiko@sntech.de>)
> v3: Remove hunks that shouldn't be in this patch
> v4: Don't overwrite the error code before returning it (kbuild test
>     robot <lkp@intel.com>)
> ---
>  drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 190f95964000..c51b73b3e048 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
>  
>  static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>  {
> +	int ret;
> +
>  	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
> -	if (IS_ERR(hsotg->vbus_supply))
> -		return 0;
> +	if (IS_ERR(hsotg->vbus_supply)) {
> +		ret = PTR_ERR(hsotg->vbus_supply);
> +		hsotg->vbus_supply = NULL;
> +		return ret == -ENODEV ? 0 : ret;
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
> 


