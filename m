Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C82C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9F221A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="S9bBmapX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9F221A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeHGE4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:56:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36943 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeHGE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:56:49 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so21056681itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aE049zikLs61bDvOBj6bpvQyUtv2zXI7TPMfWK1Gz4=;
        b=S9bBmapXhkQQ6C5bPpXK6KJFrQ31EZ2oLZKBLjIynAUpIAQ1obdKn+/jJ/zHrOvTmH
         mvc2Jj3w+U8nUvVpXPTsO1LMsN74aUhnyLdyugeTtAbcui6M9zG/mSk4jyxO9oTqQULU
         /ImB/Sp6kth0DtoDrDvKyOny49rzcHhtgqbsORMYOjWZRTQrC0jaxGgqsoFem2IdbSAH
         cW9d7mMXCiPswHGu75Q6QY+zoCnXXi8Zfoghltyh5O8/vHB7d7/+jnfKZ/B4TzYLIgVJ
         sg2R3buWxkHyWkZ1XcHOhw++X9z+LG8JxVo8GbAKt6+m/DF14VqFkQF+VbjD2fcyB18h
         Iylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aE049zikLs61bDvOBj6bpvQyUtv2zXI7TPMfWK1Gz4=;
        b=hC1epKs3cf6R/njQQxV16Es1PDOHkr0NKjjNW7qnXv7McsEG+ie6zeBupzSvYU8wSN
         TVh8Y26iS2G33ni2eczTERCdb3tuCyMEYAIRUMzbUtVsdmdxcgPZD0HRB1Gh7PwoNcXs
         r7gZ2g0qCLzPFP7qsc3KhZXn4h3eGiTWtjZ0dtPZl0X8ySqFFkSUfh2HPRhfktQl/q29
         jfBc3bCXMIWT4PmmQCAET02/0bWA9Nvm7QLIUceoyBQt7hLp1ti65EDh9vZDuyeQ6MH8
         XOl5jG387XJcDgoA+ktF28V8/VUqJjdA/xPs4ZemY9Mk01GOkSr6swEX1euz8AFKQEmO
         g+SA==
X-Gm-Message-State: AOUpUlGpQ3lypwTPpeaex0CujfEdcKW1Kq7JIs5CuZEhbQaAkS7ObA4j
        oN74ui31fQ5qOTYXEkKvevWthQ==
X-Google-Smtp-Source: AA+uWPxUywr8dadeU7m8WOD9Ni3DZKLDahlux8ADXHY0QtD5nEQwIXA05dWLv/Vqzx3WEX4yBMQrTg==
X-Received: by 2002:a24:4587:: with SMTP id c7-v6mr466827itd.151.1533609884608;
        Mon, 06 Aug 2018 19:44:44 -0700 (PDT)
Received: from cisco.lan ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id y14-v6sm35765iol.60.2018.08.06.19.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 19:44:43 -0700 (PDT)
Date:   Mon, 6 Aug 2018 20:44:42 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
Message-ID: <20180807024442.GA12274@cisco.lan>
References: <20180621220416.5412-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621220416.5412-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Dinesh Subhraveti has claimed that some part of this series might be
patented. While he has not furnished me with anything to confirm this
claim, I'll put this series on hold.

Tycho

On Thu, Jun 21, 2018 at 04:04:12PM -0600, Tycho Andersen wrote:
> Hi all,
> 
> Here's v4 of the seccomp trap to userspace series. v3 is here:
> https://lkml.org/lkml/2018/5/31/527
> 
> I believe we've addressed the two burning questions I had about v3: 1.
> it seems ok not to use netlink, since there's not a great way to re-use
> the API without a lot of unnecessary code and 2. only having return
> capability for fds seems fine with people. Or at least I haven't heard
> any strong objections.
> 
> I've re-worked a bunch of things in this version based on feedback from
> the last series. See patch notes for details. At this point I'm not
> aware of anything that needs to be addressed, but of course that is
> subject to change :)
> 
> Tycho
> 
> Tycho Andersen (4):
>   seccomp: add a return code to trap to userspace
>   seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
>   seccomp: add a way to get a listener fd from ptrace
>   seccomp: add support for passing fds via USER_NOTIF
> 
>  .../userspace-api/seccomp_filter.rst          |  79 +++
>  arch/Kconfig                                  |   7 +
>  include/linux/seccomp.h                       |  18 +-
>  include/uapi/linux/ptrace.h                   |   2 +
>  include/uapi/linux/seccomp.h                  |  23 +-
>  kernel/ptrace.c                               |   4 +
>  kernel/seccomp.c                              | 491 ++++++++++++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 560 +++++++++++++++++-
>  8 files changed, 1172 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1
> 
