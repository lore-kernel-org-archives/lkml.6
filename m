Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEBEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489672592D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TumANn3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489672592D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbeFYMgG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:36:06 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34078 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbeFYMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:36:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so13530232wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nRanzqkIoMfqWmdkJ1c2MLyzpusHVVUYXwm69uDeN68=;
        b=TumANn3lZAL7LzD0Zac85b0i+9QVA/Yrl0mYvTA1yX4k3ijeAOYosa/efyuH09agcE
         IVZ5flm1L/rRw2lx/DyVHxiUnrpR9Bp1rCmuZkYzh/ayS5JxuQOKniAyOHdy0ALWAXFr
         /lmv+x1pQckA7pnKU8/u26YoKhLJelRucHZPrsvaK+bmktCYBZNRlgtjCRLP0b7bZpfd
         BAUp5jYKBUskV3JdLoAhYfP5l6v0Qt9RoZetDSYlifa4LmNoShmukDm2n7c+T6as4S1A
         kEGaVgM5ZazheeNObI0tdm/dZQQ/hR5xyINxxtGuOnUB9ytDhjsgqLpokc5fb/C9LuvU
         e6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRanzqkIoMfqWmdkJ1c2MLyzpusHVVUYXwm69uDeN68=;
        b=tN8YlFNi8OLCQf8dPFG779xC7gDbM7Glf+9seITF6YbGm40oEVqqR0T98c84qdsVwE
         6CMZuieY116NfSeF2WqGb2T7g0ZQAIADrt+ZK/7kdkQZN1n3yHIfD8GcCN/Nn7SjHGsB
         PizNHwmsCJ+KimxSjjo4FDDrggIxnuKUPDaiVbpivg7zYheAyVJaJEyw3tPJjfJT7VUO
         3dD8yP2kMBhIOq6L1Y+mz+UtKGmWcz3CoylBtLuU0Dr4Rv8yKrcEHeZ92uLx47cRTs2A
         Wpy7NlqkRiWbCJGaVZJGLigcnBjdoGaBjjLvgmiCD/fepqhWTeWL2JacgFdGhQN5lKFd
         HfMw==
X-Gm-Message-State: APt69E1Z+u/04QRa9GgpczN6/srSudM1RxaLTsj4fhbu14yOCnA2Cgw0
        phONcLll6MC+VZ8ME1kUsaQ=
X-Google-Smtp-Source: AAOMgpdMjLADhpb0UFrEalNz/A0Hrme5moP28f3Tk9Mu4DZb/iPkesK9067vn1mrjyAGwAySN0vtqg==
X-Received: by 2002:adf:80af:: with SMTP id 44-v6mr6903575wrl.64.1529930163781;
        Mon, 25 Jun 2018 05:36:03 -0700 (PDT)
Received: from xux707-tw ([109.76.172.189])
        by smtp.gmail.com with ESMTPSA id s184-v6sm6014125wmf.5.2018.06.25.05.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:36:02 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:36:00 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-4-johnfwhitmore@gmail.com>
 <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 12:06:30PM +0300, Andy Shevchenko wrote:
> On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> >
> 
> Suggested-by ?
>

Em, not sure how to respond, it certainly wasn't my idea. I was just making
coding style changes, badly. ;)

John
