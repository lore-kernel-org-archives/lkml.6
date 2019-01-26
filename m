Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B319C282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14337218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 00:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oOzOa5vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAZAif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 19:38:35 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42761 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 19:38:34 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so2539405vky.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DheyDUZs0hMflfS1BvQnTgJ0tAbsmWQIPECsUp28vqc=;
        b=oOzOa5vj43wWpgSPSDtO+zGrUkyzuj+cWpSvXRXW0Bl6gCJV7jc9yjkbWiRWsHkyEm
         BRsrz7m5y9DR02trukb9z4gARF97jbWP17UwaXVGQE/9Rk9ChrzB6pCFkJ78bieDimDz
         I/xOEBbmu6v272Ndpx6ONQLSyCqZ5wBUFy57k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DheyDUZs0hMflfS1BvQnTgJ0tAbsmWQIPECsUp28vqc=;
        b=VmkjjKzB+OpydTxVfzTk1YSigHPzOFXoBep4o6H/gTSA04k0ifm/VoNuyjgAtMp1JX
         mgYUIFyBwcQLnY075QxITY35iXVbaZHwi4OByHi+VIeZyhf4+g+2DQbsVLbx9BCkeTMM
         c3DkUvrBbdq0xE3CQ079EdQSEDLAgmt7a02OH0YBWecb7Cq6aNWk8nM+j7mdr/PvXQww
         HuRA+3bEgpJNGMmoUSJe+x+oeE1aUb2MU49tTdoyYEWWlV0Hl9/PZscQ0AK1BPqB15v2
         oTYKw4ZsO3p9SFilfSXTtfoVUv2foAi8cOXZ7M3ZAzkwo82sPGLcimL+28yOiBC7R/mz
         wrrw==
X-Gm-Message-State: AJcUukdBskQyBwoCX1fHzVS5sN+l6A/NZzwuU6Witzd9Bjq5cTdDRu5p
        m4BN7PvC6KLORByrC2nvbqrVAoPAGoU=
X-Google-Smtp-Source: ALg8bN4+665vAq+B4nALtqH9poThZATjkF+SfmvK4MEdUz/VwOfsfGU77QcADze8R20zrD4YluuOyw==
X-Received: by 2002:a1f:1c81:: with SMTP id c123mr5322370vkc.52.1548463113053;
        Fri, 25 Jan 2019 16:38:33 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id w77sm6073537vsg.29.2019.01.25.16.38.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 16:38:32 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id n7so3856694uao.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 16:38:31 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr5356393uaf.106.1548463111521;
 Fri, 25 Jan 2019 16:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20190125204846.GA4106@embeddedor>
In-Reply-To: <20190125204846.GA4106@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 26 Jan 2019 13:38:18 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJXsLw7N-M9Ev_BMapC3L2Q1t_qn0rbJEjwOQY1=us76w@mail.gmail.com>
Message-ID: <CAGXu5jJXsLw7N-M9Ev_BMapC3L2Q1t_qn0rbJEjwOQY1=us76w@mail.gmail.com>
Subject: Re: [PATCH] ASN.1: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 9:49 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> lib/asn1_decoder.c:386:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> lib/asn1_decoder.c:449:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  lib/asn1_decoder.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
> index dc14beae2c9a..8f3d207d2b00 100644
> --- a/lib/asn1_decoder.c
> +++ b/lib/asn1_decoder.c
> @@ -385,6 +385,8 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
>         case ASN1_OP_END_SET_ACT:
>                 if (unlikely(!(flags & FLAG_MATCHED)))
>                         goto tag_mismatch;
> +               /* fall through */
> +
>         case ASN1_OP_END_SEQ:
>         case ASN1_OP_END_SET_OF:
>         case ASN1_OP_END_SEQ_OF:
> @@ -450,6 +452,8 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
>                         pc += asn1_op_lengths[op];
>                         goto next_op;
>                 }
> +               /* fall through */
> +
>         case ASN1_OP_ACT:
>                 ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
>                 if (ret < 0)
> --
> 2.20.1
>


-- 
Kees Cook
