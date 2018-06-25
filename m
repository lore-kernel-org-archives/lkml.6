Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ACFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39A025461
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neOA11xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39A025461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeFYFJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:09:31 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41201 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbeFYFJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:09:29 -0400
Received: by mail-ot0-f195.google.com with SMTP id d19-v6so13669592oti.8;
        Sun, 24 Jun 2018 22:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H3BHhImraftB/8/PC119Ykcp+BYpWiefnn4OGWXm4cI=;
        b=neOA11xmZyM9irlykqs82AM+Uu4KFG2FJuwYliVR5BM5kXHnmyxm5s9OghlWZRlCWO
         I2vYBueX4qS3u7pLsBg7886RyDKFa5il8CA9MPnGjAUghEqxHwlzuo0TIK0hkS8D3Dqq
         IRzvBSa6+5EAaPfUXfqJuSNgpCIbLJ7pzmlCL6pOe9DBs6VEW2d1kxsSpPvkd7FGVDEJ
         tVHv9dLlb398MM9TnUhCEIoF4w3tcLWKbmZq063EFD3uTvTxo6Yay7grBouzNs4JKGJb
         lIRHkg44ibYizyIeSHtYO6K1jICacJ+iUq8mm0+BHOC4qUMIDYTB/QXGeCrGl5LL1xQo
         LD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H3BHhImraftB/8/PC119Ykcp+BYpWiefnn4OGWXm4cI=;
        b=ARuEXaliF+qz4+teXR9Zmt+I3FdXCe1wvF9MNLIeVbPSuS1rZEakuLibZS6/UEOPOC
         N9EsIxMZvn/p+RmJr+vpxgWl/CVkBHbAa/nc+j83z1EtJDoPewD8bYWXWpEfbV0QZwX2
         Q8+sMM+qpvv+pRzCnx5NLQj+V7Jh5Gm2xK0fQ9YJIeEoJi8F86Llq8o/VyehFKpEk9YC
         FzLLxtqd93DL/B3bKixiek4C4dE7k1I8ALF28MORr2YXOQQN+HZQav7UxxkTxAlG9UOw
         uXU5mks93afHp7dxv3wflkATqeKws67tW4il6bSIzx7UyTbJCRfp9i4DLlNgcm9ce/Xo
         1X/g==
X-Gm-Message-State: APt69E3KlpzPiBc0zTvjUWBPRjFHGX/HkpK9eTZXhART7tQTvzYx+54y
        8hp2WSFxKEubdfQJTBHFebmrDEv+twZxPbXWlCX3YA==
X-Google-Smtp-Source: AAOMgpfXzvnzPZpusHUKAiVbsQ3V6z8ExbvGj7Bvqs0cQQMgewKciNDB2UXqsSt8gawElWZeQV2/tRoF1xRdWgT1tjo=
X-Received: by 2002:a9d:508a:: with SMTP id b10-v6mr435519oth.262.1529903368716;
 Sun, 24 Jun 2018 22:09:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b10:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 22:09:28
 -0700 (PDT)
In-Reply-To: <20180622200053.4957-1-ahiliation@gmail.com>
References: <20180622200053.4957-1-ahiliation@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 24 Jun 2018 22:09:28 -0700
Message-ID: <CAPhsuW66EoOKmgbVHa8Hrs=RVjwBxa-Mcb2+=gLpYFPUPg6C6A@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: notification about privilege required to
 run test_lwt_seg6local.sh testing script
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

On Fri, Jun 22, 2018 at 1:00 PM, Jeffrin Jose T <ahiliation@gmail.com> wrote:
> This test_lwt_seg6local.sh will execute with root privilege.
>
> This patch is atleast used to notify the user about the privilege
> required related to smooth execution of the script.
>
> Signed-off-by: Jeffrin Jose T (Rajagiri SET) <ahiliation@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/test_lwt_seg6local.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_lwt_seg6local.sh b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> index 1c77994b5e71..30575577a8b2 100755
> --- a/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> +++ b/tools/testing/selftests/bpf/test_lwt_seg6local.sh
> @@ -21,6 +21,15 @@
>  # An UDP datagram is sent from fb00::1 to fb00::6. The test succeeds if this
>  # datagram can be read on NS6 when binding to fb00::6.
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
>  TMP_FILE="/tmp/selftest_lwt_seg6local.txt"
>
>  cleanup()
> --
> 2.17.0
>
