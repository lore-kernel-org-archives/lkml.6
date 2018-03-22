Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2776495-1521725679-2-12137455812087639768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521725678; b=HfMqy9JS+YM34WGr1Fkzr+wQY4dX+EClAMXYRhxey8TJziV
    C40OeD+Xrw3hGqzNwAGbED8cxccMPQZcI2C+xpdoAOiVwcbJii+lex6aGXpHZsUG
    ebWNQu0vsdD27Ns4l3Jo63++FnIA1lxZGu6mEq5BSR/NcwnK8VMNqKKAypRq1yRf
    Ala5CSauxob1dUrBvAdBWQJa3Sp+WS6r/1b/DO6dSvX9WE0skb7HLZqBi0cOlHrX
    x0gXRyaFsK1w9JPZs+dV1xPTTicdHZO2vY9LiQOZW1f+KW0adg1QUcyQfikQ+VK5
    aARKyDFcrJAufduDKF6QVKNrvDnWWiVGdsI1zDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521725678; bh=10BQLjo3J3P/Eung4T0jt8/PBSsZ4G1g4PtUgsiWE5U=; b=m
    dKg5Qa99QoKANwzsFj3hv0zPk9eqZODIQD0EW19VHOjmw77rDgXh+dquh6yavyTP
    ggjTT1Xuom3tgOzyNeNdAr5vtQW9X1vOTmTWkA30dIqetHXFZhvpVbLoZxaSTEVl
    /mlahpF5s0cGOOlMbi9GLk03x09z1ggeElrlneyHnITqKLAoV7RCzgT/3m95ifuG
    qFyFVMTWN9GOhkOyqMdIZJbWeiKpssS1Rdr8RaPkm3NnXp13NIO9JcJi4zvDbxIF
    Flte1NxWuZFHZLIjgGD+uloi0jvklPMVyntImHZmQv6x2azYzvjJbRa11EYuISUR
    xXNAQQbRlI0PfWyMDA0AA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=collabora.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbeCVNeR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 09:34:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753626AbeCVNeQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 09:34:16 -0400
Subject: Re: [PATCH v3] usb: dwc2: dwc2_vbus_supply_init: fix error check
To: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <20180322131451.12631-1-tomeu.vizoso@collabora.com>
 <1794463.c121CNJ3R4@diego>
From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <baa69738-e6ca-be6d-391a-4dfe751ea3a3@collabora.com>
Date: Thu, 22 Mar 2018 14:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1794463.c121CNJ3R4@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/22/2018 02:26 PM, Heiko Stübner wrote:
> Am Donnerstag, 22. März 2018, 14:14:51 CET schrieb Tomeu Vizoso:
>> devm_regulator_get_optional returns -ENODEV if the regulator isn't
>> there, so if that's the case we have to make sure not to leave -ENODEV
>> in the regulator pointer.
>>
>> Also, make sure we return 0 in that case, but correctly propagate any
>> other errors. Also propagate the error from _dwc2_hcd_start.
>>
>> Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
>> supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>>
>> v2: Only overwrite the error in the pointer after checking it (Heiko
>>      Stübner <heiko@sntech.de>)
>> v3: Remove hunks that shouldn't be in this patch
>> ---
>>   drivers/usb/dwc2/hcd.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>> index dcfda5eb4cac..863aed20517f 100644
>> --- a/drivers/usb/dwc2/hcd.c
>> +++ b/drivers/usb/dwc2/hcd.c
>> @@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
>> static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
>>   {
>>   	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
>> -	if (IS_ERR(hsotg->vbus_supply))
>> +	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
>> +		hsotg->vbus_supply = NULL;
>>   		return 0;
>> +	} else if (IS_ERR(hsotg->vbus_supply)) {
>> +		hsotg->vbus_supply = NULL;
>> +		return PTR_ERR(hsotg->vbus_supply);
>> +	}
> 
> my personal cluelessnes, but can you use PTR_ERR without checking for
> IS_ERR first?

It's just a cast, so it should be fine.

> I would've expected something along the line of
> 
> if (IS_ERR(hsotg->vbus_supply)) {
> 	if (PTR_ERR(hsotg->vbus_supply) == -ENODEV) {
> 		hsotg->vbus_supply = NULL;
> 		return 0;
> 	} else {
> 		return PTR_ERR(hsotg->vbus_supply);
> 	}
> }

I kind of liked to avoid one indentation level. Also wanted to play safe 
and NULLify the pointer in both code paths.

Thanks,

Tomeu
