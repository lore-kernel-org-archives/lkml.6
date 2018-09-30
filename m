Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302AEC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE12B206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="UB3TJ8u4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE12B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeI3Nuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 09:50:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43343 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeI3Nuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 09:50:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so259576wrt.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRZz6LE0AM8YlH1VXWOC2L2NvmUeWKwPhXA7VsaUORA=;
        b=UB3TJ8u4FLqTFXJjT4TqV9KgCGx2Q6DYTj3/TRj1+Iswz15397ePvwnJGvhaLl9+wN
         60KGnriXteE7sTMQZnCyfzWON2GWqGVdYuc7QyVlK6TY/+60gG7XQ4TAmba1pwgmtzV0
         k/WGwCmC79teXbvrB23p7hhH/r/2aEjfcIS8gwuHKBQKUokE6IzPLANdZv05eaKtv3Bs
         mEKdDC8hm7XHrkIGINa5Cq6I2xHShjw+r+XNjnVOngZFNVJW11KFzEztPv2iG0PmnTqJ
         4GsrP44ZrPv3n2vXj5y1ljPpcu0ku9RnIuaQwz7r3djyPkiS/Chm3gbK82J0zYylPmEe
         ch/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRZz6LE0AM8YlH1VXWOC2L2NvmUeWKwPhXA7VsaUORA=;
        b=RM5dB3Wbkw7+0de2+/UaFNxITnUQJeFTbUgArxEnfTUrCLaU5fa+5Z2LpN4e/zKCub
         iknQsxOJKM8X/zR8SzqO9aPsip+wyy+UbGMh92TLjdd6UAM5zD0+u0TVqkKYC1b3cSe8
         GtWDir0anVpzh3wqJwq4UBwA4ltdOBM0bfxjALls5MNC2Q8ieaCCLCrRTDmzwSgMi0Ys
         l0h6wwMNZHaY2qWDC1po5SjgYHWqAIcrGrBsamgc9UwG0YQekjvv9NR40EtxMZd62L2m
         TJOtO9gR3meJ6nXjIvQr8kPrrJBsi7XPyrX4dCujvSfXX3s85yXjLNz2sJ0ZfqvLVtB3
         5+OQ==
X-Gm-Message-State: ABuFfohFY/ZkqXnCCkTTUot7KwT0xUf5T32o14F19LvC/ypVOce3LHEn
        /IK9PSHrg/z8bMBg2I/4QT25VQ==
X-Google-Smtp-Source: ACcGV62RgNzl5DTGs6r34yAjzXCfrM31td87J0MeScTbm/vDEiaLOWNMxE/z5H6X41gYoPhr0lcNKQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18-v6mr3989837wru.154.1538291940112;
        Sun, 30 Sep 2018 00:19:00 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id t4-v6sm5499221wme.3.2018.09.30.00.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 00:18:59 -0700 (PDT)
Date:   Sun, 30 Sep 2018 09:14:14 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Chas Williams <3chas3@gmail.com>
Cc:     Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
Message-ID: <20180930071414.GF2209@nanopsycho.orion>
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>
>
>On 07/10/15 02:41, Jiri Pirko wrote:
>> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:
>> > On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:
>> > > > The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>> > > > decide if it should start the address configuration. Since team ports
>> > > > shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>> > > > a port to the team master.
>> > > 
>> > > I don't want to use IFF_SLAVE in team. Other master-slave devices are
>> > > not using that as well, for example bridge, ovs, etc.
>> > > 
>> > 
>> > Maybe they need to get fixed too. I've used that flag because it is
>> > documented as
>> > a "slave of a load balancer" which describes what a team port is.
>> > 
>> > 
>> > > I think that this should be fixed in addrconf_notify. It should lookup
>> > > if there is a master on top and bail out in that case.
>> > 
>> > There are other virtual interfaces that have a master assigned and want to
>> > participate in IPv6 address configuration.
>> 
>> Can you give me an example?
>
>I would like to revisit this patch (yes, I know it has been a while).  I
>believe the VRF implementation uses master to group the interfaces under
>a single interface.
>
>I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>similar.

Again, why do you need team port to have IFF_SLAVE flag? What do you
want to achieve?


>
>> > 
>> > Unless we want to have a cascade of conditionals testing the priv_flags in
>> > addrconf_notify() this is asking for a new net_device_flags flag.
>> > Maybe something
>> > generic like IFF_L2PORT ?
>> > 
>> > Thanks,
>> > Jan
>> > 
>> > [ Jiri, sorry for getting that mail twice ]
>> 
>> 
>> 
