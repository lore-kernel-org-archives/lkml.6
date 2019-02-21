Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85297C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E87B207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HtJsTwMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBUWnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:43:04 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39503 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUWnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:43:04 -0500
Received: by mail-vk1-f195.google.com with SMTP id i68so66409vke.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeeHN5A8TYuXfyBLqkC461JBDCYqSC4jUmx5jzSnVf8=;
        b=HtJsTwMZ/y6bodUGz8ah6aWBE3c5suzmjH4E3AscE/Q0tKHjQ0EQyLo22c9SGNSZID
         feywrxucg+iY26CdlDvcsjAEzrTIy5kXaAVoUzrKJUmenp3tjnpB62AMFm+D8MJJ7GYJ
         GOqZIAqTnGopfeQD2vySUflTZPZUYpRUV3zEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeeHN5A8TYuXfyBLqkC461JBDCYqSC4jUmx5jzSnVf8=;
        b=kGf7f9vMjb2oHMkmlQdgbBi0EW9mnH6tTQ9J2VOafWqLpb/UldDlgMH3jmu+m4wI8y
         TsbtHkIomtq0nlKwKndd8DFbULYnPprN0FDmET8LgdKlfN/LLmQuWhJGCKfDipmbiwPV
         +uTFog746UjWH1ZLQy159AMtWfRPUQlYr7fmA0h63+fjyKGKqMfB41odBiVegWS6w1qm
         sEyhtSfbAIQG5gedvFN4lYvO9junFZcB5vOLS7pSftJT6AGszlXwDa0BiqaB4wN6qWOZ
         JGJ2vmVDDeZ/BHYOpDz5GIHuUKq8eJWEK345jQCoZaTqNvw5epKquLX/EOnspWTpWk6b
         PCNA==
X-Gm-Message-State: AHQUAuZ0dUqe2/hRH8vjkaX8RHPpQBGIB3+oWDq2pQOD1q35yq/VpTl5
        OFizzgrZr73wV3veFvi02QLla+NNtt8=
X-Google-Smtp-Source: AHgI3IbHJJRIecKgfJjE/rSMfYkFMxr/Zg62d6SkyasXdOY0Ohhx5KNIZA8tH2LcG3XwBp4E5WYYfw==
X-Received: by 2002:a1f:55c7:: with SMTP id j190mr602823vkb.42.1550788982052;
        Thu, 21 Feb 2019 14:43:02 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id l193sm98769vka.19.2019.02.21.14.43.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 14:43:00 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id v131so69924vkd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:43:00 -0800 (PST)
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr621947vke.40.1550788979940;
 Thu, 21 Feb 2019 14:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20190221203334.24504-1-helen.koike@collabora.com>
In-Reply-To: <20190221203334.24504-1-helen.koike@collabora.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 14:42:47 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL2xQL9rgwQsqfraGQwzOd2+yr-2qkKvZYNwXYGTV8TZA@mail.gmail.com>
Message-ID: <CAGXu5jL2xQL9rgwQsqfraGQwzOd2+yr-2qkKvZYNwXYGTV8TZA@mail.gmail.com>
Subject: Re: [PATCH v12] dm: add support to directly boot to a mapped device
To:     Helen Koike <helen.koike@collabora.com>
Cc:     device-mapper development <dm-devel@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        richard -rw- weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-lvm@redhat.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel@collabora.com, Alasdair G Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:33 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Add a "create" module parameter, which allows device-mapper targets to be
> configured at boot time. This enables early use of dm targets in the boot
> process (as the root device or otherwise) without the need of an initramfs.
>
> The syntax used in the boot param is based on the concise format from the
> dmsetup tool to follow the rule of least surprise:
>
>         sudo dmsetup table --concise /dev/mapper/lroot
>
> Which is:
>         dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
>
> Where,
>         <name>          ::= The device name.
>         <uuid>          ::= xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | ""
>         <minor>         ::= The device minor number | ""
>         <flags>         ::= "ro" | "rw"
>         <table>         ::= <start_sector> <num_sectors> <target_type> <target_args>
>         <target_type>   ::= "verity" | "linear" | ...
>
> For example, the following could be added in the boot parameters:
> dm-mod.create="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0
>
> Only the targets that were tested are allowed and the ones that doesn't
> change any block device when the dm is create as read-only. For example,
> mirror and cache targets are not allowed. The rationale behind this is
> that if the user makes a mistake, choosing the wrong device to be the
> mirror or the cache can corrupt data.
>
> The only targets allowed are:
> * crypt
> * delay
> * linear
> * snapshot-origin
> * striped
> * verity
>
> Co-developed-by: Will Drewry <wad@chromium.org>
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Thanks! This appears to have everything Chrome OS needs. I've asked a
few other folks to look at it too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
