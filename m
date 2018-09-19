Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D16ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684F22098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbPbuPyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684F22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbeISQL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:11:27 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54769 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbeISQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:11:27 -0400
Received: by mail-wm1-f46.google.com with SMTP id c14-v6so5686446wmb.4;
        Wed, 19 Sep 2018 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FrfezF+sxkXljTnQXuw4bz6AoHOAOgA2DoVMboTGhAY=;
        b=sbPbuPyc0XL072CTYubkdidjDHNtnBpWlP2KX39uJVbJLfcEH/BpHNtP7LeR481Jn2
         HfZvr+xGMsLQLn3Zb2HDcOXWwJ9GWhYgWOL+CbbXbgSfAcSK412mgtND9Vs//GcgsQKd
         KPxQrrqWHKIFhVMjKejDtMNjvirCpwcHRJeyfNhd0kSb3/ut6i05NzasR3gZ0e576NnA
         Ahfmd1ILRDQv1pu4esWEx8yq1PPE+lpenRiEwkbWUnDhQwSEHPhzHaphGpolhpbtY6Fj
         7EQtAYFvKyho6x6M/WpyyJtBBGO5ReYrOWvKr90Emoqxma0ulTnulDRUKlKHLvxbVzTt
         ueOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FrfezF+sxkXljTnQXuw4bz6AoHOAOgA2DoVMboTGhAY=;
        b=ZPRyq0zwA96ERNhUQMyN8VoEZ5K5Ps4FrSFcDMQA/hnp7ITQlJrrqQlVv/XkGtjEj1
         oKgsVfO02gsDKEC4rE3IEAEt57YvBNUOt1xZ9uz55LV4C14MLLdVba1ZCq/di4Mig2G+
         /rfTHzW3dYubBuGsXQUrxi9TU1GOO9WaRd/SpeOcUCofBYkvWJ+vwEr1OGqmNfNsZ+8T
         Q2ohdVEXSKvpdEbY0VE3FOeOfcrnFFEJQkoojp8iugqHizb8rOaViiY3F8YZCsVB60h2
         rCqK/zGJ4XtqYFhnS6bxAHBNzHztkujmMAI8kc1Z1e7YizQFRQhAgoDEALra+IXpdE2U
         Osfg==
X-Gm-Message-State: APzg51B+r0D+DGNDvf5b11SuK+9SZcKbAq6EqDv0d5soEE8BYTYJQrgf
        VEOOupjTatNL1aP5t7NuX/4=
X-Google-Smtp-Source: ANB0VdabDLFOi1vkFUGLZ4ainsZyb4e3+CvdPvJWPmd6qd8HSin9dsqBKwVdwbu0Ts1r35tsSsTXfg==
X-Received: by 2002:a1c:6782:: with SMTP id b124-v6mr19800385wmc.30.1537353248571;
        Wed, 19 Sep 2018 03:34:08 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q5-v6sm20565856wru.79.2018.09.19.03.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 03:34:07 -0700 (PDT)
Date:   Wed, 19 Sep 2018 12:34:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Chen, Yu C" <yu.c.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
Message-ID: <20180919103405.GA19621@gmail.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
 <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
 <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> > index 000000000000..fbde8f0e8fe0
> > --- /dev/null
> > +++ b/arch/x86/power/hibernate.c
> > @@ -0,0 +1,249 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Hibernation support for x86
> > + *
> > + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> > + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> > + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
> 
> I don't think this "copyright" information has any legal bearing any
> more at this point.

I think that's wrong in general, and it's routine for corporate legal
departments to insist on specific boilerplate copyright notices when
OSS code is contributed.

Copying code and then removing copyright notices is frowned upon
independently as well.

While you can probably talk for your own copyright notice, I'm not sure
it's true of the two other historic copyright notices that were copied.

So I think it's best practice to preserve all copyright notices as-is.

Thanks,

	Ingo
