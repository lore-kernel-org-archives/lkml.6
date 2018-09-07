Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90816C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260E12077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Z+PLw7zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260E12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeIGRe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:34:27 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42507 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbeIGRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:34:26 -0400
Received: by mail-ua1-f66.google.com with SMTP id w7-v6so11799079uan.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0TJcHoBwXzdm6fmxZjOILmgHWhLqBEKjOKvTX7OK8A8=;
        b=Z+PLw7zm+69qWSYkbUryfYVMZ+HYSCLfBniMIxvrZGTlGxyMEXk741IXI1XHbGPEeS
         5ymy0fUZ7L1lDk8b5gdMxG1fMOlr3y9rxDMQrbPnNrmt3u3c4W3j8xiC8/TznuoISaKF
         5rhyJgOnAcNZgnkff1y1i69dV9BrVa6g2RqvJm1rScXnYNQD5LNt+Hi0VTKvLOLukTvg
         dTaBABfL2gykQnzeSQIJEzVMDU9xaXRjtVN7pyjlBx4XiIrR0ZtoZmeQLpdQ5CVyzfKL
         6+RIzSFyCocFI8MRV4dmWT0z2pvymLpRUjSMhSnTM/P45Efg03yjM5VMZykj0feAOaPV
         CnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0TJcHoBwXzdm6fmxZjOILmgHWhLqBEKjOKvTX7OK8A8=;
        b=mWweX+y5OjvOkl95294KxQzeV/yj6B6EN7d9Wwvmv4WcPb/6v2hTvEIvuavBwjlruk
         X1BSo0Sxm7WJhA/uDVdxNtclDx9cy82OKUTgRb6B1BvnNR1cux8oBCUqtDFRqoj1GjPj
         5QvCrB5JQfovp01P+RIfv9CgPM0HgDOAtYAqn3s2zCtdnduCc9kjhfYjJgRbHeY1vrYN
         ahCf2VKlLrfZpK4uEEG83AiLInwCBD73Y1ibbi6XmrJAZzqNlvCPipFUd+lUs846Lfh5
         OYrHKhTBHIZqOyjkKpVUxRekRlNWyXX71Wh9LYfNJhOq18dQ6KkcDbVDyjQCivarigDB
         ltDA==
X-Gm-Message-State: APzg51CBbuKZVmuUe39WstD5z9fm3UbJVzh1gId89qUOzyttY0C/Mn0+
        4P/zElPEWop0gwiN66WU+Cdc7AnKTPaIHux669QhU9vpfyc=
X-Google-Smtp-Source: ANB0VdbA9bYx4Lc3RlMRFF6wajlYibceFltjieUYevtRVp3lFN6vosFuu1aj1GYTON2uvaCy9D4tLtQZK3Us9Jv0TEE=
X-Received: by 2002:ab0:5097:: with SMTP id c23-v6mr2438798uaa.43.1536324816483;
 Fri, 07 Sep 2018 05:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com> <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 7 Sep 2018 14:53:25 +0200
Message-ID: <CANr-nt0DBCSux=acwkOohFy4BsG7KgzHKH_KA+OG3Y_h7ee1Qw@mail.gmail.com>
Subject: Re: [PATCH 1/3] lightnvm: use internal allocation for chunk log page
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:10 PM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
> The lightnvm subsystem provides helpers to retrieve chunk metadata,
> where the target needs to provide a buffer to store the metadata. An
> implicit assumption is that this buffer is contiguous and can be used to
> retrieve the data from the device. If the device exposes too many
> chunks, then kmalloc might fail, thus failing instance creation.
>
> This patch removes this assumption by implementing an internal buffer in
> the lightnvm subsystem to retrieve chunk metadata. Targets can then
> use virtual memory allocations. Since this is a target API change, adapt
> pblk accordingly.
>
> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c |  4 ++--
>  drivers/lightnvm/pblk-init.c |  2 +-
>  drivers/nvme/host/lightnvm.c | 23 +++++++++++++++--------
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index fdcbeb920c9e..a311cc29afd8 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>  /*
>   * Get information for all chunks from the device.
>   *
> - * The caller is responsible for freeing the returned structure
> + * The caller is responsible for freeing (vmalloc) the returned structur=
e
>   */
>  struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>  {
> @@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk =
*pblk)
>         ppa.ppa =3D 0;
>
>         len =3D geo->all_chunks * sizeof(*meta);
> -       meta =3D kzalloc(len, GFP_KERNEL);
> +       meta =3D vzalloc(len);
>         if (!meta)
>                 return ERR_PTR(-ENOMEM);
>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index e0db6de137d6..a99854439224 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -983,7 +983,7 @@ static int pblk_lines_init(struct pblk *pblk)
>
>         pblk_set_provision(pblk, nr_free_chks);
>
> -       kfree(chunk_meta);
> +       vfree(chunk_meta);
>         return 0;
>
>  fail_free_lines:
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 2c96e7fcdcac..5bfa354c5dd5 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -579,7 +579,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev=
,
>         struct nvm_geo *geo =3D &ndev->geo;
>         struct nvme_ns *ns =3D ndev->q->queuedata;
>         struct nvme_ctrl *ctrl =3D ns->ctrl;
> -       struct nvme_nvm_chk_meta *dev_meta =3D (struct nvme_nvm_chk_meta =
*)meta;
> +       struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
>         struct ppa_addr ppa;
>         size_t left =3D nchks * sizeof(struct nvme_nvm_chk_meta);
>         size_t log_pos, offset, len;
> @@ -591,6 +591,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *nde=
v,
>          */
>         max_len =3D min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * =
1024);
>
> +       dev_meta =3D kmalloc(max_len, GFP_KERNEL);
> +       if (!dev_meta)
> +               return -ENOMEM;

We should free the memory after using it. Pardon the late review, I
just now discovered the memory leak during testing.

> +
>         /* Normalize lba address space to obtain log offset */
>         ppa.ppa =3D slba;
>         ppa =3D dev_to_generic_addr(ndev, ppa);
> @@ -604,6 +608,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev=
,
>         while (left) {
>                 len =3D min_t(unsigned int, left, max_len);
>
> +               memset(dev_meta, 0, max_len);
> +               dev_meta_off =3D dev_meta;
> +
>                 ret =3D nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CH=
UNK,
>                                 dev_meta, len, offset);
>                 if (ret) {
> @@ -612,15 +619,15 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *nd=
ev,
>                 }
>
>                 for (i =3D 0; i < len; i +=3D sizeof(struct nvme_nvm_chk_=
meta)) {
> -                       meta->state =3D dev_meta->state;
> -                       meta->type =3D dev_meta->type;
> -                       meta->wi =3D dev_meta->wi;
> -                       meta->slba =3D le64_to_cpu(dev_meta->slba);
> -                       meta->cnlb =3D le64_to_cpu(dev_meta->cnlb);
> -                       meta->wp =3D le64_to_cpu(dev_meta->wp);
> +                       meta->state =3D dev_meta_off->state;
> +                       meta->type =3D dev_meta_off->type;
> +                       meta->wi =3D dev_meta_off->wi;
> +                       meta->slba =3D le64_to_cpu(dev_meta_off->slba);
> +                       meta->cnlb =3D le64_to_cpu(dev_meta_off->cnlb);
> +                       meta->wp =3D le64_to_cpu(dev_meta_off->wp);
>
>                         meta++;
> -                       dev_meta++;
> +                       dev_meta_off++;
>                 }
>
>                 offset +=3D len;
> --
> 2.7.4
>
