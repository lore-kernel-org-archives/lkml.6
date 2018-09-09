Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC50C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5C620833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 14:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj+xJ6fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5C620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIITKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 15:10:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46651 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeIITKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 15:10:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so9160112pfn.13;
        Sun, 09 Sep 2018 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mtaRKDbOe3MDDwxtj4ta9xsjbcSyerpjm8Er4ukA9Ls=;
        b=Lj+xJ6fV9ATZrRi52oNIzBo7cKv2IvzT3nEor9HZJwjIJ8uxexQb042iFz5V62TDs0
         lAro0xzO0xLRWwdzXzXZ/MbgzHFCEFiS5jFK03QJqWxeXKyb9yptiiaqU3fEU4ey34vL
         +gJ7vmeEFES7ApVtNa51m1q7qSlvoiZi7YHrqSyIj1IMPCrwljGODO6+1Im5oqXNdFt2
         AMMa/UoVlNzmvgU16GY0qyuBigK5XZ9OLSDnpnkxOsi8wO4ek5Ac7w3bDZ8hDGvGzc/d
         jXo3ykGM2Yu46s+eRNr1w9flTYyCRPiUVL37JcETgfE3ihkHQwsrk7jOfUXPi0pWQ6uQ
         AuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mtaRKDbOe3MDDwxtj4ta9xsjbcSyerpjm8Er4ukA9Ls=;
        b=gEHxO77vF8bwcH9cLqINedeOH2O5nboucBbrFM/vUVk/Bvx1En2s0JBvhPIOy0mQzN
         cKOrbZzVXKAJAsxKvE2ThMLRJPstI5YEc/4Kk7EMu0sMbqT0td9Qo593eq9oCLniSQRj
         PF3hLVweUd0x0cOSSJW6Sq+YCg0B+OCVs6+Iiw162nQ9v90tzsUVq927+M/jsllMWUPG
         o3lBGWKZ8qP44CXl+yEedgShQZSrAsxoD90xN/1Pq68Gf/MxxP3q58s4MGfFbBJSjc30
         w1k0f8Q5/iYzTV0fB3zvyFA7J70ZZ1m4+hp7F2rbrnetb2muFqrvxKoW0SQvHy9FY+rk
         Nn7w==
X-Gm-Message-State: APzg51AYIFos3Z+W/TA9XIx9xOwKAxnwjSPHAyVFT9EUWbpUjWoD1ea3
        LfGlhC15bjenf2F9nHBNvRE=
X-Google-Smtp-Source: ANB0VdaGWbf2H8Z+Dby3hV56MPuOSNui3wTeimKdBCtYl7nRUIbkSFdS5UMfwuo3E8iAvfwCMnZpUw==
X-Received: by 2002:a63:4c02:: with SMTP id z2-v6mr18309341pga.312.1536502820025;
        Sun, 09 Sep 2018 07:20:20 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g11-v6sm22381509pgi.90.2018.09.09.07.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 07:20:18 -0700 (PDT)
Subject: Re: [PATCH] usb: typec: don't disable sink or source on
 initialization
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180907103438.GI25121@kuha.fi.intel.com>
 <0adff11c-4836-4035-39a7-1cd2ea3ff74d@roeck-us.net>
 <00ed8e5a4ae0dd40181b8de534684960@www.akkea.ca>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <690375f9-b721-51d5-7292-59acff44af7c@roeck-us.net>
Date:   Sun, 9 Sep 2018 07:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00ed8e5a4ae0dd40181b8de534684960@www.akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 07:08 AM, Angus Ainslie wrote:
> Hi Guenter
> 
> On 2018-09-07 06:55, Guenter Roeck wrote:
>> On 09/07/2018 03:34 AM, Heikki Krogerus wrote:
>>> +Guenter
>>>
>>> On Thu, Sep 06, 2018 at 01:26:44PM -0600, Angus Ainslie (Purism) wrote:
>>>> If the board is being powered by USB disabling the source and sink
>>>> can remove power from the board. Default to source and sink enabled.
>>>>
>>
>> Seems to me that might violate the specification, and cause trouble for systems
>> where vbus has to be off initially. It may be better to provide this kind of
>> information as configuration parameter instead of imposing it on everyone.
>>
> 
> It felt like it would not be the correct thing to do either. I've tried re-arranging the code in tcpci.c to enable the sink before disabling the source but the only way I found to not disable the power was by setting both of those to true.
> 
> What about adding some device tree entries for the initial vbus state and default to false if they are not present ?
> 
> init-vbus-source and init-vbus-charge ?
> 

Yes, I think we should do something along that line. Another question is
if we could or should optionally pull the current state from the low level
driver, but that may be secondary.

Thanks,
Guenter

> Angus
> 
>> Guenter
>>
>>>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>>>> ---
>>>>   drivers/usb/typec/tcpm.c | 8 +++++---
>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>>>> index ca7bedb46f7f..a1b819cf31da 100644
>>>> --- a/drivers/usb/typec/tcpm.c
>>>> +++ b/drivers/usb/typec/tcpm.c
>>>> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>>>>   {
>>>>       int ret;
>>>>   -    ret = port->tcpc->set_vbus(port->tcpc, false, false);
>>>> -    port->vbus_source = false;
>>>> -    port->vbus_charge = false;
>>>> +    /* default to source and sink enabled in case USB is our only power
>>>> +     * source */
>>
>> I am personally in favor of standard multi-line comments.
>>
>>>> +    ret = port->tcpc->set_vbus(port->tcpc, true, true);
>>>> +    port->vbus_source = true;
>>>> +    port->vbus_charge = true;
>>>>       return ret;
>>>>   }
>>>
> 
> 

