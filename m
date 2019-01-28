Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132D2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfA1XfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:35:25 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:40382 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726762AbfA1XfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:35:24 -0500
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0SNZO5B000497
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:35:24 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0SNZJVE001814
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:35:24 -0500
Received: by mail-qt1-f200.google.com with SMTP id j5so22342485qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=UDEF/0d3Q0zZWlBm2eHzE6Yozy0EgOGcdjjKxY0nlWo=;
        b=qZThx8wusEXvlMltFW56MXtWwcHzxuBAteSaIfPZyrO/hq+7ZLVN+y4/qmky8jAgFD
         84DFz9u4DHUTLBfYI8Bm99/jYSQ+dYQgg9g7uNZ4D4kJEFG3LMU7WOvP4swyu6lrRcZD
         rqmvnzVCWe1x44oOMeJHF171SiVyK9WYWIHDOf7rS0qH0TKbqoD2S9YD6a88WfhQFNeF
         rNojzdTBGARnwVMel9bKnSRsP+2poxQJhcfDSo6OI3Jd6lc8iiGMcZMLMHeoXM6+siFo
         Ud/d1caWipLa1qWgz+4c/mV2nomH7TlpsZjlcK9zhc0QMGBO8j7sMfTI54Z011+R+YHf
         tnWQ==
X-Gm-Message-State: AJcUukeLTEHifBRsKewDSukvVeF7M4KbIcQPY4JZ17bLr0NdPO9XTUfe
        M+C9P9GLlr8aem8C8esEL1V5fOwaZoaySshTq6c5nmb9yZWthreDmkcvyKGRPOTusHz+uTB6tV2
        7a0qLn0WzlEEuDF/VHf0ARNZ3OO7g0bRSeeY=
X-Received: by 2002:aed:384a:: with SMTP id j68mr23272276qte.171.1548718519093;
        Mon, 28 Jan 2019 15:35:19 -0800 (PST)
X-Google-Smtp-Source: ALg8bN56jwhHp4RgzCY6/zt4lJuhZGnty+lgoGhDyVmUo1lOJvhW0C9W91Ha8t27P2MbPdlaJrBnVQ==
X-Received: by 2002:aed:384a:: with SMTP id j68mr23272263qte.171.1548718518938;
        Mon, 28 Jan 2019 15:35:18 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id z18sm69894537qkz.96.2019.01.28.15.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 15:35:17 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Song Liu <liu.song.a23@gmail.com>
cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf/core.c - silence warning messages
In-reply-to: <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
References: <31468.1548648675@turing-police.cc.vt.edu>
 <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Mon, 28 Jan 2019 18:35:16 -0500
Message-ID: <9865.1548718516@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 09:18:45 -0800, Song Liu said:
> On Sun, Jan 27, 2019 at 8:43 PM <valdis.kletnieks@vt.edu> wrote:

> > The attached patch silences the warnings, because we *know* we're overwriting
> > the default initializer. That leaves bpf/core.c with only 6 other warnings,
> > which become more visible in comparison.
>
> My concern is that this will also mute the warning for other parts of
> bpf/core.c.

I checked and there weren't any warnings for other parts of the file.  Also, this message
doesn't even happen unless you build with W=1, which apparently happens so rarely
that nobody else has submitted a patch.

Is there a high likelihood that another overwrite of an initializer is going to
be included in the source?

> Maybe we should move bpf_opcode_in_insntable() to a separate file, and mute
> warning for that file?

Seems to be overkill - the intent of this patch was mostly to make the *other*
warnings issued with W=1 more noticable.

