Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842CEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAAC20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBWADr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:03:47 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59160 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727225AbfBWADr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:03:47 -0500
Received: from mr2.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x1N03kG5021400
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 19:03:46 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x1N03fIk002115
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 19:03:46 -0500
Received: by mail-qt1-f197.google.com with SMTP id e31so3557836qtb.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 16:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:date:message-id;
        bh=6P26B3WVjjgMdHkoqDaltUyPHvGxoNnNHJlC27kT/84=;
        b=UYbdKhemU9XsE2gjseh9+9XYhelzIoblv8a4rAXSJ7/ceLoTmnNeMbxA9Xqmi+tLxM
         ouNAWLuhKuYayrV54FohW6IeuKNbIZukv5PCEK/y6TsXQR+YDlmnKda3iHfIRuGkm+Rx
         aL2eCoBICQqWQg8Qo7zl6C4OeGMeftFUcYn7+K+CvcOM19EkHMMhjUhJCEvjJbZsHnhz
         ryUzdWqOHfnUsr8SfqPFQdK6u7F3jOPl1KHTJ/PZdYcPHGUIvT5EuhuGey7mOxmnt0kO
         /R8n0+dLfhb9bEyVnorGoaPOzCzUMYecw2QVc2yhdK1SlvnQ0Tjp4VIoUGzMIPFDZtHM
         KpeA==
X-Gm-Message-State: AHQUAuY2rW0PlZmQmLqIbMkfulr4WmUioagWCwJmXxuPpQNhjbMgrQRJ
        4OpvhOlich+QPMUFZNBCwDu0ebM2hQMip+petjTu91mJS/EXpjeduu5lfyCOzHvgEixXrzaDfHg
        xg3zo1z4ghFRNCJeoMicFdQPgyFEmwiMIqyw=
X-Received: by 2002:ac8:538b:: with SMTP id x11mr5205520qtp.298.1550880220871;
        Fri, 22 Feb 2019 16:03:40 -0800 (PST)
X-Google-Smtp-Source: AHgI3IYXSqDowMQNycn8js6oP0VMyVNscZ0p3eOzPym7ZK4agLulGmnI36Ton94bfywSU+l+Szhw2g==
X-Received: by 2002:ac8:538b:: with SMTP id x11mr5205498qtp.298.1550880220616;
        Fri, 22 Feb 2019 16:03:40 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:5952:f06b:5958:9b7c])
        by smtp.gmail.com with ESMTPSA id 81sm1520146qkg.75.2019.02.22.16.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:03:39 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Jann Horn <jannh@google.com>
cc:     Daniel Borkmann <daniel@iogearbox.net>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [bpf] 568f196756: BUG:assuming_atomic_context_at_kernel/seccomp.c
In-reply-to: <CAG48ez009feoF9=AwQ1qHSnuXeFJnAsHREmtrT-+HgPueytyCw@mail.gmail.com>
References: <20190221133556.eqzclahgngq53s64@inn2.lkp.intel.com> <cdd8143b-7719-b51e-5a6a-6bdc065cc773@iogearbox.net> <14415.1550875312@turing-police.cc.vt.edu>
 <CAG48ez009feoF9=AwQ1qHSnuXeFJnAsHREmtrT-+HgPueytyCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 22 Feb 2019 19:03:38 -0500
Message-ID: <8536.1550880218@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2019 00:15:38 +0100, Jann Horn said:
> On Fri, Feb 22, 2019 at 11:42 PM <valdis.kletnieks@vt.edu> wrote:
> > Is there a reason this commit appeared in next-20190221 but did not seem to be
> > in next-20190222 (confirmed via 'git tag --contains')?y ast@, he wanted to fix it in a different way:
> https://lore.kernel.org/netdev/20190221192916.2mcd4fmxbdj2j2u3@ast-mbp.dhcp.thefacebook.com/

Aha.  That was cc:ed to netdev, but not to lkml.  Explains why I missed that piece
of the story....

