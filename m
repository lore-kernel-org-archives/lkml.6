Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F345420C01
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 03:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfA1Doi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 22:44:38 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59612 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbfA1Doi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 22:44:38 -0500
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x0S3ibgN026598
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:44:37 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x0S3iW7J002314
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:44:37 -0500
Received: by mail-qt1-f200.google.com with SMTP id z6so19153232qtj.21
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 19:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=WZmGpQIJsh7kuBDW2LnwOtThbv1KyIFCCA2GT5KG3d0=;
        b=KWXxr+ZRIDD4zCoMLoTZfAfFL0g1lQ3OxNEbkElKbZ/W8/JQnushljgnGfcRFpVRdE
         anIPHMvl8MhN1yOrEuaRt4VD98graiSx7E59cT3E/ohMChQ5lKpUcR6FlOs5tINGbro3
         hMgExEIIrVp0lCXHlFWeY09nNIabMqtvQMeReJ4T75X5C+htk1eG2fLGb766pcNf5qgq
         0H3bpPhq8VSp//qpC9vmORFzQE1UscOAvKK/TiPrw9x/27wYf/oJEHCU8meCT+gTeKAS
         oJHPE6+69BRlKKIMAK1Pzd25EYYc2JU2JPj9UDbJCqO5X+P7WlkHSjpjWyjk7riq4b/D
         xQBQ==
X-Gm-Message-State: AJcUukc5dRgx+cEhdwGgMFMB5JyuhyfKfA5f/SUGDZxa9MFoWwjD1qMr
        A+yDwk0Xrupym1gyAJjV3WRY8A/Smk4giOE6eUJA2z1pzV7Rq/hOYyA9KkP1fLNAeA5eflCgdY/
        bNCKe5pkSuN9A/Cxr82n+Za8LjmlbAN+4MRk=
X-Received: by 2002:a37:9f46:: with SMTP id i67mr17550860qke.331.1548647071877;
        Sun, 27 Jan 2019 19:44:31 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7cEYoNuADG+25iyFEf08NS1I7WhWL8wvdNY2azFRehiwqHUnOmhB8kjDzzxTNxPTh+T+uE+A==
X-Received: by 2002:a37:9f46:: with SMTP id i67mr17550853qke.331.1548647071646;
        Sun, 27 Jan 2019 19:44:31 -0800 (PST)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id d58sm83411163qtb.84.2019.01.27.19.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 19:44:30 -0800 (PST)
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org
Subject: next-20190125 - objtool complains about dumpstack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 27 Jan 2019 22:45:03 -0500
Message-ID: <27806.1548647103@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seen in a build:

  CC      arch/x86/kernel/dumpstack.o
arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x9: undefined stack state
arch/x86/kernel/dumpstack.o: warning: objtool: oops_begin()+0x0: stack state mismatch: cfa1=6+16 cfa2=7+8

Probably a gcc9 code generation that objtool doesn't know about?
