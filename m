Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ACC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9F52171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfA1XsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:48:25 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:55336 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbfA1XsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:48:22 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0SNmLWU007503
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:48:21 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0SNmGH1000975
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:48:21 -0500
Received: by mail-qk1-f200.google.com with SMTP id z68so20058135qkb.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=uIjdwQcAPyscz2jMHxycrlbp287T3XTE7prBcZpyAxo=;
        b=Dlz1ZVg3vAUaDm82HqbqxKDBubfl08oVH38jSyAsm5XbgtI3LhgecTwA3+mPoxfbR8
         lreFyP67bUmVMe4HuSrla5AEOBZsfuO1rveGb/FI+emgA/h0AFaZ+/v32mCqGLLGmaei
         QNG0FbuSJX726PAQ2vGh+ZcS8PKOKDxd6193CtiMLetjifGWnXlORdiEHCCFeJ98IEKS
         rqo8JI7kDLC6Q5rwY6HUD7Gr7GRWayAhRHVGDcRHWOX44bAayC9fvoHpjSTt3r9wc9J6
         zf4uzMmqv+elJMotsSEbk/Hm2ka60iC0q1qmjoUjmlNMhP80HdMwt7ps8E1Cun7XD7pZ
         QNkA==
X-Gm-Message-State: AJcUukf128Bd2s8xny+ah8uJwRy81WgfrrzQL1saSGG9BdBV7nTa29nu
        mGxOW82DDmFFurRiq90z0/DJy6KWC1ZVmfYoQlit5HfG5rC3wVl34+B23tms+28Ohd0tVTd9/On
        /GMNaCgi2px8lsRR90AmKUoSvnRHjilSIZ3k=
X-Received: by 2002:a37:7e45:: with SMTP id z66mr21202800qkc.23.1548719296148;
        Mon, 28 Jan 2019 15:48:16 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4qGnx2yTbCirEYAC3HpRUrRIIRjWdGHQk/IIIW9BTEFm1p8OwF31RZAvUGRNmi0GGcdzcyyg==
X-Received: by 2002:a37:7e45:: with SMTP id z66mr21202794qkc.23.1548719295991;
        Mon, 28 Jan 2019 15:48:15 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id v53sm78955308qtb.6.2019.01.28.15.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:48:14 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Daniel Borkmann <daniel@iogearbox.net>
cc:     Song Liu <liu.song.a23@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf/core.c - silence warning messages
In-reply-to: <3c8c866f-c665-ff82-a0ab-a4eafd28b20f@iogearbox.net>
References: <31468.1548648675@turing-police.cc.vt.edu> <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
 <3c8c866f-c665-ff82-a0ab-a4eafd28b20f@iogearbox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 28 Jan 2019 18:48:13 -0500
Message-ID: <10399.1548719293@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 00:22:26 +0100, Daniel Borkmann said:
> I think moving in separate file would be overkill, imho. However, lets get
> the kdoc and prototype warning fixed.

I have a bunch of spare time at the moment, so the kdoc and prototype
warnings are on my to-do list.


