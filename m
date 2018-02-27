Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2628879-1519771982-2-10143667227301170866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519771982; b=K97EvGylA43cGHOWAal7/V0d0mcVe8NQqHKb7SQsUxNSBnv
    UNoJivvmRrha3C8hl6pMfJXigMQiKuGTuKEw7ZF4XVoEdCviBaOitGCuyi7aNiN9
    sjqFrW3o5LFfAN9xyQrjp5xXdNJsPxrmyvBRQAXpCB1YPwn+nIGWTM/rczQEQ2Tn
    aNuZvZmoHytjZqC2mJ+dKZ4vHezdyPDJj/FJsYAT5dnNy6AdOp/CCWXYVw8l41ug
    8qBWJgNxr9+6zeiO7SXyjuUl3s8fJHN+JNBY1qC0nVdbt5+uSUGjigJVdK14dMMo
    vTbWt6jc0etEGf54ICoqpsQZtZZ7+cLXDEcDpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519771982; bh=BbH5StoQ0OtopqDAu7eOhhIT4hnABMO8dwa0AciCLdc=; b=G
    aa2r0kW64l/CLR6fqnvqz7JrocSxhUEnTm8p20nwSWBZzYr6xd4DxEnD4RUaw73p
    wM2or+q5zPPxxptJABeoBHyG8NZs+zacb084JDl+xpHj1cjEXILzCF/Z1gf9huP9
    eTPqo06HhBQIOcan9CFTeiVS5vE9X2ym3iKsJIKF8uMXquvQwLM6Ef/VceHZjMqK
    m3UcAC9Xreg/aOBURh/93GzibaDZW2KXiplrz1667xOzjc29LWFzf3ouqAqrJZEU
    zDczIHSbmatBFpkNRJ87Wbakwh3WejIKafnKM+xwujDlB8maGNZCSED2pPxZSX8Y
    8innBcKus2KB8+/6KY8cw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeB0Wvr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:51:47 -0500
Received: from osg.samsung.com ([64.30.133.232]:64414 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeB0Wvr (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 17:51:47 -0500
Subject: Re: [PATCH] usbip: tools usbip_attach: Fix cryptic error messages
To: Krzysztof Opasiak <k.opasiak@samsung.com>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: yuyang.du@intel.com, nobuo.iwata@fujixerox.co.jp,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <CGME20180227222421epcas2p23e030c5de1620f5976cf4f91a2685682@epcas2p2.samsung.com>
 <20180227222356.23245-1-shuahkh@osg.samsung.com>
 <8b7b3f6a-4075-e7e3-39ac-51ddb8f961a0@samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <86353881-6807-7ca4-960e-2d1f8a428658@osg.samsung.com>
Date: Tue, 27 Feb 2018 15:51:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8b7b3f6a-4075-e7e3-39ac-51ddb8f961a0@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 03:45 PM, Krzysztof Opasiak wrote:
> 
> 
> On 02/27/2018 11:23 PM, Shuah Khan wrote:
>> Attach device error message is cryptic and useless. Fix it to be
>> informative.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>   tools/usb/usbip/src/usbip_attach.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/usb/usbip/src/usbip_attach.c b/tools/usb/usbip/src/usbip_attach.c
>> index 7f07b2d50f59..f60738735398 100644
>> --- a/tools/usb/usbip/src/usbip_attach.c
>> +++ b/tools/usb/usbip/src/usbip_attach.c
>> @@ -195,7 +195,8 @@ static int attach_device(char *host, char *busid)
>>         rhport = query_import_device(sockfd, busid);
>>       if (rhport < 0) {
>> -        err("query");
>> +        err("Attach request for Device %s. Is this device exported?",
>> +            busid);
>>           return -1;
>>       }
> 
> The code itself is ok and you may put my:
> 
> Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
> 
> but just because of my curiosity, there is a number of places in usbip tools where the same level of descriptiveness is used for error message. Why did you choose to fix this one not any other or all others?;)
> 
> Best regards,

Yes there are several very cryptic and useless error message all over the
place in usbip tools that could use refinement. This just happens to be the
one that I seem to run into very frequently. It frustrated me enough that
I decided to fix this one first. :)

thanks,
-- Shuah
