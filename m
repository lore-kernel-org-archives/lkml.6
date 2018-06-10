Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lxnBFO0vHVtqIwAAmS7hNA
	; Sun, 10 Jun 2018 14:04:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 40D9D60795; Sun, 10 Jun 2018 14:04:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA49A601C3;
	Sun, 10 Jun 2018 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA49A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeFJOEZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:04:25 -0400
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36706 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753511AbeFJOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:04:24 -0400
Received: by mail-ua0-f179.google.com with SMTP id c23-v6so11865607uan.3;
        Sun, 10 Jun 2018 07:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I32MOW+5xx2bj+zwjdbTw6N6pVUh4db8umkJFqrJQKM=;
        b=orTp7Fpj17p3s6MCA+eXi6QdQ55Yu6Id7xHnmPpXd91mloBoRXb0Hv1JhsIJM6V4Tm
         hkLpG5Zg9Njs4xc4G78j8mjubxkbXLoC6I7khxSrLiS6nB3L6cfXyVcvHK0pTPyyUJa9
         EBEBdvsMIrQ4zgSUUqKAjs66o5P0YfjRuLyF4ZsAzU5iKakk6AHdZ09k8Siu5p4CvtMs
         cBOYeEjos+Suyu8YEyGrOZXlN9/zT3veSB9mZXN/8famcjn/tPTTfeeOjsL+3OKJIa9l
         BthFzx230xIrKZU61cVSGCDiFNW8B6tBT17mjlCQv2mY4Iq3gw8deZQr8ktsBh9uovN2
         L5Pw==
X-Gm-Message-State: APt69E3OLl+cFH+/5SqpIKq5CmH1/uBdMYPrqt3LDTrulTXLSMHZ3NUE
        4+appcUwHzIbdZ1R2pfb14BCJ7qjSOJu31gmZ4w=
X-Google-Smtp-Source: ADUXVKIV6ju6LAxHVfvPJmrxOPulGe2/Vstitw91fyqQu8m3wLQ4CSnT+xzp4nsFWvIqKtwMp1GUKSdNuoSKzrjvibw=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr4575544uae.72.1528639463049;
 Sun, 10 Jun 2018 07:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <ae09ac81-c2a5-4a18-bb7f-61219b0c0ac4@email.android.com>
In-Reply-To: <ae09ac81-c2a5-4a18-bb7f-61219b0c0ac4@email.android.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jun 2018 16:04:11 +0200
Message-ID: <CAMuHMdV02LVvNXxFxMBX+N73N_b0E=YF5WTNqX85BOPjMPwnww@mail.gmail.com>
Subject: Re: UML build broken on master
To: Thomas Meyer <thomas@m3y3r.de>
Cc: alexei.starovoitov@gmail.com, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuehaibing@huawei.com, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 3:49 PM Thomas Meyer <thomas@m3y3r.de> wrote:
>The umh stuff seems to have broken this build config:
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/13394304/
>
> Bug or feature?

Bug. It's broken everywhere except for native X86.
Multiple patches to fix this are floating around.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
