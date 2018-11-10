Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1AFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A6621104
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afi0yMJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A6621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeKKEwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:52:47 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45705 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbeKKEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:52:47 -0500
Received: by mail-vk1-f196.google.com with SMTP id n126so1148187vke.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n5v/iLGMlv7PH3fcfhp2JAhZuyfFV7BC4VmUgPZq/jo=;
        b=afi0yMJZwGa54wYqGNQGfzIGxyPrgJdtD3ZOR9Qc0BwZ5RoXnC3a3iep+P88MNczn/
         QQeR1N32HuW/J+7K/geuSQXKMLAON4FopYeD0JsG+FwTBqcJLstiWqUcSxQFGm6rcsJZ
         FGHK3ZhT0pTMH55mE+z8iTePD5RKPVlirD1yJCIs6GZxqakRhXAsRhK/wgSDUmFQ7T2y
         0HOq/F819OU7V8d1H7UICLvKj5g6braE3GSOxUNAJ9FP3GXM0++ZIhTHBhlaMmsQ1pvW
         IhZuH70OKzY8KgllrOtk87kFhb8f1KBzCHAVZxJQ3vKhxhemKhkTqGlphQAqSe3q7t9R
         9PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n5v/iLGMlv7PH3fcfhp2JAhZuyfFV7BC4VmUgPZq/jo=;
        b=CakiFvNppRFsPOl7WYTt0PaYAlhqtC7QtvzefGbCdpKXQD+zZ/GQ4mAr438xOv/gYj
         gYkc1iKZ0YTtSQ3Np3tvXd6vd7UsxFNXiNyv7JGvzhbKYAGy1wS5isL+61BNFPKAraB0
         aVHCv5yhdHLnOceuimUzao+nUEtxxyHsqk3181LPsrWFhw3O9QfCog6ie+LlDMLtgGPE
         vxZGbnUgbide13e7rWPar7j1IX4LLLsXK7MHKUkR6IzFSaZXv5xFLIZCh7N/wopth0CS
         OsJ+jTIcE2Esb+yy3TX5ldJgNt73aRo8Vtz8H1oG8jZUeyzN35M4Gjfy39Np6H8J/x1W
         8FEw==
X-Gm-Message-State: AGRZ1gJXtZkr1N2MKpcgSzbaEv7tEc7Us9DwGvOHPzO+J1pu5mQmk8ck
        VjrlpMCDghOQAFpmQTfIUA2o5IEDEcUNcmjt77EAmg==
X-Google-Smtp-Source: AJdET5ex2RvGkQUeVFCtgLqr9p7l81Ss79otj6gtTdJiSwRuLhokBfPZbYvfXYmAomo8YEZzz5roevSxBWAkotwTZSA=
X-Received: by 2002:a1f:34c7:: with SMTP id b190mr2263365vka.55.1541876805708;
 Sat, 10 Nov 2018 11:06:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sat, 10 Nov 2018 11:06:45
 -0800 (PST)
In-Reply-To: <20181110190132.GA21185@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110190132.GA21185@1wt.eu>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 10 Nov 2018 11:06:45 -0800
Message-ID: <CAKOZuevup11kuHGb3QD5GuA1c7_B=Nnq-kDEB5Hbv=OqXVotQQ@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:01 AM, Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Nov 10, 2018 at 10:52:06AM -0800, Daniel Colascione wrote:
>> Now that glibc is basically not adding any new system call wrappers,
>> how about publishing an "official" system call glue library as part of
>> the kernel distribution, along with the uapi headers? I don't think
>> it's reasonable to expect people to keep using syscall(__NR_XXX) for
>> all new functionality, especially as the system grows increasingly
>> sophisticated capabilities (like the new mount API, and hopefully the
>> new process API) outside the strictures of the POSIX process.
>
> It's partly related, but you may be interested in something I did that
> is in the the RCU tree. It's called "nolibc", it's a set of syscall
> wrappers defined only in include files. It's not complete, but still
> enough to boot some small init wrappers. Mine can extract tar files
> and do stuff like this with it. Here is the kernel port in the RCU
> tree and an example of code using it :
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/testing/selftests/rcutorture/bin/nolibc.h?h=rcu/next
>    https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/testing/selftests/rcutorture/bin/mkinitrd.sh?h=rcu/next
>
> The original one is maintained here (not very active since it works
> well enough for my use cases now eventhough it's far from being
> complete) :
>
>    http://git.formilux.org/?p=people/willy/nolibc.git
>
> Maybe something along this could be done for the vast majority of
> syscalls and the thicker stuff be left to glibc ? That would allow
> simple userland to build without glibc using only kernel headers,
> or by occasionally defining a few extra stuff or glue.

Reminds me of LSS: https://chromium.googlesource.com/linux-syscall-support/

I'm not a fan of this approach for general-purpose use. There's value
in having *some* common function-level indirection before actually
issuing system calls, e.g., for LD_PRELOAD stuff.
