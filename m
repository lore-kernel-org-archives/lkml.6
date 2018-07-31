Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF61C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jvTDNZcL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4KL1Vxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D4C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbeHABYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:24:19 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43378 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbeHABYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:24:19 -0400
Received: by mail-yb0-f196.google.com with SMTP id y3-v6so1112506ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SqVUbDUqNmGJmiRFENppNJIF7juX9s3HYwyyFJ4rqLo=;
        b=jvTDNZcLFK2wAeSmB5dKrbEE20JY+6ylGln7hozQKX+BUfl6iYkJoOARjLo3dlFlQc
         FdmE3LbK0QnrtHfTQoqaajHvl7+VCIpTx4T2gMeH7P6XMzgW5/DXgpC0pj+m6zDvaXVw
         dhknBKh+RcZWanPjrXZJVrVu21dZTuPQE3tFbotA7d4H4lQAG4Cm46jHrf+nJUGXUUIa
         khB5Mfd4vZiruRzzbAjVZsR4B1g9Jv6gk6dY+0YdCT9NGI3r54pCfm44ixo0Ze858t8i
         0bCVQkd7crVRYKgMbIqQhOpEGaJ32i+vTtICd29zFBYI8DlyUrVMB2uK+b6wrgd/Od/Q
         zdoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SqVUbDUqNmGJmiRFENppNJIF7juX9s3HYwyyFJ4rqLo=;
        b=E4KL1VxkbsxNvhsMFBFJJ/ZpDLfiiCwnym0iMNFcLEtfLj8P/b10XTy1lhn3cqBn3k
         IHlYRBlfmZaGIuxggDI3sYjp5b6REJ3llWwvlXmMNn3Q0axw3WRxwGpds4vXGqzgdP2e
         1fFBFODoDYAX7xiZt5xC31J43mXi890SHFkoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SqVUbDUqNmGJmiRFENppNJIF7juX9s3HYwyyFJ4rqLo=;
        b=Ur0z3GkwHZxpPHk46LYlP8yushvm+zeflIbJQ/Fun72OawMmjxyhXDxblWZoW9YbMh
         qAsM514Ye3+l96A9jv2MxOqKLugcS83YsrUYNWmyxSwiL7zl+hGOa9LFCUffQ9I37lzg
         19k4lCORgSC/h2tGosvNsm2KOeHJLpq4+0xoMfBu/wwB85PitT1umT4J4yaIt1tGEm+W
         zY1YskfgfyG4hYfY+v5pn4az1jqC5MDbBF16EqkbsJnXfZfGXYLdNzeTJWHffqyDRbSN
         KVeebPrNZ+gEj7BgM5j2xGNo1RtXvvj//7ZlQ1xv/jo34LSng4yeOy/C0EkiCTHOmkwW
         vBMQ==
X-Gm-Message-State: AOUpUlHCEEwa0Tp6qQ4hDJ8wyp1a8xG1MJMWz1VxtQmwDeuGNad71Xs4
        ZylijXFkuRA4TbymJUtluvFEflLG0r71emkv7kGkmy1C
X-Google-Smtp-Source: AAOMgpcZGbm0+EfZ0B0InurWFsqek78sG7Q9bv24bIZTLcOaIvRMr+uTrhal9iAUQojEGY8BXgF1hPlD41EKM+6Uwws=
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr12915371ybv.484.1533080496241;
 Tue, 31 Jul 2018 16:41:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 16:41:35
 -0700 (PDT)
In-Reply-To: <20180731220225.159741-1-salyzyn@android.com>
References: <20180731220225.159741-1-salyzyn@android.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 31 Jul 2018 16:41:35 -0700
X-Google-Sender-Auth: 7hHtSnaYGOEw7I98_sVKsl26occ
Message-ID: <CAGXu5jKoEB5AOVqkAnqq9SjGRU+qSgxdk2ZBWkwZxZOkK8Fn1A@mail.gmail.com>
Subject: Re: [PATCH] HID: Bluetooth: hidp: buffer overflow in hidp_process_report
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 3:02 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> CVE-2018-9363
>
> The buffer length is unsigned at all layers, but gets cast to int and
> checked in hidp_process_report and can lead to a buffer overflow.
> Switch len parameter to unsigned int to resolve issue.
>
> This affects 3.18 and newer kernels.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")

nit: normally just first 12 of the sha is used.

> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: security@kernel.org
> Cc: kernel-team@android.com
> ---
>  net/bluetooth/hidp/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 1036e4fa1ea2..3bba8f4b08a9 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -431,8 +431,8 @@ static void hidp_del_timer(struct hidp_session *session)
>                 del_timer(&session->timer);
>  }
>
> -static void hidp_process_report(struct hidp_session *session,
> -                               int type, const u8 *data, int len, int intr)
> +static void hidp_process_report(struct hidp_session *session, int type,
> +                               const u8 *data, unsigned int len, int intr)
>  {
>         if (len > HID_MAX_BUFFER_SIZE)
>                 len = HID_MAX_BUFFER_SIZE;

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
