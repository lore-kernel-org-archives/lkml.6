Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78258C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5621470
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="NVEnDCyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF5621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJBSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:00:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbeJBSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:00:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8-v6so1738672wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUQz17/fAID5kO9JWXavIOR0BpQLAdDzhYtMVHDv12Y=;
        b=NVEnDCyn/IF7JIqF4Wwi9TLSVUaHuog6wCwpiNindwNL2YEi4SMDBPYZO17kry1plQ
         hPw04fRM9tUJ/WOsaKnVnB3RQWTGjWIb74FWd9d3LJffpegil6sNCcgTVuqM7/gY61xE
         RmS7xHl4cUVSd/yppNCnKojJZ1nmnWno0q1MY6V5RQ7SdJaE8MGgxkT4uYdK6QaHqPkl
         tG5TWKhPazQP7IhWM9NMnGsUtH2kilF4JhunHI+nZB47V5jZfC2gvGHTSkNk772tR9tU
         8RYtysRXoBZZGgPERw8ubwxf7fnC59A482zYECd50Y7KgVEWUAwLu5Xo8rKeBPeaguA3
         /phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUQz17/fAID5kO9JWXavIOR0BpQLAdDzhYtMVHDv12Y=;
        b=FpwslzP2nBrRoodcoQ/fTN9GWPbsjjUUen8Q9p4qmPWQgRPdZVjU09aRfG27SDtz7h
         p8VG/LIxg6PEhNUGDk2Q3ATdAPGYoPvMDP0DglQmVetovh8rA5oiqoZRLYO1zaBaSdlA
         DRz90+fLPLamsg1WDv6f1Z6/5K8TjqyL4W/EwB7xMAAziOBN0hZ7k2iVbvmnTovBJRRf
         5CEKTy7Mo4ray0NpizTqNF7SMHOessxUZ+y8Xz600wYU4ZhtQmihlf/cVK2R6x5WU/YG
         FRiEnCwSmId5o4N3nbO91JXZAk/jdZyWQ4jXxZaSUjIsYeO+7UQWh7Q6l+6aaEn74xAF
         efoA==
X-Gm-Message-State: ABuFfohP7LLEir0qKYQbTrTQHdW0i8BvdNYMKsT5OhcgsdRzrIE78tvk
        GgLJSQF9Zt8irzGoooBsG/LXzQ==
X-Google-Smtp-Source: ACcGV60QUcTVZT58tGcALmkOGiTu1w73Apus3xUgsEB9ZLHfrbOXYsecuYFX/LeuQgxGRUI8Zoy1Rg==
X-Received: by 2002:adf:8022:: with SMTP id 31-v6mr7984460wrk.16.1538479042817;
        Tue, 02 Oct 2018 04:17:22 -0700 (PDT)
Received: from localhost (ip-78-45-160-184.net.upcbroadband.cz. [78.45.160.184])
        by smtp.gmail.com with ESMTPSA id e64-v6sm9300231wmg.0.2018.10.02.04.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 04:17:22 -0700 (PDT)
Date:   Tue, 2 Oct 2018 13:12:15 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Chas Williams <3chas3@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
Message-ID: <20181002111215.GA2222@nanopsycho>
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
 <20180930093452.GG2209@nanopsycho.orion>
 <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3cf1799-7ee2-47b3-e9ed-98e41ae56853@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Oct 01, 2018 at 04:06:16PM CEST, 3chas3@gmail.com wrote:
>
>
>On 09/30/18 05:34, Jiri Pirko wrote:
>> Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>> > On Sun, 30 Sep 2018 09:14:14 +0200
>> > Jiri Pirko <jiri@resnulli.us> wrote:
>> > 
>> > > Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>> > > > 
>> > > > 
>> > > > On 07/10/15 02:41, Jiri Pirko wrote:
>> > > > > Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>> > > > > > On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > > > > Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>> > > > > > > > The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>> > > > > > > > decide if it should start the address configuration. Since team ports
>> > > > > > > > shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>> > > > > > > > a port to the team master.
>> > > > > > > 
>> > > > > > > I don't want to use IFF_SLAVE in team. Other master-slave devices are
>> > > > > > > not using that as well, for example bridge, ovs, etc.
>> > > > > > 
>> > > > > > Maybe they need to get fixed too. I've used that flag because it is
>> > > > > > documented as
>> > > > > > a "slave of a load balancer" which describes what a team port is.
>> > > > > > 
>> > > > > > > I think that this should be fixed in addrconf_notify. It should lookup
>> > > > > > > if there is a master on top and bail out in that case.
>> > > > > > 
>> > > > > > There are other virtual interfaces that have a master assigned and want to
>> > > > > > participate in IPv6 address configuration.
>> > > > > 
>> > > > > Can you give me an example?
>> > > > 
>> > > > I would like to revisit this patch (yes, I know it has been a while).  I
>> > > > believe the VRF implementation uses master to group the interfaces under
>> > > > a single interface.
>> > > > 
>> > > > I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>> > > > similar.
>> > > 
>> > > Again, why do you need team port to have IFF_SLAVE flag? What do you
>> > > want to achieve
>> > 
>> > Without setting this flag IPv6 will try and make a link specific address.

You are talking about addrconf_notify() right? Easy to fix to check
something more convenient. Like netif_is_lag_port() if you want to avoid
it for bond/team. netif_is_ovs_port(), netif_is_bridge_port() etc. Lot's
of helpers to cover this.



>> 
>> Why is it not an issue with bridge, ovs, and other master-slave devices?
>> 
>
>It very well might be an issue for bridge and ovs.  Other master-slave
>devices include the existing VRF implementation in the kernel and those slave
>interfaces will certainly want to use IPv6.
>
>However, IFF_SLAVE has a specific meaning:
>
>./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.

I know that some userspace apps are using this flag to determine a
"bonding slave". I don't think that they care much about eql...


>
>The bonding driver is not the only user:
>
>./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) ==
>IFF_SLAVE)
>./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
>./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;
>
>The team driver would like to use this same flag since it is a load balancer
>as well.  The side effect of not assigning IPv6 is a bonus. The fact that

No, please leave IFF_SLAVE as it is. Both kernel and userspace have
their clear indications right now about the master/slave relationships.


>bridges and ovs are also likely broken is a different issue.  Should there be
>a another flag that says "layer 2 only"?  Very possibly, but that is
>something all these interfaces should be using to include bonding, team, eql,
>obs, bridge etc.  That's not a reasonable objection to labeling the team
>slave as slaves since they are literally slaves of a load balancer.
>
>
>
