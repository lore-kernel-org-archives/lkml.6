Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E82C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647862080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdbRyarD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647862080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJaDaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:30:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38039 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJaDaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:30:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id p3-v6so7926628qkb.5;
        Tue, 30 Oct 2018 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRcMjB+Fme9fl/5ALTRje9Vh2hE2H5faUJKQ79aVThc=;
        b=jdbRyarDjRakPlpvBwYQEbZjCjKSggjzD322Sx3FdYNKlwDp27jHwPcBmNOQtgJPRi
         YtBgdZ6NYNxGgAehRFZhaqv+yCNCWNW1o2tAhgorh+SJSL3WCPHS+/tScf7ZnagPdwmL
         CIPyDydQ6m/xSr5NLJfptQKIqbl//ECp+vMPfKdvguDT075BykcQ5ofAGyy/c4EbiQhI
         Jif1sNasVssaYEOyazCGxFYLuyLRRw2T0g6qM2NiGul6lXh+tTMIorXMRpxdUh6+ZMIT
         jA71//GPk8Fmv6hJsc+PZCAby9xEIarhM3mXbFKiq93dZdSeId45lkx6/XSZZoQ0aagb
         BoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRcMjB+Fme9fl/5ALTRje9Vh2hE2H5faUJKQ79aVThc=;
        b=CHVb4bgMYLjKDwBrAcph12vaXQM3qQcyenECXRi/23vzZSaWyqxg3SwPDWW2r20ZNi
         3gDuNc8aEupV/A3RF1mFwKAmllOyT6Vm7RlOEr2lTi4hTb3cw9W5JYfs+X4egS7lGO6y
         gsVya/ikmeq8JzAVzGoMGXs5Hbq7Xn7u9PZ3DhLsKFjINI0cjyp6y/XRmrvWCSBM54PC
         uQ92fcWr9RKCRvL/c6PTqPt9femskavUVqveA6qgFUS/Qaz+RIZk82wBH7FgHWx79V41
         BJlf9i//rahj31juJuMjq9OulJ8ECuEFmuCFmsq2yfFzjEsltVutZ3+qk6DGYv3Jl4GC
         cN4w==
X-Gm-Message-State: AGRZ1gKrVYDIpfTM4tB5lZR8XEf2+eE5kDm74+7+HXyl29j+CUYZLQJn
        VFP5KajyWDkajDGeStC9XpHo0iaQLstcmfkCSrORFLUa
X-Google-Smtp-Source: AJdET5eB4EUJXGgFvf9Y6NBK4VwXsbB8IHIADjQrxO84mPv58MfRudz/iKbpxu7DRMYCmroBlL8VvyQMEWmEeI/zSHo=
X-Received: by 2002:a37:6749:: with SMTP id b70mr12379qkc.41.1540924533747;
 Tue, 30 Oct 2018 11:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540869355-13324-1-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1540869355-13324-1-git-send-email-lizhijian@cn.fujitsu.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 30 Oct 2018 11:35:21 -0700
Message-ID: <CAPhsuW4Bm2H7sV8xgzcD9s=9d_z1bpeEYbo2OMTTh9mcgmrC0w@mail.gmail.com>
Subject: Re: [PATCH v2] kselftests/bpf: use ping6 as the default ipv6 ping
 binary if it exists
To:     lizhijian@cn.fujitsu.com
Cc:     shuah@kernel.org, Networking <netdev@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:35 PM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> ping binary on some distros doesn't support "ping -6" anymore.
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

I think this should go bpf-next. Please resubmit when the bpf-next tree is open
(after the merge window). Other than this:

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_skb_cgroup_id.sh | 3 ++-
>  tools/testing/selftests/bpf/test_sock_addr.sh     | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> index 42544a9..a9bc6f8 100755
> --- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> +++ b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> @@ -10,7 +10,7 @@ wait_for_ip()
>         echo -n "Wait for testing link-local IP to become available "
>         for _i in $(seq ${MAX_PING_TRIES}); do
>                 echo -n "."
> -               if ping -6 -q -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
> +               if $PING6 -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
>                         echo " OK"
>                         return
>                 fi
> @@ -58,5 +58,6 @@ BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.o"
>  BPF_PROG_SECTION="cgroup_id_logger"
>  BPF_PROG_ID=0
>  PROG="${DIR}/test_skb_cgroup_id_user"
> +type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"
>
>  main
> diff --git a/tools/testing/selftests/bpf/test_sock_addr.sh b/tools/testing/selftests/bpf/test_sock_addr.sh
> index 9832a87..3b9fdb8 100755
> --- a/tools/testing/selftests/bpf/test_sock_addr.sh
> +++ b/tools/testing/selftests/bpf/test_sock_addr.sh
> @@ -4,7 +4,8 @@ set -eu
>
>  ping_once()
>  {
> -       ping -${1} -q -c 1 -W 1 ${2%%/*} >/dev/null 2>&1
> +       type ping${1} >/dev/null 2>&1 && PING="ping${1}" || PING="ping -${1}"
> +       $PING -q -c 1 -W 1 ${2%%/*} >/dev/null 2>&1
>  }
>
>  wait_for_ip()
> --
> 2.7.4
>
