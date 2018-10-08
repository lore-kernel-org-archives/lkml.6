Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6FE2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="jhazeqZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6FE2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJIBNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:13:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42680 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJIBNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:13:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so10403896plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtJH1QdwhbrgyqiPLe408Wuhlx5dwCE57Yg2TZSlaRg=;
        b=jhazeqZN7YVVBOeeSzlL77MTMuKYSaAzepyy9UAEIi8rZOl6vaMkaBy05TPCRo65hU
         0Xfj9frQTtO6QsenGHEe92gmN/n+AvORVmnWssn/OPEsyZliO7SmYkqqnCT4nOl8j4qJ
         9Ddnw1pJJWVbPymtVOPIQAGDXYWsra6jbI16Wa9Eo1iBDcfpNJ1P6A1ZaYb+H+dPko8M
         gV0b/HfragCFvj93ZKRqNQHq7iipCS3TAaz6BolJZ2sFpqT4AGoFCGGpAsWH4rYC8UtT
         sHPEsvq/L6QQ6JmzQPt/8lsU9BGm7vq1WJQvmcoATHKuiiRJ09DrrBiwGfwUxT2Aislr
         rUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtJH1QdwhbrgyqiPLe408Wuhlx5dwCE57Yg2TZSlaRg=;
        b=VnRqetT6rvSMv/u+/Sw/weqP4DGa8nPRCBNxeD8sXpdCumAwuIGbVQNZu7FIxX8KZs
         qnJZ6HpwFD8O7AjTOsWdkHyc8O0AROlQ+tbnNVIEvG/tHU+plhZRFVpceSx8S8nB/Brp
         HqwhQiToIQbZiUs1rxHV03BkXZph1NKSglrtbnrcA1KD3qFgEVsAjoDjpe0oXE58tqnv
         2UDBQk4nEKu6mIPcqtInZE2xwYNmODXgUp4qzS5Dl7n7PaRKYZR+tNhpHGVZd01BdQD+
         EUHR5RSKL/13VuJJiwaqbu47UrmFxiGzh+NAYeMUpTqhfBnwnU6TqaaRC2y4KwDE92P/
         ZfQA==
X-Gm-Message-State: ABuFfogHK2lGXfHp2G3pnAFy3tPNVePzxDf70GBNYY//lQ9fWWnZUeEQ
        njCN7X72mc0gNsrhyieTiR/5cYQPKGPWSw==
X-Google-Smtp-Source: ACcGV622TAD2OGk64bfYlGrPQT0ucL5kwmZqJICeavsHAG/LFkU69H3EmpCG0zSivLXcPEDD6r3tVQ==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14-v6mr25265369plz.61.1539021645795;
        Mon, 08 Oct 2018 11:00:45 -0700 (PDT)
Received: from cisco.lan ([2001:420:28e:1260:c7c:88c5:50e7:459f])
        by smtp.gmail.com with ESMTPSA id h5-v6sm23488305pfo.135.2018.10.08.11.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 11:00:44 -0700 (PDT)
Date:   Mon, 8 Oct 2018 12:00:43 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181008180043.GE28238@cisco.lan>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008151629.hkgzzsluevwtuclw@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 05:16:30PM +0200, Christian Brauner wrote:
> On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> > 
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> 
> So for the slow of mind aka me:
> I'm not sure I completely understand this problem. Can you outline how
> sendmsg() and socket() are involved in this?
> 
> I'm also not sure that this holds (but I might misunderstand the
> problem) afaict, you could do try to get the fd out via CLONE_FILES and
> other means so something like: 
> 
> // let's pretend the libc wrapper for clone actually has sane semantics
> pid = clone(CLONE_FILES);
> if (pid == 0) {
>         fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
> 
>         // Now this fd will be valid in both parent and child.
>         // If you haven't blocked it you can inform the parent what
>         // the fd number is via pipe2(). If you have blocked it you can
>         // use dup2() and dup to a known fd number.
> }

But what if your seccomp filter wants to block both pipe2() and
dup2()? Whatever syscall you want to use to do this could be blocked
by some seccomp policy, which means you might not be able to use this
feature in some cases.

Perhaps it's unlikely, and we can just go forward knowing this. But it
seems like it is worth at least acknowledging that you can wedge
yourself into a corner.

Tycho
