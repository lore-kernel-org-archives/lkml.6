Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3066120B80
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="cWAsLcxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3066120B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeHVL4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:56:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36389 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeHVL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:56:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so901821wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JlIhNKWoRmlu3BCz1LONL1NCdAbQZ8VJt+Ce3M8WYEU=;
        b=cWAsLcxoob8uvsLt9TI2u/qMmBAnJ3syPzHjh69icZbU4XK/OjANI9rtBabNYxZO5M
         BseJGR2MFY9i5IV0jifBQZRmmKBerWGh1BUsWWCByrSNerJ5xaMgEZP0DBicu8LdvKXS
         LA571RUNjt3m0mNqhdfeVqdMT/8mIiW6aj8e/SV48YpH/3E1iHscA4/Px0PvFY2XDh6o
         n4d878HOQqYlkJ0WIjeA7l+pxYAVNYQ/r/ZQcHMgxjCRT9A0bz6viGVdQdqUGty0c+oV
         tnhSjw340AA4jGgg5DGBK91lm1iHtv+rG4TJdIGSYGXWV885Xnb1JWNdTFgxDvSujuh3
         +mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JlIhNKWoRmlu3BCz1LONL1NCdAbQZ8VJt+Ce3M8WYEU=;
        b=oqj7a2DouCNk0qphkYHKr7RxyTDAD9l4+vh6qyxYlJhkFHE4JA2kDuH4yHZyVbl19K
         9zkIgF8Ze5urSeNw2BNZ8eHT5jiBfEWj8crdlAjqkBttLj7rWzxPAXC+xjLulU/YRfZ9
         K5//WK2SfsrrwBkB5Gyo77NE1JIfJLTknnuJ5+WxDZa/FmtpkC0W4Rz8DnuL1Np1WxFp
         iS9rFy/AzxDP8n5cDsdDJYfah2irzpfl/LJ/VNVAPzXNUaErT0XfQOzI8R2mmVrfjWcQ
         p5O1SNu1Ut4CIjfuRg2ZuyGsOoFR4QHxYu5a2MS+Q+1vNVC/FOpKHaWpstD/gGSmb48I
         rNXA==
X-Gm-Message-State: APzg51B/S91FXIq7TGhqiq7gSUIsZjAk2lb7jyVt110q6IdMd8jQQ5Sx
        s3WfIVtHR/gUF9UCAXuvoQ5fmeGu4RxooyhOvjdAw0Gwq66Yqw==
X-Google-Smtp-Source: ANB0VdatBZoTgZa8ML5qAXa51pzxm33uSGbchGFZzhZpK4Cxhea2j3BTBtoPVT3rL+SCHOn8RiddaE5GAyhBSriVeDU=
X-Received: by 2002:adf:f504:: with SMTP id q4-v6mr8743389wro.241.1534926766518;
 Wed, 22 Aug 2018 01:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <kk5mute6dt2.fsf@brer.local.valinux.co.jp> <CA+res+Qq1uw301md02ZDPNdiEtdFHOe5VKhsUZ_ugY_LK5t2mg@mail.gmail.com>
In-Reply-To: <CA+res+Qq1uw301md02ZDPNdiEtdFHOe5VKhsUZ_ugY_LK5t2mg@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@profitbricks.com>
Date:   Wed, 22 Aug 2018 10:32:35 +0200
Message-ID: <CAMGffEmyQhBQHrqa0wzdS7OSNeJHB+A-56RaX53NTAUCLjDLKg@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/vmx: Fix GPF on reading vmentry_l1d_flush
To:     minoura@valinux.co.jp, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: MINOURA Makoto / =E7=AE=95=E6=B5=A6 =E7=9C=9F <minoura@valinux.co.j=
p>
> Date: 2018=E5=B9=B48=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=
=8D=889:50
> Subject: [PATCH] x86/kvm/vmx: Fix GPF on reading vmentry_l1d_flush
> To: <kvm@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
>
>
>
> When EPT is not enabled, reading
> /sys/module/kvm_intel/parameters/vmentry_l1d_flush causes
> general protection fault in vmentry_l1d_flush_get() due to
> access beyond the end of the array vmentry_l1d_param[].
>
> Signed-off-by: Minoura Makoto <minoura@valinux.co.jp>
> ---
>  arch/x86/include/asm/vmx.h | 1 +
>  arch/x86/kvm/vmx.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 95f9107449bf..c4b834b05178 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -581,6 +581,7 @@ enum vmx_l1d_flush_state {
>         VMENTER_L1D_FLUSH_NEVER,
>         VMENTER_L1D_FLUSH_COND,
>         VMENTER_L1D_FLUSH_ALWAYS,
> +       VMENTER_L1D_FLUSH_PARAM_MAX =3D VMENTER_L1D_FLUSH_ALWAYS,
>         VMENTER_L1D_FLUSH_EPT_DISABLED,
>         VMENTER_L1D_FLUSH_NOT_REQUIRED,
>  };
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 1519f030fd73..155ba2a9139f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -204,6 +204,8 @@ static const struct {
>         {"never",       VMENTER_L1D_FLUSH_NEVER},
>         {"cond",        VMENTER_L1D_FLUSH_COND},
>         {"always",      VMENTER_L1D_FLUSH_ALWAYS},
> +       {"ept-disabled", VMENTER_L1D_FLUSH_EPT_DISABLED},
> +       {"not-required", VMENTER_L1D_FLUSH_NOT_REQUIRED},
>  };
>
>  #define L1D_CACHE_ORDER 4
> @@ -286,7 +288,7 @@ static int vmentry_l1d_flush_parse(const char *s)
>         unsigned int i;
>
>         if (s) {
> -               for (i =3D 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
> +               for (i =3D 0; i <=3D VMENTER_L1D_FLUSH_PARAM_MAX; i++) {
>                         if (sysfs_streq(s, vmentry_l1d_param[i].option))
>                                 return vmentry_l1d_param[i].cmd;
>                 }
Easy to reproduce. Thanks.
Tested-by: Jack Wang <jinpu.wang@profitbricks.com>

--
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
