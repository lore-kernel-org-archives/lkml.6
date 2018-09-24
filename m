Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E3CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692892145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692892145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIXNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:01:46 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44389 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeIXNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:01:46 -0400
Received: by mail-vs1-f66.google.com with SMTP id v18-v6so7687632vsl.11;
        Mon, 24 Sep 2018 00:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wwj24f5g0ZiQpkO0aqADUB5HNc2kD6qfDDTVqriMcIk=;
        b=eLBOomQWHMwrf4c9XvzSdOZmdOAsKV0CUGedOUqeR7+FWd80fc6zlvFojUH+bznfeU
         LSNU4wmurd+RCrBLysTQdQTmmuCpXgsAHX+F+ka4g+t1FCoIuJ8IGRRe7tVCODsMy65S
         PMUAB1iyQyI/MiS9BDRv7FSK5wSJLlD9qaR/sa3SBI/f3NtQ0J8CMDcCwUx5BIo9kPly
         yjcR4BHL5u5TkiV6a+cOnCpGEC1JPLzPl2Z7o//3Rr8eQoDqErpX66j/+HamdBgafcbX
         zQoEC/VRHRPnyyF0NT5KFKxKyXgOMJVVrGI5xmW6hMrdDEoBXF6v4XKy7p+lJUS00hLu
         2azg==
X-Gm-Message-State: APzg51BuVI+A8RCmN/NsQDyISr5ERTTQf/KI2ODcZ3/R/Z9dD8UG5LCX
        tqH8kZA2urq9skBYPZwQKWEGTVRl77O8KGXg1Oo=
X-Google-Smtp-Source: ANB0Vdbr5wFsWRfulPg+ilgtGXkoFGtGpgWIa90m3ssbrDqCGYfMN0ccF548NePJJnggKEJbVgLiDV6P+1KTPhqldxo=
X-Received: by 2002:a67:3a51:: with SMTP id h78-v6mr1871323vsa.63.1537772463437;
 Mon, 24 Sep 2018 00:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-2-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:00:51 +0200
Message-ID: <CAMuHMdWLx6JcVTt0FsCD3rj_kgT8vRWapzApbZT=XGWios5R1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] m68k: Rename system call table file name
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call table entries are present in syscalltable.S. One of
> the patch in this patch series will auto-generate the system call
> table entries using the system call table generation script and
> which'll replace the existig table file.
>
> In order to come up with a common naming convention across all
> architecture, we need to change the file name to syscall_table.S.
> This change will unify the implementation across all architecture.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
