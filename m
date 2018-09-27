Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50615C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08316216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NABKZz3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08316216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeI0UWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:22:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42197 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0UWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:22:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id g20-v6so511330qke.9;
        Thu, 27 Sep 2018 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aw5iVKMofaO/YrtDj5lmpQCvyVhSfIDWEQBpceKe6Xk=;
        b=NABKZz3vlF/pUue0jfZ9SLAPg4yxt9Ha9+sZzELd0jH3PLqjHxAYUCQwu70mfkB0tM
         MY0gxWdL9lGof9sPhw0LeisGFcgwbMrPC7iE/wMTEI7BTnzAN/yG0c9UbG/IEraE/yi/
         t4sfb4Z4ztFlDt9H73ieocZ4Y22VwhduyzLQstAcVb80A2pMoCWxAf8vJTgg2O0lmt9U
         +HC7zDIXvv2svv3Bzx1cz4dVkqkFGd1/6oM2/j7Tao9TqXhLCF2OrObVM/k1jnRfzPtl
         nNH6ccXXaOy4pLpTiU8SqkfPDIf98TrRrkcLuD8s1jZFUl+QTipjCpLBCMISZ95BaGUl
         ZePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aw5iVKMofaO/YrtDj5lmpQCvyVhSfIDWEQBpceKe6Xk=;
        b=QO2/Pe3w98dLeXO9QOtgX125XsnCnWNM8A85w3lBpBUrE5W50f3bZvqYSp5WjDFBG4
         BBAOZH5mrXoTceMPB5mUwLFfGOimK6S0SWY/gPYxLHvx4MG1QJQU4VozfvHjFsazc3Hh
         4mpBd3SwIE8fnyz2KrULOkuKShBgfaGfgo2UcU1gYUeWyi4ncZ+3h7h0uZF6uAh9Kcga
         I2oIXYCwVCf9sUVKj/O6rRCmTgsAsnfsb3/SyATqAYpm3FAY96pAFOSQ1yI2J+tYx5wB
         aNfOm+k9KPwpb6Lj4NxmaNneBniVUOX1QtbeTA9iNZ3bQOpNI+OTtLmFhzExoT6Q1UWa
         JMGw==
X-Gm-Message-State: ABuFfoiouwOQQ//J2H2P01C6n/GJz0jncpF4HcMdOWjRaA1W2qnlIfv3
        TsP2dt0tnJz4rLeaNspJRmU1aBlM
X-Google-Smtp-Source: ACcGV620Ptwrixj2Vks6uxpkMeDyr/4DcFWvUYXy81Pvd1ZlDodfAVfpxspIPeQG6Ntp7XPuJRGhgQ==
X-Received: by 2002:a37:9442:: with SMTP id w63-v6mr8071990qkd.304.1538057067405;
        Thu, 27 Sep 2018 07:04:27 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-255-154-210.washdc.fios.verizon.net. [96.255.154.210])
        by smtp.gmail.com with ESMTPSA id e206-v6sm1055553qkb.4.2018.09.27.07.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:04:26 -0700 (PDT)
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
To:     Jiri Pirko <jiri@resnulli.us>, Jan Blunck <jblunck@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
From:   Chas Williams <3chas3@gmail.com>
Message-ID: <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
Date:   Thu, 27 Sep 2018 10:04:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20150710064147.GA2204@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/15 02:41, Jiri Pirko wrote:
> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>> On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>>>> The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>>>> decide if it should start the address configuration. Since team ports
>>>> shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>>>> a port to the team master.
>>>
>>> I don't want to use IFF_SLAVE in team. Other master-slave devices are
>>> not using that as well, for example bridge, ovs, etc.
>>>
>>
>> Maybe they need to get fixed too. I've used that flag because it is
>> documented as
>> a "slave of a load balancer" which describes what a team port is.
>>
>>
>>> I think that this should be fixed in addrconf_notify. It should lookup
>>> if there is a master on top and bail out in that case.
>>
>> There are other virtual interfaces that have a master assigned and want to
>> participate in IPv6 address configuration.
> 
> Can you give me an example?

I would like to revisit this patch (yes, I know it has been a while).  I 
believe the VRF implementation uses master to group the interfaces under
a single interface.

I don't see a reason not to use IFF_SLAVE since team and bonding are 
fairly similar.

>>
>> Unless we want to have a cascade of conditionals testing the priv_flags in
>> addrconf_notify() this is asking for a new net_device_flags flag.
>> Maybe something
>> generic like IFF_L2PORT ?
>>
>> Thanks,
>> Jan
>>
>> [ Jiri, sorry for getting that mail twice ]
> 
> 
> 
