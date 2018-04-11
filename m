Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1563688-1523429481-2-6108361535669588643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523429480; b=A1p5dIvxpIKaFBTE2UEGVcSJf3Xh5vfczjeobX393Hn4c2zR5C
    OWbR7LYYcq1rjAnvZcqaVxbv/cTFfYcViHaf0eRjIL9uwY+To9AgP1MuCFzRUMpu
    VeOKE3JZwbrDRq9/OwXY7Q9gyV1s2eHIJ/9j0kElnos68Nbmyoxb4pX25pmBe/8m
    7idpwksXkMzHHLhJPxxZ1/WNX/iT1bgZ51ARf42NDGHh8yK5Vkn7TAePzy7L5SSg
    OaQGfa6p3RknqML/mi2hnZ+V3d2rH99SNJBSNsgEO2dFZ+uJNLT+nvHplJbznULC
    g8APNSac6MF4amN43U4wTqeUErhzx6WfHxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1523429480; bh=WCB8JmQNtx2aAbmlkvH0lQC
    +x8zZ5xC0BVNlvMsz4wU=; b=lxpXbX4ib87JTIVFx+ghqCw/4qwuMhcVfAPmVKi
    CgEs3mvqvGTOneqV5NaCoRl0WuzB4F3/PxQC9WKsRQBD3DOeI1I+yNIB/Hwm4B3J
    zTaWwUBS7eZyN7E38r1nVa244H+ba5LiXKoRtDaEzUvOI0yB6M9AYP8tbwNrCp6y
    W5Z0WldmJNdgrtSCx7f+PNh2mcKLrEl6HQwyuQCCGEm4OtNxxO+SVW32pfNAzZME
    fs/5TSHFXxLzJLTzZqSAnALNeL2XYolGsmn3Lv1doj95AqHublqTpfUZVz2Xd5Sr
    Lo+jaBDivi3mVbAQXopPMciSvCjnGfmHJaDHRkTFMfVjDQw==
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
X-CM-Envelope: MS4wfCi9EtSG5C+t5+UpoPuj1Ql9LIqbqrbrMG3KvX1zQN/XMCRc8zilo2lSaOpxIP5SMo0yE8Tqy855tk6eCKbiMY4+qyJGbDiCp8aDV0dQd7V6Wh84O4L4
    JdykR+dsBa29QT8CG8TaywM3QpqEO0uTwut1DnGppt7wwozAnlh+7qHMCd8PLmdvngYTHWurebV1HuoyktTG1Htk0zw2maRHYd3DlcNDucwMLNPBbIeE6dHQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NMaeLcIL3LwA:10 a=8nJEP1OIZ-IA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=8b9GpE9nAAAA:8 a=QX4gbG5DAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Dff2wK1WOhdaTgpDBiMA:9 a=wPNLvfGTeEIA:10
    a=x8gzFH9gYPwA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=AbAUZ8qAyYyZVLSsDulk:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeDKGvB convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 11 Apr 2018 02:51:01 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:49875 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeDKGvA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 02:51:00 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: =?iso-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC: Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTxOD8nEoVzOZ04EOGN7z3QZ1Kzw==
Date: Wed, 11 Apr 2018 06:50:54 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113AE831F@am04wembxb.internal.synopsys.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <4613360.AXT7q7Ng0i@phil>
 <410670D7E743164D87FA6160E7907A560113AE7E5C@am04wembxb.internal.synopsys.com>
 <41174786.HiOuqceMIB@diego>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.63]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Heiko,

On 4/10/2018 7:37 PM, Heiko Stübner wrote:
> Am Dienstag, 10. April 2018, 15:52:25 CEST schrieb Minas Harutyunyan:
>> Hi Heiko,
>>
>> On 4/10/2018 4:28 PM, Heiko Stuebner wrote:
>>> Am Montag, 26. März 2018, 11:00:01 CEST schrieb Tomeu Vizoso:
>>>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>>>> there, so if that's the case we have to make sure not to leave -ENODEV
>>>> in the regulator pointer.
>>>>
>>>> Also, make sure we return 0 in that case, but correctly propagate any
>>>> other errors. Also propagate the error from _dwc2_hcd_start.
>>>>
>>>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
>>>> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>
>>> The patch that gets fixed here also breaks display-output on dwc2-based
>>> Rockchip devices (likely even more), probably due to making the regulator
>>> framework hickup.
>>
>> Could you please elaborate what mean "breaks display-output".
>> On which Kernel version you apply this patch?
> 
> I think I may have written that poorly. _Without_ this patch I get
> display breakage on the most recent torvalds/master (merge-window)
> where "usb: dwc2: add support for host mode external vbus supply" is
> applied and this patch fixes the issue.
> 
> "breaks display output" means both hdmi + edp output are missing
> also including the backlight staying off.
> 
> The patch we're fixing here, causes a null-pointer dereference in the
> regulator framework, which seems to also cause issues when other
> regulators are enabled, which I think is what I'm seeing here.
> 
> 
Thank you for clarification. Earlier you added "reviewed" tag, this 
feedback can assumed as "tested" tag.

Thanks,
Minas

> Heiko
> 
>>
>> Thanks,
>> Minas
>>
>>> With this patch applied, apart from not seeing the NULL-ptr, I also get
>>> display output on my rk3288-veycron Chromebook again, so
>>>
>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>
>>>> v2: Only overwrite the error in the pointer after checking it (Heiko
>>>>
>>>>       Stübner <heiko@sntech.de>)
>>>>
>>>> v3: Remove hunks that shouldn't be in this patch
>>>> v4: Don't overwrite the error code before returning it (kbuild test
>>>>
>>>>       robot <lkp@intel.com>)
>>>>
>>>> ---
>>>>
>>>>    drivers/usb/dwc2/hcd.c | 13 ++++++++-----
>>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>>>> index 190f95964000..c51b73b3e048 100644
>>>> --- a/drivers/usb/dwc2/hcd.c
>>>> +++ b/drivers/usb/dwc2/hcd.c
>>>> @@ -358,9 +358,14 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg
>>>> *hsotg)>>
>>>>    static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>>>>    {
>>>>
>>>> +	int ret;
>>>> +
>>>>
>>>>    	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
>>>>
>>>> -	if (IS_ERR(hsotg->vbus_supply))
>>>> -		return 0;
>>>> +	if (IS_ERR(hsotg->vbus_supply)) {
>>>> +		ret = PTR_ERR(hsotg->vbus_supply);
>>>> +		hsotg->vbus_supply = NULL;
>>>> +		return ret == -ENODEV ? 0 : ret;
>>>> +	}
>>>>
>>>>    	return regulator_enable(hsotg->vbus_supply);
>>>>    
>>>>    }
>>>>
>>>> @@ -4342,9 +4347,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
>>>>
>>>>    	spin_unlock_irqrestore(&hsotg->lock, flags);
>>>>
>>>> -	dwc2_vbus_supply_init(hsotg);
>>>> -
>>>> -	return 0;
>>>> +	return dwc2_vbus_supply_init(hsotg);
>>>>
>>>>    }
>>>>    
>>>>    /*
> 
> 
> 

