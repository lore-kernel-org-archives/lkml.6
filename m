Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DAAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57A920672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtBYMcT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57A920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeLMJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:00:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41225 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:00:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so746229plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbiTCO+OSlfp4GdZoOQfhsM8gZ3dLWt1a+yNSWdYEqc=;
        b=MtBYMcT8RPsL2Mfzf7AP4bLUpnS7U/cmym3rwjwbHD+JJNU2pWP7ZVtSMvHWBVV+7J
         ba0FpZRtdPnqDqknB4W0+Dm8DUSOlDXIXf7rSkjtJr4PrJHRKVp5wW2OZqsvEXHPaMVf
         /PzZdqrbpmdA/ItEo8lOjyr0ggY55sRuO7TF3p32zGeu5qCN58ocVLarAqXUNxoq/5gR
         ympqaCxVmgPqvlr/IRwhYXoPSlq/uQz9o27jMqQb1wYgYw9el2NoIh9GKu/9vKqPM2HF
         Q4yedKgbM1IPnxWS3Lqy6XsFOeEJRXmqhE6FOo962X4a1ZA4fjDtoW2Gw12UUimXXQAT
         U4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbiTCO+OSlfp4GdZoOQfhsM8gZ3dLWt1a+yNSWdYEqc=;
        b=MWX3Z54ZauHSVbG3rbSXJeHq6cEJWkSsFzUKEscovhfimngegHQ5+RA4OuLaThsOnz
         28bwapExWVrJGodX8oWgqZpbjStkVRQZHuQWzK2FBpsSwIsYqk8fiIXSdN/9LsODPDfN
         UwrXCFbJi0z0MhVdg8uhg+mn3rJh1EAUmiiml/SBx35sojpwJJ2vXhSN0FClxOvMJQhF
         xUeX5RDSNeoEhT2oRYYWqTzBSaWrFgtjEsTPKr6jXUtdef38UO4P25CTwP1cQKCUfFHJ
         ZVQ9awfjFo9m6+bnAIrVfGcuD0XEwHJOHr6XJzZU9kMT1q0aFdfo0s1befladA3oQuQN
         xr/Q==
X-Gm-Message-State: AA+aEWYGX6kTLNkSloqjmYrICuoSZTGGJPm+1moPK3whimKVAAjmoi4C
        kzo6m8IXLyhOjLzyTnQzmQA=
X-Google-Smtp-Source: AFSGD/Wfb6hu3MHQw+bAUqQqDLR6VCn0n99btKRU4n+gWQmZjYVhdcCGOcIn6dxkJjqEpQCAOgswiA==
X-Received: by 2002:a17:902:aa0a:: with SMTP id be10mr22489681plb.266.1544691632153;
        Thu, 13 Dec 2018 01:00:32 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id z62sm2391122pfl.33.2018.12.13.01.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:00:30 -0800 (PST)
Date:   Thu, 13 Dec 2018 18:00:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     sergey.senozhatsky.work@gmail.com,
        Dmitry Safonov <dima@arista.com>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        yang.shi@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181213090026.GA7278@jagdpanzerIV>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
 <9cb1526a-e82f-dfa7-4b3c-5ea911a8d476@arista.com>
 <20181213051853.GG4860@jagdpanzerIV>
 <CAJwJo6YZNtdsQuGyk6=YDj9QzvktfYeNc5FTi-qw5ttQDVoJ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6YZNtdsQuGyk6=YDj9QzvktfYeNc5FTi-qw5ttQDVoJ0w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/13/18 05:54), Dmitry Safonov wrote:
> > I thought about it for a second, but couldn't figure out if this race
> > was real.
> >
> > E.g. uart case - if there are two paths which concurrently free and
> > access debug object, then the same race condition should exist for
> > the xmit.buf page. debug object's lifespan should be the same as the
> > lifespan of, ummm, whatever the thing that debug object is attached
> > to? I'm surely missing something here.
> 
> I think the point of debugobjects is to reduce the damage caused
> by an improper life-time of objects.
> 
> IIUC:
> 1. alloc_page()
> 2. dynamically allocate a workqueue on a new page
> 3. schedule some work
> 4. until the work has run free_page()

Hmm, if we free() that page then __debug_check_no_obj_freed() should ->fixup
all ODEBUG_STATE_ACTIVE objects first. Maybe we are talking about different
scenarios.

	-ss
