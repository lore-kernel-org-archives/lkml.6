Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B979CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5C520836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETkr1+YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5C520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeFTMdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:33:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46687 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFTMdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:33:13 -0400
Received: by mail-io0-f195.google.com with SMTP id d22-v6so3275225iof.13;
        Wed, 20 Jun 2018 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlqvigSX2wqFnGf3S6KYoxH+ho/Mn6+DpfqQU/LlAMc=;
        b=ETkr1+YPl32K/jjVSl/oy12TxFr2p7cf/Oz5SA2FLiMCGrCaejd6k8ZKJMjoiS3wRf
         5XCE8gn4JpUH3WnotYa+mRqM2UoVLF+JIpoqkAg5gKklsntAzC5lqPlN4NGs3ti4RgcV
         rghzkJjjTZOGenH0WtGqHUwWen6DH354xq2/gNjLywfaIQDynFvw5334zxif79e0u/1q
         idT31SmCIHSOCTE62jMvxcUSSZ7XO2Jboj9lu4hmTQmeeUveTorsp4xnJaMn4fYA+ilv
         k0dgnwTJxyHd1t9XE/ZWUtK9SX5VPueFOALCA3wZijiEcbXHKok469Rqz98CykGcaZTM
         EUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlqvigSX2wqFnGf3S6KYoxH+ho/Mn6+DpfqQU/LlAMc=;
        b=YfmqlbTwTWK1hbr5h/xi6lam3FYBJlWcgRb0Pvm7La58tgFhFAKooeNg8gXuhyndVd
         9osw9jOGhhobf9hfzmCTU0PAzEEtczev2upHLZMtwRurkglzUho99lV90Yjbyt9ulUtt
         A/2zz4wia7+GsyilBDg4rVLJcvhS9YEt4Bug/eFOP9GR1DarM9I4Id3/i+6u43kKTTdg
         v3U+zOkoMk0fxbHFcyEscQ3HiehRlV0mCGrw2OLsobpAhXq/E+0SxbsHmTRR4YeZi8/M
         Ux2CSWjKW4lsUaUM88Qbe79QUF2hZnHRRVTUlXU6vzMRVxdKsVVhFHZCEMTlO52hkkCd
         pxiw==
X-Gm-Message-State: APt69E2+miVyfGCY/JBgxuAJ4X3LexV39loNNOLB06qEr8bZ7zVTCpeb
        sSs1Tn8EUztP7WZA/UJ9tES/OPorDjHV/pci8YvDC1g7
X-Google-Smtp-Source: ADUXVKKtbYRVJcCaxfJY1e7k9B0XH9JChLRRfDzbJba5HzwVcBzYtu2uqFWnPKvdhYysa7HW6aU9Ild1/0BbUxXF+Jw=
X-Received: by 2002:a5e:8406:: with SMTP id h6-v6mr16378119ioj.171.1529497992424;
 Wed, 20 Jun 2018 05:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
In-Reply-To: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 20 Jun 2018 14:33:01 +0200
Message-ID: <CAOi1vP9Aa9xb2RD7ahE=jOj8nvOX936oVyp6rkKHV8tknF_1Kg@mail.gmail.com>
Subject: Re: [PATCH] ceph: use ktime_get_real_seconds()
To:     allen.lkml@gmail.com
Cc:     netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        y2038@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:00 PM Allen Pais <allen.lkml@gmail.com> wrote:
>
> Use ktime_get_real_seconds() as get_seconds() is deprecated.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  net/ceph/auth_x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 2f4a1ba..99561c2 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -154,7 +154,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>         void **ptp;
>         struct ceph_crypto_key new_session_key = { 0 };
>         struct ceph_buffer *new_ticket_blob;
> -       unsigned long new_expires, new_renew_after;
> +       u32 new_expires, new_renew_after;
>         u64 new_secret_id;
>         int ret;
>
> @@ -191,9 +191,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>
>         ceph_decode_timespec(&validity, dp);
>         dp += sizeof(struct ceph_timespec);
> -       new_expires = get_seconds() + validity.tv_sec;
> +       new_expires = (u32)ktime_get_real_seconds() + validity.tv_sec;

Why the change to u32 and this cast?  If the type has to change,
wouldn't time64_t make more sense?  ktime_get_real_seconds() returns
time64_t, after all.

Thanks,

                Ilya
