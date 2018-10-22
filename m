Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE90C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duz2xaOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeJWAR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:17:29 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33086 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJWAR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:17:29 -0400
Received: by mail-ua1-f67.google.com with SMTP id j13so10151452ual.0;
        Mon, 22 Oct 2018 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnilPm5zaKWAf/CuXZT44JPcxCOnx3YMykk4czPJfR4=;
        b=Duz2xaOp43vKg8j/Sb1ECD+DAK+9PDJzBnaAbESs1JzvKMxw1ZIbcvu/rG77qIg5+E
         PCLbreDbPKHS/Wz6TzYBBFGZ+HkO6MM3x1KqGBjBKcKZ30tJyjATHinu/UR9TJxU3Ncu
         atriK+T+4tTNyICuzwWJdsth2yQb3q2ZT4TcmRf2OMzuC9ZYT+0oHRo1MACW5OIFIQrp
         i85gqJjvXO51cfcCy709eMvUCBK45CNBLno/QHkcIoPFrc0caV46k305rNFWTkOg7kjE
         SjIooqd28oo7ljm3ZMKZJiYkk5vg5qIXlFe9JJIL8pZVbcyq4ioDSUrvCYMKE5jGj1o8
         LvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnilPm5zaKWAf/CuXZT44JPcxCOnx3YMykk4czPJfR4=;
        b=qpa6+/IsU/A5TRZf5HG2N13GHAA2jB+0LmzgYfzX6c5cw/zTS8Carnw5j03//EEleB
         +2HZJQZAx9N0oCXTImeymcgobatTPwxXgoaFvYLklGqhI22e1ep8lh5Ur2Ey/BEMCF31
         3t//b/A9CsmcPlR8WIN9Qp/oYNoBcCHiFQ6hrt2/zQ20jE5/k0TpoRWqCXlANPTy2Orb
         F8lOqQtG/h/B/w2Bf0NSnK0hLf+gYShsqqt2dwDqk/JC0oWHZF3rngVSz5cyP0bYH/pf
         wree7qT0fzvQsYHf6iLK98F20bGslnMt3SRygm5+/EragcL0SpeydL1bUaKC6l8ZzlXd
         ioeQ==
X-Gm-Message-State: ABuFfohhWDJXtuLBpiVjiSYPkbQq4q9nxYCy2lWysIgbhf4z9kh41P6T
        k/A77cTNZweGnYIHba+fQNZX+rdh3Ir/Iy6hp74=
X-Google-Smtp-Source: ACcGV62U2Zk7nQR+8QhVX4RnhPDyu8UdSL1ym3mMC+a9q22RxC0u3pPn42F17g0cyYxqVKFr9Y8IXh4JuXit4zxMQlw=
X-Received: by 2002:ab0:3003:: with SMTP id f3mr20953820ual.80.1540223902463;
 Mon, 22 Oct 2018 08:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
From:   Y Song <ys114321@gmail.com>
Date:   Mon, 22 Oct 2018 08:57:46 -0700
Message-ID: <CAH3MdRV2qLj_3KHFYmCKYHMx2wZk_4mQrdvRJe+znXr3Astm8g@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Fix a missing-check bug
To:     wang6495@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 3:30 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
> verified. If no error happens during the verification process, the whole
> data of 'btf_data', including the header, is then copied to 'data' in
> btf_parse(). It is obvious that the header is copied twice here. More
> importantly, no check is enforced after the second copy to make sure the
> headers obtained in these two copies are same. Given that 'btf_data'
> resides in the user space, a malicious user can race to modify the header
> between these two copies. By doing so, the user can inject inconsistent
> data, which can cause undefined behavior of the kernel and introduce
> potential security risk.
>
> To avoid the above issue, this patch rewrites the header after the second
> copy, using 'btf->hdr', which is obtained in the first copy.
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  kernel/bpf/btf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 138f030..2a85f91 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2202,6 +2202,9 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
>                 goto errout;
>         }
>
> +       memcpy(data, &btf->hdr,
> +               min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr)));

Could you restructure the code to memcpy the header followed by copying
the rest of btf_data with copy_from_user? This way, each byte is only
copied once.
Could you add some comments right before memcpy so later people will know
why we implement this way?

> +
>         err = btf_parse_str_sec(env);
>         if (err)
>                 goto errout;
> --
> 2.7.4
>
