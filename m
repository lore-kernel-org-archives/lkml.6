Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F8C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257221486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs5nBtVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJFUb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:31:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33685 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeJFUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:31:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id q40-v6so16742234qte.0;
        Sat, 06 Oct 2018 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3wptkEntcpaA2eVJnxjIOkawa5jE01MIaDBD8x2hyXQ=;
        b=fs5nBtVswKoHwLfPi6EcjMUG0jJDaG6G9bXZlBOdOja1Y3E+T5iTAsPiGorD3tK89Z
         a95fzrWBnJP8X/KL9jngJF3312ViGIuv+qibZIK1Vc43mmkTh0/6SGxeMK1L3v157YDd
         X6ybQajUHGQhnOoen+tEVGcL66jayXUSRm6w3aSFpyIcq7p5gk9JJhp3aaWhVVQOGTBN
         zsjyDx1toXdvZy1R5N9frVNDxLdgxSk6XwT/+56HfDDX5e4vCyxxOKU4Zp/PxxUwpEMD
         88JYE7t5tbsMciM9Xf015rFe/I7WV6X3Pf3Bw7nJgz1nULbu3KFP8UFWgjgQLwU+EUab
         bEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wptkEntcpaA2eVJnxjIOkawa5jE01MIaDBD8x2hyXQ=;
        b=fZ9hqG3ayZaEVOMS4LtL2YU5rs3mgv4P+mhZGAku7F4zS1ZCFrMK0vVPjIUr969DL6
         xKIm58dYTjPZD7HYcYId/vhAZnpEnm0Q7TL85Jo5hZ5zEyk8drfxibYoFrbEB8/M3e56
         5I/7mKIoolcoItRnXLal6O2o16wDxgf8uQaIPXR8+uJi0HyeKZ8ZvXbxrD3w0i7ZIO42
         nk3/hMW8vjBVUC9W1wyCsbUEI5ZYKU6Rx5WRebGtJZMf3TyfHEPF545RvWAjXQfRHUY6
         aAfO81amSwJUnwm7Ard9bba4ytWJf2EsRrtya5/CB+xv1IQkL3pOMrpVnPInMiR8FUvU
         1NcQ==
X-Gm-Message-State: ABuFfogE4fY20seL0kTGknjwb6m0T5yIEGLU1BjR578jmKbqSGrmIJ42
        r44xnO8Wy0kbjkLTUbEafDraohvq
X-Google-Smtp-Source: ACcGV62GE0afhqCZEjB4pEe17WRJ0IzEok0nclOfKEQM+7XUyku0KCAKDWMRSEgYcJBFEr6vl0uQEQ==
X-Received: by 2002:a0c:e88f:: with SMTP id b15-v6mr13238582qvo.103.1538832485544;
        Sat, 06 Oct 2018 06:28:05 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-255-82-34.washdc.fios.verizon.net. [96.255.82.34])
        by smtp.gmail.com with ESMTPSA id r57-v6sm6168621qtc.36.2018.10.06.06.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 06:28:04 -0700 (PDT)
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
 <20180930093452.GG2209@nanopsycho.orion>
 <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
 <20181002111215.GA2222@nanopsycho>
 <d87d05cd-bd35-4551-4c6c-44409b92dd5b@gmail.com>
 <20181003104436.GB2222@nanopsycho>
 <526bd655-5816-69dd-ac75-bdd4f85f1ce9@gmail.com>
 <20181005064637.GA3061@nanopsycho.orion>
From:   Chas Williams <3chas3@gmail.com>
Message-ID: <6990d7ab-43fb-713f-7833-f3fdfd88f2af@gmail.com>
Date:   Sat, 6 Oct 2018 09:28:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005064637.GA3061@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/18 02:46, Jiri Pirko wrote:
> Wed, Oct 03, 2018 at 07:30:06PM CEST, 3chas3@gmail.com wrote:
>>
>>
>> On 10/03/18 06:44, Jiri Pirko wrote:
>>> Tue, Oct 02, 2018 at 11:20:25PM CEST, 3chas3@gmail.com wrote:
>>>>
>>>>
>>>> On 10/02/18 07:12, Jiri Pirko wrote:
>>>>> Mon, Oct 01, 2018 at 04:06:16PM CEST, 3chas3@gmail.com wrote:
>>>>>>
>>>>>>
>>>>>> On 09/30/18 05:34, Jiri Pirko wrote:
>>>>>>> Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>>>>>>>> On Sun, 30 Sep 2018 09:14:14 +0200
>>>>>>>> Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>>
>>>>>>>>> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 07/10/15 02:41, Jiri Pirko wrote:
>>>>>>>>>>> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>>>>>>>>>>>> On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>>>>>>> Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>>>>>>>>>>>>>> The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>>>>>>>>>>>>>> decide if it should start the address configuration. Since team ports
>>>>>>>>>>>>>> shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>>>>>>>>>>>>>> a port to the team master.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I don't want to use IFF_SLAVE in team. Other master-slave devices are
>>>>>>>>>>>>> not using that as well, for example bridge, ovs, etc.
>>>>>>>>>>>>
>>>>>>>>>>>> Maybe they need to get fixed too. I've used that flag because it is
>>>>>>>>>>>> documented as
>>>>>>>>>>>> a "slave of a load balancer" which describes what a team port is.
>>>>>>>>>>>>
>>>>>>>>>>>>> I think that this should be fixed in addrconf_notify. It should lookup
>>>>>>>>>>>>> if there is a master on top and bail out in that case.
>>>>>>>>>>>>
>>>>>>>>>>>> There are other virtual interfaces that have a master assigned and want to
>>>>>>>>>>>> participate in IPv6 address configuration.
>>>>>>>>>>>
>>>>>>>>>>> Can you give me an example?
>>>>>>>>>>
>>>>>>>>>> I would like to revisit this patch (yes, I know it has been a while).  I
>>>>>>>>>> believe the VRF implementation uses master to group the interfaces under
>>>>>>>>>> a single interface.
>>>>>>>>>>
>>>>>>>>>> I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>>>>>>>>>> similar.
>>>>>>>>>
>>>>>>>>> Again, why do you need team port to have IFF_SLAVE flag? What do you
>>>>>>>>> want to achieve
>>>>>>>>
>>>>>>>> Without setting this flag IPv6 will try and make a link specific address.
>>>>>
>>>>> You are talking about addrconf_notify() right? Easy to fix to check
>>>>> something more convenient. Like netif_is_lag_port() if you want to avoid
>>>>> it for bond/team. netif_is_ovs_port(), netif_is_bridge_port() etc. Lot's
>>>>> of helpers to cover this.
>>>>
>>>> OK, IPv6 should probably be using this.
>>>>
>>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> Why is it not an issue with bridge, ovs, and other master-slave devices?
>>>>>>>
>>>>>>
>>>>>> It very well might be an issue for bridge and ovs.  Other master-slave
>>>>>> devices include the existing VRF implementation in the kernel and those slave
>>>>>> interfaces will certainly want to use IPv6.
>>>>>>
>>>>>> However, IFF_SLAVE has a specific meaning:
>>>>>>
>>>>>> ./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.
>>>>>
>>>>> I know that some userspace apps are using this flag to determine a
>>>>> "bonding slave". I don't think that they care much about eql...
>>>>>
>>>>>
>>>>>>
>>>>>> The bonding driver is not the only user:
>>>>>>
>>>>>> ./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) ==
>>>>>> IFF_SLAVE)
>>>>>> ./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
>>>>>> ./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;
>>>>>>
>>>>>> The team driver would like to use this same flag since it is a load balancer
>>>>>> as well.  The side effect of not assigning IPv6 is a bonus. The fact that
>>>>>
>>>>> No, please leave IFF_SLAVE as it is. Both kernel and userspace have
>>>>> their clear indications right now about the master/slave relationships.
>>>>
>>>> The team driver does create a master/slave relationship.  The team slaves are
>>>> literally slaves of the master device.  It's not clear to me
>>>> why you we can't mark the slaves of the team master as actually being
>>>> slave interfaces?
>>>
>>> So? IFF_SLAVE flag serves a different purpose. That's it. Team does not
>>> need it, bridge does not need it, macvlan does not need it, etc.
>>
>> I agree.  But team *is* a load balancer.  Why can't team mark its slave
>> interfaces as IFF_SLAVE?  They are literally slaves of a load balancer which
>> is the exact meaning of the IFF_SLAVE flag.
> 
> I described that multiple times, don't want to repeat myself. Please
> read the thread again.

I have read the flag and you never described what the flag is for.  The 
only vague mention is "to indicate a bonding slave".  A team slave is 
exactly the same thing as a bonding slave.  If there is some application
using IFF_SLAVE to find those slaves, it should worry about team slaves 
as well. Given that the eql driver is using this flag for the same 
purpose doesn't give bonding exclusive rights to use this flag with its 
interfaces.

> 
>>
>>>
>>>
>>>>
>>>>>
>>>>>
>>>>>> bridges and ovs are also likely broken is a different issue.  Should there be
>>>>>> a another flag that says "layer 2 only"?  Very possibly, but that is
>>>>>> something all these interfaces should be using to include bonding, team, eql,
>>>>>> obs, bridge etc.  That's not a reasonable objection to labeling the team
>>>>>> slave as slaves since they are literally slaves of a load balancer.
>>>>>>
>>>>>>
>>>>>>
