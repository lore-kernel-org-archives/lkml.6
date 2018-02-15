Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-941211-1518680744-2-13345644702459144280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518680743; b=QlHlsK3iFzRE88P7OyZAE4LmCoZLbynkSMqLQXmteZ8YCNG
    mGq1t09MtEhS+ZfnVeqIbIwxoermsrEq7HSQZf8zJMIhVK//T02lKatSiv3TGshG
    dr8yOpxwqN+Y3AiuUozOrg9vRo2NIlVGyMXmXH3ekVV4r+ofEeyelcKRTGTAU7Fr
    wP4cg6N1U7vUcHrqsElL6XIbHn807NCCJ9JzSSvY2Jti3ZFOp8rF/MEUIdeCT4Id
    5EC9ueSF4ogJ1aRJCKIzRltSj8lPo5kHcvjln/n7UOFz3GRoAKuGgQY/dIP7cKuj
    BAuDKqUn2wcDObEbMUiyhOoGKnxwg/oaleGbZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518680743; bh=kBd6FCLuA8TEAy2XHlgBVBzS250savd/ocafjX/gkyQ=; b=E
    tlybJzhQEEMDJHf9EFE6fYZGMBsAStKUuhopcVg0GByMMqzQaIaqE0BXAMEtTAWn
    YWLb68LcyyeQ77IG+RKDvsR7hz1Y3mdHEBPejUfAb8SvsXfN/C4szLxHLnGVuHqT
    gjSBhajbsQ/SIePv2tP/UPdob4BIKsBsAHvh8SnJK0fcGR5PoYTD+Ns2N6W+5rSC
    kh3efiVk4sFC9xxesoD6iK+wEXaQjsboYQD95jDcw36moVnoxqldH5DJdKAsWSHE
    P4Ou20h0A6oGtTqLNwb7L9su+5KGmwrTX9WjCohsHUQSS3I3PnmZNTnauEwvg856
    U0wus96L+D7l19W8rHURw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Y2jmDkCh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Y2jmDkCh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbeBOHpM (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 02:45:12 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:64364 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754851AbeBOHpL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 02:45:11 -0500
Subject: Re: [PATCH 2/2] usb: dwc3: drd: Fix lock-up on ID change during
 system suspend/resume
From: Roger Quadros <rogerq@ti.com>
To: Manu Gautam <mgautam@codeaurora.org>, <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1516626103-1969-1-git-send-email-rogerq@ti.com>
 <1516626103-1969-3-git-send-email-rogerq@ti.com>
 <522f639a-466f-ae72-745e-61cbcc6fbfc7@codeaurora.org>
 <557afc49-712d-9e70-7e4a-b7b3e74b7a50@ti.com>
 <8c4da216-7468-df31-01e3-644601421049@ti.com>
 <b9089d1d-a773-ae05-b9ea-8dec0328cb29@ti.com>
Message-ID: <d3963657-e902-771c-967f-e35315c110e0@ti.com>
Date: Thu, 15 Feb 2018 09:45:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b9089d1d-a773-ae05-b9ea-8dec0328cb29@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Felipe,

On 25/01/18 18:11, Roger Quadros wrote:
> Hi,
> 
> On 24/01/18 14:19, Roger Quadros wrote:
>> On 23/01/18 14:41, Roger Quadros wrote:
>>> Hi Manu,
>>>
>>> On 23/01/18 05:45, Manu Gautam wrote:
>>>> Hi,
>>>>
>>>>
>>>> On 1/22/2018 6:31 PM, Roger Quadros wrote:
>>>>> Adding/removing host/gadget controller before .pm_complete()
>>>>> causes a lock-up. Let's prevent any dual-role state change
>>>>> between .pm_prepare() and .pm_complete() to fix this.
>>>>
>>>> What kind of lock-up are you seeing? Some hardware lockup or software deadlock?
>>>> IMO using a freezable_wq for drd_work should address that?
>>>>
>>>
>>> I was seeing a software deadlock. freezable_wq is a good idea. I'll try it out.
>>
>> using freezable_wq doesn't get rid of the deadlock.
>> If I use freezable_wq plus add some delay before I do a dwc3_host_init()
>> in the work function then it starts to work.
>>
>> As dependence on delay looks fragile so I'll stick to the current implementation
>> based on .pm_prepare/complete().
>>
> 
> So I was able to reproduce the lock up with my series as well. On further investigation
> this is what I see.
> 
> There are 2 different scenarios.
> 
> 1) controller in host mode prior to system suspend and switches to device mode during resume.
> 
> In this case when we call dwc3_host_exit() before tasks are thawed
> xhci_plat_remove() seems to lock up at the second usb_remove_hcd() call.
> This issue is resolved by using system_freezable_wq for the _dwc3_set_mode() function.
> 
> 
> 2) controller in device mode prior to system suspend and switches to host mode during resume.
> 
> In this case we sleep indefinitely in _dwc3_set_mode due to
> dwc3_set_mode()->dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq()
> 
> This is not resolved by moving the dwc3_set_mode() call to .pm_complete() nor via the system_freezable_wq.
> 
> One way I could fix this is like so.
> 
> Felipe, could you please suggest a better way?
> Maybe we need to do this in dwc3_gadget_exit() before calling usb_del_gadget_udc() ?

Once you let me know your opinion I can revise this series. Thanks.

> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b417d9a..0c903c1 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -109,6 +109,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>  	struct dwc3 *dwc = work_to_dwc(work);
>  	unsigned long flags;
>  	int ret;
> +	int epnum;
>  
>  	if (!dwc->desired_dr_role)
>  		return;
> @@ -124,6 +125,17 @@ static void __dwc3_set_mode(struct work_struct *work)
>  		dwc3_host_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> +		spin_lock_irqsave(&dwc->lock, flags);
> +		for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
> +			struct dwc3_ep  *dep = dwc->eps[epnum];
> +
> +			if (!dep)
> +				continue;
> +
> +			dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
> +		}
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +
>  		dwc3_gadget_exit(dwc);
>  		dwc3_event_buffers_cleanup(dwc);
>  		break;
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
