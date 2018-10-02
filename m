Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E09C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33CC20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev3/BYfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33CC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeJCEFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:05:48 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:40785 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:05:48 -0400
Received: by mail-qt1-f170.google.com with SMTP id e9-v6so3677559qtp.7;
        Tue, 02 Oct 2018 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0alpmmHz6ZTguZZiITBs+sXBvYpmgUBHdxQc24Ep7ZY=;
        b=ev3/BYfjfgUvow7Mewboan8kywxdK7Eae1av3bRh6/mMaYc/6TzpytxsD6asYgDG6w
         Okdui2QW7XZykQqJ860jBKHDQ+nCtmsi4cWIiRvew/2lxNQ9rJxFhSFkKP0xxkXys3lG
         8rgOYqkhJGcRF71Vw4zdg5QnQ0xjVO8+H/FmUqaxY3ZrD/jqdvsG+cedFj5rvCqNjH9H
         Kh1JbyQzNlJNThhVYGx/W6s2BKBtLzql36LmrRDq1oxri88JHZolDCep1SoL5tGYTsy+
         jwPfv5YyU8wSh6rZCbkVi8AW8RGHQSn6fJAIkPyqvzmKN5Qjr2EZV5sBGVv+7wtqRrE7
         KRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0alpmmHz6ZTguZZiITBs+sXBvYpmgUBHdxQc24Ep7ZY=;
        b=SIQzB5UAXDR+I55J2fRdcNY5MRpWd09rdh6T2DuoQtBGUK+yk+LoxqdpQYkHnVkuuQ
         FEVY0PGdiTEXA4t/m5iSpGAHYFPtjo7ej2sBdH/1XSsHaFX/YMnAMFEmtEKMwYbO/y60
         Vjtq/bw+9Y1rc0Kxr9jbEF75WsOLGAqMeyAXiSUyouGpuUjxZLhq+na7AhnBubXVI4T8
         KCQeKj0qWH6a7ykA0Az5eDgziV0vjih6QdVROqS7Gq0cVbe7b/u2NMy0SarPSpbyqvLG
         +1FLzytcsQndVlYdUTnPtcEC/tXQwt45rYLtE8FW8O3+C7YvEfs+tSypnF0CtR0e6ofN
         jObA==
X-Gm-Message-State: ABuFfogcXlX8/rOsw14OwMi0NzPQiHOQVJQwW8aGUnheprhVVxHEPume
        iLxqnk0yeJejdQmnKjdJxsw/x3QG
X-Google-Smtp-Source: ACcGV625me3clzLtHLdSUMGz6asFsLJ8Ah7i5d409+TLX02CoCcghGWzzWritvAw41TtIgHdjXbrFQ==
X-Received: by 2002:a0c:8662:: with SMTP id p89-v6mr874780qva.192.1538515226627;
        Tue, 02 Oct 2018 14:20:26 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-255-154-210.washdc.fios.verizon.net. [96.255.154.210])
        by smtp.gmail.com with ESMTPSA id n67-v6sm10743432qkh.66.2018.10.02.14.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:20:25 -0700 (PDT)
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
 <20180930093452.GG2209@nanopsycho.orion>
 <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
 <20181002111215.GA2222@nanopsycho>
From:   Chas Williams <3chas3@gmail.com>
Message-ID: <d87d05cd-bd35-4551-4c6c-44409b92dd5b@gmail.com>
Date:   Tue, 2 Oct 2018 17:20:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002111215.GA2222@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/18 07:12, Jiri Pirko wrote:
> Mon, Oct 01, 2018 at 04:06:16PM CEST, 3chas3@gmail.com wrote:
>>
>>
>> On 09/30/18 05:34, Jiri Pirko wrote:
>>> Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>>>> On Sun, 30 Sep 2018 09:14:14 +0200
>>>> Jiri Pirko <jiri@resnulli.us> wrote:
>>>>
>>>>> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>>>>>>
>>>>>>
>>>>>> On 07/10/15 02:41, Jiri Pirko wrote:
>>>>>>> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>>>>>>>> On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>>> Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>>>>>>>>>> The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>>>>>>>>>> decide if it should start the address configuration. Since team ports
>>>>>>>>>> shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>>>>>>>>>> a port to the team master.
>>>>>>>>>
>>>>>>>>> I don't want to use IFF_SLAVE in team. Other master-slave devices are
>>>>>>>>> not using that as well, for example bridge, ovs, etc.
>>>>>>>>
>>>>>>>> Maybe they need to get fixed too. I've used that flag because it is
>>>>>>>> documented as
>>>>>>>> a "slave of a load balancer" which describes what a team port is.
>>>>>>>>
>>>>>>>>> I think that this should be fixed in addrconf_notify. It should lookup
>>>>>>>>> if there is a master on top and bail out in that case.
>>>>>>>>
>>>>>>>> There are other virtual interfaces that have a master assigned and want to
>>>>>>>> participate in IPv6 address configuration.
>>>>>>>
>>>>>>> Can you give me an example?
>>>>>>
>>>>>> I would like to revisit this patch (yes, I know it has been a while).  I
>>>>>> believe the VRF implementation uses master to group the interfaces under
>>>>>> a single interface.
>>>>>>
>>>>>> I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>>>>>> similar.
>>>>>
>>>>> Again, why do you need team port to have IFF_SLAVE flag? What do you
>>>>> want to achieve
>>>>
>>>> Without setting this flag IPv6 will try and make a link specific address.
> 
> You are talking about addrconf_notify() right? Easy to fix to check
> something more convenient. Like netif_is_lag_port() if you want to avoid
> it for bond/team. netif_is_ovs_port(), netif_is_bridge_port() etc. Lot's
> of helpers to cover this.

OK, IPv6 should probably be using this.

> 
> 
> 
>>>
>>> Why is it not an issue with bridge, ovs, and other master-slave devices?
>>>
>>
>> It very well might be an issue for bridge and ovs.  Other master-slave
>> devices include the existing VRF implementation in the kernel and those slave
>> interfaces will certainly want to use IPv6.
>>
>> However, IFF_SLAVE has a specific meaning:
>>
>> ./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.
> 
> I know that some userspace apps are using this flag to determine a
> "bonding slave". I don't think that they care much about eql...
> 
> 
>>
>> The bonding driver is not the only user:
>>
>> ./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) ==
>> IFF_SLAVE)
>> ./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
>> ./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;
>>
>> The team driver would like to use this same flag since it is a load balancer
>> as well.  The side effect of not assigning IPv6 is a bonus. The fact that
> 
> No, please leave IFF_SLAVE as it is. Both kernel and userspace have
> their clear indications right now about the master/slave relationships.

The team driver does create a master/slave relationship.  The team 
slaves are literally slaves of the master device.  It's not clear to me
why you we can't mark the slaves of the team master as actually being
slave interfaces?

> 
> 
>> bridges and ovs are also likely broken is a different issue.  Should there be
>> a another flag that says "layer 2 only"?  Very possibly, but that is
>> something all these interfaces should be using to include bonding, team, eql,
>> obs, bridge etc.  That's not a reasonable objection to labeling the team
>> slave as slaves since they are literally slaves of a load balancer.
>>
>>
>>
