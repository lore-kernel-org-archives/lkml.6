Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D5ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBC12075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Jp6AXexd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBC12075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbeGRD7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:59:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41371 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbeGRD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:59:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so1359093ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DOcETJK+mrW4NbvhRdPR+EyOGIwkzyC9IN9wH8Qu2Hw=;
        b=Jp6AXexdaMvlztcDHp83Ymgs7u6VjgklMsIwRDmjXf6mQNPOhNfc2hTqt5jJZiyWf1
         uRt1zmZTHX8q42zA4P5Y25Ovj0ihoaAWEIW7xyH2DzsRD1aEgZpURSZUjkHK1pvEiliK
         bCqLXp+99Y7dfQ1WndBPgaXgz6athdwt7CJFAVwozA4dwdb8wD27NEgJWBA7SjXP6vEv
         DBy0yq27jbUBtZjYLyeReBNUY34kvroNS83RXStM/RUuCIlLb/MbXp2yZIc0sRFG3/LI
         8jJRPhBFjNj+lyD3vlu6fugkNqHqfjX8DDL0G+rI9e1ETLz+W3yOOKxWZSogZWQCiiIM
         AsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOcETJK+mrW4NbvhRdPR+EyOGIwkzyC9IN9wH8Qu2Hw=;
        b=I2BF2KNf2hHEpBMbqYBU39v37Mf5W68dRuKqHCtd+WqNPIAKj0I2vo4FgovE9vtn6V
         4eMBtpWNAugMCJ3ivxbgHC8h0FwMCfKJ1VWM6QR70jNmNFtFxic5w8P3WYmWmlUSb+hH
         LVv1WkvQ2rncUXnvIgTDOF0l8tklq/3WRHOcu3xJiQCC6PnEib/E9vhXEXiWwDbfjpzT
         hlFChib33ZNp+dN3iyb49WzYFPddLcHZl2CTOoR44ZO0YyDMDsOXugBU6AV7JOnIdcLc
         srjTFNTnpH3jkP5ezMN35w2+ex6fkgFeGr1vIkWHSUWQLh1HTeYG8jcZuy1g05mNcV5V
         UbVw==
X-Gm-Message-State: AOUpUlEkHuYAMJWMfFhRrngf0BWb/LdCM/DAFgEvaufnAKXBnoBp+Ejn
        6SQ0vgUE7uZ9FxTB/OEobOiwaw==
X-Google-Smtp-Source: AAOMgpcIT0gzIncCmwELJRMO560Sv30VfdOwv54kMW5PpQGaPSt/qLi5EOnDf4mh9HMRUilNLm2iRQ==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr4130645pla.325.1531884246713;
        Tue, 17 Jul 2018 20:24:06 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:bc4f])
        by smtp.gmail.com with ESMTPSA id r87-v6sm9869934pfb.1.2018.07.17.20.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:24:06 -0700 (PDT)
Date:   Tue, 17 Jul 2018 20:24:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/7] proc/kcore: replace kclist_lock rwlock with rwsem
Message-ID: <20180718032405.GB29351@vader>
References: <cover.1531440458.git.osandov@fb.com>
 <783ba3becc424db45e5d5c93559fc40ef6173f01.1531440458.git.osandov@fb.com>
 <20180717193841.271d1c57b6f88d75c83892be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717193841.271d1c57b6f88d75c83892be@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 07:38:41PM -0700, Andrew Morton wrote:
> On Thu, 12 Jul 2018 17:09:34 -0700 Omar Sandoval <osandov@osandov.com> wrote:
> 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Now we only need kclist_lock from user context and at fs init time, and
> > the following changes need to sleep while holding the kclist_lock.
> > 
> > ...
> >
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -59,8 +59,8 @@ struct memelfnote
> >  };
> >  
> >  static LIST_HEAD(kclist_head);
> > -static DEFINE_RWLOCK(kclist_lock);
> > -static int kcore_need_update = 1;
> > +static DECLARE_RWSEM(kclist_lock);
> > +static atomic_t kcore_need_update = ATOMIC_INIT(1);
> 
> It's unclear why kcore_need_update was changed to atomic_t - it's still
> updated under kclist_lock?

Not in the hotplug notifier (kcore_callback()) anymore, so I need the
atomic_cmpxchg() in __kcore_update_ram(). That could use a mention in
the commit message.

> Maybe it's for a later patch.
> 
> 
