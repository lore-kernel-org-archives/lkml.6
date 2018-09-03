Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YdNsJoXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6364A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeICGAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:00:54 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:55449 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:00:54 -0400
Received: by mail-it0-f54.google.com with SMTP id d10-v6so13612021itj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rV+ggJJzpVeroU6dmTj0LJb7xawv3iXkPp3QEuiFoJE=;
        b=YdNsJoXn2EegL2qQVurDMOggMpnMrFzLtiGqsYg9bWLymhG2kCYTy4379d3kGb3SYs
         AeJC5kuAw67bj10QBvwOVlND0JA1zk0QtK3CYnAMeJgTfTYj7adp/AaqibEBcEGlYh8M
         RTQ/j4fpMjAc6DAugLGE0F6wKn+2X1YdaG2mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rV+ggJJzpVeroU6dmTj0LJb7xawv3iXkPp3QEuiFoJE=;
        b=kvshEb3oWCof0XCoGy82znc23GEIjMj3u+YS2kX6oGSbxp/5JKhggI86WiZm3gte53
         cWe3a9wpimwSc655CysKF9Iw7KdRQqx6rk/3YmEEggJ1NnI0uhsL/7n3kFfwSPHEmIyv
         TF58uK9zLFGQXcDjybGq33NdVkH2UdHW514+dBq+LJCTPmLNzNPFam+H1tbDJrY1K80k
         JtIJfs+X47HLz7SLVkS6yg7KCw44/Vqf5o6oPOWyLnDpVCOOMN3Pz6jiEob+d0EYD3jU
         +ZZMr4AY7sJlkBho6TRmhGOLl43tWIEpLVx9srtc5wh8g9qEo4H57FEs42InHMQIuza5
         3EpA==
X-Gm-Message-State: APzg51BKfBZewWbJ4QuFkn/DCEv/dilGw+dBLyViTrFgehrhefGkgzf9
        BPCsmgU2va6RtMRggbDezAh7sn+nCZVs9TVMAUc=
X-Google-Smtp-Source: ANB0Vdb0UFRbK/R1LLLTv2mpSl/D6mg9gRDI3fHEgo1YAUPaix83MC1xhshxzQIX74A8AdfM+/t/LFDLlZhjqgZslJc=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr18654418jaa.10.1535938984562;
 Sun, 02 Sep 2018 18:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
 <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org> <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
In-Reply-To: <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Sep 2018 18:42:53 -0700
Message-ID: <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
Subject: Re: Access to non-RAM pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 6:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It's not used for vmalloc stuff. It's just regular kmalloc().

Just to clarify .. that's true of the dcache stuff.

The strscpy case actually explicitly limits things to page boundaries
and falls back to the byte-by-byte case after that.

             Linus
