Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F210C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17274205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql1FbgE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17274205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJHWAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:00:10 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33508 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeJHWAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:00:10 -0400
Received: by mail-io1-f49.google.com with SMTP id l25-v6so16075175ioj.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHlvVCqPSvIqr2VI+JMj/d4p8FlUlBcs0rrEdgObXbc=;
        b=Ql1FbgE9n9g64+sCump9uc0SJvjuliTxzxwWqKfICszKvZNsdBNh8MVfv6JBdVaiWb
         PkUEJuhzoQfeytPppRh9Aeen1LBGwlZ53Bhv37YSkAN7LAj+nySHDUbUy9MCOeVCJ067
         k/s9VymKF87KQrFYMbaRwMqto2ALvh/FYdvJzuVHp6melUv9K/j7+UCPxt24m+tTqp/m
         hw3UpGx5Q3CdGj2IAI8s0RKUbBdAndbppt5Xo7A6Oawn2Dkflx+ieUW/sH83sPocDOOd
         mPCb/IBapSEKt7MfjrgscXLuu9KRgxCqQmcwTxDJwbvbgOe1N5NOwbSwQJX8YoKqB0f1
         HcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHlvVCqPSvIqr2VI+JMj/d4p8FlUlBcs0rrEdgObXbc=;
        b=opqXHQFC+DMwJJyqpFGno/aL74U0hRHlL9fM19/qDkoTidipUPyPQecCl9AkMVyemB
         4eD0NRy8AQpvnFIGWsZGBGNygdSc7MRR5O54DYSxAWlOEvuMXu3oh04Z2S5agdD3daLw
         xIqWNxfpdbbfzsuLG1bqFhLVaoBVP+XkU0tyLcleMvYsuyI255JG6EkRylpkYFLRPs9u
         bH+cvqTPSNk+FV2tZjYUa2RGMOja2s5V5NQdhwhtgWGTd5e7cwjdk6VrEykQXO9sJoyQ
         X7iLHsqCbtQaMV8m8LsSBjAVWLdu7e0Uh5d8SfAVS2KdUvqzE14ruB+XUDMtp7Atmyms
         VWZQ==
X-Gm-Message-State: ABuFfois4uJW+Ien0tnHkEg6Q6dP+TelILtR/gumDsZgoqBalw8fSSTl
        Sr9RpHcnU/p285us//MntotWbu54Cu8GWk7p968Q8/+l7An1jg==
X-Google-Smtp-Source: ACcGV6200BOC1xsqqCl84u/7m4E+jtPzo9GmO3XLhzml9PuJ6IAqw+bn0fxvskv8txyEOxc/arrXhUpGL3+xqaBmOYQ=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr17492677iob.73.1539010084305;
 Mon, 08 Oct 2018 07:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com>
 <0652963b-90ac-06a7-3a35-50a307465cf9@gmail.com> <CALOAHbAAwr1rsPhHT4R7wn3SYJ220C-i92qObSA3Cvp99M8i8w@mail.gmail.com>
In-Reply-To: <CALOAHbAAwr1rsPhHT4R7wn3SYJ220C-i92qObSA3Cvp99M8i8w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 8 Oct 2018 07:47:52 -0700
Message-ID: <CANn89iLUKmiP==WP=cf9KYwMaNDbsU2M=b07dPU+DspfBGSsAg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] inet: do not set backlog if listen fails
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 3:47 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
>
> Pls. correct me if I missed something.
>

You missed that this variable must be set before listener is setup.
Same feedback than prior version really (when you trived to move
around sk_ack_backlog clearing)

You are changing inet_csk_listen_start() but this is wrong...
