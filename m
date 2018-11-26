Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1465C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E8B2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeKZVeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:34:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43465 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKZVeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:34:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so15322347oie.10;
        Mon, 26 Nov 2018 02:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgIERePgpk2uqf/nREl6qjaL77RHDiIugA7bYB9vdt8=;
        b=WR6h4E1NENnwOfghY1lQ3mtacwiAItzYDoXi1SWKmIDIIy4NaT4/Riv+VlHfAi2AjO
         qkryIxV0GigYSaZoLK2XWFH4CwoJnQ2SL13qJZnfwd3n0UZu7cIl1K1XqzNz3J4BWrqc
         otYyvJXQweQkLAO+S06tXhA6J0j8hBVLTtcuwcxqgD2K/zK7KUPmiJGCX0DL8XxAwVMz
         TkOVGKFrNrqnxoH39E8LIkD2lY30nb55FjLmNYbeV5RIZpyUgb3cjrE6W/FpUgH9wSzn
         Dcq2QHVI0l6msvpA7petbaJhWogmskc6SKMaZwCxzy2Oq4NbqbmVinuQ9frc65Et7vev
         Cjaw==
X-Gm-Message-State: AA+aEWaRYMaNqZ/WIfcCqGtJC8cU55dLTYwbLicQsACWojgisS6+EULz
        JCLwi6U8kmBeczdAHd4Wta3pp48+0BpjwXKrW6Y=
X-Google-Smtp-Source: AFSGD/UvAzwE2p1IQkJXWxa7CqOU4Uw23wJfQsghlYTrt+bqDtwbUUfID34Vhhd4jhetL67ZIKLiXjwHP2Mj/T79zY8=
X-Received: by 2002:aca:100b:: with SMTP id 11mr6037387oiq.303.1543228867924;
 Mon, 26 Nov 2018 02:41:07 -0800 (PST)
MIME-Version: 1.0
References: <1542860922-9730-1-git-send-email-yamada.masahiro@socionext.com> <1542860922-9730-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542860922-9730-2-git-send-email-yamada.masahiro@socionext.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 26 Nov 2018 11:40:55 +0100
Message-ID: <CA+7wUsz6amd-Kp3Gf4fK5VyuwAB8ZkJpgKkAy+DYJxvfaLEczQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: file2alias: check prototype of handler
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>, rusty@rustcorp.com.au,
        miguel.ojeda.sandonis@gmail.com,
        Michal Marek <michal.lkml@markovi.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 5:29 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Use specific prototype instead of an opaque pointer so that the
> compiler can catch incompatible pointer type.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/mod/file2alias.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 7e4aede..a37af7d 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -47,7 +47,7 @@ typedef struct {
>  struct devtable {
>         const char *device_id; /* name of table, __mod_<name>__*_device_table. */
>         unsigned long id_size;
> -       void *function;
> +       int (*do_entry)(const char *filename, void *symval, char *alias);
>  };

It makes sense to do this cleanup.

Reviewed-by: Mathieu Malaterre <malat@debian.org>


>  /* Define a variable f that holds the value of field f of struct devid
> @@ -1299,12 +1299,11 @@ static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  static void do_table(void *symval, unsigned long size,
>                      unsigned long id_size,
>                      const char *device_id,
> -                    void *function,
> +                    int (*do_entry)(const char *filename, void *symval, char *alias),
>                      struct module *mod)
>  {
>         unsigned int i;
>         char alias[500];
> -       int (*do_entry)(const char *, void *entry, char *alias) = function;
>
>         device_id_check(mod->name, device_id, size, id_size, symval);
>         /* Leave last one: it's the terminator. */
> @@ -1420,7 +1419,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
>
>                         if (sym_is(name, namelen, p->device_id)) {
>                                 do_table(symval, sym->st_size, p->id_size,
> -                                        p->device_id, p->function, mod);
> +                                        p->device_id, p->do_entry, mod);
>                                 break;
>                         }
>                 }
> --
> 2.7.4
>
