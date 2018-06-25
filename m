Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC96C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD425E83
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjGiAXEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD425E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933711AbeFYQt6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:49:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38993 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeFYQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:49:56 -0400
Received: by mail-oi0-f68.google.com with SMTP id 18-v6so3639070oiq.6;
        Mon, 25 Jun 2018 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJSMZyjox9FbYzzivndN/KWheimr7j+8/x9FyOvn0QM=;
        b=WjGiAXElnP3x49SAy0us6Tsp9HdtwNIjb6JW69Z4Y7vepTSiXjQooUKSoht/iUBNhy
         QxvImPVRYYaZ1+Neczy8fhmxIoKduoPi6F6p9DzLey/XqQ/hlTi3rBq47xxLah/hYmuL
         NnRovpD7teLX2zIYacxKjyk7y3UA/WUoJYaB1g8aWGaqEHpj0vxErYKMH9lu7e71hUsR
         NoMigp6n2JwqVHmxGXsEcumlrl2Yj2F2R2K1cw4WOaqgV6CpMSQxqculk0gjGDSLiFBV
         pqjuWU1N2yXoTDKNxpqgMMJG/xbpDTiw1Ps0C47z8Uqn+A5Qd5wXWEJNZlYtyieYLFNU
         jGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJSMZyjox9FbYzzivndN/KWheimr7j+8/x9FyOvn0QM=;
        b=PmY1PagS9JsWs81dicmqyGbN9HH0vwszZ1RToU+pci0nz1EVHRs9fGuzRXzmjY3/UJ
         cqCyYkYatnCQdW38yMCZXCJPdylWDrr0zxHRJdUmfXRJBiA6vRMBBGIyS/vXRLUvZeq5
         LKr5yJgJy+eJ0GKrNcjclEmC55tn3rJcZUObo2zsX70rRZrKh7r4neD7tARkVRZPBtbk
         8Vw+JQMj0vzv6RFWqK5x1GINEf06RncbxKZNVvOdG3XO2AjXuRZ8s9Ncxeo4zkeq+4B8
         7HeFNQta7ha5/C4BXykbfu9PR8Qu7AcgHanGYpA1o8/gYmtxslWIK1BIFSuuAwU3gfV+
         g1Wg==
X-Gm-Message-State: APt69E2wqZ8gcH5SUdMODiCv9JGPz0pQRvc1KS65v0Xdf7Tpg8niU724
        y0gXqFxuQFTA5jNOu6fZWCx8QllQEXYBTHqppaY=
X-Google-Smtp-Source: ADUXVKJ+lNB3UmtXKNso/mLuLPlVC47tyNDvgfD4wnW4Ly0n101jCAAgFxl01nID/QVdZ9uCxAwcjaUlj9NjfP0NKjs=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr6815960oia.251.1529945395611;
 Mon, 25 Jun 2018 09:49:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b10:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:49:55
 -0700 (PDT)
In-Reply-To: <20180625145605.13726-1-anders.roxell@linaro.org>
References: <20180625145605.13726-1-anders.roxell@linaro.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 25 Jun 2018 09:49:55 -0700
Message-ID: <CAPhsuW5fMyJeuU4EMdJ_zgkZgEz2emEU42qxx_etLigRSFzXPQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: enable NET_SCHED
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

On Mon, Jun 25, 2018 at 7:56 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> CONFIG_NET_SCHED wasn't enabled in arm64's defconfig only for x86.
> So bpf/test_tunnel.sh tests fails with:
> RTNETLINK answers: Operation not supported
> RTNETLINK answers: Operation not supported
> We have an error talking to the kernel, -1
> Enable NET_SCHED and more tests passes.
>
> Fixes: 3bce593ac06b ("selftests: bpf: config: add config fragments")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 1e0c547caf3c..7a6d92562dc6 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -6,6 +6,7 @@ CONFIG_TEST_BPF=m
>  CONFIG_CGROUP_BPF=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_CLS_ACT=y
> +CONFIG_NET_SCHED=y
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NET_IPIP=y
>  CONFIG_IPV6=y
> --
> 2.18.0
>
