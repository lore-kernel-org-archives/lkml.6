Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D86208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/nL5UDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D86208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeJAUoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:44:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32953 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:44:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id q40-v6so1127709qte.0;
        Mon, 01 Oct 2018 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5T7pE4qzMkLVakrC9ZdwQdfR3ePliJEv70qnWJM9I1E=;
        b=o/nL5UDU/6j6EJ3ugGsGQEtzXJhWN+6ei5Fit/8mDi0gi8hnAUMBEomCbXkzQdvDGt
         WB3xQh0FjmerkcvmwtfsJO3H8xyFmv7HElOEwncS4iytzn3hXcxqjzxV7oGxeb146n2+
         yPDweCXZWSFTrd4juxrobSPTDT/2u94I8TMPi1ZtP1JwJoHR3nt5x2nljrUamtLtkY6j
         acowRDgs21NoFPmsuyEDa54gtiYlugbUSRB9CCxh9pqHFV+O4QGIxK+1FVUvF87Eua0G
         +0WIzhT4hHaCvT/J7O4GspZUpXKjm/ay7T9w9FQRHNzqzrynBE3oOcwJiVAnAnTX+PNl
         TCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5T7pE4qzMkLVakrC9ZdwQdfR3ePliJEv70qnWJM9I1E=;
        b=kjbDLBcXLKrB2caS/FS99I5uR/NrPHfnBr+KrpfK87cCFGtO/wUcCX6tCD462cQGKL
         HSfwva0tFEVONodWNSsJe0A3f3o++6kNADfBY1tYVSpQ1SrVxVuWZkaO6oMLLFRLOaKY
         dKIbBRKDEJaUycXSqT6SQj4qLggGPD1NVHtkJ95wfwCr7Wtd2dj7IVK0quxkC4bHtRlO
         n1eTcXm8P+BHWa2//e3uAcKPQi/xnYbfGLOGLjmSGQC8/mmqVkH7qReakZQfHqiXOAT9
         smvPZA1GqiOqmzeYisPQIFOnO0n1YWgrf/f+TkxB1NfxcS6PET7xnG35NiuDq4ULgGHM
         0AAA==
X-Gm-Message-State: ABuFfogDYsvg7V4X/N28RR93SnGQxDZdcf3RJOetj9i+QU0Dv6FV1OLw
        FPpPb+HPTeUC1jP3tVDQ2wxwGLWU
X-Google-Smtp-Source: ACcGV635cl9SFpNIaHXhT43mK69GsNlaOwVDQXvpTC9pvUWIwyDR71JVvOzLVRQWe+u1denvivJ26g==
X-Received: by 2002:ac8:fa2:: with SMTP id b31-v6mr8739275qtk.2.1538402777715;
        Mon, 01 Oct 2018 07:06:17 -0700 (PDT)
Received: from [192.168.1.10] (pool-96-255-154-210.washdc.fios.verizon.net. [96.255.154.210])
        by smtp.gmail.com with ESMTPSA id f48-v6sm6149086qte.17.2018.10.01.07.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:06:16 -0700 (PDT)
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
To:     Jiri Pirko <jiri@resnulli.us>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
 <20180930093452.GG2209@nanopsycho.orion>
From:   Chas Williams <3chas3@gmail.com>
Message-ID: <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
Date:   Mon, 1 Oct 2018 10:06:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180930093452.GG2209@nanopsycho.orion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/30/18 05:34, Jiri Pirko wrote:
> Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>> On Sun, 30 Sep 2018 09:14:14 +0200
>> Jiri Pirko <jiri@resnulli.us> wrote:
>>
>>> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>>>>
>>>>
>>>> On 07/10/15 02:41, Jiri Pirko wrote:
>>>>> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>>>>>> On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>> Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>>>>>>>> The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>>>>>>>> decide if it should start the address configuration. Since team ports
>>>>>>>> shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>>>>>>>> a port to the team master.
>>>>>>>
>>>>>>> I don't want to use IFF_SLAVE in team. Other master-slave devices are
>>>>>>> not using that as well, for example bridge, ovs, etc.
>>>>>>>    
>>>>>>
>>>>>> Maybe they need to get fixed too. I've used that flag because it is
>>>>>> documented as
>>>>>> a "slave of a load balancer" which describes what a team port is.
>>>>>>
>>>>>>    
>>>>>>> I think that this should be fixed in addrconf_notify. It should lookup
>>>>>>> if there is a master on top and bail out in that case.
>>>>>>
>>>>>> There are other virtual interfaces that have a master assigned and want to
>>>>>> participate in IPv6 address configuration.
>>>>>
>>>>> Can you give me an example?
>>>>
>>>> I would like to revisit this patch (yes, I know it has been a while).  I
>>>> believe the VRF implementation uses master to group the interfaces under
>>>> a single interface.
>>>>
>>>> I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>>>> similar.
>>>
>>> Again, why do you need team port to have IFF_SLAVE flag? What do you
>>> want to achieve
>>
>> Without setting this flag IPv6 will try and make a link specific address.
> 
> Why is it not an issue with bridge, ovs, and other master-slave devices?
> 

It very well might be an issue for bridge and ovs.  Other master-slave 
devices include the existing VRF implementation in the kernel and those 
slave interfaces will certainly want to use IPv6.

However, IFF_SLAVE has a specific meaning:

./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.

The bonding driver is not the only user:

./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) 
== IFF_SLAVE)
./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;

The team driver would like to use this same flag since it is a load 
balancer as well.  The side effect of not assigning IPv6 is a bonus. 
The fact that bridges and ovs are also likely broken is a different 
issue.  Should there be a another flag that says "layer 2 only"?  Very 
possibly, but that is something all these interfaces should be using to 
include bonding, team, eql, obs, bridge etc.  That's not a reasonable 
objection to labeling the team slave as slaves since they are literally 
slaves of a load balancer.



