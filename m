Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F009C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B765724098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odHgPQD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B765724098
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeGFH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:58:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39832 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeGFH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:58:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so7757093pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7uS9OUKoYRQr3Vrm3L0TKXO5oWAwBIe1/VHygnpRUFU=;
        b=odHgPQD6IoZsOdsuGGjQueNzMPOWuG7EAJGmqTdtVdJS9S2SS0V4iw5zHhD/LQ3SS3
         GMc58uGbgaUvSW91+UZJ9oHJzosvdC4M18VG0NZVz/SOsJ6lpjZ2I5PtOm0rbpHmbZwm
         82DVpa4luRtBParfC4n0hgFBsObiQLn4Ptra/o6LS7fWb0M2OE7K4w068HwxZd5xjbdg
         VTYPpYPJHXd+ltmJ+zNnxz/zN9vDSR+2bgtfBBp98mbXsGype18QVhcTemub7HHTTe4v
         Pjf3AlMgdQmVEXU0s2yAF8ilqbmBohP81r6QEj1GVIDHO2g96ZZ6MM1oqaHjFiNThTv8
         owSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7uS9OUKoYRQr3Vrm3L0TKXO5oWAwBIe1/VHygnpRUFU=;
        b=Wh2CLiq471obppIrZ4KmSgC/DOnhSzAD2A97nDt6mUwgEaZvJfXHIs3nYKNLy7TGEy
         qjRw4uWwgplYN2jS9OOnbEJusLrgu9QICGWIrBOrE749LDIi70niPCRfy7LR8ifhAMn2
         PQ/6ogusaXAw0qjUVI9+DdKHmU9dfvi/NrAdnKu40vNnQX8VtJqUM2S0Di0c3QihkhGD
         MkjWKTk3z03yXTDnnCeethsdW8Q3mYd7BH32Hb7E6v80SD9+KhWFnDDX6+pUkO98Cb5D
         /eptQS1pIZPmj7NTnHqQaqllDnqBhV/DBAZFda8Mv622CmJXv1lBVHzrWiE5wIIvCzXj
         yqoQ==
X-Gm-Message-State: APt69E1I9HN0UzTV27lmrtVahke/Ewz3piyWQQV9S49CROnhIyhIzOqt
        c6P04J3xtz9NCYTZdtrC/a3+f7xQorJdU3tdsZuDxaY1mwA=
X-Google-Smtp-Source: AAOMgpfwbXZqLJoLqeNalhk0FeySB2RzCnibuHkanD6uSmRnnCsUKTSxHT1NtVYaGm5N6QNaJY8Aqjhg0RSICGncr5w=
X-Received: by 2002:a63:b43:: with SMTP id a3-v6mr7505187pgl.50.1530863910841;
 Fri, 06 Jul 2018 00:58:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d581:0:0:0:0 with HTTP; Fri, 6 Jul 2018 00:58:10
 -0700 (PDT)
In-Reply-To: <1616306.R4SzcgHSdy@positron.chronox.de>
References: <00000000000092ad87056950ef9e@google.com> <1616306.R4SzcgHSdy@positron.chronox.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 6 Jul 2018 09:58:10 +0200
Message-ID: <CACT4Y+ZDw9by_Fq5Bi5MtR8FqDjWmW834Pc-1-7j2OZniTXacg@mail.gmail.com>
Subject: Re: [PATCH v3] AF_ALG: Initialize sg_num_bytes in error code path
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 9:50 AM, Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
> Changes v3:
> * Fix syz testing line

Just in case, the syz test does not have to be in the patch. Just an
email to the syzbot address will do.


> Changes v2:
> * Addition of syz testing line
>
> ---8<---
>
> The RX SGL in processing is already registered with the RX SGL tracking
> list to support proper cleanup. The cleanup code path uses the
> sg_num_bytes variable which must therefore be always initialized, even
> in the error code path.
>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> Reported-by: syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com
> #syz test: https://github.com/google/kmsan.git master
> ---
>  crypto/af_alg.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 49fa8582138b..bd6795ff406a 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -1148,8 +1148,10 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr=
 *msg, int flags,
>
>                 /* make one iovec available as scatterlist */
>                 err =3D af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen=
);
> -               if (err < 0)
> +               if (err < 0) {
> +                       rsgl->sg_num_bytes =3D 0;
>                         return err;
> +               }
>
>                 /* chain the new scatterlist with previous one */
>                 if (areq->last_rsgl)
> --
> 2.17.1
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/1616306.R4SzcgHSdy%40positron.chronox.de.
> For more options, visit https://groups.google.com/d/optout.
