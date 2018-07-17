Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F65ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62820693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fHKZvdw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E62820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGQUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:48:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52542 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeGQUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:48:19 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so951341itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBNGvOwE2k6zHFGYPTokhboJ1nK9O//k08KLpx5LKrA=;
        b=fHKZvdw2qL4ob1tLQ+4zIerq9oD9beDN9wIAqmYxsyNBztSXa0B9CrlxATeuNjezmD
         QL3MKNG/5iuZRlYZJsrxAjZacJug73wrOeuWlb/znCYpdTDOlgbRjsHR3L/WM3Y1UTBN
         ck++dh8mrDOa8H+eZPpFe2FqDwSRryXb+uhAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBNGvOwE2k6zHFGYPTokhboJ1nK9O//k08KLpx5LKrA=;
        b=d8DO/MdFln5pzmuSGumAu0iicq9McaHPz6I5Q1IiOm1HA7FLDkDs/nWiiXuAkIrG1q
         PJfvMLGcOCNw2eJ8gSDxQGJNLiKkSggaTWWQuT/z1e+7AyfqSUtHonQ4MDRXwMOiOyaF
         SCxIDWKsF/sFJAaYlj3JN3F2Y3Hh2tr4++2+Ns3uzXEmROgQr4x27Big5EXCzJfmzW55
         ZcwLj6MvmWg1l7SUTAGK2nfPC92sAjmoIC1AnrTD1V+MKTpK1ovrJALuMnX/K9k7/tkK
         kNGn91GXgrsi8q+h1HsPTYUjYp91AweoniAssPR7GaFl7OtfIzxvNZldYsRb3tFVMlK6
         FYzA==
X-Gm-Message-State: AOUpUlHFoF5I8YfxTFA0Ihoq7DlD+7Lh7X7wGAGLnebkPEngu9WQCr2a
        xbu31/qhUQJSu+pTHKblidFI85LyuOeuFapWnFs=
X-Google-Smtp-Source: AAOMgpfUoSxW7tFGByzPmXvp4e7+9NeU45d9c1Ggz1CV8+GZ3Zv8fbceE1X8R0+/9GPEVM7mshNkocb4lqjIckgs1sY=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr2773254itg.1.1531858443250;
 Tue, 17 Jul 2018 13:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
 <Pine.LNX.4.44L0.1807171528530.1344-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1807171528530.1344-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 13:13:51 -0700
Message-ID: <CA+55aFyLp7DMp4jgJjV_Dj_KvMD--umZkqCDKBPbzH+sOZu24g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:37 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Why not?  Instructions are allowed to migrate _into_ critical sections,
> just not _out_ of them.  So a store preceding the start of a spinlocked
> region can migrate in and be executed after a load that is inside the
> region.

Hmm, yes of course. But the isync instruction description I found also
talks about the previous instructions being "completed".

But yeah, that obviously can mean just "in the store buffer", not
actually ordered.

           Linus
