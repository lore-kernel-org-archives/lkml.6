Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048FFC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A371721708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqXzeOIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A371721708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeI1Amj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:42:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42616 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1Amj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:42:39 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so2579652ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7rp/5iEndkLZCxZXbT5YYafnRVKH0TTcfePVIV0nnAM=;
        b=mqXzeOIV90UIp5wF8L4RhQQtpggJ+OYJgN+2xcGz7zRirxyphxlzs8Q7gDgbt/EHGw
         Gz1ODh87bLo6OCSh6fGMBn9VgGJEZLUpyccxLMldaMoS/caD/o7e1Nz85T1+XdP96it0
         DhugliZVIJyVSpCiQRNXLyynhdj1n9OpdTQeXkb3LE/6YPzIZjsZKmSze/mR+WH/2/cD
         y13y2MQmFBvDGOVfNvtQLEycCg3rjrWB6EB8YxSW8e9btrJUA9KxDSVWx/+98hL0fXfg
         QzrAg8o/VFZ3M1W0T2MoLxcxD68v7+gaCcSyXtgpxufo14KRC+36n3gYwKsabn+0bKPL
         AX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7rp/5iEndkLZCxZXbT5YYafnRVKH0TTcfePVIV0nnAM=;
        b=Bkkd/6lW4tupqtWs3PeHBeaQGEeWR/GU01elxEFrJnc5z9IDha9n0ilCx4p1cqmRF5
         rVWb2MUjhWke+NaQRTqN9qZ/YE2v5L5WVwpzY3wxErOmZnR1txpOf3nirq1smC1cYMKF
         AAu+ESegWqJB3G/TfD/aCt5cvrxt+WBx2TWrpH6IvRZgC+Hm51mGmo5ietaP5riI/EJs
         4mvoMvnbeVsbKYBvvrGwLdVg+LcdC7CXj8hcsHmtjAwM6qE10dIR7bnoEaYhCilE2ISU
         kuEMhFzYT5K/2vxKO6zZh6Weq71ICkWEP+badph6Ffno0nkSb02fDNRJckWYxxQzdvPt
         qUAA==
X-Gm-Message-State: ABuFfoiCGrWRSCi8qdFL97gRx8mnhQl53DCkCcQql4EHFFgpr9vRRN2T
        VTHS+gYeHo2Qp7zBaQDI8tgCNgBWamdEn39vosECYEA=
X-Google-Smtp-Source: ACcGV62hCQqGaAst9A4EY7AcexWbUFNtGcPXVhArFQJ6GKoNBWjMyx1B7Hzl5p8Bs1kbBhJWbJpMHGqaVziO7coiwRU=
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr10196340iog.31.1538072587464;
 Thu, 27 Sep 2018 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180927134117.15371-1-xyproto@archlinux.org>
In-Reply-To: <20180927134117.15371-1-xyproto@archlinux.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 27 Sep 2018 14:22:55 -0400
Message-ID: <CAMzpN2iC7-CaxAsgrq-jwujgMYRqPf_5DLihKUHF5F6a1nxabQ@mail.gmail.com>
Subject: Re: [PATCH] Reduce boot header size with 1 byte
To:     xyproto@archlinux.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 9:42 AM <xyproto@archlinux.org> wrote:
>
> From: Alexander F. R=C3=B8dseth <xyproto@archlinux.org>
>
> Only ah needs to be set to 0 before calling interrupt 0x16 for waiting
> for a keypress.
>
> This patch changes the line that uses xor so that it only zeroes "ah" ins=
tead of "ax".
> This saves a byte.
>
> Signed-off-by: Alexander F. R=C3=B8dseth <xyproto@archlinux.org>
> ---
>  arch/x86/boot/header.S | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 850b8762e889..905cb96f43d4 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -71,14 +71,15 @@ msg_loop:
>         jmp     msg_loop
>
>  bs_die:
> -       # Allow the user to press a key, then reboot
> -       xorw    %ax, %ax
> +       # Allow the user to press a key
> +       xorb    %ah, %ah

Because this is code running in 16-bit real mode, xorw does not need a
16-bit prefix and only uses 2 bytes.  You save nothing by using xorb.

--
Brian Gerst
