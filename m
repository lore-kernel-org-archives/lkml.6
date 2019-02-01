Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E531FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FB520869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJ/B+jLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfBAOAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:00:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfBAOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:00:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so6094245otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAhbsvt685Jn2cv9mpgyqPQtKTkU+Bo5Putqk7WhW8M=;
        b=qJ/B+jLynXP6frwszrKGn6qamBu3+8N/GtAUAJT67zR9u13vIc0LV0AlKqqGiqX7kA
         1IOwBZNudri1ClOeqr4R8e7KBOcXtH5z9lqpb8hDgZtxqgIeW4/JmeCLWh8/Tk9T++3N
         HcWYVXiZIp3TmNYkBHIPi0cMPUqtk3o6p/W/9dPml0axx1OKa2HSmFBtBUiNhWo0tdkl
         +G8jnAjSkUPwH3GyTf10EorsHUkus7DhDXhKOVBnxJx30fe3G6eXUhyl6DYXbAf7O94L
         IAGcgCqdltFObWS6uX/KRgnLglce7BJeRR4VBKb/SzB4A5ixSME4pFpv4YpSAW59mYpk
         J6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAhbsvt685Jn2cv9mpgyqPQtKTkU+Bo5Putqk7WhW8M=;
        b=p5gI31ZZfFmmSIP5Z3hibROUH3hGRW23bkN2i/FYZDGxRoHnELE0lqUBhXvqhPKL5O
         sHJKHDlaZ5ulE72YFEHKrVJExjnp3daGCKe2WUeOLrv/Xf85m8BSf+BWAdQhYKF9twt/
         E9vwPSNvN+mwz0Ezfv5DJeRBSbfFcBbVQDPlWYYYGo76fMqjuoO4iX7uFwD7l99OchMr
         mR4P/aMs9kP1h2CFFp98oQ0lhCq5Vl6h5EDdruH6k5gTf8BniAnk6wQbqWgKFxo/r5wO
         svwS4v65wDrLNXx13AYBtkwrloP5+EGKUmuGBtaH5eLQZVyizgstApYxhMUGbSbVW029
         0wNg==
X-Gm-Message-State: AJcUukfjc/+dqQk7tu443D5DAN6A7Cc38u2ExuV0RAUsMDkRfVUjLyiz
        428AVmWgj57OmpS9pTEeAtWLc/rUmgT3wzSyBqbKLw==
X-Google-Smtp-Source: ALg8bN4mTY5UDFF8dGMKvSIqu6I1PvupNC3DQw5cEfvju/gijJ3llKb1Jgn4txfwc653oCRlRciF6H8wbtCMDVTcK0g=
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr27148466otr.292.1549029645488;
 Fri, 01 Feb 2019 06:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20190129113159.567154026@linuxfoundation.org> <20190129113207.223846678@linuxfoundation.org>
In-Reply-To: <20190129113207.223846678@linuxfoundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Feb 2019 15:00:18 +0100
Message-ID: <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
Subject: Re: [PATCH 4.19 095/103] bpf: prevent out of bounds speculation on
 pointer arithmetic
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:47 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> [ commit 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 upstream ]
>
> Jann reported that the original commit back in b2157399cc98
> ("bpf: prevent out-of-bounds speculation") was not sufficient
> to stop CPU from speculating out of bounds memory access:
> While b2157399cc98 only focussed on masking array map access
> for unprivileged users for tail calls and data access such
> that the user provided index gets sanitized from BPF program
> and syscall side, there is still a more generic form affected
> from BPF programs that applies to most maps that hold user
> data in relation to dynamic map access when dealing with
> unknown scalars or "slow" known scalars as access offset, for
> example:

Is this also going into 4.14 and 4.9? I don't see anything related in
the stable queue or in stable-rc.
