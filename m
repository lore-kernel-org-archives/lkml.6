Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6429C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6552218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bVWglcuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfBARt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:49:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36295 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfBARtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:49:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so6560041ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=bVWglcuNXEYTcI2DPnNSJ687yDAFVE4LcRlyGlRu7KEiazzElLdp5QEWYsGNIuQGmi
         YR+S8F55RsjKDcMQ3sMl+WG3f/Ikw7suvXaNS091xV3aTRgKeoif4C/YT7Yd3imeJ2LM
         D8CjhFcy9U6Q/hQGqvhp8pBKE19I+a0LgJ04g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7lrexG/S2ZMmYpuKyHJIqG74wkYAVGMQ+BpnsBM9Cw=;
        b=e3D0y/wuSJ3ru+nRermO/Icd/4qnoVY+Yy6BxhoHFmiKWxrQEzRQjCxwKE7ux0O4T9
         C+mtjpK6jD4YZg8bC/P0mcxg2KQ5INqQpg0e9UAcdL7GWUP7IJdv9A2+20e4rmuccVPB
         YM48I7zyDA4uG1PpaZE/TwNKSuTCZZDErMpuxxahbk+obmgrAUNF57irSE8oyFJlwCon
         5XCmQdicVZt/uMPCcf6t234Ak4Mb/qohZLPklqSuDDPMRe7xR8kxt+aIXYDjEPQLfHYf
         K98NAS+MKI1/BfIhm6bnA18cCUTQ18gtyl5bWW88n8bycuBa5ohMoDm2QQ19o1jCwqJz
         LPUg==
X-Gm-Message-State: AJcUukfa+eyrOmeIAFK5PzU6LSDMLuEa8pL79vfgRdbw9dkIJjku7AgS
        exTxxeSmDzxzv2WF9f7c9U+IWR+PCUc=
X-Google-Smtp-Source: ALg8bN5yFMkgqTHD9wu2BC8M8K4wFFJtz8XjgKbDWBuc5xfveEsfPgravnyR3VK8rqMESkb8bGbYIw==
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr32480050ljc.131.1549043363151;
        Fri, 01 Feb 2019 09:49:23 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t67sm324723lfi.38.2019.02.01.09.49.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:49:22 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f5so5653281lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 09:49:21 -0800 (PST)
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr32303202lfk.78.1549043361378;
 Fri, 01 Feb 2019 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Feb 2019 09:49:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Message-ID: <CAHk-=whOU=Ek3C6=r2xkTtdv==He=KxUjz_8x2Jo3nJJiDW3VQ@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        stable <stable@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 3:33 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Thus, it makes sense to fix this also in tpm_crb, not least because
> the fix can be then backported to stable kernels and make them more robust
> when compiled in differing environments.

Ack, looks sane to me, and should help both the backport and probably
generate better code too.

In the meantime, I've committed the iomem.c change with a *long*
commit message. For all we know, there might be other cases like this
lurking somewhere else that just happened to work. Plus it's the right
thing to do anyway.

               Linus
