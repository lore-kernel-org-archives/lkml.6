Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16C2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnsdwNuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC16C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJXa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:30:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38751 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:30:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so6278968qtf.5;
        Wed, 10 Oct 2018 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHwF7mt84G9Z5smPmPdAyHErcbbfZdeXgBPZ5XZMwoQ=;
        b=MnsdwNuom/db6bO13FNdMLsbNTPyI2qIAoxyNOh/37MAqBHPZ+PmD9ZKxl9irF0KWR
         dqy1szSNDl+EtaJGRcFjKC5GCOTrMLVKwNPFjLAhI+I4M/b71BoBDW1t2ovMrjxtirgF
         hTWNTFqxid0WJvr2MJ9KKx3cKp3vOmDCQZpGP0rw5qAHjzyyW+547TpPV0w2nlLYepea
         XI1j2edWW99fJZZqWXimrvksQ3Yb4bbr9lcIiKchCwHOcfIACwTKvrw2/nGYMPsgwi2+
         9cbtnbodVsZX4rKs6KWFP2Iz004PtnGHEX3DnyHaeOoACGaN9rqPMowdQBCjlhfw/wid
         xaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHwF7mt84G9Z5smPmPdAyHErcbbfZdeXgBPZ5XZMwoQ=;
        b=dj0nxPLG7Bl7K8AVv08Wuz1DJoH2rJaoR+/nuVJLXy7ku8j2KAceavI/kseutwkf1L
         aVK+9Y7kWczGMj8zUgxKb4DC4XjGXTRtSo2zX7MfCEw5Iomv2DeJyk6fJ2EJHJDOmZZN
         XLSoBnt9HzUSn4WUO9US2hdluFI/wTiX3cBtrtSJEd6agZjEUUtcyCRahS7KvQpw+wNP
         FXUN0JWc+r4bDYoy5Gst4geUhtlYiOdl667crUuJZyb7cldX7bUhlrEN/BMEi5NkS1Wf
         NceEE6GqjWOArqUtGbv5DhUU+UM/AYEacq92PGz7jqw3vEASCPdnPtK94HgG5A0ReAYW
         35LA==
X-Gm-Message-State: ABuFfogHTKySB+X6BvwLMDl82gainm9xqfjzo9v4TiDIg552s6rmgENw
        liC2IMYyZMIc6VLaCtswssrOBaLMIzm56VwysBSPhto2
X-Google-Smtp-Source: ACcGV610/naSQ06L0dTGqu/6LY6q2BKwmDMMs+E04qGm4PjLqq4x6hrRJjrygZlEbqmH5ZrpC9QviodyHXv+ZYxZnpc=
X-Received: by 2002:a0c:f443:: with SMTP id h3mr7339955qvm.5.1539187686619;
 Wed, 10 Oct 2018 09:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181010142704.26990-1-anders.roxell@linaro.org>
In-Reply-To: <20181010142704.26990-1-anders.roxell@linaro.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Oct 2018 09:07:54 -0700
Message-ID: <CAPhsuW7xqr91k0c6zQxWf1n5nDPk1tq9F5Fp_yarBdZxE7Vn9w@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: install script with_addr.sh
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shuah@kernel.org,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 7:28 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When test_flow_dissector.sh runs it complains that it can't find script
> with_addr.sh:
>
> ./test_flow_dissector.sh: line 81: ./with_addr.sh: No such file or
> directory
>
> Rework so that with_addr.sh gets installed, add it to
> TEST_PROGS_EXTENDED variable.
>
> Fixes: 50b3ed57dee9 ("selftests/bpf: test bpf flow dissection")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 1381ab81099c..efd108ff737d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -51,6 +51,8 @@ TEST_PROGS := test_kmod.sh \
>         test_skb_cgroup_id.sh \
>         test_flow_dissector.sh
>
> +TEST_PROGS_EXTENDED := with_addr.sh
> +
>  # Compile but not part of 'make run_tests'
>  TEST_GEN_PROGS_EXTENDED = test_libbpf_open test_sock_addr test_skb_cgroup_id_user \
>         flow_dissector_load test_flow_dissector
> --
> 2.19.1
>
