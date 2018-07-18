Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E62ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBFE20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="DL/FqiY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBFE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbeGRDy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:54:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46381 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbeGRDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:54:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id l123-v6so1472557pfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YJj7O6QzX0eMgHKDAIE8NQMr7YnFenCzwwSx4ixSNg8=;
        b=DL/FqiY5N0T6Qzi9hQxjKUD5bJGJRttNTLjSFszY5PFuegonZWVtyUTtvhlBX6SFPj
         XktvxdmTJ5SmUuEG/NJ+UcyVQodmwOsvVl/hdM++Zp47/6x3IHXy0WwjjdHfikM6bOcl
         uEQYNtaI9FxsCSwd/DUyUScbLgmwYnZ6Bs5/vCyf+VcQsA+vbbxrFKXByQHd6zt0/fNy
         9C4Zow38Y8QrTm0MTATGJMcpxveutRMfvriNCI9sjJlqQRECpv8OsIKbbUD1J+k7VLSy
         q271bWzQih5wWNiK+WNzqMC6idFmskpoaz7OM6UbW1YQ6VwuLNsUn9nQ/ythc0JHKTCp
         TiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJj7O6QzX0eMgHKDAIE8NQMr7YnFenCzwwSx4ixSNg8=;
        b=QVPP5PFICL7jk5z15R1QVryqHTul5O/1TM54A9AqzuyafRwcLTjP/0FQPTjjp05eD8
         VR1ZoVc4adLs6OdKqb7RKq0Fn+eCiEUhz6lC4WSKssm3oT41v6E4B7+D22hoXnDgAj8h
         iNo6GT9oO1YE1gdS/mZPs5xxvz4HU0SFYRYUKshAin5TWzUv/FUteiUorehQyZrcyU39
         N3+BE5zKj7tJMKQiXaVbnkXmusIvSnlAUaXG+5gyHTJsCRFwbQkzrNh/q2cTXS1yp6Wt
         MChwsIvsKf2Dfr4dP7eGcQ4VFXP+dZebyfd3Uy9uld5xn3zwcf/ETCTUj1NrU9PwMsEx
         JSAA==
X-Gm-Message-State: AOUpUlGhB2kfVCoQz9+IuV8vnvujU88MsYXg6ocneU3TrhOq5+wYm7J6
        +pkYdDE/a38HYJ1UUnciQJXM1A==
X-Google-Smtp-Source: AAOMgpfDfAOopJNwhZkG7O8ucaNPtJqxgBw3kxw5dU6N63qUFb07bFLCJmSC47xtvzXkwLM/cR8+Lw==
X-Received: by 2002:a63:788b:: with SMTP id t133-v6mr4031861pgc.329.1531883955913;
        Tue, 17 Jul 2018 20:19:15 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:bc4f])
        by smtp.gmail.com with ESMTPSA id 13-v6sm397027pfw.131.2018.07.17.20.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:19:15 -0700 (PDT)
Date:   Tue, 17 Jul 2018 20:19:14 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/7] proc/kcore: don't grab lock for kclist_add()
Message-ID: <20180718031914.GA29351@vader>
References: <cover.1531440458.git.osandov@fb.com>
 <ddbe991f42b8d49e50645878ad8c1a8168db2e82.1531440458.git.osandov@fb.com>
 <20180717193504.1d76fb1a43d0c8687d969143@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717193504.1d76fb1a43d0c8687d969143@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 07:35:04PM -0700, Andrew Morton wrote:
> On Thu, 12 Jul 2018 17:09:33 -0700 Omar Sandoval <osandov@osandov.com> wrote:
> 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > kclist_add() is only called at init time, so there's no point in
> > grabbing any locks. We're also going to replace the rwlock with a rwsem,
> > which we don't want to try grabbing during early boot.
> > 
> > ...
> >
> > --- a/fs/proc/kcore.c
> > +++ b/fs/proc/kcore.c
> > @@ -62,6 +62,7 @@ static LIST_HEAD(kclist_head);
> >  static DEFINE_RWLOCK(kclist_lock);
> >  static int kcore_need_update = 1;
> >  
> > +/* This doesn't grab kclist_lock, so it should only be used at init time. */
> >  void
> >  kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> >  {
> > @@ -69,9 +70,7 @@ kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> >  	new->size = size;
> >  	new->type = type;
> >  
> > -	write_lock(&kclist_lock);
> >  	list_add_tail(&new->list, &kclist_head);
> > -	write_unlock(&kclist_lock);
> >  }
> 
> So we can mark kclist_add() as __init, yes?

Yes, thanks, I'll add that in v2.

> That way we save a scrap of ram and if someone starts calling
> kclist_add() from non-__init code we get a build-time warning.
> 
> --- a/fs/proc/kcore.c~proc-kcore-dont-grab-lock-for-kclist_add-fix
> +++ a/fs/proc/kcore.c
> @@ -63,7 +63,7 @@ static DEFINE_RWLOCK(kclist_lock);
>  static int kcore_need_update = 1;
>  
>  /* This doesn't grab kclist_lock, so it should only be used at init time. */
> -void
> +void __init
>  kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
>  {
>  	new->addr = (unsigned long)addr;
> --- a/include/linux/kcore.h~proc-kcore-dont-grab-lock-for-kclist_add-fix
> +++ a/include/linux/kcore.h
> @@ -35,7 +35,7 @@ struct vmcoredd_node {
>  };
>  
>  #ifdef CONFIG_PROC_KCORE
> -extern void kclist_add(struct kcore_list *, void *, size_t, int type);
> +extern void __init kclist_add(struct kcore_list *, void *, size_t, int type);
>  #else
>  static inline
>  void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> 
> 
