Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD38C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADFF204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACVdsr1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfARKsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:48:55 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53989 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfARKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:48:54 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so6082299ita.3;
        Fri, 18 Jan 2019 02:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOBcfNKV+2EQdlh7iZ2VWKfWv/9d30gdWgSFa+ssG6I=;
        b=ACVdsr1+vF1imka3fd/HpCf86uc3WOX9D5K4KzcQotNJdHg7DA+3d86MUwwdHq32PO
         IGtCLajBfTaZ5z4an+Oryktr18FB2M9sAJRsvW/D2pzTgXvnVe9ZKpWej6L7qgJopJND
         9Ina7S6+cribkUlMxHgm4tHJPIzFWbO4jHSfN6JT8stLplKGXdZId9dwEb+CJUy7CyFt
         WbF1eoh9OyH6MRxpsB0YUVWtaVvthBAis9fDGsnsPreL2zx4utawXRftLqTlGEWHC/4t
         RGV3t1so63d4BMDBATkfPGiR2U1I/8CDjA7j0Raxq8/tKSAXZsY39YIxg+V3o1zF2wBY
         7vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOBcfNKV+2EQdlh7iZ2VWKfWv/9d30gdWgSFa+ssG6I=;
        b=e5Aybs6T7rKxRaIwO3uyKKAKXToojn1blE1D1tY4vNee63ZJsEvf+GoF+7g1ia/b5t
         /omaqKlsHMwZ8IrZjHgDPf8ivnit3ETIFIbRblfAQuthsC2i57fKglOcxRtVp0/7oiIa
         wGMTi99+EV+UrnucsA5ChcY9oJp8mEHhc6QZUUfHF9nOEh3rpiZd8DjpB0WQq8K7h+mP
         GiiEkv+LeqRac+sw6/AbnimzrcfhLbaK9sXnfGDxIZTB2acd/gna15NKHII/8AyJ9PBY
         7+TUlxwOYzKsnwxfNFvzrcEnlCdePPGJkZiQd4iWoveQsGUxNjOTLQmuJAvLeYBG6BNd
         /ekA==
X-Gm-Message-State: AJcUukcypu4AgnUdgDMOR5wVZVod5MZCXoREhNIUJ+TQ+xerVM5HaTMU
        tCeRvDVuCrUBSXdsboGDjdWVPjrsZZW0ziRbRkWKY+ol
X-Google-Smtp-Source: ALg8bN4RFYCQ6jv7mwl84Q2CxXyvFVApjnmdsNblrsLy8fqov8q91d6yoMaSFAQ5hSqdQDYEx3YFatuhNRLIHd/Tvzc=
X-Received: by 2002:a02:7b09:: with SMTP id q9mr10440544jac.39.1547808533452;
 Fri, 18 Jan 2019 02:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231501.346447710@linutronix.de>
In-Reply-To: <20190117231501.346447710@linutronix.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 18 Jan 2019 11:48:42 +0100
Message-ID: <CAOi1vP_zHqKvoqZ3Bupip3=Hcoy6fY4jEF-kf46-A0g4ZTNpcw@mail.gmail.com>
Subject: Re: [patch 6/9] ceph: quota: Cleanup license mess
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Henriques <lhenriques@suse.com>,
        Jiri Kosina <jkosina@suse.cz>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Precise and non-ambiguous license information is important. The recently
> added aegis header file has a SPDX license identifier, which is nice, but

Looks like cut-and-paste from crypto/aegis.h patch?

I'm changing this to say "recently added quota.c file".

> at the same time it has a contradictionary license boiler plate text.
>
>   SPDX-License-Identifier: GPL-2.0
>
> versus
>
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
>   * as published by the Free Software Foundation; either version 2
>   * of the License, or (at your option) any later version.
>
> Oh well.
>
> As the other ceph related files are licensed under the GPL v2 only, it's
> assumed that the SPDX id is correct and the boiler plate was randomly
> copied into that patch.
>
> Remove the boiler plate as it is wrong and even if correct it is redundant.
>
> Fixes: fb18a57568c2 ("ceph: quota: add initial infrastructure to support cephfs quotas")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Luis Henriques <lhenriques@suse.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: "Yan, Zheng" <zyan@redhat.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> ---
>
> P.S.: This patch is part of a larger cleanup, but independent of other
>       patches and is intended to be picked up by the maintainer directly.
>
> ---
>  fs/ceph/quota.c |   13 -------------
>  1 file changed, 13 deletions(-)
>
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -3,19 +3,6 @@
>   * quota.c - CephFS quota
>   *
>   * Copyright (C) 2017-2018 SUSE
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>
>  #include <linux/statfs.h>

Applied.

Thanks,

                Ilya
