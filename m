Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B32C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809C0208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHTqPBSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C0208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJPCbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:31:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38352 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbeJPCbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:31:15 -0400
Received: by mail-io1-f66.google.com with SMTP id n5-v6so14956852ioh.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VX/MgkYzDqDmiFd1pyCQjYy2N8AVhySoE6XGOLPt/Dg=;
        b=CHTqPBSWqTJXpvRiN2nkycONGaUEMVJuZOzsBEjF/JHCgWwE4AgnFaCkMbsMzTXCGG
         80xAPtQr4MX3Sht7UQByyxWAj7mIJ/i5TIIs/eG5pBgSkIvIEl2qS2vkCMZDlccKl+tv
         nLN0i36N8C8llWNdVf0mhv8mDTv5KD8pjeYECxruwKVK7GChqPulWDASVZh1Viuzfh5Z
         70Gwj93H6yExkXPI2GWsxWwtEX7a6IWxIYdCyCJx6JCztBUZk0A/74QkDcRedAlJmcYn
         SCwIc8boRULerhvAzR2LTfUJ3mYgs3lLsVOAasiZ0PvEnTOMBCABcA14qFd2nt3C9f1q
         KuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VX/MgkYzDqDmiFd1pyCQjYy2N8AVhySoE6XGOLPt/Dg=;
        b=Amb8GwikU7h2ip5pknD+L+sQldEzAPnjPI2wFtBzPzw4fbYpFOWl3Hd6KxGiNx5mei
         UtvJJqanG98it33SUwzX2WYi+rmQcURv9PzrxUYCMydMABd/CqS6nx7tOy1fNnWOAwRs
         SBxtU6pdeTVmMNryeUmdGi+foirSbIhoq3+Lg7SoONpIXkbXInA8EDNQWkmvEdVVU1HK
         I03R2J6V8qtzmJFYAYv/1lFjMsDWY8nttHe5XbT+bSbDBk1yu0Bmqey71uVj6EnEPspC
         NYYZiGcJS/eEa2aU3bHozImqS/Omk7bsGKZEGwm9vmjPQg6HrpFXbB2IVDntvcWG34vo
         r/RA==
X-Gm-Message-State: ABuFfojaLbzHOkTsjp90k4OWh/5u9Oxtb2oat6702f6E1YY+SnbfRFRI
        LSVK5amf1sDwJah+34TsHlGp2A==
X-Google-Smtp-Source: ACcGV61aaMpT7Q6Arbx2daLNxHJHln+1oNUIc4gJJ7g7wlHV0JVQHpKuue9rr/92i7cMl6kyxDeAjA==
X-Received: by 2002:a6b:bc41:: with SMTP id m62-v6mr12279790iof.64.1539629086821;
        Mon, 15 Oct 2018 11:44:46 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id z3-v6sm3386955iol.3.2018.10.15.11.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:44:45 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:44:43 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, jack@suse.cz,
        David Rientjes <rientjes@google.com>, kemi.wang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        bigeasy@linutronix.de, kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: detect numbers of vmstat keys/values mismatch
Message-ID: <20181015184443.GA175390@google.com>
References: <20181015183841.114341-1-yuzhao@google.com>
 <CAG48ez1AEpYx_nDCaNUbw7RdtsCBvAR8=SKSgyaoeSrhqRZ27w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1AEpYx_nDCaNUbw7RdtsCBvAR8=SKSgyaoeSrhqRZ27w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 08:41:52PM +0200, Jann Horn wrote:
> On Mon, Oct 15, 2018 at 8:38 PM Yu Zhao <yuzhao@google.com> wrote:
> > There were mismatches between number of vmstat keys and number of
> > vmstat values. They were fixed recently by:
> >   commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
> >   commit 28e2c4bb99aa ("mm/vmstat.c: fix outdated vmstat_text")
> >
> > Add a BUILD_BUG_ON to detect such mismatch and hopefully prevent
> > it from happening again.
> 
> A BUILD_BUG_ON() like this is already in the mm tree:
> https://ozlabs.org/~akpm/mmotm/broken-out/mm-vmstat-assert-that-vmstat_text-is-in-sync-with-stat_items_size.patch

My bad! Didn't notice this. Please disregard this patch.
