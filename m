Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+YMl0mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E91120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIEQOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:14:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35325 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeIEQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:14:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so7340507wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BnD0tyKYt1s0Tlrm8PzLcizcKK6ekn5oZtMYDI7NCfM=;
        b=c+YMl0mbwkD1GD9r74tJuq3mSy2w9JyQfX0Ri/7CCled/cs4peshLw4NjA2JeVWNIi
         FItkKQftmYDi9oO27S6yPv//tncl3k8pF8WMnsjKBejsG1aJbmyNr77xDZf7n2O2gH+i
         o6fyZ0MknP3uEjJS5XKvWxjyYXaKHGU3acFOS8Eljzb8fNXhZkpHvzTSDscl+7HLROZG
         bt9fX28pOcWLiPQE+7h3IYu1Jan8CsZuSeMWTnSA3FFsriiVxOp06+oaNWDZRoC6jAAY
         rOefRANPPVZh6XbS9wn1bq/l9425c9u+gjEJLCIAXFAL9bMZIda4CqrmlMItg4Nan/gy
         0oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BnD0tyKYt1s0Tlrm8PzLcizcKK6ekn5oZtMYDI7NCfM=;
        b=mV5mJZTZ48Uv7PEJu/svsk30dCZdyVfiBZeDsWEhJvkdyikh7T/DPEPRhqgnsZ3C09
         DzFBfgrZ+FxD4S9VcCNv+qUWqTvQqrxobU+43M7J7IKO+tDHx+t4Y1kyeZytVxCuR9NU
         SWnP6Z7vj9qmb7Hb1yb3Y7QNdW8lFQZ9b9AdQ1m857SFeVHpqcHqlHwBD2KNumqC3WZp
         noSYTqEBctUG+5xx6mQ8nOPOZ/CeyjqTqtAAl+Al3s5cu9yC5mQjAtQLmREYsFmi7clQ
         a4sYT7TEZZvBklJG1/wahUnjtUMIAz0lt4q0xUkC98fwtAgo5L+ZKNtQ6T81xj4Hs5tH
         1I3Q==
X-Gm-Message-State: APzg51D8WF3vwfkxREeayAfviYYDyAe9vKpFiSjDzo2ScSMZAPWuKDie
        EPgTH6WIwZZX1eWiALdIz+m5M8O7
X-Google-Smtp-Source: ANB0VdbNyRYjSJiizoQI9bHCPhIX5w5zDQl+A9Cxzxdt/DE9klaWD/E3RZGhjd/afCiTSCaKgt8Cbg==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr25436994wra.110.1536147885727;
        Wed, 05 Sep 2018 04:44:45 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id a6-v6sm1885832wmf.22.2018.09.05.04.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 04:44:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove empty if statement in
 rtw_led.c
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180904111616.18508-1-straube.linux@gmail.com>
 <20180905081315.bdbotkyfpdkdj537@mwanda>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <14e81d5c-cafd-4d6d-13a7-87f7d97a5ae3@gmail.com>
Date:   Wed, 5 Sep 2018 13:44:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180905081315.bdbotkyfpdkdj537@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 10:13 AM, Dan Carpenter wrote:
> On Tue, Sep 04, 2018 at 01:16:15PM +0200, Michael Straube wrote:
>>
>>   	case LED_CTL_SITE_SURVEY:
>> -		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
>> -			;
>> -		} else if (!pLed->bLedScanBlinkInProgress) {
>> +		if (!pLed->bLedScanBlinkInProgress) {
> 
> I think you have introduced a bug...

Ah yes I see now, thanks.
Would it be ok to merge the conditions in a single if?

if ((!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
     !check_fwstate(pmlmepriv, _FW_LINKED)) &&
     !pLed->bLedScanBlinkInProgress) {


regards,
Michael
