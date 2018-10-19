Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6963DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B8F21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQhXwO9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B8F21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeJSRbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:31:02 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40291 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeJSRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:31:02 -0400
Received: by mail-vs1-f66.google.com with SMTP id y195so9109551vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iim0wBvDiJ99yf4NNYppkFey1FpkyJEg0f3tzp8xDT8=;
        b=NQhXwO9yqNxQnrIdlt2Ri2JDmFkfiENprHMcNRZOEh4yLVtbkJjM9J9A9W1LhrufEV
         OuN5cMYHBBjiM6IcCqm+hbPFMVlWvoZnQtp+osRumkg/5ZWnvZwP0xFqxrjYvj5YzVnz
         uFsRomwpw+ddiuT4oNt+VoY9rPIn/JHJmXhHVzmuMUm4KbEKQ4pxcpE71X8gupyENvf3
         hPhfbBFRWrIepPAFqyRV9+lpHJjKPxXK76uYSubNtKSyf0SlUVpBRRaai54R2o4Y8/pP
         xg8Qg94HOHE347vmZD6XpR3mQbredJZ7kPBvPLbpY9LVFZ5M0FbSFzJVD+/HF+bNicl7
         gHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iim0wBvDiJ99yf4NNYppkFey1FpkyJEg0f3tzp8xDT8=;
        b=TpRJWs6dupFw3+XQTtC3s3f2XnqUtPYwnM3Vj1MZOe4EXMEOhQZSyDHYijvD6tvm2Y
         jdBaU3ggJfcHSTQmnHwXrUjgxuUiddvweG1o5iJ1CGAtjXjxUWPfiaWgoY7rqz6DlLk4
         QkGlsZ1SpoKKD15BpqCZONoBHvJrLtvVgCGCvKZz/6Tz4YjiW+scrvRv2gTZmnrZu+Rz
         R+G5oBRQxlLspeyzuGifvlj2MuHPOvMhgeYZ3XTnIsH8GpvtPLls9/+RKMmL3SavdPfM
         tWdYWnaqGPHeutSwSRM/dL3gybfgbef4wGYMPArVpfYbHjPXp76ihd+XWm2bw31U4Aox
         NvxQ==
X-Gm-Message-State: ABuFfohSageEE/G+3HkB/gqwK1Ks8YLHJm9uNNTR/Cu2k6AC3AzGHtoG
        YnqB1nLu5//rTgnSFhhSKKhRtldVafaIlKg0KG0=
X-Google-Smtp-Source: ACcGV616zX7DAaViL9+QNjydwC2tRdR1KFfr+NPjc2e+QT1DE4e6iH35jruzPNZt1zL1ojp675AagRfMDnrssg692iY=
X-Received: by 2002:a67:33d1:: with SMTP id z200mr14161253vsz.40.1539941146085;
 Fri, 19 Oct 2018 02:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539654056.git.nickhu@andestech.com>
In-Reply-To: <cover.1539654056.git.nickhu@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 19 Oct 2018 17:25:09 +0800
Message-ID: <CAEbi=3f+q5tCD-t1nLkkp3vHrHyYpVF_nwaNZ2thu4g_i0vpTw@mail.gmail.com>
Subject: Re: [PATCH 0/3] nds32: Unaligned access handler fix
To:     Nickhu <nickhu@andestech.com>
Cc:     Greentime <greentime@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Zong Li <zong@andestech.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nickhu <nickhu@andestech.com> =E6=96=BC 2018=E5=B9=B410=E6=9C=8818=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The patches are about unaligned access handler. We fix some
> bugs in unaligned access handler and add some kernel configs
> for unaligned access handler. Then we add the kernel unaligned
> access handled by software in handler.
>
> Nickhu (3):
>   nds32: Fix instruction simulator bug for unaligned access handler.
>   nds32: Add 'HAVE_EFFICIENT_UNALIGNED_ACCESS' config
>   nds32: Add unaligned access in kernel space.
>
>  arch/nds32/Kconfig.cpu    |  3 ++-
>  arch/nds32/kernel/traps.c |  4 +++-
>  arch/nds32/mm/alignment.c | 43 +++++++++++++++++++++++----------------
>  3 files changed, 30 insertions(+), 20 deletions(-)
>

Hi Nick,
Thanks
Acked-by: Greentime Hu <greentime@andestech.com>
