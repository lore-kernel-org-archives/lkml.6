Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC70C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47B62652C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 05:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz80/ai2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47B62652C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeFZFdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 01:33:31 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45504 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeFZFd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 01:33:29 -0400
Received: by mail-ot0-f196.google.com with SMTP id k3-v6so4117745otl.12;
        Mon, 25 Jun 2018 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=173+nqW/4hsa4WBCGR7iTfbmuOTAZubBq6d2zhkkJbs=;
        b=Mz80/ai2bITAKXp8/9SX261JNM/ldDcxqrHyOW0zbVhPZ8uiXeJ6gKW9J2E2DmDZFS
         GLRLAXqQyOqj9D7GGJaIwAR+Z1WBRE+dixfU5a1EkLxBIEGgN+ADv3a2rA9dKiaITw6/
         fV+AgrJyZKzfgEkI86UisyvPk5Zdd+IekO/Hqn665YHYVsrP0BfvxeWc1alDXO0fRjhQ
         uefCi9vTMR2H4AHImgADny/BobYyiRqXvvbbV6Rb7LBb5iLCPXsslwXkSib1IbCpfy4H
         nv6aWkqVZIrDkrS3kdx106Ot+Tgg6U5vEMRG+EREVlyPpCTbYS4tkhAQxzk3mYN8KbvM
         etzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=173+nqW/4hsa4WBCGR7iTfbmuOTAZubBq6d2zhkkJbs=;
        b=PI43L2X6dwngWEqLEkXPoBi65muPJPSyPjEdwMo4grezrabVZ++kd9lkM+FpegAuvn
         nEf151rMH31fFHBK3J9Dtbt7/o1CerM7pc9DaIth7xPG343P4H0OIxgiP8wCtYQHaJ+J
         V+WPYsw5BesG6sjJcyvugYJiu8s+Seq4PwR8XBH0Wdx3yvxvhzomjaI9XcQBtqxkJ8a8
         P6e84ZdN1CzwZ0rXGZgfazkjAXOnnHJRqYF7UX00psAXpdxmDiyCwRXZ5Hqlrb+NTUmo
         HA3mFh8dzwvE1CURB18vfK+F9e0trHdRC9UMbflGr4cclUANkTXuhbikQDujPqLpxuey
         qRPw==
X-Gm-Message-State: APt69E36KbwtjNfgp5361xO/A+mJuV6yrPaJ0QcowdgoBv0mvSpqQ6J1
        BH1a2LIteG77a+fzAZHZcIU6kC0gLXDcqwpafoA=
X-Google-Smtp-Source: AAOMgpfsV727t4Wn3lJZybi7TBwOqvtuUVzH73jBkpNXFrlEaW8tIVVE+cQ3TCzFT253jckHVKhkdvIn1+kV8tQ4+iM=
X-Received: by 2002:a9d:25cd:: with SMTP id q71-v6mr40439ota.262.1529991209211;
 Mon, 25 Jun 2018 22:33:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b10:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 22:33:28
 -0700 (PDT)
In-Reply-To: <20180622214032.6527-1-ahiliation@gmail.com>
References: <20180622214032.6527-1-ahiliation@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 25 Jun 2018 22:33:28 -0700
Message-ID: <CAPhsuW40D4SGyer5pwf_yM5UdQxViuPJUGmxY8HvcemTBg+MZg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: bpf: notification about privilege required
 to run test_lwt_seg6local.sh testing script
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

On Fri, Jun 22, 2018 at 2:40 PM, Jeffrin Jose T <ahiliation@gmail.com> wrote:
> This test needs root privilege for it's successful execution.
>
> This patch is atleast used to notify the user about the privilege
> the script demands for the  smooth execution of the test.
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
