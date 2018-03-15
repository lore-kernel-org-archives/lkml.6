Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3162421-1521079090-2-16773935274864888749
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521079089; b=Eqqh/7n9ZHnqxhW5y1Qy8VVDAg6kVpRwK/+qZ9QLJLdel63
    5GIWIfRlxYstExsm9GOkpCpOiKejWIFTcKClHd/WruvRUQpZtZmr7CwPMYM19kTw
    UNYuCoIFXMGNFCwEl6TC6gCRx3JNDZTQ1lYw1Ixtdn1vxATjE/2zRq97OvQp1zLF
    X2buMregv6/0cRnAbI8xERCobQ6WPpTH0+EtCj6u/bENXZREojCXh1ExH8zRs+jT
    eIGvinmwR/XFf8twfEmp0hJr8CO+QswcYMZekmYgYpAwjfn7DHr56/XCB283eWIx
    OqMEIgLee7Yew1LOD44FwvOc2naCTVz2/UVbP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521079089; bh=y7nVuMG+z+Q6cxInEbwFQBRkgNtgY5pgEzdWOQ
    pF+aU=; b=p4Kk1hr3kA0doVL5nY0ceG+L5MUaC1bLJS0gohmSHaOn5BTmpjwU8p
    fgrcnAswzDyvqLZLdt3WZWMYs3ennlfPsohZ2fspGSa7qFSwTR4YJb+aVeNrr+El
    7IBOu5r/bbJBbOA6VmQZ7HMaFF9BmX+488YDujNyKj0vySHNlk0h/CNNc4AoPnB6
    OS2RgtjpUO+Hzk5pPtlu+Raw2TBZHq4yMQu2HITrGwNWPGdJmRaxwprqlOjHyZch
    AgVyhwWppaI5VNxabucGkQEuerxme7jYXsOrrrf3KwUm2JLDqaBGGQys/BZjlwoa
    Wrb48pwZQtFkfg6WR2l+Fyz+cW3AgcRQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Eq4iqJJw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WvRSLZU3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Eq4iqJJw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WvRSLZU3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeCOB54 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 21:57:56 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46944 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeCOB5y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 21:57:54 -0400
X-Google-Smtp-Source: AG47ELs0Et/1aAVeiEkGoL+HXq7SqgBSiwyLiGchOiH5vqk3vBncD1tVvxNN9DvTAIUpAXl4+zTRR3gnmCh+48gNt0M=
MIME-Version: 1.0
References: <20180315014817.142930-1-djkurtz@chromium.org>
In-Reply-To: <20180315014817.142930-1-djkurtz@chromium.org>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 15 Mar 2018 01:57:41 +0000
Message-ID: <CAGS+omAk+SQRVg2KyZYrtAfSZ-i_MhyUbN2tLTWQe0TLfnPq+A@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Fix __earlycon_table stride... again
To: peter@hurleysoftware.com, Rob Herring <robh@kernel.org>
Cc: adurbin@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        jslaby@suse.com, Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 7:48 PM Daniel Kurtz <djkurtz@chromium.org> wrote:

> Commit 470ca0de69fe ("serial: earlycon: Enable earlycon without command
> line param") added EARLYCON_TABLE().

> Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") referenced
> commit 07fca0e57fca92 ("tracing: Properly align linker defined symbols")
> and tried to fix EARLYCON_TABLE() using __aligned(32).

> However, the fix copied just works around compiler behavior.  In fact, it
> was subsequently re-implemented for tracing using a table of pointers in
> commit 3d56e331b653 ("tracing: Replace syscall_meta_data struct array with
> pointer array"), commit 654986462939 ("tracepoints: Fix section alignment
> using pointer array") and commit e4a9ea5ee7c8 ("tracing: Replace
> trace_event struct array with pointer array").

> Let's do the same "array of pointers to structs" approach for
> EARLYCON_TABLE.

> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Oops, I forgot to add:

Suggested-by: Aaron Durbin <adurbin@chromium.org>

> ---
> Changes since v1:
>   * Change __earlycon_table to an array of pointers.

> Note: I do not have a convenient system to test the of/fdt.c part of this
> patch, so would apreciate help verifying it.  Thanks!

>   drivers/of/fdt.c                  |  7 +++++--
>   drivers/tty/serial/earlycon.c     |  6 ++++--
>   include/asm-generic/vmlinux.lds.h |  2 +-
>   include/linux/serial_core.h       | 21 ++++++++++++++-------
>   4 files changed, 24 insertions(+), 12 deletions(-)

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 84aa9d676375..6da20b9688f7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -942,7 +942,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
>          int offset;
>          const char *p, *q, *options = NULL;
>          int l;
> -       const struct earlycon_id *match;
> +       const struct earlycon_id **p_match;
>          const void *fdt = initial_boot_params;

>          offset = fdt_path_offset(fdt, "/chosen");
> @@ -969,7 +969,10 @@ int __init early_init_dt_scan_chosen_stdout(void)
>                  return 0;
>          }

> -       for (match = __earlycon_table; match < __earlycon_table_end;
match++) {
> +       for (p_match = __earlycon_table; p_match < __earlycon_table_end;
> +            p_match++) {
> +               const struct earlycon_id *match = *p_match;
> +
>                  if (!match->compatible[0])
>                          continue;

> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index a24278380fec..22683393a0f2 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -169,7 +169,7 @@ static int __init register_earlycon(char *buf, const
struct earlycon_id *match)
>    */
>   int __init setup_earlycon(char *buf)
>   {
> -       const struct earlycon_id *match;
> +       const struct earlycon_id **p_match;

>          if (!buf || !buf[0])
>                  return -EINVAL;
> @@ -177,7 +177,9 @@ int __init setup_earlycon(char *buf)
>          if (early_con.flags & CON_ENABLED)
>                  return -EALREADY;

> -       for (match = __earlycon_table; match < __earlycon_table_end;
match++) {
> +       for (p_match = __earlycon_table; p_match < __earlycon_table_end;
> +            p_match++) {
> +               const struct earlycon_id *match = *p_match;
>                  size_t len = strlen(match->name);

>                  if (strncmp(buf, match->name, len))
> diff --git a/include/asm-generic/vmlinux.lds.h
b/include/asm-generic/vmlinux.lds.h
> index 1ab0e520d6fc..e17de55c2542 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -179,7 +179,7 @@
>   #endif

>   #ifdef CONFIG_SERIAL_EARLYCON
> -#define EARLYCON_TABLE() STRUCT_ALIGN();                       \
> +#define EARLYCON_TABLE() . = ALIGN(8);                         \
>                           VMLINUX_SYMBOL(__earlycon_table) = .;  \
>                           KEEP(*(__earlycon_table))              \
>                           VMLINUX_SYMBOL(__earlycon_table_end) = .;
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..93b7add47087 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -351,10 +351,10 @@ struct earlycon_id {
>          char    name[16];
>          char    compatible[128];
>          int     (*setup)(struct earlycon_device *, const char *options);
> -} __aligned(32);
> +};

> -extern const struct earlycon_id __earlycon_table[];
> -extern const struct earlycon_id __earlycon_table_end[];
> +extern const struct earlycon_id *__earlycon_table[];
> +extern const struct earlycon_id *__earlycon_table_end[];

>   #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
>   #define EARLYCON_USED_OR_UNUSED        __used
> @@ -362,12 +362,19 @@ extern const struct earlycon_id
__earlycon_table_end[];
>   #define EARLYCON_USED_OR_UNUSED        __maybe_unused
>   #endif

> -#define OF_EARLYCON_DECLARE(_name, compat, fn)                         \
> -       static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name) \
> -            EARLYCON_USED_OR_UNUSED __section(__earlycon_table)        \
> +#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)             \
> +       static const struct earlycon_id unique_id                       \
> +            EARLYCON_USED_OR_UNUSED __initdata                         \
>                  = { .name = __stringify(_name),                         \
>                      .compatible = compat,                               \
> -                   .setup = fn  }
> +                   .setup = fn  };                                     \
> +       static const struct earlycon_id EARLYCON_USED_OR_UNUSED         \
> +               __section(__earlycon_table)                             \
> +               * const __PASTE(__p, unique_id) = &unique_id
> +
> +#define OF_EARLYCON_DECLARE(_name, compat, fn)                         \
> +       _OF_EARLYCON_DECLARE(_name, compat, fn,                         \
> +                            __UNIQUE_ID(__earlycon_##_name))

>   #define EARLYCON_DECLARE(_name, fn)    OF_EARLYCON_DECLARE(_name, "", fn)

> --
> 2.16.2.804.g6dcf76e118-goog
