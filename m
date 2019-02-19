Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F6DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10A921773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpOqurwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfBSOPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:15:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37938 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:15:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so10510215plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ouowyjcqF3w/n3qaTY+a0VQKWy/8IwYxiXyW0hynWPg=;
        b=SpOqurwh8Dre3mqH91/KGVlIc8+J+oFoVAMJEWNxrhx4K4GmfFGXFYzQlZrilbOct+
         SGs/L9CkoMigBneE2ApsC9v6Z4CbTPnLzIi9nvPCx3sE4FFXa5YdlBtwK5+4S5WiM7KZ
         hfsWTo43jPOIWBMmKqtqYwxRJxgvyxxRaMhT8pjBEqZh2tIoVLtCHWZKCkMuGKfJtKBy
         1LfjCZ2VlX9cTVcIWccP9d3c9DEKIKIZLOVjdQrSbKVzfYecVuj5ueB5eyD6jz/cU3DW
         E3Wsb7YtH7pWM3kTP5pPsjT6cag29dO6anKFYC/uF+WP/cDGUaxuZ/SrnrzJafpH66nA
         pMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ouowyjcqF3w/n3qaTY+a0VQKWy/8IwYxiXyW0hynWPg=;
        b=DFBgBqhVnRZgxfTn1bNur5g4aOK0ho/2yx77KYFkvkBBBH7JPhVtq4GYh3w8ssxrQT
         obya+kNhuXbzll6zsGPdBQBs8+n50tnv6MyYYiwEup2Zde3AL2eC1yWdlle67nMG7pv0
         6S7mxT28CTP47WKDC03np9gKziaHL16eu+PXpHw3dzLhEB68lMvJLv5WXYIuffryHpxq
         zRirLhWzTz+rvLkEWN4HeQ8KT9M1b9q4LvNSlBs0kdAMaT0dnCDSQ9Uz1knV+fjVg9Yt
         FUkPp1A0yVfxVRYjQKFh/vH4od8co0t88MF92vF7mZU30KyYsfCijedCMtU/soYy9UJF
         LCug==
X-Gm-Message-State: AHQUAuZlXmDZb3vkHDzsTpwRaHOX6IBLciy/tAWtOI9noUTtd4C1DO//
        63+v2+QwmKte8nNXGN46IOY=
X-Google-Smtp-Source: AHgI3Ib/qpWTbQTSPXxqKfkctIdzdBha3tpKYBpsMn356z6zLoRY6tsAh6oMGmeTBhVUic3u7OGTUQ==
X-Received: by 2002:a17:902:1009:: with SMTP id b9mr29494022pla.42.1550585720951;
        Tue, 19 Feb 2019 06:15:20 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id 14sm25161188pgq.22.2019.02.19.06.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 06:15:20 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 19 Feb 2019 23:15:16 +0900
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20190219141516.GA15836@tigerII.localdomain>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-9-pmladek@suse.com>
 <20190219033003.GA2284@jagdpanzerIV>
 <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
 <20190219125115.GA19910@tigerII.localdomain>
 <20190219134956.GM9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219134956.GM9224@smile.fi.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/19/19 15:49), Andy Shevchenko wrote:
> > On (02/19/19 13:02), Andy Shevchenko wrote:
> > [..]
> > > And if it's not? You will get in either case incomplete information,
> > > but at least with "(e" (or even "(") you might get a clue that it
> > > errornous conditions.
> > 
> > The thing I'm signaling here is that in some cases we still can
> > crash the kernel; with the difference that invalid dereference
> > can now be a memory corruption. Just saying.
> 
> Wouldn't that mean that the culprit in the caller, not in the callee?
> 
> (As far as I got your another example with badly called sprintf() which may
>  overwrite stack, etc).

ipv4 printout case does not look like a caller bug to me: we expect a 15
bytes ipv4 address, allocate a 16 bytes buffer, sprintf() voluntarily
writes 18 bytes. This error reporting is a bit of a dangerous practice;
next year someone might add another specifier and another

	return string(buf, end, "(this data does not look right)", spec);

We probably would want to do something about it. For instance, mandating
that "(error)" string cannot be larger than 8 bytes can be a good starting
point.

	-ss
