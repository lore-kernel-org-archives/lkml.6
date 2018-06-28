Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB9DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFF227814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Tf8w8cht";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEwrnMqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFF227814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967083AbeF1TC6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:02:58 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42361 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967033AbeF1TC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:02:56 -0400
Received: by mail-yb0-f194.google.com with SMTP id i3-v6so2417791ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TiHJhkWPJGa3yyy8nt1zk5vAZijdtJCQjeWAhj8uvD4=;
        b=Tf8w8cht7iWx5th5EqaoLvJXyuGzQNhFbIhPp/b5qjwveHDtgtn9yz87IG3xrgFhV7
         +L3zeV+7Vdhu76tbsdSlLzUu3+ZVI2/25LwbYpsj+fPVDSCL14UY+L95gyqSMLblh2cc
         JUWy/wmiFOR/874ClgTt5FUFuLlUHtzcI736s3zBfmD6v/XcE7PsIipbgesKA1typnhd
         WeZsdeoqjBN/Ld49Mpmk4tM85G0vTp3s7GV94XgBR0qXOd/Lze/nh1T2Jd2L8uVdMAiN
         3o80S+MTo9mHnJfnNqQpvYvDUKPq0NFMLO0CnqodwcJM+Rc3OF73jUrudFNJovzZIaX9
         vT8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TiHJhkWPJGa3yyy8nt1zk5vAZijdtJCQjeWAhj8uvD4=;
        b=bEwrnMqTZVfTfOEeeMKEeBoAN+eL7ApgbFmYo/MNXynvMg6F9Tfsu1u/siKcXq/wau
         5OoGUqG2QAtsMRGIl8Iozr0/ZIgVn+eupJv8kbetkyCKD4GfmBGD0HyqoJNH1/5EOls8
         AVSNBj5uhWAiIfGmnIEhQ9734nqhapDrIsAPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TiHJhkWPJGa3yyy8nt1zk5vAZijdtJCQjeWAhj8uvD4=;
        b=b4MSbFVJlWRVwv07+8HjnSyP9F20kcW1ORThnjhLwYb1v46HWKjljxm88GfzzXQmrp
         1IYik5inUHChNJ3hmMZyUg7PZ0lveJqzaGKZ2bRR8k/UTlFZchUv/a6bN1G8c7ldu+lF
         ldrB8sdEfHMgowhJGCeNj4FABwRilwf/iSMqDwFgDbnQfAg+3MPJIqk4jVvh3Hn7v7SW
         t+G1VTxytNG6x+9R/s2mo53zQzWmSjmyIIso93mnkhSuJ79zaxsqjfphR84nrzYm23O4
         1r3QkZWIR3248UkMNb+156sKWNLOXxjb8YIFBtBMzXqF8rkhDDMVh0ZpF17UIda/qeRx
         Jjjg==
X-Gm-Message-State: APt69E34rcMYYvvUKYi1kuYotyzsYFCvj6UugeX6DdrAQkFiOP0VPTc3
        xlDAislemFOuM8p8srWLe71XuvxzoWLpAXKnhbJgjw==
X-Google-Smtp-Source: ADUXVKKQgSPsMl10qA1bkkwl+tRjffvZxurueC9unHXkBOXRNNxQ803JGKBY3Qw95qPbPmBfwBw9NhMS7VgYK7dzaoQ=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr6106203ybi.193.1530212575680;
 Thu, 28 Jun 2018 12:02:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 12:02:55
 -0700 (PDT)
In-Reply-To: <1530189936-25780-8-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de> <1530189936-25780-8-git-send-email-nmanthey@amazon.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 28 Jun 2018 12:02:55 -0700
X-Google-Sender-Auth: WzxjqykLya2dMpivXYQxblbxQro
Message-ID: <CAGXu5jJBvkxpnZS31hJuUo-5vTes=mLeoM=28HXD+UfzKYsv-w@mail.gmail.com>
Subject: Re: [less-CONFIG_NET v2 7/8] seccomp: drop CONFIG_NET
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Josef Bacik <jbacik@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 5:45 AM, Norbert Manthey <nmanthey@amazon.de> wrote:
> With the goal of dropping CONFIG_NET, we have to drop the dependency
> in the configuration management. Since SECCOMP_FILTER also requires
> BPF functionality, which is usually activated by CONFIG_NET, imply
> BPF from SECCOMP_FILTER directly.

Nit: "select" not "imply"

> In case both CONFIG_NET and CONFIG_SECCOMP_FILTER are activated, BPF
> will be activated as well, so this additional dependency does not
> destroy original builds.
>
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>

Otherwise, sure. As long as this still compiles and runs, it looks
fine to me! :)

-Kees

> ---
>  arch/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 1aa5906..8cfb634 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -397,7 +397,8 @@ config HAVE_ARCH_SECCOMP_FILTER
>
>  config SECCOMP_FILTER
>         def_bool y
> -       depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
> +       depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP
> +       select BPF
>         help
>           Enable tasks to build secure computing environments defined
>           in terms of Berkeley Packet Filter programs which implement
> --
> 2.7.4
>
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
>



-- 
Kees Cook
Pixel Security
