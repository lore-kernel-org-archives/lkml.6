Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB5BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3307A20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXW1n0Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfAFTdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:33:23 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34629 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfAFTdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:33:22 -0500
Received: by mail-qt1-f179.google.com with SMTP id r14so45728444qtp.1;
        Sun, 06 Jan 2019 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrVYSwQMPhRCTdCIBKJFNbmH6Rycli9NEDcMtuz9oVw=;
        b=kXW1n0FqRwMBijqFBoz3opBY2tNoWgIlo84vJW/OI5rwDsbjyf1jLFkRQ/SfW+XfH1
         YilyBuT713z8gvWmNAg1eAhX40GankL+nR1C9rSF4UXeW/uurcgj7lv9TOnyD+g66MLU
         zvbrIEBTYWFJRG6/j5W5RiE7UMxdSwpSChgODM+Tmb4Kx8Jurf77cYzL6havqobE0c7I
         nOiM558fst4GHTMFzgWVVLuOsMPBET6gS/HCHx5iGImidBJSB/nGudjDs2jK+lwHcJ7+
         EeRzq14GU37j2HUyg7YNke3RTVQ8nElxRrLvOpbKokT3EcPlYIT/noaW/grce+NSnto1
         7kzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrVYSwQMPhRCTdCIBKJFNbmH6Rycli9NEDcMtuz9oVw=;
        b=ZiPFrhuZdEM5TvTv+Mie+r+mRtt4deyZsiKiZLmCJklw/Ao43+bsZPiCuZYVd0ZPZD
         LYaCuo3KDW8yqF4cYoJ0hyB7HN6wE2VYAJcXidcDAOobEZCV3h4aO8QZh3KwdBP9xIYA
         FFNXTl9uGOAylTlxOl681z7JxX3PgaphGraZtNztu59TC5dvUrL4RQZZOlxulJC45Nfx
         q6prpLpsT4mljtM/AjfI/wPzXnvSIqUHt6EiCU2FVhilr/cm0uFOFbZLm/3LwMN31O6t
         4Gs8arQsh6ph+MW/DpdaWplDD1py8swIVu3spWW/5Eix+dbBJ7w7FINHExZ01L9sn6eX
         yKUA==
X-Gm-Message-State: AA+aEWaGxH3LUMXUGLWhs6GGfUTR0Dx8BdHzc5vjgFL0Kn/J1vrY4GJq
        hhET1jtEQIQWdL8BXiekmG4gV3HoOP64HT8KuDM3Sw==
X-Google-Smtp-Source: ALg8bN78kQ8pOizkVSnZIHr5Enz5dwgLe3VUbdqOCtpRK25d0UNNCwNLn5LqTdfLnwczoFCu+DsnB6+3k026ie2xado=
X-Received: by 2002:ac8:1:: with SMTP id a1mr56856982qtg.366.1546803201086;
 Sun, 06 Jan 2019 11:33:21 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
 <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
In-Reply-To: <824caf1d-f5db-a439-fc77-deda67df5bfc@linux.intel.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Sun, 6 Jan 2019 13:33:09 -0600
Message-ID: <CALaQ_hpy==CbwmF25eoYM6xb7dAxQZ3y1DmFMDDv-GtK8p3NPg@mail.gmail.com>
Subject: Re: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 -
 Kernel 4.19.13
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm only posting to say I'm still waiting...
The error came up while I slept, and when I copied that log and looked
at it (yes, it WAS huge, just as you said), the timestamps at the
head/tail were much later than the journal logged times.
So I made a little script to monitor the journal kernel entries for
that message and have it copy the file after maybe 5 seconds. And now,
I'm just waiting for that error to occur again.

On Wed, Jan 2, 2019 at 5:32 AM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> The event type 37 is a host controller event, most likely a event ring full error.
>
> So there are probably so many events that we fill the event ring before we can handle them.
>
> Could you take traces of this?
> Note that the trace file will be huge.
>
> mount -t debugfs none /sys/kernel/debug
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
>
> copy the traces somewhere safe once the error is triggered:
> cp /sys/kernel/debug/tracing/trace  /<somewhere>
>
> -Mathias
