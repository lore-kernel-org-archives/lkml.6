Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41538C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E974E2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUr/OF08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E974E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbeKNJyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:54:00 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43626 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:54:00 -0500
Received: by mail-yb1-f193.google.com with SMTP id h187-v6so6162515ybg.10;
        Tue, 13 Nov 2018 15:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9SSbxt6Czk/yLy1ifmYRVBwuOz00Y9gMqs42USdK/7c=;
        b=IUr/OF08qwuO0Te42e8J9IuRQZxAMcVt7orBfLhWvo5v8TVQRUVGnQJ/y6KYnA0YvY
         DymcnClu2ic2KlTvhw8ZK4Sr8NUmZ5+myMJ9msfzcsH8OYrM73eRzxAC0Aa+d+5NX/64
         oESiMOk5mSwg3apGKbbtkfCSIf0EyKkgE+T/1qjnsNkol7H/5frAEz31faWaAuHfxSs2
         nOSr1jr06e2iuXCSjgI6atIpczksagAj0EVKfDtvjq+/hlFGJv29lEAjlELkpej1yVK8
         8OuOJUELsQ2igB2IROb+LTmOHlgFPIsczmQ11INsrkapBYR0kxwS52RtaqyO2xO4oa9e
         TNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SSbxt6Czk/yLy1ifmYRVBwuOz00Y9gMqs42USdK/7c=;
        b=GmZmCsrczamhCJA9zKI2+JpsQ78uw4T2HLYcWnJvEZothbuj74GdgP0orWTuBuxvB4
         ah7SzWRWjea5GyNUG4zw8yjshPw5T48h/fKnlYHjxpgnPxSCqWUEdQWxK1UZP2TtdV4o
         AqjLxfCNKlVehDCYAJ8vqzhrbDVfbd9iR89w7t1MBAPVjVCARbTMyhYy51HVINOW17ZQ
         m8Ot75ZAZdXBbM0RH7mS5MViCfm9DuRwCHo3XmNCt/G4chAAIG8ZzxWJTe8BD9nvDhR0
         z0SkkfbeVUROJawIZVDLSRqn+gDerpX75O7ElOYHZObGWNh4/3sVs0qKk/sMP6W7Eq6v
         wE2A==
X-Gm-Message-State: AGRZ1gIx86mLya+uPYw5RuZEhawC1emvzZz8VW4yIkqzqVqxRGe0WLQJ
        Fd/6lE4Vwe2vAxfCF68w/XcVKl0lq6GvTNwsBhE=
X-Google-Smtp-Source: AJdET5ckWpgUBnIxDTeWSR6pOpI8FhtZhBuwZMNa5/Wj3yiGVXEeUXTN4yWn1T2TiwkcdcrJd5JkurU9n026WOJI2Cs=
X-Received: by 2002:a25:aa52:: with SMTP id s76-v6mr6936540ybi.405.1542153201298;
 Tue, 13 Nov 2018 15:53:21 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 13 Nov 2018 15:53:09 -0800
Message-ID: <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
[...]
> Firoz Khan (3):
>   xtensa: add __NR_syscalls along with __NR_syscall_count
>   xtensa: add system call table generation support
>   xtensa: generate uapi header and syscall table header files

What's your plan for submission of this series? Are you going to
submit it with other similar series in a common tree, or shall I take
it into the xtensa tree?

-- 
Thanks.
-- Max
