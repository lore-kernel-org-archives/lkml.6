Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB51521841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+kDzEdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfBYXbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:31:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35692 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfBYXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:31:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so5246034pfa.2;
        Mon, 25 Feb 2019 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ANCpRZExgWfAWt6x3rbXhsjbF2XSJtWxXkrwBpcaGM=;
        b=b+kDzEdYFiZn3dK+6W48Co8HgFk/TCUVE2nxQDaNFmWFZ+1HeUe1l6TBVOQdj1PsXp
         lDuQU7hGzhI+sl5w59oxVow1GuG4jEi/yHqn6tDzJwD429oDhAq9Ym8AXjew8PD4yID6
         jqQUaTxmomsK/yFhPDVnBWXYIjAmiKIjF73u95E1luyZxrHJsAyJqtYNMboTRRxjYoJd
         fvJivRXSpAA5aMitwpwcdN2rF4jITnfIw76Q2dYUbZV/JZjQ6BQRgHakalq9yFxCt9XE
         9tzOUYMlYlmdCFNjZqrBatuioYFnvg+AIX78RWRTbeVp0UU7tx6hwFAJMpZfHGI+LkEv
         ZYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ANCpRZExgWfAWt6x3rbXhsjbF2XSJtWxXkrwBpcaGM=;
        b=GU6N4uxsEcPpW450KUfRMqyySOEma4t5dBrTOzxUR3fXIrL3VBxl19fsCuvaOW7blU
         5E4kI0ROl5GiTMzaKxmR1/S0GVkmFYz3qryj12aCBDYuu7wxkW0hRqbvGW+a2GeEAIt3
         r4arGPilWZ/3VcbFClc8TBWXeHzDSzVOu+PuHHXwbiR2QYZ799KYlDfqqq0oWdEfNY9V
         kEImMXaNEFyJdHtVMMgRyRlEV0SiMVPe19usTevW8QpauxQNoFksa34J5pDv2n87nGn0
         afs9Dy4Z4RRGhQ2f9e+2TdblBHzDrM80Wx3TWUvu6uCZPAzreZ6q/Rd/BpUXnGPITAIP
         gG/A==
X-Gm-Message-State: AHQUAuZq4GJi3w3snL5Ch8TX/g7XNeu0ZTTpuFXm/ntu0uZmlcmcyzV/
        Vmn2Vd9zvXXm7hmL4/P97rvFHuyI
X-Google-Smtp-Source: AHgI3IZiUoVpvefUzGJbB92wMs+GycOfGKHmlbvwo02DigrKkqSd2lUNAKhzoi9qm6YXzyEXsZGHAw==
X-Received: by 2002:a63:f544:: with SMTP id e4mr17090448pgk.145.1551137481625;
        Mon, 25 Feb 2019 15:31:21 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id p14sm12697470pfn.91.2019.02.25.15.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:31:20 -0800 (PST)
Subject: Re: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
To:     Dmitry Safonov <dima@arista.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
References: <20190225212721.2908-1-dima@arista.com>
 <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
 <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5079b888-a62f-991a-6f0b-1248d23d0045@gmail.com>
Date:   Mon, 25 Feb 2019 15:31:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/25/2019 03:21 PM, Dmitry Safonov wrote:
> Hi Eric,
> 
> On 2/25/19 11:09 PM, Eric Dumazet wrote:
>> On 02/25/2019 01:27 PM, Dmitry Safonov wrote:
>>> While it's possible to document that rtnl_unregister() requires
>>> synchronize_net() afterwards - unlike rtnl_unregister_all(), I believe
>>> the module exit is very much slow-path.
>>
>> rtnl_unregister_all() needs the sychronize_rcu() at this moment
>> because of the kfree(tab), not because of the kfree_rcu(link, rcu);
> 
> I may be wrong here, but shouldn't we wait for grace period to elapse by
> the reason that rtnl_msg_handlers are protected by RCU, not only by rtnl?
> Like, without synchronize_net() in rtnl_unregister() - what prevents
> module exit race to say, rtnetlink_rcv_msg()=>rtnl_get_link()?
> 
> 
>>> --- a/net/core/rtnetlink.c
>>> +++ b/net/core/rtnetlink.c
>>> @@ -308,7 +308,9 @@ int rtnl_unregister(int protocol, int msgtype)
>>>  	rcu_assign_pointer(tab[msgindex], NULL);
>>>  	rtnl_unlock();
>>>  
>>> -	kfree_rcu(link, rcu);
>>> +	synchronize_net();
>>> +
>>> +	kfree(link);
>>
>>
>> I really do not see a difference here (other than this being much slower of course)
>>
>> If the caller needs rcu_barrier(), then add it in the caller ?
> 
> Well, sure - but it seems confusing that rtnl_unregister() will require
> synchronize_rcu(), while rtnl_unregister_all() will not.

rtnl_unregister_all() is a different beast, since it removes the whole rtnl_msg_handlers[protocol]

rtnl_unregister() only removes a subset, with different usages.

> And I thought no one would care about another synchronize_rcu() in exit
> path.

We definitely care about things be done properly.

If synchronize_rcu() is needed there, be it, but kfree_rcu() seems to be fine.

In any case, I believe you need to more carefully explain what is the problem here,
because I could not really see it.

