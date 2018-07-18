Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62341ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B962075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fElTP1A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B962075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGRU4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:56:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42904 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729973AbeGRU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:56:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so2490196pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HKWPKp4OhQNPtuUh2A4lTKaE+Px7CtP8hYAARoUwSkI=;
        b=fElTP1A8Vg0Ke8cqdtPeLKorGfytM2ioy8KBSzqwP82D4Op4P68SbglP68DpofctzV
         IMPBBnfF9O5ZT+UJw64SLeD8fipSif5kYks6F8dlCT7iM8XztEeXCdydsglOO0+NEbl5
         AP4VZZiLalWpxQeFS5sIbLpn/4c8PjRoBv0IKdGC7Yl4dhv7hFuZiufAdMMEJKee1aqC
         +FlZ0n8iocoM4sq8S0LlpFPw7bbjLEJjgpirKSDAvsWUB0GOIMatlMVPemZ6PZMamCQH
         9GbucyutVxCgOvU8p4qNDhw1DBJH7NUcmrswZ4+acPNJh/aYmABwb3qR63Mx8ssSgxZ6
         Tt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HKWPKp4OhQNPtuUh2A4lTKaE+Px7CtP8hYAARoUwSkI=;
        b=QVg1OfZKpq9J0AG3wDSwwGsX5hJiuN4zSPt0ImXCCnrTYrf8bxPGE59L0EYFpl3zRf
         kdp4rrH7aCRfzsR9U69TYWGVOqU0ipEprOKIYhRtCL0YR99AaFzg/WKlxyoW4GCR8Igq
         TEBFrlImrKzwXKDj2c8flg5AYJ3OcYDv3JNpFiPzs+svjFKiH31ZRtgAc+W9NgPbSDR9
         C0ryS9phRkbV80SGly8X+OZtkVHSAl1rq9OlZcx8LoWwoaaIX3pS3hztKk/NsForUzvr
         siEzJN2lK1A3AMsu86moNBBqhYkwOQNTHsuqRsI6H4o2eg12LMtjEG7JXRR2ZbaYkGYF
         s6og==
X-Gm-Message-State: AOUpUlEBGoNUScnxvznVhtthI2dzF+9tm8aWcib7LJBfNJJ2+XfRGPZN
        4Zk9CcyHKOuhsa+2/wywXpzv4+1GVos=
X-Google-Smtp-Source: AAOMgpe6g9KAN0d+u5DuK50zBJPPx6XER2pNfGh2df4kXSZovhfpSwGRnOQ7tuYrYHOCQx8J3lQm/w==
X-Received: by 2002:a63:e452:: with SMTP id i18-v6mr7023038pgk.185.1531944989786;
        Wed, 18 Jul 2018 13:16:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r19-v6sm21085410pgg.39.2018.07.18.13.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 13:16:28 -0700 (PDT)
Date:   Wed, 18 Jul 2018 13:16:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Baoquan He <bhe@redhat.com>
cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Deprecate kernelcore=nn and
 movable_core=
In-Reply-To: <20180717233100.GH1724@MiWiFi-R3L-srv>
Message-ID: <alpine.DEB.2.21.1807181314230.49359@chino.kir.corp.google.com>
References: <20180717131837.18411-1-bhe@redhat.com> <alpine.DEB.2.21.1807171344320.12251@chino.kir.corp.google.com> <20180717233100.GH1724@MiWiFi-R3L-srv>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Baoquan He wrote:

> > > We can still use 'kernelcore=mirror' or 'movable_node' for the usage
> > > of hotplug and movable zone. If somebody shows up with a valid usecase
> > > we can reconsider.
> > > 
> > 
> > We actively use kernelcore=n%, I had recently added support for the option 
> > in the first place in 4.17.  It's certainly not deprecated.
> 
> Thanks for telling. Just for curiosity, could you tell the scenario you
> are using kernelcore=n%? Since it evenly spread movable area on nodes,
> we may not be able to physically hot unplug/plug RAM.
> 

To evenly distribute ZONE_MOVABLE over a set of nodes regardless of the 
many memory capacities of systems that we have where individual command 
lines cannot be tuned.  But you want to deprecate kernelcore=nn, not just 
the percent version, so I assume that's not the answer you're looking for. 
We do not enable CONFIG_MEMORY_HOTPLUG so this deprecation would break our 
userspace such that we cannot use ZONE_MOVABLE.
