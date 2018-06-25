Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B42C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052312545A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECmRSVxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052312545A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeFYFIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:08:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35349 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFYFIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:08:53 -0400
Received: by mail-oi0-f66.google.com with SMTP id e8-v6so11285362oii.2;
        Sun, 24 Jun 2018 22:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xQNLyaNt+SMXTxgmbyMA/LXag7ETmkz5e39c/TCVGlE=;
        b=ECmRSVxOe0cuptJrM6VGL7VXg0DjO3YLFDqz9IfiDglxFGNpNfj7gh+52m701Oe6Z5
         SmJRQUQ0eQ4IuVyx8tPI14VKQpVPgHVCQK92NuDwHTdGgHO1QhdQrjFG/kY43Mw/bq1R
         /tNFb5VspoTxbL1nYO3RxntYTt+uVC30tcV/4hS+S9zQ4Kj7n48c5kP1qQ3rYkvdOmAz
         lCCh0qFnsYO3y992ZO57afGTsZgXcYpv95CC6RPuLcpr6c/DeRDOPD0JoyRu148xOUVP
         rM0W+J5b2t15MjwQFxPe/uK4SSMZLNxJqwq/mbe//HZ1nY31V8SAVmFzJQRkS1bkEKIK
         T5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xQNLyaNt+SMXTxgmbyMA/LXag7ETmkz5e39c/TCVGlE=;
        b=j76FCXO/kn/kU9Sepe+FZ0N848VX7hqGVZ2W0V76I8WCvDPmjFJF1UfqxxK45uEQMa
         iOtGjyaXcu2CG6MTRsyggVKFRYkPATOEoMgYLapLgWvmiHUF+lWOKoWcRrSHvBFVVNEd
         pKk5UWgZH823Qg8XeHiTf8qKyeP/Pd8tpK9Z3XJpbaQs/2zvn6Z3lNBSvCgdN6nU5pt2
         rBxZe82UTfeBlxrjnbWNVAON9XO/p/QODlgZPIPrwArO3EWooW65zParYRxMuIh8TtBU
         rm/pI77CpOo2V1z8iI/i1pHiH9kFVoSNenr2OgumwqEAuwS6T3EavEnVNQb/Btd+QAXa
         oj/Q==
X-Gm-Message-State: APt69E1kQuvKssSQ2myyzhHnbxtrs8hCShj+qbfooVFjQwuHz6+6YD1t
        vyfVxcvgwlidPeeGcAgVvATQDpBWrKQzIk1+yC0=
X-Google-Smtp-Source: ADUXVKLUyFlawuXzj4vE//sxLs3+vgbd1LuEWIJp/7VU6JYOLw+He53dDXYEvLT7yT14ovyVqXPUFf0O8cCAwldX5Gg=
X-Received: by 2002:aca:3788:: with SMTP id e130-v6mr6166270oia.21.1529903333382;
 Sun, 24 Jun 2018 22:08:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b10:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 22:08:52
 -0700 (PDT)
In-Reply-To: <20180622185417.3452-1-ahiliation@gmail.com>
References: <20180622185417.3452-1-ahiliation@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 24 Jun 2018 22:08:52 -0700
Message-ID: <CAPhsuW6MUKiKdstH=H8nrPA5kRQUQus-UVSxYgCM+KwWQ3VXJA@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: notification about privilege required to
 run test_lirc_mode2.sh testing script
To:     Jeffrin Jose T <ahiliation@gmail.com>
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

On Fri, Jun 22, 2018 at 11:54 AM, Jeffrin Jose T <ahiliation@gmail.com> wrote:
> The test_lirc_mode2.sh script require root privilege for the successful
> execution of the test.
>
> This patch is to notify the user about the privilege the script
> demands for the successful execution of the test.
>
> Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_lirc_mode2.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_lirc_mode2.sh b/tools/testing/selftests/bpf/test_lirc_mode2.sh
> index ce2e15e4f976..51184f8f9e64 100755
> --- a/tools/testing/selftests/bpf/test_lirc_mode2.sh
> +++ b/tools/testing/selftests/bpf/test_lirc_mode2.sh
> @@ -1,6 +1,15 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +msg="skip all tests:"
> +if [ $UID != 0 ]; then
> +    echo $msg please run this as root >&2
> +    exit $ksft_skip
> +fi
> +
>  GREEN='\033[0;92m'
>  RED='\033[0;31m'
>  NC='\033[0m' # No Color
> --
> 2.17.0
>
