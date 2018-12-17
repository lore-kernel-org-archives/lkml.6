Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CFB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QW3q71Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbeLQUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:02:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45365 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388591AbeLQUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:02:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so12115527ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Id803VgeqNGTOf+bYN9Bt7zLdpkyRWR5JR5dcOykPok=;
        b=QW3q71OkW/Fyy1QhQyq1ysovFnFQEy6uAILDyDjOIxTj/BJ6uvCbZXxjilYJz86jcN
         rpNh10Cfh+jy5rOHIwcyMD4ns2Wp4pqDb00wKj1LUpm+f7G6L0+IUmvuTxblUa27+/CP
         g9qy4Wwja1zWA8opIcDBJzFWD4pci6xOslYQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Id803VgeqNGTOf+bYN9Bt7zLdpkyRWR5JR5dcOykPok=;
        b=H2fHMDXPi4V97I9UpqbwMDDYo+vJ76ZFu64tx/iF0ZdzWxYX7w9qMwMSxXM0YqCerK
         AO/EZ+js2LHlXnGyJqZT7QsjoFsUyDQ0fsR9I67YcZw/9fFO2N1v0NlcMM15gCAJNhx0
         SJ+8aZhvdmfslF4TiPc/isHwPte7pU0fu+9jIFeUqCu8us818sfiBZCwrj8ANyrZ2cKE
         0MJoGgzRvofIcBEnoQ5dQ71mVIYhEND2u46QmQwFTRI4D/WmTuYaN74es6/7mr+fzdIA
         6reAKV5I2/w3q6H/OZ0C+/u30w3H3ix3tijUtiXjSBDpUC2TuUlCFvXER+jUnBw/QLvl
         jyzA==
X-Gm-Message-State: AA+aEWZC6tmi6ewX43+rmrEHMa98MqsuxA6hyJFmbo+uqHsFG7fw+Zf5
        11iVg7yOZctdu985pbtmmnBJGC8ufjY=
X-Google-Smtp-Source: AFSGD/UiH+bW1QVM/7VW4T0tpJ+bQkxfUBiK0J6pxFxUrWzUblhNFn5G4ctVXw/KOw2lfHePuOabHw==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr8359819ljk.128.1545076941423;
        Mon, 17 Dec 2018 12:02:21 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3005301lji.90.2018.12.17.12.02.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 12:02:18 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id u89-v6so1446569lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:02:18 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr9121271lji.133.1545076938018;
 Mon, 17 Dec 2018 12:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
 <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com> <1545076260.2878.15.camel@HansenPartnership.com>
In-Reply-To: <1545076260.2878.15.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 12:02:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
Message-ID: <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:51 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> If this is to replace Eric's patch, didn't you want to set token_mask
> to (1<<Opt_err)?

No, let's not add any extra code that is trying to be subtle. Subtle
interactions was where the bug came from.

The code already checks the actual Opt_xyz for errors in a switch
statement. The token_mask should be _purely_ about duplicate options
(or conflicting ones).

Talking about the conflicting ones: Opt_hash checks that
Opt_policydigest isn't set. But Opt_policydigest doesn't check that
Opt_hash isn't set, so you can mix the two if you just do it in the
right order.

But that's a separate bug, and doesn't seem to be a huge deal.

But it *is* an example of how bogus all of this stuff is. Clearly
people weren't really paying attention when writing any of this code.

                        Linus
