Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9287FC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589AB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPRQjjPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589AB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeLKWZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:25:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45214 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeLKWZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:25:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so7575066plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0QRHmOX9pOxuQEveIxHJT8YsVZ8O9ehPXeitj8Ev49Q=;
        b=mPRQjjPKzEJ0PD4XUPmHNHtc/FmuH01KydfsgMF9KYjcJWV3GmwhgoewBPNaw6aSph
         fQnAJ3GsDPqugwRCMkZWmnqxmhbgTYAxfH1wYIbU73uzkudkpI+O8JRKs9vr+5ZZZmSE
         f7yd0F7WLyDRsRp8sEmEeRlTfPAMzTyYQKty5EErKpb4lWzA2zqdCAeJI5J56V60Fpff
         eZhJq4myLL88ZCpvkSkChZ4jvFL62sVBsjJjOFwgbg/tubge8qVjxloU1kpNHdy1Ty6L
         Qv80YGnXx9mkXj5xTaBldSsgEk7M0+rdPR5TVsSJTyZmgzD4+6vaX6RlJ5jcCzCvQ5KH
         0IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0QRHmOX9pOxuQEveIxHJT8YsVZ8O9ehPXeitj8Ev49Q=;
        b=d/cgyAPACQrCxai1rEyiX0xCek7TiNbneGDc6Kv4aGgCMLgkgjltrI7eWHj6hN2efA
         FJlPiI4xjythIqnak+rPMOZqLwMQbicKPm2fvoOy0M9PWWwnArt1L48ZIqOCJelm0R8m
         Dy7aVTHos1k5Coy3aNSyJNn8GDCI8sk/9TTP/BRCts+61AmszXM61uiC+qvEpu5dEo9y
         iGeYuCvc2jlDiv2RX5fWmM3WVK7NNKorveng0N2mBZYqVw4mcr3M6zn5MHPdzbosrfLM
         WKS9dH/X+x013+t/QbsjyE13A+ThhST7v2T1LWKaTI5DGqJyyCDDL1Q7khig9e10Jpri
         GcXA==
X-Gm-Message-State: AA+aEWYu8MIDfDGE1URUeUfbkXL7xnFQu55Eb49SbT6bYeH5OatJr1EO
        4MejbqG/z9+SwsDiwFhhQOBs+w==
X-Google-Smtp-Source: AFSGD/UcBtYJ2hFGRrH/TBxT4L5V8OWnQy+19V3Ut2KzmlPUmLugSRbbAaTkHiIgbbsOBuokTJYJJQ==
X-Received: by 2002:a17:902:d68c:: with SMTP id v12mr17411398ply.4.1544567104320;
        Tue, 11 Dec 2018 14:25:04 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p67sm31082581pfi.85.2018.12.11.14.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:25:03 -0800 (PST)
Date:   Tue, 11 Dec 2018 14:25:02 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Arnd Bergmann <arnd@arndb.de>
cc:     =?UTF-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
In-Reply-To: <CAK8P3a1yn7RAp7Q29dx5Rcb0mCoDpcHPzxSGqKHdgfJd+=iiNw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812111424400.124369@chino.kir.corp.google.com>
References: <20181211200526.3868586-1-arnd@arndb.de> <20181211201909.GA6478@redhat.com> <alpine.DEB.2.21.1812111310320.87855@chino.kir.corp.google.com> <20181211213636.GB6478@redhat.com> <alpine.DEB.2.21.1812111341280.97190@chino.kir.corp.google.com>
 <CAK8P3a1yn7RAp7Q29dx5Rcb0mCoDpcHPzxSGqKHdgfJd+=iiNw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Arnd Bergmann wrote:

> > Hmm, strange that Arnd's build failure is only reporting about an unused
> > variable instead of MMU_NOTIFY_CLEAR being undefined :/
> >
> > I think this should be done so that anybody using
> > mmu_notifier_range_init() doesn't need to worry about the implications of
> > *any* unused formal parameter as a result of how the #define is formed:
> 
> Your patch below is more or less what I tried at first, and that resulted
> in another build failure for
> 
> mm/hugetlb.c:   mmu_notifier_range_init(&range, mm, start, end,
> MMU_NOTIFY_CLEAR);
> mm/hugetlb.c-   adjust_range_if_pmd_sharing_possible(vma,
> &range.start, &range.end);
> 
> where range.end refers to a nonexisting member of range.
> 

Isn't that separate?  It seems like there is a strict dependency that 
CONFIG_HUGETLBFS has on CONFIG_MMU_NOTIFIER.
