Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD075C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF1208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZY+DnKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEF1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbeHAOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:09:58 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:37716 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbeHAOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:09:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id t79-v6so12484531qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WpjUkMT3no32SFHlBP8VQJdLKyMLvqfpMp+HqCR4oVw=;
        b=GZY+DnKLo6RmyX6DxlpyHo67q1iWXd95YjfQfBWkmuwwCZYfp6q419ZryVaep47uiW
         2X5IS9Wlmp1wO1xr/TR1yPFtKD809/0cd85biQdX/xrJjwpsKdgf8LvLe+la+LKdaD1y
         CLGRW8vhXiOaHuaSg6Ndow4Z7jWo+KMzr0iSyjh5OyROKGmD/cGr50fHQhUKbQh/mNkj
         sK/TrAfApOXehxtWmCOwxSYtfxyr1ZTARU4TckvarWbgr9iXEIh2PQXMXxuAunQN3GTH
         CYvNGgRK/4TFJzrdqd9WxNr0zLiPzjpIYphoXEhViST5rgNTvqj0nlR8FaNGRbLavukT
         7JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WpjUkMT3no32SFHlBP8VQJdLKyMLvqfpMp+HqCR4oVw=;
        b=k/EbOPjUhr2lwGe7X785Dw4/Ws6in3eey811lafWfXrc93055CG3nFE9YQ3D+I5G3J
         YBgzgfIe47HA6hH3td2DfjYyWoi4OrPcycfndrDaU1XXoq6WySxCW4brvZ9PsQ1uLGF/
         /SG5tSEnoc2LAfTI5nntjbpyhWYzVsfcH2YC/aRhM04RiccvPwQw0IlQ6se46UmNvVDj
         K96SwlUBJULa72hJ+GOsV2PlPfxWcM3OhDpJpWqlMA7be2vp5udzyAD3SPduv213YBoD
         jARWyuDE5s0KoNNdqCZXcGXjux75pz731sDsEXVQU/8vXCl2cUOlBgwKhWi9X+WKDxHA
         NkzQ==
X-Gm-Message-State: AOUpUlG8sD+PMDBM+iE1uRqfIxrvjfiZ8ZHh9C7qeDPolXlFM18V0p8h
        RmT+eJBqCLTdY92A9vAlywJfPn6IDdwzCdlUBCE=
X-Google-Smtp-Source: AAOMgpckWDQvw+Xqeicjiv2cMOYt1Qc1TnUtl/b8E+cpoujuT+QC6FmSsou9wdnpVDwrgIGlUo3bH5n+HKH9BgoQmXo=
X-Received: by 2002:a37:5c44:: with SMTP id q65-v6mr22825836qkb.97.1533126265097;
 Wed, 01 Aug 2018 05:24:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:24:04 -0700 (PDT)
In-Reply-To: <CAMuHMdWo=YZJB8Hv098EWDz2O5d8=QaHbMB6XGMTV+2ifsVh0Q@mail.gmail.com>
References: <20180730064632.2555-1-geert@linux-m68k.org> <CANiq72mnLATzFJKwO-h1f2q7b2-YrVBfUt4muCLNCC0FAVYwww@mail.gmail.com>
 <CAMuHMdWo=YZJB8Hv098EWDz2O5d8=QaHbMB6XGMTV+2ifsVh0Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 1 Aug 2018 14:24:04 +0200
Message-ID: <CANiq72=7Lw5ZGMW72+MM_-jJ3wiqeRhowVUGCRpcmo9f2GPpVg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc7
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Aug 1, 2018 at 8:56 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Miguel,
>
> On Mon, Jul 30, 2018 at 6:05 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> On Mon, Jul 30, 2018 at 8:46 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > Below is the list of build error/warning regressions/improvements in
>> > v4.18-rc7[1] compared to v4.17[2].
>
>> Also, a suggestion for Geert (or whoever is maintaining the bot): it
>> would be nice to see from which target the warnings are exactly coming
>> from. Many/most warnings come from many/most targets, but at least
>> knowing 1 of them would be nice.
>
> I used to upload the summaries containing that information to kernel.org,
> but stopped doing so when kup was introduced (and I had to spend time to
> learn how to use kup).
>
> I've attached the summary for v4.18-rc7.

Thanks!

Cheers,
Miguel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
