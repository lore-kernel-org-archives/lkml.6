Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB03C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE852089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LimrfKpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE852089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJDATa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:19:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33515 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDATa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:19:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id 84-v6so3979361qkf.0;
        Wed, 03 Oct 2018 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLLgdNqTYo8gcp/kwsvLkrnQICnyFyO3IbBK2xL1F+o=;
        b=LimrfKpvwrDGDhkSp4DYzb+7N1lqSAdLIA+dnRb45QVyOufsjc76Gy0F5bjqFRY5dq
         uWP21k5ijUvPReF1XjlkpPkED/eXnA52jpyGDrsqQewG8RcJ5gtzojW4eDlKcZBBOn3f
         zrjI4P1N5lVQd823bRl/G3xR9qJUp3oARpQCG2PTKs9SnF7Kbl8O+Ue9GzuZlJRivNjZ
         Wpo/USrrG4ziEjtzLa4Myd77Zcv8FytDA81Sq70/fhZZfmJg48ZZ9WouVSBXv6+b66OO
         6MdT+073uiAhdWqjAdFCE6JhdDRr+KairXw/zPlkqP+9QQN8EWVF6SsmKvOcJVzYB7BV
         Q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLLgdNqTYo8gcp/kwsvLkrnQICnyFyO3IbBK2xL1F+o=;
        b=roXl28I7/9Y8uQB8pdeBMiExzixUNLZ2KWCNqxGcjUTbmuDgHWzPde2/TCA7cKAKFi
         pvMd2+Q7avw+nzSow7Vy42sXr8Tm/na6c31E07bUOooM/ywCQMgWsbqCoLguvLGK8mJ+
         nadxxb8Fv30yFnWmhyTVmaTEC1xo4BZ0wriWHxRmp5FEL65AS0uuSZe75EUOAqn2i0b9
         BCS4qWUM5ILQzafWiFVu5iJ9wY4nKB7PNDDhJ2NRqPwtZP28tZKgHJ26vVIhSoOC+RCq
         JlrBZ9bygA9qplrFBLDCbH9sjDqSU+2aAd1GDjFnvWf/7i1hWyHqlSJgWG30mFBEBayb
         N50A==
X-Gm-Message-State: ABuFfojPC8/wphMq3gvVScipsNSoluGQcg3j/ElD1VO/e/P9LvtE93IH
        9Xtx8cR6xRF7/3LhJdKFPmhI9nD2
X-Google-Smtp-Source: ACcGV6013Z+Ig7kpHoxPBrq6TRD3LtkMNO1cQVSOwJRe88XynAsBX5vnXpZdXwjQW0/CQP0VR2TFIA==
X-Received: by 2002:a37:7883:: with SMTP id t125-v6mr2022466qkc.334.1538587808171;
        Wed, 03 Oct 2018 10:30:08 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-255-82-34.washdc.fios.verizon.net. [96.255.82.34])
        by smtp.gmail.com with ESMTPSA id a50-v6sm955398qtc.93.2018.10.03.10.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 10:30:07 -0700 (PDT)
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
 <20180930093452.GG2209@nanopsycho.orion>
 <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
 <20181002111215.GA2222@nanopsycho>
 <d87d05cd-bd35-4551-4c6c-44409b92dd5b@gmail.com>
 <20181003104436.GB2222@nanopsycho>
From:   Chas Williams <3chas3@gmail.com>
Message-ID: <526bd655-5816-69dd-ac75-bdd4f85f1ce9@gmail.com>
Date:   Wed, 3 Oct 2018 13:30:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003104436.GB2222@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/18 06:44, Jiri Pirko wrote:
> Tue, Oct 02, 2018 at 11:20:25PM CEST, 3chas3@gmail.com wrote:
>>
>>
>> On 10/02/18 07:12, Jiri Pirko wrote:
>>> Mon, Oct 01, 2018 at 04:06:16PM CEST, 3chas3@gmail.com wrote:
>>>>
>>>>
>>>> On 09/30/18 05:34, Jiri Pirko wrote:
>>>>> Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>>>>>> On Sun, 30 Sep 2018 09:14:14 +0200
>>>>>> Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>
>>>>>>> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 07/10/15 02:41, Jiri Pirko wrote:
>>>>>>>>> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>>>>>>>>>> On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>>>>> Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>>>>>>>>>>>> The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>>>>>>>>>>>> decide if it should start the address configuration. Since team ports
>>>>>>>>>>>> shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>>>>>>>>>>>> a port to the team master.
>>>>>>>>>>>
>>>>>>>>>>> I don't want to use IFF_SLAVE in team. Other master-slave devices are
>>>>>>>>>>> not using that as well, for example bridge, ovs, etc.
>>>>>>>>>>
>>>>>>>>>> Maybe they need to get fixed too. I've used that flag because it is
>>>>>>>>>> documented as
>>>>>>>>>> a "slave of a load balancer" which describes what a team port is.
>>>>>>>>>>
>>>>>>>>>>> I think that this should be fixed in addrconf_notify. It should lookup
>>>>>>>>>>> if there is a master on top and bail out in that case.
>>>>>>>>>>
>>>>>>>>>> There are other virtual interfaces that have a master assigned and want to
>>>>>>>>>> participate in IPv6 address configuration.
>>>>>>>>>
>>>>>>>>> Can you give me an example?
>>>>>>>>
>>>>>>>> I would like to revisit this patch (yes, I know it has been a while).  I
>>>>>>>> believe the VRF implementation uses master to group the interfaces under
>>>>>>>> a single interface.
>>>>>>>>
>>>>>>>> I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>>>>>>>> similar.
>>>>>>>
>>>>>>> Again, why do you need team port to have IFF_SLAVE flag? What do you
>>>>>>> want to achieve
>>>>>>
>>>>>> Without setting this flag IPv6 will try and make a link specific address.
>>>
>>> You are talking about addrconf_notify() right? Easy to fix to check
>>> something more convenient. Like netif_is_lag_port() if you want to avoid
>>> it for bond/team. netif_is_ovs_port(), netif_is_bridge_port() etc. Lot's
>>> of helpers to cover this.
>>
>> OK, IPv6 should probably be using this.
>>
>>>
>>>
>>>
>>>>>
>>>>> Why is it not an issue with bridge, ovs, and other master-slave devices?
>>>>>
>>>>
>>>> It very well might be an issue for bridge and ovs.  Other master-slave
>>>> devices include the existing VRF implementation in the kernel and those slave
>>>> interfaces will certainly want to use IPv6.
>>>>
>>>> However, IFF_SLAVE has a specific meaning:
>>>>
>>>> ./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.
>>>
>>> I know that some userspace apps are using this flag to determine a
>>> "bonding slave". I don't think that they care much about eql...
>>>
>>>
>>>>
>>>> The bonding driver is not the only user:
>>>>
>>>> ./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) ==
>>>> IFF_SLAVE)
>>>> ./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
>>>> ./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;
>>>>
>>>> The team driver would like to use this same flag since it is a load balancer
>>>> as well.  The side effect of not assigning IPv6 is a bonus. The fact that
>>>
>>> No, please leave IFF_SLAVE as it is. Both kernel and userspace have
>>> their clear indications right now about the master/slave relationships.
>>
>> The team driver does create a master/slave relationship.  The team slaves are
>> literally slaves of the master device.  It's not clear to me
>> why you we can't mark the slaves of the team master as actually being
>> slave interfaces?
> 
> So? IFF_SLAVE flag serves a different purpose. That's it. Team does not
> need it, bridge does not need it, macvlan does not need it, etc.

I agree.  But team *is* a load balancer.  Why can't team mark its slave 
interfaces as IFF_SLAVE?  They are literally slaves of a load balancer 
which is the exact meaning of the IFF_SLAVE flag.

> 
> 
>>
>>>
>>>
>>>> bridges and ovs are also likely broken is a different issue.  Should there be
>>>> a another flag that says "layer 2 only"?  Very possibly, but that is
>>>> something all these interfaces should be using to include bonding, team, eql,
>>>> obs, bridge etc.  That's not a reasonable objection to labeling the team
>>>> slave as slaves since they are literally slaves of a load balancer.
>>>>
>>>>
>>>>
