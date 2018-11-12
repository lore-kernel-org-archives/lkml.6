Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C88C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA1321582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHSowSuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA1321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbeKLQVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:21:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33748 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeKLQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:21:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so727970oib.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=en+M8qwLLTVyz4mNnIV9oXGc3BXJGTwM/2EcYJ81ZKQ=;
        b=kHSowSuom4FqPNxM1HfDTZTYlPyh+HPk405uNCGTaPvRgmqaWI+4yZCq2A69DhzPA2
         fYt6KU/4SpVWiGg0ZALkO/NG/ZBJrMe54lz8Dbzsfy3dgOEJXWDXx5pY5ZE0YDGgz1dW
         ZeB2xaMfIMYER9/QFjPJVsSz0jgaTPP+Q/ymNhrcUiyWC7DV8wqHfmuC/Wn+5o6uGhWU
         KM7IUNTAkPPsZtZBoipIUCgoqaIAuT9mNCB3naaMG20RnCdi5kobVt2wqnPFC8UiKtUc
         hqWrEli6QIxdn3VLC9FvdpeKd+Jon7zXCEhCaLViEcIVz/NXavIa8ASPVXvb4WGTLMws
         nu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=en+M8qwLLTVyz4mNnIV9oXGc3BXJGTwM/2EcYJ81ZKQ=;
        b=bXlTSNUrVC2FWZFHOjcq9XB0U3JFGKF6hUE/QwxEA2+PyQilw+hpcgXHmbKJ12L55j
         TV+iPQ3VQo9HCNMa/mY9bQ9cZKPWdvKub3owGn9cBlCVEAQxC0g2xhTEX1pOifxW2XeW
         rq94pe6kkw3Y2JICfYnGdosrojCk2j15Hpp/RXik2uglc7Cfkp6L1/QN6WPCvyoq8VHz
         Am6dO4QEmIHw3vprh1go1GvdlHO12iOe+YcioVupaaXrdhtjaeO6yK7QG6UA4I8eedwP
         A41d9vcTpEnlVlTbNgmIr0KtkKBFCiHrS6N+1Qy2/NwYFcPjAAmot7WhzCYhD9TRpYiz
         /Qrg==
X-Gm-Message-State: AGRZ1gJxgBXNZiJDBeLx/W0og9+0XYb5+raP40bqmlsp22h7LCE8GGPC
        Q+KN2kfE3d/HVxkYASGPho01bvWyndKsw7U05tU=
X-Google-Smtp-Source: AJdET5fss32b3UWdqZc+Zgo/XhsB1Hriji1NuUqQF0mXw2ZXg34m3rQ8RDTN1XoJb5e0Tixhq3C70900jVJvJ2wyuc8=
X-Received: by 2002:aca:b183:: with SMTP id a125-v6mr9373445oif.44.1542004164743;
 Sun, 11 Nov 2018 22:29:24 -0800 (PST)
MIME-Version: 1.0
References: <7958aa50-8808-e909-753c-e232b3d1f84e@packi.ch> <mhng-58f419dd-47a6-4540-91b6-08be173d4216@palmer-si-x1c4>
In-Reply-To: <mhng-58f419dd-47a6-4540-91b6-08be173d4216@palmer-si-x1c4>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 12 Nov 2018 07:29:13 +0100
Message-ID: <CAEn-LTqd3+t+zhmbbZ3CjPMnFOsUxy0pVNUkgvU5T7yQU_DkcQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: add S and U modes to ISA string
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     me@packi.ch, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:14 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sat, 10 Nov 2018 00:35:15 PST (-0800), me@packi.ch wrote:
> > On 10.11.18 07:45, David Abdurachmanov wrote:
> >>
> >> The patch adds the missing S and U modes.
> >
> > This is the same patch I submitted earlier (see v2 here [1], based on
> > Palmer's feedback). Palmer stated that the "S" extension should not be
> > exposed to usermode.
> >
> > Since two people arrived at the same solution, I wonder if the
> > supervisor mode should really be hidden from userspace, as it's about
> > the CPU information, not about the environment the calling code is
> > running as.
> >
> > [1] https://lkml.org/lkml/2018/11/10/96
>
> I still think S should be hidden from applications.  This patch was fairly
> mechanical, so it probably just wasn't though about twice -- that's the problem
> with user ABI stuff, lots of times the obvious answer isn't the correct one :).
>
True. It was mechanical based on warnings I noticed while booting Fedora
with latest kernel and BBL.

Also true, that /proc/cpuinfo doesn't need to reveal all things to user space
(especially if you don't want various programs to depend on it as some
tend to parse /proc/cpuinfo).

Note, that on server systems which probably would implement SMBIOS
(based on the current proposal for RISC-V) the administrator could
check for S mode.
