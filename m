Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D077CC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D22206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="iEq+wQjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D22206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeI3QK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:10:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeI3QK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:10:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so917540wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RexvrdjWAibOSKnB/gl/HDqkX58+1V6uNAmi3aW0Tks=;
        b=iEq+wQjDIueCdd4pvi9fDiy4EzRyF9xCMoD3oFrc28D4GW2JBbqe4sQ1eGhZq/LQ8p
         +CxSEwHAawS2uGlG5XqnpX2QtcD8/FHgZsWeY6HHTmUwKWM3aRvVQkpL5cko4pzE4dQm
         dl6eQQRwZFd3sk7D8uy9LyBQMo2DE5Fns+INTta4/R9pidqvyEni0tglImvqnP530nui
         TnLSOu97jGrPj9KX45SNZSS6tcn/zA9vDQBZkXbl6L34qshAKeavM4LIwGR1f9Gio/ik
         Znv6IlcWwhGHZLVtuTVXlXFzLgRNh8RsBNbJ9LCUZWjFI7J/H2sK0k6ZOBi8rJ528vLw
         QPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RexvrdjWAibOSKnB/gl/HDqkX58+1V6uNAmi3aW0Tks=;
        b=BPr+rqmtTie3v37cfKubm+Q7y4NkLTz+mFPOnBPYfy3LyCsHwFnlrVDG5kB59+BW+5
         dDbGpEJW2OUHcJrDMD0PTWQR2LkVwHPbh3KoBRxx1/HfuZAmi/YA7VbK9PxVwXX269kE
         5pBNtSdBNXqVInPMIIHPYoUaVjnuQIJFg4NwHZ0F2xI9T4YQOpGViyxKy4yEucdsAn9v
         HAp5F8BCWN8h3TUIfxnbFKV0wg22Tcbo1Ry1/RPFMWVd/wdGHpWLYPiQOPSpJaAl6cmv
         LitM5hOIBC6RzhTYcTKc8svaLPfkwixOCni6ccbyJiGZswqDEz8/rNzXWKQuzhBthlQh
         zGUg==
X-Gm-Message-State: ABuFfohTj2DLGnNt0+9supOw3F0iybaR2KdaBT2ktlN2U8A3fn+xmaPK
        D78cRJAzTowvap+R0OpsgZ7GyUuq03I6zg==
X-Google-Smtp-Source: ACcGV62ICy8aeZHjBKIWVB+21iqVjBTgZ4aRmhUV9x2VfC56tOQcVAWX8xze/8Fa9KyNACFHnS6zsg==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr6498818wmf.43.1538300289941;
        Sun, 30 Sep 2018 02:38:09 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (p548FFB46.dip0.t-ipconnect.de. [84.143.251.70])
        by smtp.gmail.com with ESMTPSA id o19-v6sm12465308wro.50.2018.09.30.02.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 02:38:09 -0700 (PDT)
Date:   Sun, 30 Sep 2018 11:38:05 +0200
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Chas Williams <3chas3@gmail.com>,
        Jan Blunck <jblunck@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] team: set IFF_SLAVE on team ports
Message-ID: <20180930113805.3b8e62a1@shemminger-XPS-13-9360>
In-Reply-To: <20180930071414.GF2209@nanopsycho.orion>
References: <1436435914-8903-1-git-send-email-jblunck@infradead.org>
        <20150709100727.GE2270@nanopsycho.orion>
        <CALe+Z03R_MPcgUSa8xoMeT5Sv3z8KwFhrtoYYzON=prfR-7hxQ@mail.gmail.com>
        <20150710064147.GA2204@nanopsycho.orion>
        <c674e681-9f7f-85c2-a578-a246d1ec9f45@gmail.com>
        <20180930071414.GF2209@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2018 09:14:14 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> Thu, Sep 27, 2018 at 04:04:26PM CEST, 3chas3@gmail.com wrote:
> >
> >
> >On 07/10/15 02:41, Jiri Pirko wrote:  
> >> Thu, Jul 09, 2015 at 05:36:55PM CEST, jblunck@infradead.org wrote:  
> >> > On Thu, Jul 9, 2015 at 12:07 PM, Jiri Pirko <jiri@resnulli.us> wrote:  
> >> > > Thu, Jul 09, 2015 at 11:58:34AM CEST, jblunck@infradead.org wrote:  
> >> > > > The code in net/ipv6/addrconf.c:addrconf_notify() tests for IFF_SLAVE to
> >> > > > decide if it should start the address configuration. Since team ports
> >> > > > shouldn't get link-local addresses assigned lets set IFF_SLAVE when linking
> >> > > > a port to the team master.  
> >> > > 
> >> > > I don't want to use IFF_SLAVE in team. Other master-slave devices are
> >> > > not using that as well, for example bridge, ovs, etc.
> >> > >   
> >> > 
> >> > Maybe they need to get fixed too. I've used that flag because it is
> >> > documented as
> >> > a "slave of a load balancer" which describes what a team port is.
> >> > 
> >> >   
> >> > > I think that this should be fixed in addrconf_notify. It should lookup
> >> > > if there is a master on top and bail out in that case.  
> >> > 
> >> > There are other virtual interfaces that have a master assigned and want to
> >> > participate in IPv6 address configuration.  
> >> 
> >> Can you give me an example?  
> >
> >I would like to revisit this patch (yes, I know it has been a while).  I
> >believe the VRF implementation uses master to group the interfaces under
> >a single interface.
> >
> >I don't see a reason not to use IFF_SLAVE since team and bonding are fairly
> >similar.  
> 
> Again, why do you need team port to have IFF_SLAVE flag? What do you
> want to achieve

Without setting this flag IPv6 will try and make a link specific address.
