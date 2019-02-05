Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039AAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C18217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P1SlXlLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfBEPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:06:28 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35124 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfBEPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:06:27 -0500
Received: by mail-ua1-f65.google.com with SMTP id d2so1214789ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeb+/7X6ctrg7EB9qRVefGZuI0rIyiOWA+QaZTZz7DU=;
        b=P1SlXlLdkcmEwOf2LPJrg8mjP1tyYOaJgHX45bCaXy8BxKY43+PBw94PAAzgFtL5PH
         u/t90K4cMdWAuCxbxhcYWK1ziO3sgQQLBzFuObwDxQhMUFyOJ254gKt9MOgr3lE8FPA0
         pe3WJ91wRJ96nj8XKaIwwq04LqgJRIqM0I1lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeb+/7X6ctrg7EB9qRVefGZuI0rIyiOWA+QaZTZz7DU=;
        b=KEOD8a0gSTJGC1cUxiTpe7UvDaCWnyBPi8iiDM9EyW+kP8+1JgBLb0EN32foDthxyR
         MKPJt2f/qxSkb+2XTPzhafsfRNbcXSTlOjRFVT5ZSV0RvTVsocLggD9ri9KPMELYPEGd
         Uc5VoFvK5gHPqBjBWozG7egt6EkbiVbW80aHw8n6HqXARpuD0+DOcSC79xEeIfaAthYi
         lI03G/Pew1CWWedStEqo8RyYlfFAlDART4Rm6NPFoNAnKZdA/yXzHOcZOdPGeGoIZ7UE
         W54LxKOBpbarBbweK2TzVemWya+eXa9mwvIM/lafGvhQTReSH5tCLTF2Q9XVnEISKdhL
         Lbfw==
X-Gm-Message-State: AHQUAuZESiik3KGds7kutzG6yVw07nY8v5v+9ub5scfCz4UcNcbCxnvh
        FZ1nwvn0zYhXnZ6DaO4TGEspQYaurAI=
X-Google-Smtp-Source: AHgI3IaMi7sUxQe1XxBD/Pbaoxd72FTS76uVXLji+rgVCMEl6y+y46qwkUShbbvXhism9NhILx0lgg==
X-Received: by 2002:ab0:7801:: with SMTP id x1mr2118637uaq.128.1549379186513;
        Tue, 05 Feb 2019 07:06:26 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id n15sm640561vsi.5.2019.02.05.07.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:06:25 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id z24so1199302ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:06:24 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr1958192uap.14.1549379183897;
 Tue, 05 Feb 2019 07:06:23 -0800 (PST)
MIME-Version: 1.0
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
In-Reply-To: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 5 Feb 2019 15:06:10 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
Message-ID: <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable kernels
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     William Cohen <wcohen@redhat.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng@reliableembeddedsystems.com,
        lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi,
>
> I notice this commit as a possible culprit of the illegal instructions my lttng
> users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> in a Yocto environment [1]. They were able to reproduce the issue with perf
> as well.
>
> commit e46daee53bb50bde38805f1823a182979724c229
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Oct 30 22:12:56 2018 +0100
>
>     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>
> I *think* the intent there was to do
>
> -       memcpy(code, &optprobe_template_entry,
> +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>
> But if you look at the commit, the "&" seems to have been stripped away,
> which happens to change the behavior significantly.

Yeah, this was a typo on my part. :(

> Has this change ever been runtime-tested ?

I thought I had, given the details from the original bug report, but
clearly it didn't exercise it.

Thanks for fixing this!

-Kees

>
> It has been backported to:
> - 4.19 stable as commit 3fe0c68aea21
> - 4.14 stable as commit f9e0bc710347
>
> Thanks,
>
> Mathieu
>
> [1] https://bugs.lttng.org/issues/1174
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- 
Kees Cook
