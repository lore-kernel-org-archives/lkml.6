Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50DF2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO5CSOc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50DF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJJX3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:29:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45102 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJX3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:29:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so3476148qka.12;
        Wed, 10 Oct 2018 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zp3JZCOowVTIt3vYzt2E763vMPdsIZvVj6QE5kAJE4=;
        b=BO5CSOc4LQZqknq16RBzZMHGRlPZBB0n1jwaoL1eYPIUYKrLHAuKprGqDaqDODfSQw
         drlhzvdjGmjsf1B7f7lIAqn7z+yZ6jrINrUD0TEANh1t/0AvA5WCh8/qv0U8HZzBPUku
         1WJ+KogaKcj6IvmX5ToBCPKwTSUjZt/AMn0dHikFK16LQ0JBUISYYwhZxL3IiuLWKch+
         yPx0YUcqEquQHl/zALvj3dq2bkysfF3TtsdJ7CuYHL1KYcgr9pJjamWNQZUZhG65p9j2
         Bv1mVTC5EuGVpwHzZWoYdCtZTZ6PTsG5Wcg/EKcE5fo1he1I9NyQ0+X9wse1PT5nHhuW
         Xqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zp3JZCOowVTIt3vYzt2E763vMPdsIZvVj6QE5kAJE4=;
        b=amDscrCNZzbNHFg4NSmscs+tREOAU7YFzKiQnSqWH/oxEmzWAMKHcvWTEriLnMFkWU
         e44CJ+5aYIUyqHVL1neoBKEvTzwrAeKBoyHsefMqISsL56J89vvgG6WQWtBZRU1ZRvHT
         BkAW+rs7xXt/AxLKUJMPVoxejulQRGwxUySxIiNKuPiXgeswNXIHULmU2hZ2FwK7aFhg
         KQDwJ+QyAsD8WuK0j4m3wrbQ1CBJcDwdP4HLanC5fX28H/NxJL0v8N3Xfz5ulKIu3uHr
         YAnD2nPJbcRCJKYQEcjsobHpiZrWrQO0/kwDR89lfF6m40WOrkAMBLvquClMNNyeRQmg
         19qg==
X-Gm-Message-State: ABuFfog2TeBQb2ZeeCJUthm4yhV9HNXJeq+57w0eiGsEV9aYOrYcIiNh
        oAN/kwxIH+py0oYFXu0JRZx+EVdadtouYSKJGUDoHBwc
X-Google-Smtp-Source: ACcGV63Mu4C7BEACc3ziQT8mHxDCOHrd/KgiRPgbLH6NvqOp9Ichzam0GabptCmUoO6cD8yiG3hGOXuvfDnWFq5dRFo=
X-Received: by 2002:a37:28d4:: with SMTP id o81-v6mr26022322qko.120.1539187620373;
 Wed, 10 Oct 2018 09:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181010092123.26218-1-anders.roxell@linaro.org>
In-Reply-To: <20181010092123.26218-1-anders.roxell@linaro.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Oct 2018 09:06:48 -0700
Message-ID: <CAPhsuW4BhxJoQvqzTM1Z-O_JKC7m=uS3HuGatX6vMwoEJvWNNw@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: add config fragment LWTUNNEL
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

On Wed, Oct 10, 2018 at 2:23 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When test_lwt_seg6local.sh was added commit c99a84eac026
> ("selftests/bpf: test for seg6local End.BPF action") config fragment
> wasn't added, and without CONFIG_LWTUNNEL enabled we see this:
> Error: CONFIG_LWTUNNEL is not enabled in this kernel.
> selftests: test_lwt_seg6local [FAILED]
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 3655508f95fd..dd49df5e2df4 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -19,3 +19,4 @@ CONFIG_CRYPTO_SHA256=m
>  CONFIG_VXLAN=y
>  CONFIG_GENEVE=y
>  CONFIG_NET_CLS_FLOWER=m
> +CONFIG_LWTUNNEL=y
> --
> 2.19.1
>
