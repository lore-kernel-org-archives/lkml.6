Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF4FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16BE20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 23:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="c26QDWUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16BE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeK1KVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:21:00 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41207 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 05:21:00 -0500
Received: by mail-pf1-f178.google.com with SMTP id b7so9157923pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 15:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BACgqBVl9I9JRF7hJttp/J2Db4y0yD/xPeT1Fy8Zd8M=;
        b=c26QDWUkFDetmH5aoU0xh0Wj8Hue5nLDOMbukaYdB9KcBVSNqmzwKy9bMKLS2amWhT
         wbuIwq9va+7VNNW6lG4rnPICcQZmtR488V+6Wlp2bdUxq2iWFRPvj0vnrhxSbcdeFksy
         ekeeZksbKaeekJ5d4OOk8Nj27JPi8/iYMXTn1xIz/Vx1tAew8lAd1F4eNmm5DTL/Jyob
         Te4eC5BiSF8zuTJjr/FF97aMFKC4+PsbUtAHU4lralLO/QOesPJCJtDJiv/pQ2keBTDr
         4XGPALDi2N14uTtSJXChI/Qi366LH2X8Dy/HvnTsAEzs8HnFNPoMDins0HVfswzdrRYe
         mTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BACgqBVl9I9JRF7hJttp/J2Db4y0yD/xPeT1Fy8Zd8M=;
        b=i3kP6EdFevzxzomaQg368AwYaKgA0OiPlUfp00h/m03Q+D9xWs7CIrqSF7BEJ4GjWy
         5pJwRbhTlS20alS0z07nuIdZyL1017HVNUmUqZKgtLCzEkR2HqAG2Q3PMFa7jLaKTfjj
         MuWF7SMqsmxLyaxL8PU3bH++HRd9nc8dGt463W8xJ6hX1oOec9rJwj4OMZFeGQ3SVMxN
         bYp4ETvTr/IkuMzjsiS2IgK3tJQxt1lbPQ/1OMAGlMT6Why0lFI7IFrJz5GGboNQDW2c
         8ZYNNDfceIVn2hsymydvhVSc9DuVVVVjbvLjHUqX06yGHR9Im6IWwolIfXzFcI0e3XBP
         CWCA==
X-Gm-Message-State: AA+aEWZyxVJTDFuSZgm5afqUtTvFINM1dYShKkZn+Ci3n/ys9y82lvhU
        bnqfiGp+UietiMR/ZAObDrZkDkHudXU=
X-Google-Smtp-Source: AFSGD/XhVOSPIfOW7cl/8J0AVQMwXaT33NjC3GirskZT+yy3oXzoG4chgUfysCKWMBPpdOo2ev53+A==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr31538106pgv.179.1543360890047;
        Tue, 27 Nov 2018 15:21:30 -0800 (PST)
Received: from cisco ([128.107.241.185])
        by smtp.gmail.com with ESMTPSA id 8sm7027795pfr.55.2018.11.27.15.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:21:29 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:21:26 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181127232126.GA23658@cisco>
References: <20181112171144.GI3645@cisco>
 <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco>
 <20181112192443.GL3645@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112192443.GL3645@cisco>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
> 
> Ok, now I have,
> 
> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
> global.syscall_restart: Test failed at step #22

Seems like this is still happening on v4.20-rc4,

[ RUN      ] global.syscall_restart
seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
global.syscall_restart: Test failed at step #22

Tycho
