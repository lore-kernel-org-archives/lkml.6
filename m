Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BBFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B409218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENKwg+qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfBFVTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:19:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42844 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:19:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so7409861lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fo8Lm4KBmvjTZ0mZCuqp4B4b09dyPVpXHLK0FgH2YtI=;
        b=ENKwg+qDnJsXZX9to+9JBV9jqAFaAhb4kL7aj8fCMG4qCUZCT5yEAdGV697SnBh6Jp
         9xPPxM4jaoWIAUz5kCpeKFlp69bn6ZA/dOqFVF8KUx7+rYmuBBWXbTBBacfN5YbgZcXq
         f3WeiS98VvKVlGwEVaOuWpHAw1JESf+p8wvXC/67rECcNfvrYXeYR+TcLEPBaaUM2rLy
         ByWZ8P4dD5YvjZNSUpynLgiOAz5bjahicL4+56d3ILWiLeoYvJB4qRuO5XNkF65oejOp
         +mkub7f6dcuGSk036Bn1UHQtK+sey5bkki1LwTasZi6EiPuWrn3TNZ8kMvbHmplfAho5
         5JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fo8Lm4KBmvjTZ0mZCuqp4B4b09dyPVpXHLK0FgH2YtI=;
        b=nBKLq1StpQ6qHVWA3wVNFjrAAp7uQvLxIUhUKgwDMg/eyNwiIm0y5s10S5Rya5eFk+
         WsxXW0W1CTw8LISeavouHtE+6oAFulkkXOnefOYrX3F9LG2XRTAraxny7PK3PQF2TKsU
         +YQlrAnX10lbpi/d4kII8e9le/6wnKEv8q99KqSLKtP8drh0c/wbEpBv7cwO4/Vfny+Z
         Pig5aIzPZTRqUdcnXefvqTYQUu14/NzwnjI0UovoNVtgNVDLTE0yTD/g4mtVw6OuurIt
         eQBOidDkCON7v3wa7UX1Il65tLVifeS/EgmQFWQ5pzUBbuLM5o3qLVJMOrQ7qInckdoA
         eXgw==
X-Gm-Message-State: AHQUAuaWwOttEP2UXZDaDjY0Y0Lj2FzhyXru62g27FKoupb7wQ38bR+U
        Qq0wvIRG2W2UiG3XpA8/P5BWF7xV9pwPHb+VbNnhdjAseNI=
X-Google-Smtp-Source: AHgI3IYtQslrCprwOmjhabNUPYLxwhykT7KHFrc3DyqXcKeZyQNrmucdeE+sZZ3mZPSYYD4RxEJnbAfcxB/K3UXm0I0=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr6715134lja.19.1549487988741;
 Wed, 06 Feb 2019 13:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20190206175627.GA20399@gmail.com>
In-Reply-To: <20190206175627.GA20399@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Feb 2019 22:19:37 +0100
Message-ID: <CANiq72=gS7=G6WbZ4jqybMBh44FeF7UeVEfeb1hN8uMAMt_2bw@mail.gmail.com>
Subject: Re: [PATCH v2] include/linux/module.h: mark init/cleanup_module
 aliases as __init/exit
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 6:56 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8fa38d3e7538..1b5e370f1bc0 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -129,13 +129,13 @@ extern void cleanup_module(void);
>  #define module_init(initfn)                                    \
>         static inline initcall_t __maybe_unused __inittest(void)                \
>         { return initfn; }                                      \
> -       int init_module(void) __attribute__((alias(#initfn)));
> +       int init_module(void) __init __attribute__((alias(#initfn)));
>
>  /* This is only required if you want to be unloadable. */
>  #define module_exit(exitfn)                                    \
>         static inline exitcall_t __maybe_unused __exittest(void)                \
>         { return exitfn; }                                      \
> -       void cleanup_module(void) __attribute__((alias(#exitfn)));
> +       void cleanup_module(void) __exit __attribute__((alias(#exitfn)));

It turns out that there are some modules without __init/__exit marked
functions, which GCC complains about, since now the alias is in a
different section than the target:

  * In some cases, this is due to a missing __init/__exit marking
(e.g. drivers/connector/connector.c). These should be fixed in any
case.
  * In other cases, the cleanup function is not marked as such because
it is called from another place in the TU, like the init function
(e.g. arch/x86/kvm/vmx.c). We would need to create an actual cleanup
function (marked as __exit) that simply calls the current exit static
function.

So we have a few alternatives:

  1) Going only with __cold.
  2) Using the new __copy attribute (because then they are copied only
in the cases they are actually used).
  3) Fix and go for __init/__exit. While this requires some tweaking
as explained above, it would be good if we can achieve it since then
we are enforcing proper __init/__exit markings for all modules
(whereas __copy wouldn't spot).

I think it is worth achieving 3), but that will take a bit more of
time. In that case, I suggest we push 1) or 2) for the moment (so that
the warning is fixed) and then work on fixing all instances. As soon
as that is done, we can push 3).

What do you think?

Cheers,
Miguel
