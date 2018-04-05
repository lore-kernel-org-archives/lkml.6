Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2323995-1522918941-2-2352255082623076363
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
    1522918940; b=gvMC2DBrkXNQFeYFZ6KTVCuYc+8pG8NjNMOBXbW0OpEK61f9vH
    PgJEVFUxnX2ExkUHCxk8gvh+aJzGvfEXVUMVigY/bx6Cnor1gvvlKDnHIiWp6dJv
    naIxq87WJnAzDekae5x1TzGyZ78S8nwTlvgTRI326s2KZ3IMuLGb8pvR5+vCF4ZB
    rAjI1sAk85Or17/Ja/MBtlCV2rjN7DXkS3q7urkgfTZm3fIEswxZ8QQuxX6uJmMg
    rePd+2WYJeMmUnSX3gqlX5KIpKysRykSOxz0xOfFMbZCniGWPQHNTiWoSzExUOQ5
    15pN9Z2EmJV1GlvIG2Vx//A16u1E8Wxu3dOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1522918940; bh=GtnwJqmUgdshDwJbByv0S9r
    ZJMa93Fol8moFBM1s2+c=; b=q1zr2xpPvOfTgHaukbe6P+hB1Id1y2OpO1T4W14
    8XIC/QB/rE1uaUjGlFf2KrX1BXPggsvZHaskN1k8AE1ONe8idrTjFzK+28MKQ0Gw
    HBI2b6XiaqeE9rbXY9ItN5YoKw1DoX3Ixjf+tqxK3Ufo98537z/uEuss8rG3XO2t
    aGFm0kfqO/FPdHRy7/eh4MJPbGuMFZ6qfGukZd5ucT3IRuisIssQskO6vOWmhdSp
    5U69kUfwI7vmTs/Q3kOagmuw8Y3oNgvmW2uguxtV+DgrNTGXDGBo6biQRkLwieo8
    OGjulKcFkAFwFJkxnXKVEz0ZXPS9TfkLmSnsqQsxRgf+6/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfE3eoP5/PUEgLymoe1OasQYhMxzHJ2KhADzzZksuBA36VlB0Iqi6QEm4KiufagNIgOQsCluliBL5G9kZeFGxRHFt8aia45wgv7mKJUxqPL7I/gJSc7ic
    ztRlfLFAcX0GgQ0IN/LZxzcctvnUP1rgAUbhvpvKYqboblKdmNKhCPsV98gois7yd6aqiwLoQB6JR51+uI+sK26GOr11kATXnNYw3Q2fRM66u98F4WpjJUwS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=6ZF3mutI6AgA:10 a=8nJEP1OIZ-IA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=RpNjiQI2AAAA:8 a=MYbuxtNEOOB3qLC6DUwA:9
    a=jpIH26JlB8aEU1M81S3jpgcb7nU=:19 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=T3LWEMljR5ZiDmsYVIUa:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEJCH convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 5 Apr 2018 05:02:07 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:46504 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDEJCG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 05:02:06 -0400
From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTxOD/EnRsRkoOHE2ZtYRlyd+fGg==
Date: Thu, 5 Apr 2018 09:02:01 +0000
Message-ID: <32EB88BF8EC1614E9FB18BD3718BE1A116412638@am04wembxb.internal.synopsys.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180326090001.57627-1-tomeu.vizoso@collabora.com>
 <410670D7E743164D87FA6160E7907A560113AE527D@am04wembxb.internal.synopsys.com>
 <fe9292c5-e90b-96fd-aa73-ea82e7497281@collabora.com>
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

On 4/5/2018 12:11 PM, Tomeu Vizoso wrote:
> Hi Minas,
> 
> On 04/05/2018 09:54 AM, Minas Harutyunyan wrote:
>> Hi Tomeu,
>>
>> On 3/26/2018 1:01 PM, Tomeu Vizoso wrote:
>>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>>> there, so if that's the case we have to make sure not to leave -ENODEV
>>> in the regulator pointer.
>>>
>>> Also, make sure we return 0 in that case, but correctly propagate any
>>> other errors. Also propagate the error from _dwc2_hcd_start.
>>>
>>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus supply")
>>> Cc: Amelie Delaunay <amelie.delaunay@st.com>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>> ---
>>>
>>> v2: Only overwrite the error in the pointer after checking it (Heiko
>>>        Stübner <heiko@sntech.de>)
>>> v3: Remove hunks that shouldn't be in this patch
>>> v4: Don't overwrite the error code before returning it (kbuild test
>>>        robot <lkp@intel.com>)
>>> ---
>>>     drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>>>     1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>>> index 190f95964000..c51b73b3e048 100644
>>> --- a/drivers/usb/dwc2/hcd.c
>>> +++ b/drivers/usb/dwc2/hcd.c
>>> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
>>>     
>>>     static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>>>     {
>>> +	int ret;
>>> +
>>>     	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
>>> -	if (IS_ERR(hsotg->vbus_supply))
>>> -		return 0;
>>> +	if (IS_ERR(hsotg->vbus_supply)) {
>>> +		ret = PTR_ERR(hsotg->vbus_supply);
>>> +		hsotg->vbus_supply = NULL;
>>> +		return ret == -ENODEV ? 0 : ret;
>>> +	}
>>>     
>>>     	return regulator_enable(hsotg->vbus_supply);
>>>     }
>>> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
>>>     
>>>     	spin_unlock_irqrestore(&hsotg->lock, flags);
>>>     
>>> -	dwc2_vbus_supply_init(hsotg);
>>> -
>>> -	return 0;
>>> +	return dwc2_vbus_supply_init(hsotg);
>>>     }
>>>     
>>>     /*
>>>
>>
>> Not able to apply patch. Please rebase to balbi/next
> 
> Are you sure? Just rebased and the resulting patch is identical to what
> was sent.

Sorry for inconvenience. We fixed the problem.
No need to rebase.

Thanks,
Grigor.

> 
> Thanks,
> 
> Tomeu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwIDaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=K1ULVL1slpLXpMJJlAXSOxws4tRq0IkTBqxDkyW2hUQ&m=q-x0UcPJc6m4O6WQ6ZklCRyxp1ZT8QOQDRuaA_B6m6c&s=F7VAPO-hcO1TMfvPHhEkJYgX-8exTHxrioO3C6oNubs&e=
> 

