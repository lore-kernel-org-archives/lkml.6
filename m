Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D062920874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AhLXP7nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeLQSuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:50:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36603 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeLQSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:50:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so11971683ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUCDd1qVR7zra0gSo/zsbGu0tuzqW9bjcUU103oLgIw=;
        b=AhLXP7nc+oqTGaEt2DtKQyFN9pPdd63bF0SeX9hPGdzqoLVSGib4VXXJ+aTIztLOlQ
         ZrBDjsSbgKb9G1dNBOk4O7Ps6K9qJHnQFy/1NsK2j76fjR/fxixUrfJuna9/AK7mdCZ/
         gizOWY37n5WoZDP9IA0rzmXoVn/MEN78JQcWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUCDd1qVR7zra0gSo/zsbGu0tuzqW9bjcUU103oLgIw=;
        b=W9a+N3hugET4bRiKPPWzF+/0IgrJkUIyup/vZGKZdeQuJdnM1ygiYuUdXNr04NBTX2
         kLiSOks4jBwQ49tSgOHV9ELtv2dDCem5s2NCxt0t9plP4B7bAqIdyZ3QO7l21ff9Y7nx
         5AruWZGRCXuTDJ5lrfrHaI+mQTqZcdAXZMTj2lrAjlo1ohW+oQuij/3HLBQz0Ltp9caK
         jerR/G7odTM9m8jtehPxPSynMuQoWMVH9voEatqS76QUTU8cYPoVGx9G4Uu004T4ylEI
         Kb+3MLi/1ZNhYfwOgWSQ3jql1eahxPo7uSYLZp9qBnlDm1w7hCBRofpeBYhwW4VJpj2m
         zTEA==
X-Gm-Message-State: AA+aEWYSVrH5PuaeO6oimfIP1w3wrjuXwKe3UL734XLsKaPfDc5rpZ6J
        CRCwgvhMfhHOUJAexmCzFs2KNMN3Vko=
X-Google-Smtp-Source: AFSGD/Wgj5CQNkqWCL9wYxyrthIJ79dlUUVyXYJ6A92NpAATiwFTYIK2ciXCmDjYSccMBvLjT1fvrA==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr8261272ljj.9.1545072617810;
        Mon, 17 Dec 2018 10:50:17 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m77sm2807596lfg.3.2018.12.17.10.50.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:50:16 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t9-v6so11950923ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:50:16 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr8985170lji.133.1545072616266;
 Mon, 17 Dec 2018 10:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
In-Reply-To: <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 10:49:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
Message-ID: <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or maybe just remove it entirely, since it's clearly entirely
> incorrect from the very start.

.. or another alternative: remove the "Opt_err = -1" entirely.

Again, this seems to be a buggy pattern exclusive to the security
code. Nobody else does it, and using that negative value is basically
the source of those two bugs. It seems pointless and wrong.

So the *simplest* fix would seem to be to literally remove all those
"= -1" for the Opt_err initialization.  Making the code smaller,
simpler, and fixing the bug in the process.

Hmm?

                 Linus
