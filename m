Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1014559-1518432531-2-13465231072921970142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518432531; b=k5hyw5Go8VvKpDnemOqL29CpN8CBjSWK1JD6vMrvLYAN3+n
    719PkhAT1Uov3XKoEYU5xp/bZOHresdTPiFPtN/NwMuI+H3uN+ytMrovdOtHYG04
    NX/e7VW3sBM08X9jIp6/JP2Mm1gIEvsaoQgRVBQE4b2k6srOAtpKZiqPPjK6gePc
    RZq10bX4AS17PiG92SJcUeXAA5/OTpJrvuCaIJG2ZQSQYJtfl7j41OPg44US6R3W
    sjibo2Q70s0FeQvdisbXFty5DS4EMaywtCyIpMqbcj+FvvFZzYJlNAKB2Ar4BfHN
    QvQ8QcS2gLYcKGN89FIetYU0YaKhYP/TOm94lKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518432531; bh=Ca3kQzWIMIdSJyOhBq9dEu3BvyZR3yW4arBTRAzdgBw=; b=U
    X2mytJ2Wu0d/q7CEK7oZN1pNRKqq5oHRD8Op37ybyInXmEnQV5cgO6DxkHD+y/DS
    F+zgsiDiAe51yBTek/Su9zcEvgCDmW6lQ0OpsOMafYw3LCmK0Xw5n9sAodicPQ8q
    sStuEPyqAqagTNwko3XA2r2TDu95utUDjipJejCOU6m2LdJK0Isstcl9ns3YncMc
    lZE0v7A5Cv10jfpXvUpNz+x3r0hG405J8XKzs39lYjN22gdrImAlS1Cwm42ad/Ah
    SClQ6E+Z9fZf+lftkJTVVSXFMkQErzKm1WmB7pxw7Ia3zn/zIAL+voFuD/YVX3WK
    BZIUnJaXdKxSc1NvOE80A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=LV9+n3ZM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=LV9+n3ZM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeBLKse (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 05:48:34 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:64622 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeBLKsa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Feb 2018 05:48:30 -0500
Subject: Re: [PATCH 2/2] usb: dwc3: drd: Fix lock-up on ID change during
 system suspend/resume
To: Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1516626103-1969-1-git-send-email-rogerq@ti.com>
 <1516626103-1969-3-git-send-email-rogerq@ti.com>
 <87y3jya8pr.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <24506c62-b904-af2c-da0f-f995cfaa29d3@ti.com>
Date: Mon, 12 Feb 2018 12:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87y3jya8pr.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Felipe,

On 12/02/18 10:54, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> Adding/removing host/gadget controller before .pm_complete()
>> causes a lock-up. Let's prevent any dual-role state change
>> between .pm_prepare() and .pm_complete() to fix this.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/core.c | 31 +++++++++++++++++++++++++++++++
>>  drivers/usb/dwc3/core.h |  5 +++++
>>  drivers/usb/dwc3/drd.c  | 10 ++++++----
>>  3 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 42379cc..85388dd 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1414,6 +1414,33 @@ static int dwc3_runtime_idle(struct device *dev)
>>  #endif /* CONFIG_PM */
>>  
>>  #ifdef CONFIG_PM_SLEEP
>> +static int dwc3_prepare(struct device *dev)
>> +{
>> +	struct dwc3	*dwc = dev_get_drvdata(dev);
>> +	unsigned long	flags;
>> +
>> +	if (dwc->dr_mode == USB_DR_MODE_OTG) {
>> +		spin_lock_irqsave(&dwc->lock, flags);
>> +		dwc->dr_keep_role = true;
>> +		spin_unlock_irqrestore(&dwc->lock, flags);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void dwc3_complete(struct device *dev)
>> +{
>> +	struct dwc3	*dwc = dev_get_drvdata(dev);
>> +	unsigned long	flags;
>> +
>> +	if (dwc->dr_mode == USB_DR_MODE_OTG) {
>> +		spin_lock_irqsave(&dwc->lock, flags);
>> +		dwc->dr_keep_role = false;
>> +		spin_unlock_irqrestore(&dwc->lock, flags);
>> +		dwc3_drd_update(dwc);
>> +	}
>> +}
> 
> wouldn't it be far easier to just disable OTG IRQ in prepare? and,
> perhaps, also flush_work_sync() ?
> 

There was some more discussion on this here [1]. Apparently using system_freezable_wq
and a patch mentioned at end of [1] is sufficient as well

[1] https://lkml.org/lkml/2018/1/25/384

Could you please share your view there?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
