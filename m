Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1295DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB634223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Bj3Aw1qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB634223F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeHJKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:33:38 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:32843 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeHJKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:33:38 -0400
Received: by mail-ua1-f67.google.com with SMTP id i4-v6so997830uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7ck28YG30p+AvmsTOwRHLuHq+HW9kTe+vTVYiroLUI=;
        b=Bj3Aw1qX9lJpyuK/mvV5n0de0lNHZ8rx252BIFScWz3K8b9BoSoJ1KTeFyhmh+TuZ1
         7Vbi2ItMk+SzT2/KulDdh6bFEMbx9nGVlJ/s3+OO9ghOoDKm74AyM/YQGFEvanGxcAui
         ihQXt4TV9UK2MsSIItTA3zCICm8gt7zXXj7u9CNoqTEYFmOEa/YACp1OeZcsd4xa1dYI
         KEdtVD80kdY02lXpRkW6r59XdH+1EU88pe88QPZyAKkY4aCcYd5R3gRq1pgi/5cu1xwz
         1IbpIZ5EnENNgaZTnLJPF/abichF1kVWhkr7hQv8SUI2RixWU1WW9H3ETsU9agn+S3s8
         yuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7ck28YG30p+AvmsTOwRHLuHq+HW9kTe+vTVYiroLUI=;
        b=E1v67PxvxaQ4kR0l8Kr5/CC5O3UqEv7BDmRyLc/VtJ2oDwZNKzwTF2ijKMMufXee7P
         qRtunJn4iHJ2wGB+3Q06ZXpuXDldLHbuFIxLaYpEYCuJZGHwjQm5+zQhe+VJOhOgZd2z
         yOEtVAxRVew7euH2/LfHuXHFIFZyNa/UYHSK07HjPdy2GAIy3Oq8JQ+vaOTojV+2MFIb
         TZOr+XoGFREA3cT83lyFCgedb2ImYBQQyZPF15CqKZETzsTkzRAvZYmH7BubWsH6QxAj
         cuXhe8yi3VrGx0OaHOBBZMLEjDiv1gshHjGlVd3IzzNnVRTqJpKBRym7gbrDWAR4baIg
         zKKA==
X-Gm-Message-State: AOUpUlGPD/XsXxFXKyFhQsSy84wooJwZZZqhGvpnosOxUajzt0Dc5+/f
        1qGi3pVlWXqDx02ooao3voz5mxpsMNOf2oHx9IivcQ==
X-Google-Smtp-Source: AA+uWPzAuz9xFfukO+dkPZeQByqOb0yMHRjOlFsXOtpuxGQZseqA6sQkicTRrieQFhAbKzkU45Ri6V89sIg0hJ5TdI0=
X-Received: by 2002:a1f:6285:: with SMTP id w127-v6mr2771452vkb.78.1533888293003;
 Fri, 10 Aug 2018 01:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:984f:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 01:04:52
 -0700 (PDT)
In-Reply-To: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 10 Aug 2018 10:04:52 +0200
Message-ID: <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 2:05 PM, Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
>
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
>
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
>
> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> ---
>  drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>  drivers/lightnvm/pblk.h      |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..160b54d26bfa 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nv=
m_rq *rqd)
>         return nvm_submit_io_sync(dev, rqd);
>  }
>
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +       if (rqd->opcode !=3D NVM_OP_PWRITE)
> +               pblk_submit_io_sync(pblk, rqd);
> +
> +       pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);

This will only work if rqd->nr_ppas > 1, better check if rqd->nr_ppas
is 1 and pass &ppa->ppa_addr on to pblk_down_page when needed.

> +       pblk_submit_io_sync(pblk, rqd);
> +       pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
> +}
> +
>  static void pblk_bio_map_addr_endio(struct bio *bio)
>  {
>         bio_put(bio);
> @@ -737,7 +747,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pbl=
k, struct pblk_line *line,
>                 }
>         }
>
> -       ret =3D pblk_submit_io_sync(pblk, &rqd);
> +       ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
>         if (ret) {
>                 pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
>                 bio_put(bio);
> @@ -842,7 +852,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pbl=
k, struct pblk_line *line,
>          * the write thread is the only one sending write and erase comma=
nds,
>          * there is no need to take the LUN semaphore.
>          */
> -       ret =3D pblk_submit_io_sync(pblk, &rqd);
> +       ret =3D pblk_submit_io_sync_sem(pblk, &rqd);
>         if (ret) {
>                 pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
>                 bio_put(bio);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 4760af7b6499..6ccc6ad8e1ce 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm=
_rq *rqd);
>  void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
>  struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
>                               unsigned int nr_secs, unsigned int len,
> --
> 2.7.4
>
