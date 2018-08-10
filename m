Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC7DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530CC216E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Pmo1YYHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530CC216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeHJKqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:46:31 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35921 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeHJKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:46:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id c12-v6so1022729uan.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5+vk8TzJLekk5CR7j60VyV+5jkEGyiKn3CZR+45tKo=;
        b=Pmo1YYHpk+PHLs6C0HDfPs9MNbGbA5uUA6HQFxvKQGzpSL8y4cqEfHdVY9skZJq8Kd
         ONGPYtEvA3tg9uisHNgAwTIvQJit4G796Ji7rDccUA0+GxfLtRr0/qhzV76+t1kuHxX0
         XAEp3ZZHmv2kVsy9N/UVYUvWmKmcvFjMx7eeO6vNQW95Fa1cGs4rIcOTE2lyAXymdnvG
         geQZUdSdx4ij2IoKwq2UzrmkbY3Rf03lYKIk/EF6OsAfVR8m+sNjIfZViyEN3z3Lq7lN
         oYNY1dgLp7b4d3XygKJtfg+J1d6ESz4Hd6fvQvWf3aRp481yml76flSTqK3cKduPuFzh
         tv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5+vk8TzJLekk5CR7j60VyV+5jkEGyiKn3CZR+45tKo=;
        b=nls2NExCfntk/p4bk9Sh9kueA080hYRZbhoFGGWcLrSnroTNfbCqUP2rR4ZBc3gNvE
         Z+ckPvdTzizVhqVipxxS0r5zaqPfAJK/OyTdVIeGBDACHHUtAW+jVNFdgwvexHOFFJE8
         iZY+RPmz4Iwp3/dibGS/cVH+/S7c8DK2j2BmOXyFTFTiA1FrGNHI1nK9bjjcYciNfM1V
         W/oM/EN4cdBlNYzYOoX+s00O7bsCtCyVDJE9gI0hHcQYD0nfIKm25F9p6oEMBtKSqwa9
         ly9GH8H296IhGPhdhvLgQcOj7JdCrmv8XL0JnaiGjndNLAehH2UfkPTP2MLEmzsvb11+
         /ZSg==
X-Gm-Message-State: AOUpUlHZP9ahkz6fA6pQHuXfHrthbY28Ik86d9q/NNAGb7iMsydoWuOw
        mqvW1pxyIbVgTuFVMUn3EHeHJZSgP8Z3EUKgm6GRWw==
X-Google-Smtp-Source: AA+uWPwQ61ld5vuVE+z5Tyr3U3XeQVklbDAiR94Hqrt3svXFbJuEsQkNCBkceuje9xUJK7VZJE2AUso4mifDWhCOGtc=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr3789446uap.33.1533889062117;
 Fri, 10 Aug 2018 01:17:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:984f:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 01:17:41
 -0700 (PDT)
In-Reply-To: <20180802205023.29094-1-mb@lightnvm.io>
References: <20180802205023.29094-1-mb@lightnvm.io>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 10 Aug 2018 10:17:41 +0200
Message-ID: <CANr-nt1SrDTa+im3THtOPgh=0vPP+iBfGjVJuLZkVnvF3Z0WXA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix rqd.error return value in pblk_blk_erase_sync
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 10:50 PM, Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
> rqd.error is masked by the return value of pblk_submit_io_sync.
> The rqd structure is then passed on to the end_io function, which
> assumes that any error should lead to a chunk being marked
> offline/bad. Since the pblk_submit_io_sync can fail before the
> command is issued to the device, the error value maybe not correspond
> to a media failure, leading to chunks being immaturely retired.
>
> Also, the pblk_blk_erase_sync function prints an error message in case
> the erase fails. Since the caller prints an error message by itself,
> remove the error message in this function.
>
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
>  drivers/lightnvm/pblk-core.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 72acf2f6dbd6..814204d22a2e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -886,10 +886,8 @@ static void pblk_setup_e_rq(struct pblk *pblk, struc=
t nvm_rq *rqd,
>
>  static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>  {
> -       struct nvm_rq rqd;
> -       int ret =3D 0;
> -
> -       memset(&rqd, 0, sizeof(struct nvm_rq));
> +       struct nvm_rq rqd =3D {0};
> +       int ret;
>
>         pblk_setup_e_rq(pblk, &rqd, ppa);
>
> @@ -897,19 +895,6 @@ static int pblk_blk_erase_sync(struct pblk *pblk, st=
ruct ppa_addr ppa)
>          * with writes. Thus, there is no need to take the LUN semaphore.
>          */
>         ret =3D pblk_submit_io_sync(pblk, &rqd);
> -       if (ret) {
> -               struct nvm_tgt_dev *dev =3D pblk->dev;
> -               struct nvm_geo *geo =3D &dev->geo;
> -
> -               pblk_err(pblk, "could not sync erase line:%d,blk:%d\n",
> -                                       pblk_ppa_to_line(ppa),
> -                                       pblk_ppa_to_pos(geo, ppa));
> -
> -               rqd.error =3D ret;
> -               goto out;
> -       }
> -
> -out:
>         rqd.private =3D pblk;
>         __pblk_end_io_erase(pblk, &rqd);
>
> --
> 2.11.0
>


Nice catch! I just added fixing this exact issue in my own backlog,
great that you've already fixed it.

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
