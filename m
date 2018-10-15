Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2803208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XbIqwVMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2803208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeJPDTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:19:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJPDTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:19:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so18602484ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvfCXmYwHXkcK+HuPA6zIxFmycSQxz2gz+u0JHfF4cY=;
        b=XbIqwVMg3/aZQNSSQ1dd2++n6f2eF/sWkGz+6zALpoPFFeQIZhCJzMt+2o03tPDYgi
         lz7PJzn1ZQ4Ek+VxfeXvuRamozbiUMrWKjsvG0q7gkMzgf3oYYHXa9O1anxuqCc6EN1H
         q/wot+U3GxU7wranICfrDo4BnSlQsPkh20O1Iz/6uaki9YH+pklWY9kNpfSdsrwfcoSH
         nK1e10i0wlN5PuEwMpTEDV1gphpWLU9ghxl0nEFeC1IT2cU/X6nFANtVCmMcr2VWAF5T
         63/jliuPjIhssxZJEL/OzlXEd32Mf+PT4LEVjZPBhm8EUCn5FeBYPpRVy8/CR/xq6yFF
         Yupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvfCXmYwHXkcK+HuPA6zIxFmycSQxz2gz+u0JHfF4cY=;
        b=dgrfgCG4qeodqC/e8v2i357OfR345zRgW8XrocHHSzr2HRaWw67DpPwq0Zn1UJnLBJ
         2lg4iiVn1784DLdiFPn0tK1Ro+IcCktugV0JvJRq3uPFEm6xKt7wnFbm4TtTdLz2X0uY
         QTFreRkz8eoMsIsRrL0wPLESrnA0YaZ1WwAa1Qdlx3uTMY5ZYhsOhuOjATxcvryrHNga
         qQ4vTrtkN6Ih9/E6CNsJR5PDPcJ+jrGrEsqqCSFQX2c8YiWUWWnQxPlbSakSeUkWL3Yc
         r9gYB7yh3rn3HYZxgzh6PxTJfuPTnN+Si/qvE4hPI0uYGXjCiVUIw5aAFi9vx3qDYnyl
         FWjA==
X-Gm-Message-State: ABuFfogOjBSd8mXmOGf4kQCZj1AUlV9XNJrBL/i6fjcxBRTZDhfqCwiY
        n66W80XIWl1HPKzHXjrCM+9+BF6sIpeFt7YsM8Y34w==
X-Google-Smtp-Source: ACcGV62hvfyQFtMUw/wlZPLxjMfajChOAnHz5l4AJh66bzK09LQRFvcCdao7qBN7e+HisTeU/0YZP4ZmlSs2N/kX3qQ=
X-Received: by 2002:a2e:8981:: with SMTP id c1-v6mr11985011lji.124.1539631962811;
 Mon, 15 Oct 2018 12:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181015192710.GA18693@avx2>
In-Reply-To: <20181015192710.GA18693@avx2>
From:   Christian Brauner <christian@brauner.io>
Date:   Mon, 15 Oct 2018 21:32:30 +0200
Message-ID: <CAHrFyr7nXUPxysMNv-HHRVSCB3UUmSb60qwFM8zg3Zv41NC1RQ@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 9:27 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > int kstrtoul_bounded(const char *s, unsigned int base,
> > char **trailing, unsigned long long *res)
>
> NO! The whole point is not have million variants of slightly different
> integer parsing functions.
> Cap it in the sysctl -- noone would care.

(Please keep the CC list when replying.)

Whatever works; I prefer the local strtoul_cap_erange() in kernel/sysctl.c as
well.
