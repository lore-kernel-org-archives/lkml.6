Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521196469-2-9806121334495301615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521196468; b=Pt0mOfa4dr/gw1rValxdIv1RC1hPlx2jnFYLbRwbGJeCIdk
    WFEOLXXFktBIjfTedIKLS9wVP4UBNEJN3PtCxQODAY3sCMMimD27FqzIdki1yfpy
    lR8K67jb8JSX8FoXdNu1fMVszkgs8Fp0yX6LBvn+QDKwEA+MtCZOKMKD2WNH+cGI
    1m+TljIrP2SmsirP39uVhXGP7ip0ezOa+SH3pCOfxKJSOkB6ngs1VgB9PDIeuG4R
    rDpRohJGbRe7mTpg77QspUi5K6T74NK3T65AWOk2pwrvJ2sy/A68VS74wSvImpVK
    s76YVfEBSseTsBIwYAjGfcWZ/91Kv20rhWF3Bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521196468; bh=gK9+5Amz935dtJTLxEKyfkzWtH4BJ44ZCeAC16U3tlU=; b=C
    qvPGWBDifyMGCyF4fXNtHFSVUwCv0XFT7M92S7UsuoWEdrrCzEO7LKkbr7MDdobw
    ikfATsS2YzDn3kmi5baFkP8+JdOO/VugxNz420pNQNP0LSJ7ShDyTgt60B1FFcyQ
    tbulQOFnun3xq+YjjCZ7je2z6uSKIEdD5dFFvn1yZlfr7XLrJTsS+62+EgZCrF9z
    jQzQOKFBA/XaY5Ve6iF768YwQbb27U6rDzsgAKF1EnUDD0mgCozeK+QGTdPD+fCR
    laL8s0SnwTBFTnYo7nMFDdBc8O+Hk9seLeX9lvFuXp12w0jXdxiOn2kij9Kmp01T
    IPAndLBGMLlwGAQQLAYGg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=AxyuKTy4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=AxyuKTy4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeCPKeP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 06:34:15 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29732 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbeCPKeO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 06:34:14 -0400
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
Date: Fri, 16 Mar 2018 12:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Felipe,

On 09/03/18 14:47, Roger Quadros wrote:
> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
> after which dual-role switching doesn't work.
> 
> On dra7-evm's dual-role port,
> - Load g_zero gadget driver and enumerate to host
> - suspend to mem
> - disconnect USB cable to host and connect otg cable with Pen drive in it.
> - resume system
> - we sleep indefinitely in _dwc3_set_mode due to.
>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
> 	dwc3_gadget_stop()->wait_event_lock_irq()
> 
> To fix this instead of waiting indefinitely with wait_event_lock_irq()
> we use wait_event_interruptible_lock_irq_timeout() and print
> and error message if there was a timeout.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Thanks for picking this for -next.
Is it better to have this in v4.16-rc fixes?
and also stable? v4.12+

> ---
> 
> Changelog:
> 
> v2:
> - use wait_event_interruptible_lock_irq_timeout() instead of wait_event_lock_irq()
> 
>  drivers/usb/dwc3/gadget.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 2bda4eb..7c3a6e4 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1950,6 +1950,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  	struct dwc3		*dwc = gadget_to_dwc(g);
>  	unsigned long		flags;
>  	int			epnum;
> +	u32			tmo_eps = 0;
>  
>  	spin_lock_irqsave(&dwc->lock, flags);
>  
> @@ -1960,6 +1961,7 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  
>  	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>  		struct dwc3_ep  *dep = dwc->eps[epnum];
> +		int ret;
>  
>  		if (!dep)
>  			continue;
> @@ -1967,9 +1969,24 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
>  		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>  			continue;
>  
> -		wait_event_lock_irq(dep->wait_end_transfer,
> -				    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
> -				    dwc->lock);
> +		ret = wait_event_interruptible_lock_irq_timeout(dep->wait_end_transfer,
> +			    !(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
> +			    dwc->lock, msecs_to_jiffies(5));
> +
> +		if (ret <= 0) {
> +			/* Timed out or interrupted! There's nothing much
> +			 * we can do so we just log here and print which
> +			 * endpoints timed out at the end.
> +			 */
> +			tmo_eps |= 1 << epnum;
> +			dep->flags &= DWC3_EP_END_TRANSFER_PENDING;
> +		}
> +	}
> +
> +	if (tmo_eps) {
> +		dev_err(dwc->dev,
> +			"end transfer timed out on endpoints 0x%x [bitmap]\n",
> +			tmo_eps);
>  	}
>  
>  out:
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
