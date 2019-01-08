Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12152087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546940521;
	bh=cDT2Ih3wTMws+wDRKH7Dx52/MQWyBH4CUcYhUnw69yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=McM3OghKFWcJCz/Ctxi1fvoCayK/K2X8mZOb/DLNCcPet00zYyik3epGGiXeqLPvQ
	 +tlgjg190RKeMrj1IMVZXVNOeLu+IcP1iuU53QdPdBOJz5I6nFXn1vy9z26DVTfa7a
	 tU88a7ye9F8mLHvxcKxvjUuo0hQASrGF2oISeu94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfAHJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:42:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38962 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:42:00 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so2938397otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGc1jTQhyM25nf+TjaC46ic6uVxzRFFNtDt1Z+8If7Y=;
        b=uQn1MzeO3X8DernbBQ2/njwxPvzTGbI/pf7l580R79I7KmxYUB9JH2TAes8m1686Ja
         YWagam5sbGg+sWS9vwiIlbUjBg6vMlcIgeE0ENzPjgS61mc3SW/Ln/G+c4IRqLC/KB2J
         CCcY5X/zqjX+0kQqD4Ci17GZ6MjBIs6Oo3kkYH2+++7vB2tmhE3vMo/VQUIxuCcthR6K
         zhJVsH0dyxjGJnwptTtkYG4FCTXgVAsGAd3uOqdVHqXDRXDQebiFXzXnW3B0tN4eKRQV
         e3IcdhkH8urQil5yv3z5e9CnZmm5g8NsP46RCIkTc8HEeBVWSCb/+ZzLufEQB/rEqp4I
         QPqw==
X-Gm-Message-State: AJcUukeKNOY4Yr+Tz7xEZFRro+22bZq+kYnpPssaZiu/HifJPmOIEvpH
        BLjqx9vlF/eWlAYbWv9Z97shdV+FEJ+SE14bNzE=
X-Google-Smtp-Source: ALg8bN4oKhiyVpl9QLDpXrs/6xEWTkVpKLMMcDPXe6uViXvLnU+eFl3tZTRKvWQH/4ErNv6uW9b2P69Y0+2Rm3wvp9Q=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr682319ota.244.1546940519184;
 Tue, 08 Jan 2019 01:41:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1546915794.git.tsu.yubo@gmail.com> <2ba5177197f8b40e399867ea1f1aee2920c3cb49.1546915794.git.tsu.yubo@gmail.com>
In-Reply-To: <2ba5177197f8b40e399867ea1f1aee2920c3cb49.1546915794.git.tsu.yubo@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jan 2019 10:41:48 +0100
Message-ID: <CAJZ5v0hCRYwLx5iqb7jY5VArSqN9sWg4rWw0kvUph7biLYeLtQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kobject: drop newline from msg string
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:11 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> There is currently a missing terminating newline in non-switch case
> match,when msg == NULL
>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes in V4:
> Recovery  originly declaration, requested by Greg.
>
> Changes in V3:
> Improve the commit log, requested by rafael.
>
> Changes in V2:
> According to Joe's suggestion, drop newline from msg string
> ---
>  lib/kobject_uevent.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 499dfcdafcb0..118226a02707 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -200,7 +200,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>
>         r = kobject_action_type(buf, count, &action, &action_args);
>         if (r) {
> -               msg = "unknown uevent action string\n";
> +               msg = "unknown uevent action string";
>                 goto out;
>         }
>
> @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>         r = kobject_action_args(action_args,
>                                 count - (action_args - buf), &env);
>         if (r == -EINVAL) {
> -               msg = "incorrect uevent action arguments\n";
> +               msg = "incorrect uevent action arguments";
>                 goto out;
>         }
>
> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>  out:
>         if (r) {
>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
> -               pr_warn("synth uevent: %s: %s",
> +               pr_warn("synth uevent: %s: %s\n",
>                        devpath ?: "unknown device",
>                        msg ?: "failed to send uevent");
>                 kfree(devpath);
> --
> 2.11.0
>
