Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C62086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbSSgUrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4C62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbeK0VPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:15:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53776 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeK0VPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:15:02 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so33352287ita.3;
        Tue, 27 Nov 2018 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzQzFsZsVFmr1NzmqUcEjcivJzT3KsUE4+tZJ3j5oZw=;
        b=UbSSgUrpl5R8QdhVyinW6uL0jnmrbLfVOYHmaJHmbFN0UWFPLjMbEyni393xiH+QqW
         HL2aiP//qU76ZK/23eweXHEMnUGGWT64xZ5yQtbvd52LwRLqCquCDlCX4Yev3/8Yvgrc
         mahCGYnz254JfYCvEG0fmeAL97xy0gZlxSwezHaUSd5jwyJRz/TKH2QaSCQsTN9FIo9n
         ID8LIQMMmpaucMxOE67M2SnFm4+f/J6rfY3whIuoShX56HuR5QBgx1oSxlH3mNl+VO4I
         rg7VPgZnPhNryq6oiWtoi5qVdOZ1Ij6mILuxXJvkmhR7UX2YQ2jLkmv2HDSEtQSjeTDa
         Azlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzQzFsZsVFmr1NzmqUcEjcivJzT3KsUE4+tZJ3j5oZw=;
        b=QiesHCOhaiqrUvffkcCIkoop7BDBNlNYP27/zdYZOkMfUc7k0deAPHoxt1h8x0udJc
         Lq+uuCPV5oI+r/2gOUCSN1Ou3n4MD/vEHHynIViB6Y9v9r/hJI4m3EV78BjMruo7v6BO
         zJLeqPvtX6Ugd6zVAduF15sxS/vdZvzKrOLuapnEVlvwrvEhrrqIM55X8bMdl6bM/lg/
         WWHZ1GQ/IewxbhD6plbltu24wid5H8P0ZQMGblWbA3JJDAGESCxpqCy+7gTQv6tXamdj
         7ULjzX8dZE7ybDBVTyS0Q+TIyIc2F0FTkArE+rM78RL48y+7j7gHcICZsDzFpQrkSOKy
         UlLQ==
X-Gm-Message-State: AGRZ1gJqDE9NWVnrwI0IY7jzz3nTRnFsnBFkaZedLWoiAYs4j2BLHCJz
        goBKKPKpmGVnxqwOtEUsnZYsmGcMYHK9dyXWTXQ=
X-Google-Smtp-Source: AJdET5eg4NnlEsGx2dUVCM5EHYcQGcon+eKFDkeEwxvHDUmIKAy159TQkUBgr5Ws6XvncRbOxvjJbxpeRfELg4YiRu8=
X-Received: by 2002:a24:57c4:: with SMTP id u187-v6mr26234091ita.73.1543313857085;
 Tue, 27 Nov 2018 02:17:37 -0800 (PST)
MIME-Version: 1.0
References: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1543310472-31861-1-git-send-email-bianpan2016@163.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 27 Nov 2018 11:17:26 +0100
Message-ID: <CAOi1vP8Ff9HLF_v93RwyW4LwQ5jYPWPaZhqBgx9FsxmXH6M4AQ@mail.gmail.com>
Subject: Re: [PATCH V2] libceph: fix use after free
To:     bianpan2016@163.com
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:22 AM Pan Bian <bianpan2016@163.com> wrote:
>
> The function ceph_monc_handle_map calls kfree(old) to free the old
> monitor map, old points to monc->monmap. However, after that, it reads
> monc->monmap->epoch and passes it to __ceph_monc_got_map. This will
> result in a use-after-free bug. The patch moves the free operation after
> the call to __ceph_monc_got_map.
>
> Fixes: 82dcabad750 ("libceph: revamp subs code, switch to SUBSCRIBE2 protocol")
>
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
> V2: correct the format of the tag Fixes
> ---
>  net/ceph/mon_client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 18deb3d..05ef5aa 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -478,9 +478,10 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
>         }
>
>         client->monc.monmap = monmap;

monc->monmap is assigned here.  It's not obvious, but monc->monmap and
client->monc.monmap is the same pointer.

> -       kfree(old);
>
>         __ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);

ceph_monmap_decode() returns the new map, kfree() frees the old map.
I don't see a use-after-free here.

Thanks,

                Ilya
