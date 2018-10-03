Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDB20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Y6hxxcYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEDB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeJCRhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:37:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55329 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeJCRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:37:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so5240512wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHd5Iub72wnm7iLW1zhIdpR34oDA66b5afbYs4S47h4=;
        b=Y6hxxcYOYVzIlLv1NiXhwFQ+f+VpRZgyC7hfc88YIr73sPLYeHq9tKTR7tZcsYme2T
         DVv2D1Q/aDWs9IjKGSVR/Z2UEZRprriVGn7JOMKb3RD63u/PzFo1eCIQHIRuZDhy0WgM
         z0h5+T4p42jAiEGjZcLJ00RORSY9qE6y7pHLwt8mGBGyGqbuDykifrLZm0BjpJRcq5fA
         8aghkgCC3rOYmO9ErUiMyf+G+6hzb687lrdrz7ItHB8x5c1/xRvJelvxzuCw8Nx05MhC
         nvaP3Q90Y0pVV3w02WqoGUXGiCFh/lEzsZRfiegPybgP10E6doN4o9gfccf80W9cZ867
         KAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHd5Iub72wnm7iLW1zhIdpR34oDA66b5afbYs4S47h4=;
        b=HU4fKWz4O02jKGn8NQlt9dcetcVf3VEpTGdEKqsOTwTEUACw8vla6l2QmQFjthInRO
         UWNSfxTc4Odtq/Lg6NYkTZxiDPn7xpUW0905yx77l0KJ6/DVIgVihA5HYuYdc2/dpt68
         OpfJkfdJtfn39g9bf8pyMDRMSaaUEhOoFb/IARv4cL+pAAJyEPTNgLV+FZE2F3n9F7zx
         kMm+VDF6sdmF1ZK+VFT5udGF0aohQkYyZqdqkwRUgTwx+L1S7JdZorJ0ST8AOTuc7YTH
         u7EYZdtgNiM9/v/ukk1jfMJZ4IElHXY3T95bChknsBCQjTJdwOP2xkCwEKwTXhYa9/eB
         O7vA==
X-Gm-Message-State: ABuFfogoW5QpbLo7cffTtROQ+NtYdDhqkRJekE5vrKa53AuSdD/pkyKC
        sIINGHzKXdiSY4QCt/LXi8YnFA==
X-Google-Smtp-Source: ACcGV616O8nni/TTYYEjnuSmpaePeN+NxRfgWikv0JVfGtuvsypevBc5XB0Q/QVqDVCbJ474JWc/rA==
X-Received: by 2002:a1c:ee8d:: with SMTP id j13-v6mr1053801wmi.125.1538563782311;
        Wed, 03 Oct 2018 03:49:42 -0700 (PDT)
Received: from localhost (ip-78-45-160-184.net.upcbroadband.cz. [78.45.160.184])
        by smtp.gmail.com with ESMTPSA id t14-v6sm1064248wmi.35.2018.10.03.03.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 03:49:41 -0700 (PDT)
Date:   Wed, 3 Oct 2018 12:44:36 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Chas Williams <3chas3@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
Message-ID: <20181003104436.GB2222@nanopsycho>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d87d05cd-bd35-4551-4c6c-44409b92dd5b@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Oct 02, 2018 at 11:20:25PM CEST, 3chas3@gmail.com wrote:
>
>
>On 10/02/18 07:12, Jiri Pirko wrote:
>> Mon, Oct 01, 2018 at 04:06:16PM CEST, 3chas3@gmail.com wrote:
>> > 
>> > 
>> > On 09/30/18 05:34, Jiri Pirko wrote:
>> > > Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>> > > > On Sun, 30 Sep 2018 09:14:14 +0200
>> > > > Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > 
>> > > > > Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>> > > > > > 
>> > > > > > 
>> > > > > > On 07/10/15 02:41, Jiri Pirko wrote:
>> > > > > > > Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>> > > > > > > > On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > > > > > > Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>> > > > > > > > > > The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>> > > > > > > > > > decide if it should start the address configuration. Since team ports
>> > > > > > > > > > shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>> > > > > > > > > > a port to the team master.
>> > > > > > > > > 
>> > > > > > > > > I don't want to use IFF_SLAVE in team. Other master-slave devices are
>> > > > > > > > > not using that as well, for example bridge, ovs, etc.
>> > > > > > > > 
>> > > > > > > > Maybe they need to get fixed too. I've used that flag because it is
>> > > > > > > > documented as
>> > > > > > > > a "slave of a load balancer" which describes what a team port is.
>> > > > > > > > 
>> > > > > > > > > I think that this should be fixed in addrconf_notify. It should lookup
>> > > > > > > > > if there is a master on top and bail out in that case.
>> > > > > > > > 
>> > > > > > > > There are other virtual interfaces that have a master assigned and want to
>> > > > > > > > participate in IPv6 address configuration.
>> > > > > > > 
>> > > > > > > Can you give me an example?
>> > > > > > 
>> > > > > > I would like to revisit this patch (yes, I know it has been a while).  I
>> > > > > > believe the VRF implementation uses master to group the interfaces under
>> > > > > > a single interface.
>> > > > > > 
>> > > > > > I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>> > > > > > similar.
>> > > > > 
>> > > > > Again, why do you need team port to have IFF_SLAVE flag? What do you
>> > > > > want to achieve
>> > > > 
>> > > > Without setting this flag IPv6 will try and make a link specific address.
>> 
>> You are talking about addrconf_notify() right? Easy to fix to check
>> something more convenient. Like netif_is_lag_port() if you want to avoid
>> it for bond/team. netif_is_ovs_port(), netif_is_bridge_port() etc. Lot's
>> of helpers to cover this.
>
>OK, IPv6 should probably be using this.
>
>> 
>> 
>> 
>> > > 
>> > > Why is it not an issue with bridge, ovs, and other master-slave devices?
>> > > 
>> > 
>> > It very well might be an issue for bridge and ovs.  Other master-slave
>> > devices include the existing VRF implementation in the kernel and those slave
>> > interfaces will certainly want to use IPv6.
>> > 
>> > However, IFF_SLAVE has a specific meaning:
>> > 
>> > ./include/uapi/linux/if.h: * @IFF_SLAVE: slave of a load balancer. Volatile.
>> 
>> I know that some userspace apps are using this flag to determine a
>> "bonding slave". I don't think that they care much about eql...
>> 
>> 
>> > 
>> > The bonding driver is not the only user:
>> > 
>> > ./drivers/net/eql.c:#define eql_is_slave(dev)	((dev->flags & IFF_SLAVE) ==
>> > IFF_SLAVE)
>> > ./drivers/net/eql.c:	slave->dev->flags &= ~IFF_SLAVE;
>> > ./drivers/net/eql.c:		slave->dev->flags |= IFF_SLAVE;
>> > 
>> > The team driver would like to use this same flag since it is a load balancer
>> > as well.  The side effect of not assigning IPv6 is a bonus. The fact that
>> 
>> No, please leave IFF_SLAVE as it is. Both kernel and userspace have
>> their clear indications right now about the master/slave relationships.
>
>The team driver does create a master/slave relationship.  The team slaves are
>literally slaves of the master device.  It's not clear to me
>why you we can't mark the slaves of the team master as actually being
>slave interfaces?

So? IFF_SLAVE flag serves a different purpose. That's it. Team does not
need it, bridge does not need it, macvlan does not need it, etc.


>
>> 
>> 
>> > bridges and ovs are also likely broken is a different issue.  Should there be
>> > a another flag that says "layer 2 only"?  Very possibly, but that is
>> > something all these interfaces should be using to include bonding, team, eql,
>> > obs, bridge etc.  That's not a reasonable objection to labeling the team
>> > slave as slaves since they are literally slaves of a load balancer.
>> > 
>> > 
>> > 
