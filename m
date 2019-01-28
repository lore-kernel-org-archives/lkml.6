Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE116C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB73D20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfA1Q5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:57:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35515 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbfA1Q5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:57:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so19024578qtc.2;
        Mon, 28 Jan 2019 08:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRdUzs8F3ggic15T5/5Iok69F9NtfF35ruUrPQ5UI0Y=;
        b=X8pWfoUzy9c8Uxb6JM7F9eChxI8pD3udwOtRbSGT+MbaAgEZGLFT7pvfy+fwWNV8mG
         mNVKq2wDxqFL1gIXtIgDhBgGcOXrAHqmwUCJqXwKX4gfcchMZYXkv7GnB79egtOLG7Jn
         /AOa0jmuB27BkZeCnOWsbUGZilQb4f3VOXgEBndnOJP8gVG5Ovk+/QVcnf9jcHima6nT
         nRPBQT7gcjpWobIecAPE1GaSNAMjPFzu4RSzy1W62HjJn/p5Bd06kRsd/dkXU/IG+mq+
         m2x2OE1SelS7a+pGdhB932W0MkZm9p5pZKLOO+PdgKJVPNdkVl6yCuqAiyqYQjWpbixZ
         xfeA==
X-Gm-Message-State: AJcUukcjz0zI6tqvbp03ToeaMtpc8IZiw7LwMqTtl8PKdkruGZnumh5C
        wN0X+AhEq1lYPpnB/44mi+JV5lxnOmt//XZ1bPE=
X-Google-Smtp-Source: ALg8bN4FOiA6SpeR4YJkpSDHrMFcEYY36F+UlZhrBE07U86hg/iH5tu1KSpBpyutPnjSHDNo2BBHo0bMvuXskBqkpTg=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr22053250qte.212.1548694632532;
 Mon, 28 Jan 2019 08:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20190128155924.51521-1-sashal@kernel.org> <20190128155924.51521-181-sashal@kernel.org>
In-Reply-To: <20190128155924.51521-181-sashal@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Jan 2019 17:56:55 +0100
Message-ID: <CAK8P3a2Xi-P9CxVgxxzf1iFg9htus670GHu7MAo2VPT1Tw+E-w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 181/258] tools uapi asm: Update
 asm-generic/unistd.h copy
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <ren_guo@c-sky.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 5:07 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> [ Upstream commit 89a0948984896352cac1ebe079cb3d64d6c3adc6 ]
>
> To get the change in:
>
>   b7d624ab4312 ("asm-generic: unistd.h: fixup broken macro include.")
>
> That doesn't imply in any changes in the tools.

This one should only be in linux-4.20, not any earlier tree that
does not also backport b7d624ab4312, otherwise the uapi headers
are wrong.

I don't think we want b7d624ab4312 backported, it would only
be useful if we backport all y2038 patches.

      Arnd
