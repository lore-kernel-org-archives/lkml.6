Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE67C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3132083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l08EbGrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3132083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeIGRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:36:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44985 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIGRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:36:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so6963441pgp.11;
        Fri, 07 Sep 2018 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/iTA2d2KrpjnDGL1a1FzznXDMvDUZVnWXWH6jnmLSc=;
        b=l08EbGrWZ28ILFdgmBdhy3BVe9bUkitGV7AJm1ZmeQaHIh/JXLQCLFniuQaE6nOsJ2
         AZNi7Cjs74MRwWbTXa1caOIuxzbGpVenkw6fNLnGT8rQsCYUOxznao+zw5UCH+lhQp6e
         GRGNpZQ9Fw4av2tqPmQ+NnBSoS3SCcVgdbYeuKCZIuc4lU4RVbX4wXRWkpPP3jMWVGVj
         2Pmf/Hc/nzOKV/hxb8BaL6GK5qdvPCTmKhLvKsii3smTWbkl60NSQ9jmjhZLb4/5V+RF
         l4az3fiLlyOxiHaZYosQp+ZcIkGIA7F0POHqtmsAGu+fB8ua1v8d0wpooQOVGG+MvDcn
         NfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/iTA2d2KrpjnDGL1a1FzznXDMvDUZVnWXWH6jnmLSc=;
        b=Q8wOfJiccc7rZhmR4FZkKaRBA6ImTYuSDF2GOg8ZqmUTw6gf61s4XY7doeaf6arj4v
         03Y/8JbsmC2qckFCdEl1z9fLNT8CKZjU4FnCUYOIJMzWvtBIfSNhPVcyoT3sYymlvkXe
         cO3JwUecKen64BtVu0FgfyhqYL4NS/Dq4D0XAAqbx+u09bgbH9NO49zrg4xHkw8C9fCR
         SinfVc6AgItqN0FoY+kq10DjGDtYDkrJ6fmYoPLIkdwQxPk0vDDq07fxhDi3s8OwVwHo
         /GNhPU28DRq4MiO1td2Gg+WqjW8BeySz0ijPdkq80mfuBPocj0GBtH6x2AIR7OA97atF
         SPWA==
X-Gm-Message-State: APzg51AmGzesQqiwdpt6x/Ac7Jkko/jPRblGSiuRXCjLe+jQ6fN/nLLN
        WQUhVj2BjKJS+sqPdDfjFoG/Jmcy
X-Google-Smtp-Source: ANB0Vdb0oMVOJ6ibyVmWHlvFfTMVeSqSESCdTHR2n9L8xoXGvI58vamayVjKMZQ2/t7JWZm4bv/bzA==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr8183084pfb.157.1536324956235;
        Fri, 07 Sep 2018 05:55:56 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y4-v6sm11188036pfn.123.2018.09.07.05.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 05:55:55 -0700 (PDT)
Subject: Re: [PATCH] usb: typec: don't disable sink or source on
 initialization
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180907103438.GI25121@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0adff11c-4836-4035-39a7-1cd2ea3ff74d@roeck-us.net>
Date:   Fri, 7 Sep 2018 05:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907103438.GI25121@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 03:34 AM, Heikki Krogerus wrote:
> +Guenter
> 
> On Thu, Sep 06, 2018 at 01:26:44PM -0600, Angus Ainslie (Purism) wrote:
>> If the board is being powered by USB disabling the source and sink
>> can remove power from the board. Default to source and sink enabled.
>>

Seems to me that might violate the specification, and cause trouble for systems
where vbus has to be off initially. It may be better to provide this kind of
information as configuration parameter instead of imposing it on everyone.

Guenter

>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>   drivers/usb/typec/tcpm.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>> index ca7bedb46f7f..a1b819cf31da 100644
>> --- a/drivers/usb/typec/tcpm.c
>> +++ b/drivers/usb/typec/tcpm.c
>> @@ -2462,9 +2462,11 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>>   {
>>   	int ret;
>>   
>> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
>> -	port->vbus_source = false;
>> -	port->vbus_charge = false;
>> +	/* default to source and sink enabled in case USB is our only power
>> +	 * source */

I am personally in favor of standard multi-line comments.

>> +	ret = port->tcpc->set_vbus(port->tcpc, true, true);
>> +	port->vbus_source = true;
>> +	port->vbus_charge = true;
>>   	return ret;
>>   }
> 

