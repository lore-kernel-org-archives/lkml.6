Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773A8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC1206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NM9cyw72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AC1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeIHCiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:38:03 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35677 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIHCiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:38:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id o17-v6so5990034yba.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcWFk/c6OlQZKHjNMAozKzn9hc/2tKEH442cyg7HNrE=;
        b=NM9cyw72Jh/jrpEZKiVleuak5QJAt7Mnvp01lY9H0OyWW4nnxBzPDkoEpDk1f8fUck
         xKsQaN8gc0Y5Vq77cWI3bNVTWVfT6ZiRfDS4K/O+z2F7iIQ8MAfRtxjM+RftBpF7kFR1
         mM3Ag7gZ9VAculiy7mBwmMLvlk5CW2lsUIJGXyDSwWJW8iuA5WJ56xqyqAuvAahKgGTq
         RxT3JmQarGewzkHlTdfO6WsCkfBkfz60OhhIw3AeRr0e95CzJmwgY4UCdE64GWgBOVMF
         oH5QlaOg25M88SFGhP1APkKDvy0Zq40GGuXfK3ImWKLW99px0JsV1QQYiGJ02bIFh3vf
         XHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcWFk/c6OlQZKHjNMAozKzn9hc/2tKEH442cyg7HNrE=;
        b=rNL2YpNNfCJqGMFgfY4HtrV3hJIN4xpfWaySLvlCfC535Yz99W/ceCPIkGCcFDpF0t
         3hYF4DwBqo3Q5Lqh/oBiRJTmKunSADw6Hgs4uYazeV3XukcIlaGMduBfIwqCa8OzAETW
         XP1huvZUP/haqN+EGKxTwPVTrSEw9Y7IZyMdBIOdbfwckeCt9VFQZwNAQtdUNehIxAop
         HD02/LccZRlaKa4Ry8aikEw5liAUm8H+2mvAfzZatq2iMjz9RNs6Cxp7DziwjtHcH4w6
         RYLRjwDiYdmYOelWJHs921GBUPSCtqKfVdguO5yjmh2Uw3zp311JP66JKg1pMWhbEF5y
         WAQA==
X-Gm-Message-State: APzg51B5BsR1sqH+361x0MAYcnp8M6BJwkca/VC9NLgib9p4j7MXigQ4
        J2kV6CnmAG1i3qOMnQIOgwTL/aRSVpH1q+oF0RAc7vy7
X-Google-Smtp-Source: ANB0Vda5zmSdJtd0nwg0eJGhsD43OWQKTmTtCxPRbSDqIe6z9Qy0VTgqpKKup9EZK9vunuL5FtJR4daJJz+EgLRxlyA=
X-Received: by 2002:a25:483:: with SMTP id 125-v6mr5049246ybe.110.1536357303855;
 Fri, 07 Sep 2018 14:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180907211012.965501324@linuxfoundation.org> <20180907211013.141014795@linuxfoundation.org>
In-Reply-To: <20180907211013.141014795@linuxfoundation.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 7 Sep 2018 14:54:52 -0700
Message-ID: <CABXOdTdnU51wjwy7g3oXK2+6dC9Qps_Zy8nN_zZevDXUvN8Y4A@mail.gmail.com>
Subject: Re: [PATCH 4.9 03/63] 9p/net: Fix zero-copy path in the 9p virtio transport
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "# v4 . 10+" <stable@vger.kernel.org>,
        Chirantan Ekbote <chirantan@chromium.org>, groug@kaod.org,
        Dylan Reid <dgreid@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, dominique.martinet@cea.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 2:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>

Do your scripts have a bad hair day ? The subject says 4.18.

Guenter

> ------------------
>
> From: Chirantan Ekbote <chirantan@chromium.org>
>
> commit d28c756caee6e414d9ba367d0b92da24145af2a8 upstream.
>
> The zero-copy optimization when reading or writing large chunks of data
> is quite useful.  However, the 9p messages created through the zero-copy
> write path have an incorrect message size: it should be the size of the
> header + size of the data being written but instead it's just the size
> of the header.
>
> This only works if the server ignores the size field of the message and
> otherwise breaks the framing of the protocol. Fix this by re-writing the
> message size field with the correct value.
>
> Tested by running `dd if=/dev/zero of=out bs=4k count=1` inside a
> virtio-9p mount.
>
> Link: http://lkml.kernel.org/r/20180717003529.114368-1-chirantan@chromium.org
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>
> Cc: Dylan Reid <dgreid@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  net/9p/trans_virtio.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -406,6 +406,7 @@ p9_virtio_zc_request(struct p9_client *c
>         p9_debug(P9_DEBUG_TRANS, "virtio request\n");
>
>         if (uodata) {
> +               __le32 sz;
>                 int n = p9_get_mapped_pages(chan, &out_pages, uodata,
>                                             outlen, &offs, &need_drop);
>                 if (n < 0)
> @@ -416,6 +417,12 @@ p9_virtio_zc_request(struct p9_client *c
>                         memcpy(&req->tc->sdata[req->tc->size - 4], &v, 4);
>                         outlen = n;
>                 }
> +               /* The size field of the message must include the length of the
> +                * header and the length of the data.  We didn't actually know
> +                * the length of the data until this point so add it in now.
> +                */
> +               sz = cpu_to_le32(req->tc->size + outlen);
> +               memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
>         } else if (uidata) {
>                 int n = p9_get_mapped_pages(chan, &in_pages, uidata,
>                                             inlen, &offs, &need_drop);
>
>
