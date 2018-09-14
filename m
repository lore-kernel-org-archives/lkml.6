Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C2ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7332146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7332146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeINVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:25:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35279 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:25:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id j7-v6so9240121qtp.2;
        Fri, 14 Sep 2018 09:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1XoAkgSkbz2+TuaV2zTmugVabS7TtdYX94so4kcebk=;
        b=HGwxSL39RHl4rSSq1/YzB0e6BWwbyGwpnWGosL25wqVsJdp4VZFmN18IqofIGbFcrJ
         NSbRxzjQF/xrCFliQoYacbrIMlMIbmPfLdfeYO5JgTP9gH1YcAEjvft2/ObOTM6qjaSr
         r/hyoJyoMpctJ+oazfwaAlj6ETXe6Jh6YrqlIinn6PzvH8zGbbxqSPJYAfRiQePnljw5
         9jvXOT8KvaS+GEmUFyry1i8xgoi6ynEi5WW03MURdCT7fyIPks+71RvKhtwi6+KGDb5J
         P/6kOchy3LWuqcTW9T1WwE9r9ONdyC9MsCvoE4+vzKqZfTrEuYKCXiC+aKRksAfref0e
         2CAQ==
X-Gm-Message-State: APzg51DhhGE2CDcaqDu+MXjWeecyxDuHkj7gBaHUJhApTNkU2wr6r39u
        fa7fVrKaIXZap06hMZxaKV3+uFZN3sjF4N6gqhY=
X-Google-Smtp-Source: ANB0VdZst5YONMQ6BD932PvR3LpJm8OXZTtYxZ4GVX5ahdbbrPjcQoVEHAIsQqDT6+oEPvGMr/aTW3K2Xkrg7mCT42o=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr9711481qvc.161.1536941391896;
 Fri, 14 Sep 2018 09:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536757532.git.ren_guo@c-sky.com> <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <20180914143719.GA27689@guoren-Inspiron-7460> <CAK8P3a0fZYbd4a2nBnExPVXKs-898R9vaCSa4kXyz0qA=rCzZQ@mail.gmail.com>
 <20180914160231.GA32161@guoren-Inspiron-7460>
In-Reply-To: <20180914160231.GA32161@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 18:09:35 +0200
Message-ID: <CAK8P3a0ZBBL8LHoV=tDr3Ner6wRK=QcrepciZqCPNEHk=B2n7A@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 6:02 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Fri, Sep 14, 2018 at 04:46:56PM +0200, Arnd Bergmann wrote:
> > On Fri, Sep 14, 2018 at 4:37 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> > One level below that, you can of course choose to build
> > a distro with only 64-bit time_t regardless of whether there
> > is still support for 32-bit time_t in kernel and glibc or not.
> Do you mean I could merge kernel port into linux-4.19 or linux-4.20.
> But let glibc merged after linux-4.21 and csky glibc only support
> time64 syscalls ?

Yes, that's what I meant. Note that it won't get merged into 4.19:
the merge window for that was after the 4.18 release and no
new features are getting merged for 4.19 that have not made it
into 4.19-rc1 already.

Getting your code into linux-next now is the prerequisite for you
sending a pull request during the 4.20 window.

     Arnd
