Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968F820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0Z4JLfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfAQRLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:11:38 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34732 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:11:38 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so6710672vsi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NH/nNdAELJO+XX2r9h3AuIOg98tGgx6St0RefpZQA4=;
        b=T0Z4JLfnMp6XuQB31A8RKP7WphX7sY6WgvX+4tfIoDjyoCuLGyUfV8XhV8Zuh5jCCu
         Pf3umkvMa9TNjQ+I7YigjnavGhUcMYboLngOHaa70kHbPCdMQIzkEeiZg2B3MZ2+wM9u
         TIM/Pex5NBW1vlQ2ApRkW/34TwIJgqr5MMlxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NH/nNdAELJO+XX2r9h3AuIOg98tGgx6St0RefpZQA4=;
        b=pmDRsi5/J/4uxmCWKVe2LYgSRkLyC7/q8ZBaKrSAJ51Tf+23dHbg77T3k/8CHntXuu
         DsIJ9ckJwXfaNfYIUdqxbsloBz1a74d999WkGmo+5iwYLffwjwcKsM2Z+Dy2bmUslvDC
         iedc9E5yocouGEkP0YRA+rvZWIk/cO96OpJ4/V1jz2Ry/Al5TIDOwd4uCxgKi6/kkxfu
         9U9WTamIgi6WNRily2w61F40+E8VL+avKg1NXCifUFc3L88Wo7U3suZ5AEQBogMzgRye
         bl0FjS3YEiqMc5K6UVwGJqTJz0nvGptlEXyssCb5emu0fBOh1xBQTcwnbNfRpOaMGeNx
         Q9Zw==
X-Gm-Message-State: AJcUukfrfywssV0j0u17a+cAcEehtiAZ7OF8mS6c9Ht0RDZHMAS+XnHr
        ebPMtUkUidQ9Szq9sMvnXL6hQ9izb4Q=
X-Google-Smtp-Source: ALg8bN7N0BEf9dvBSIK0RZ2d5VBLUYXIMW+KqnXhMzFdRrgjeN4Oxdp3E5pxmTDEgMxwq75pB8yUDA==
X-Received: by 2002:a67:d804:: with SMTP id e4mr6481018vsj.7.1547745096059;
        Thu, 17 Jan 2019 09:11:36 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id n206sm57649943vkn.36.2019.01.17.09.11.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 09:11:35 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id n126so2419680vke.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:11:34 -0800 (PST)
X-Received: by 2002:a1f:298e:: with SMTP id p136mr6005109vkp.40.1547745093881;
 Thu, 17 Jan 2019 09:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 09:11:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+E1Eiv8T9OLDeM2-_qCUwh79zRhJ92Yixg496ZXo5ccg@mail.gmail.com>
Message-ID: <CAGXu5j+E1Eiv8T9OLDeM2-_qCUwh79zRhJ92Yixg496ZXo5ccg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Fix console ramoops to show the previous boot logs
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:27 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
> arguments") changed update assignment in getting next persistent
> ram zone by adding a check for record type. But the check always
> returns true since the record type is assigned 0. And this breaks
> console ramoops by showing current console log instead of previous
> log on warm reset and hard reset (actually hard reset should not
> be showing any logs).
>
> Fix this by having persistent ram zone type check instead of record
> type check. Tested this on SDM845 MTP and dragonboard 410c.
>
> Reproducing this issue is simple as below:
>
> 1. Trigger hard reset and mount pstore. Will see console-ramoops
>    record in the mounted location which is the current log.
>
> 2. Trigger warm reset and mount pstore. Will see the current
>    console-ramoops record instead of previous record.
>
> Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Whoops! Thanks for catching this! I've adjusted the patch slightly (no
need for a local variable), and will send this to Linus.

-Kees

>
> ---
>
> I guess commit msg can be improved.
> ---
>  fs/pstore/ram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 96f7d32cd184..441a44215456 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>                      struct pstore_record *record)
>  {
>         struct persistent_ram_zone *prz;
> -       bool update = (record->type == PSTORE_TYPE_DMESG);
> +       bool update;
>
>         /* Give up if we never existed or have hit the end. */
>         if (!przs)
> @@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
>         if (!prz)
>                 return NULL;
>
> +       update = (prz->type == PSTORE_TYPE_DMESG);
> +
>         /* Update old/shadowed buffer. */
>         if (update)
>                 persistent_ram_save_old(prz);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>


-- 
Kees Cook
