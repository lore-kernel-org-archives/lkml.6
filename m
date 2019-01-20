Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA67C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1420883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPeUIWS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfATAnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:43:39 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33977 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbfATAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:43:39 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so10718990vsi.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0spsRCEMQnkejZhPS9QWqYpt5x3Y6BmVKKyqV+i176s=;
        b=RPeUIWS4N3RmNGQBzt48W2rYR/9p3aO/9m1FN/ef2YkYAQXQtl8YNMC2wCwp7njw0H
         6g8m246Pt6ws/Lvvf44R7gIMGFyrrrIDlSBFsy0VNBOBAWbEL6FvFyF3qSkutS5o+wNN
         0VqPqf/9fRdQFq23+c+1GCIbdi+oa3lAjD3kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0spsRCEMQnkejZhPS9QWqYpt5x3Y6BmVKKyqV+i176s=;
        b=LYqh5XIOm86wMLRW+KF2YCKncvlsb1fyHxIrFWCEsICKlRXGQuq2tArbtuwIkkP2Bw
         llRhsdQ1mMe+fTkUnDTG3a7lWCaFvOVa7Ybv2gn/edm89sCVP81XDVVOZeHcyAVK9iuF
         FZ8/FzCbrjoQSkn0X9XMNzLfglXgZDOThcdDJk6EXouvHEsv2SgwRYjrpOhcHtEdejRd
         9V9I3E61QoRebkmc6hrlSZLPs4sLt1aWx/XyPPOV9Nju915LkHHvTXE/5UT8TfDw4jNu
         gWgMxj/f9MmqpwAkB3r/Lab1WrYnmN89KZY3Ki4hP7uQusprQJN93ZFJvDuQtdv3PYIO
         ZtmA==
X-Gm-Message-State: AJcUukdFDX/kYntl3/gyF1n7CelWSmZ62yU3QUc0y1/sxLgE0wUli7Tn
        S+SvqT6XJ18eJG4E+UUr7p+P3+vYNso=
X-Google-Smtp-Source: ALg8bN7mqbRfsE/PmbXMIU9hRMQWqKtxdmqwsQegNfrC3xn3Fhr4EQTwk8T/PXisJXLeaNcOiIRGAw==
X-Received: by 2002:a67:f114:: with SMTP id n20mr10545611vsk.90.1547945017398;
        Sat, 19 Jan 2019 16:43:37 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a137sm11137824vsd.24.2019.01.19.16.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 16:43:36 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id u11so10661616vsp.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 16:43:36 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr10490444vsc.48.1547945015904;
 Sat, 19 Jan 2019 16:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20190119001217.12660-1-tycho@tycho.ws>
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 19 Jan 2019 16:43:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKtQZ5oKethjopCW75eDtj6fEdCANRqah+wUh2pYfdGiQ@mail.gmail.com>
Message-ID: <CAGXu5jKtQZ5oKethjopCW75eDtj6fEdCANRqah+wUh2pYfdGiQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] seccomp test fixes
To:     Tycho Andersen <tycho@tycho.ws>, Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 4:12 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> Hi all,
>
> Here are the fixes I previously mentioned I would send. I previously
> assumed that the tests were mostly run as root, but it turns out
> everything else besides the stuff I wrote in the seccomp tests either
> sets NNP and doesn't require real root, so it all actually works. This
> set of fixes should make most of the other tests work unprivileged,
> while XFAIL-ing the one that requires real root.

Awesome. This all looks good to me. :)

Acked-by: Kees Cook <keescook@chromium.org>

Shuah, can you take this series?

-Kees

>
> Cheers,
>
> Tycho
>
> Tycho Andersen (6):
>   selftests: don't kill child immediately in get_metadata() test
>   selftests: fix typo in seccomp_bpf.c
>   selftest: include stdio.h in kselftest.h
>   selftests: skip seccomp get_metadata test if not real root
>   selftests: set NO_NEW_PRIVS bit in seccomp user tests
>   selftests: unshare userns in seccomp pidns testcases
>
>  tools/testing/selftests/kselftest.h           |  1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 42 ++++++++++++++++---
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
> --
> 2.19.1
>


-- 
Kees Cook
