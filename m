Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E01C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61B2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="rP7XzDzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF61B2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI3QL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:11:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33052 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeI3QLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:11:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so10629049wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njNayWkayFN3pyzEKssYbIn5QgNwMWA4MCahIR2inrw=;
        b=rP7XzDzsAzTHZ4qp+Gy/bNdUKbQTSlDtCmwc36h3+ND5umYjp6j+7kpKP5VRZ7hflX
         nL9ehni2UAtnQmGa3jFDILLxoQ3AXsc0km9GnbdWitJcz6a00OrollPwwyl3BYgNgF+n
         sy52YkeyKBnZFMNF7tjr5bUI4Itwe+/asNqhiX1iqARwQB3gnEGLurECAcfPDCnOvpr/
         VHa/swi6m1bMXo3QofsHSqRoHJjwM5vWYuQC0OA6TcC5FD/saNp9IvW8/IMD2o5K20UN
         mTrdOawJGyHJesJcLINkaz+j/vWzntl7wbX3tWt5L6WY6DBYuWWVNHuWX6jaRq8bJirS
         C8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njNayWkayFN3pyzEKssYbIn5QgNwMWA4MCahIR2inrw=;
        b=aMTTHdh2vBog3I7JEvUKMPURI3To+sRUi2/rFi3uWe5Y1892VKZyVD+YHhKS5/cTEI
         ZvidMeZVYVmWFvva1dTcxuDAh7V5ry6/jDEujmdqlaKA+cxhuBIAvGNrymiG+TFolXPv
         4fFIrIcLmY5ZDAiSTTEcLt0WHGwXIhHgE9/O/V6Veu2OR5a4OnGF0085gqyInH5S4plu
         4GymHxUcONY98mn6SGeXoou/jRIdAx3tLu/NHeDr5ppKHrWFJA82v7ZifYOxCeaYLL7U
         Aw3labp2ocC92flsLFSlKt+ZK1B8Ckb2VJz8JmNrKJY/4XbGLinfogRYQp8hBP/4d73A
         B9Ew==
X-Gm-Message-State: ABuFfohdef/Zlj707AW4vZxS9JcZvSoz1aAXgSdd3NrZaXCHHLe5E3Ye
        drUm5RKMOTtNAmvQMNnXBdgZIQ==
X-Google-Smtp-Source: ACcGV62UOMhRoMbfoLNgriZroM0VvRw8389pUPIw+nWSBzbTLr2OQTwCWUexh6KTzprfatiJwqiuGw==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr3600512wrm.127.1538300377392;
        Sun, 30 Sep 2018 02:39:37 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id j46-v6sm17581991wre.91.2018.09.30.02.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 02:39:37 -0700 (PDT)
Date:   Sun, 30 Sep 2018 11:34:52 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Chas Williams <3chas3@gmail.com>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
Message-ID: <20180930093452.GG2209@nanopsycho.orion>
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
 <20150709100727.GE2270@nanopsycho.orion>
 <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
 <20150710064147.GA2204@nanopsycho.orion>
 <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
 <20180930071414.GF2209@nanopsycho.orion>
 <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Sep 30, 2018 at 11:38:05AM CEST, stephen@networkplumber.org wrote:
>On Sun, 30 Sep 2018 09:14:14 +0200
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
>> >
>> >
>> >On 07/10/15 02:41, Jiri Pirko wrote:  
>> >> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:  
>> >> > On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:  
>> >> > > Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:  
>> >> > > > The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
>> >> > > > decide if it should start the address configuration. Since team ports
>> >> > > > shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
>> >> > > > a port to the team master.  
>> >> > > 
>> >> > > I don't want to use IFF_SLAVE in team. Other master-slave devices are
>> >> > > not using that as well, for example bridge, ovs, etc.
>> >> > >   
>> >> > 
>> >> > Maybe they need to get fixed too. I've used that flag because it is
>> >> > documented as
>> >> > a "slave of a load balancer" which describes what a team port is.
>> >> > 
>> >> >   
>> >> > > I think that this should be fixed in addrconf_notify. It should lookup
>> >> > > if there is a master on top and bail out in that case.  
>> >> > 
>> >> > There are other virtual interfaces that have a master assigned and want to
>> >> > participate in IPv6 address configuration.  
>> >> 
>> >> Can you give me an example?  
>> >
>> >I would like to revisit this patch (yes, I know it has been a while).  I
>> >believe the VRF implementation uses master to group the interfaces under
>> >a single interface.
>> >
>> >I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
>> >similar.  
>> 
>> Again, why do you need team port to have IFF_SLAVE flag? What do you
>> want to achieve
>
>Without setting this flag IPv6 will try and make a link specific address.

Why is it not an issue with bridge, ovs, and other master-slave devices?
