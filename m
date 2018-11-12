Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7195F21527
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN7amoro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7195F21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbeKLOIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:08:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40669 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLOIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:08:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id z8-v6so618718wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lLJXrIqYM8TU/W6Zal1zkWGH1kuS9Sn6oelDMQ/ByZ0=;
        b=WN7amoroUOx/aF4g3ObV5EgZ5pVl9eBdDhGl+pdGNXO01hWCiB6QppOEbVKWpbnHkD
         +J6I9VzDM5RznQq3TTO9ynjyflV3WWFivO/T9MwWS5evyBE4wq9NVwUIfjoPWWOymCL+
         nv9N4PvA2uVfO8+zT0PIXMr0hqstI8S/SmR1pQ0zSxxr2MHpEdpPz4zm1eGkVAqs/5h4
         dCAKyl9FbQtRO5bwMARI8aqPMQ95yMkl6s6QpoNSfQEynmuc+AF7ezCCBVpZWwFrHJyM
         6TMVtLHz4D5AlfgYIcZlX6JX2rrWy8LJMCDlmd8POXTuvFI9c7py8tEbRM9k97DdJoSR
         1e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lLJXrIqYM8TU/W6Zal1zkWGH1kuS9Sn6oelDMQ/ByZ0=;
        b=KtQ/WPOq7O/tj4unzHS+B+EgWCf4ILK1ncjtrDDo3f5NFxb8B7LBTDzdDRDd2y9rPv
         VYk10F2Howmb5e1KojpLzEbYhaxxVPzgLNOe2oYgisqByhWy0kSkiQOdSFHHoIXN62Tg
         yXlA2GVCF2EmxfX9faBWyJPBz+TOKfWdO6r6sjDGS5PR41i/KGI6ZuAndwFHnrWfKxmq
         aWCtTNKwP8MljPkobB6Ylw+ZElVNjGLEgnXt1MaUUdZsHXh+A3oAZKmEFwLAGVD9i+FL
         DWYlPU37Bal1b+8brqXLLic6PLGtgQLvq3cmo8fjMu6ZmJQf6Qd7go9iXOmmmHdAf8Co
         D6vw==
X-Gm-Message-State: AGRZ1gKnjie0UVG81As0X2sbZD3Z/mwy92NuLBsNif9/mIiJncfukh8T
        BlL6RgeXrRSX+JVzH/aGHWA=
X-Google-Smtp-Source: AJdET5c/GDBHq3uuMBSgVW+YPmQpi4l3tkFBOwf0QpKqcZMiQUnq9khSH7KAtMYK1TgKrBrefUP+zQ==
X-Received: by 2002:a1c:9690:: with SMTP id y138-v6mr6185188wmd.67.1541996219952;
        Sun, 11 Nov 2018 20:16:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q11-v6sm11865608wrj.7.2018.11.11.20.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:16:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:16:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 3/3] sched/fair: add lsub_positive and use it
 consistently
Message-ID: <20181112041656.GA47272@gmail.com>
References: <20181105145400.935-1-patrick.bellasi@arm.com>
 <20181105145400.935-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105145400.935-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Patrick Bellasi <patrick.bellasi@arm.com> wrote:

> The following pattern:
> 
>    var -= min_t(typeof(var), var, val);
> 
> is used multiple times in fair.c.
> 
> The existing sub_positive() already capture that pattern but it adds
> also explicit load-sotre to properly support lockless observations.
> In other cases, the patter above is used to update local, and/or not
> concurrently accessed, variables.

> Let's add a simpler version of sub_positive, targeted to local variables
> updates, which gives the same readability benefits at calling sites
> without enforcing {READ,WRITE}_ONCE barriers.

> +/*
> + * Remove and clamp on negative, from a local variable.
> + *
> + * A variant of sub_positive which do not use explicit load-store
> + * and thus optimized for local variable updates.

I fixed up the two typos ('load-sotre', 'patter'), and fixed eight 
grammar mistakes (!) in the changelog and in the code comments, but 
*please* read the changelogs and code you are writing, this is scheduler 
code after all ...

( Please also use the fn() notation in changelogs consistently in the 
  future: first you use 'sub_positive()' correctly then it becomes 
  'sub_positive'. )

Anyway, the fix looks sane so I've applied it to sched/urgent.

Thanks,

	Ingo
