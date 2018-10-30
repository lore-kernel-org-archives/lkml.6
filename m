Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725EEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ECB20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="oeNIYn5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38ECB20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeJaBiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:38:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42391 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeJaBiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:38:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so5925068pgq.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OtMAj1L7mXwhMbSq/VcI6iHOvUL4RLxD22+oCFKUVY=;
        b=oeNIYn5fzcWxQBawf4khXDdYRMbWr6D415pElcQcwspL33Q09ZXQ4FctwZGZ/KwFsz
         Pgv08XRv6oU2bfJfdoAYUGT9FDxD4iKFco7XTXotl5U/OPYREBo2KX3brqRQR3ja3o/q
         +pMSMgKzSvpyValb7o5jXJf2fHJMVO/g6fnFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OtMAj1L7mXwhMbSq/VcI6iHOvUL4RLxD22+oCFKUVY=;
        b=hbZ+Qpe8XjOnb8SDdHA3/2qlLZD8bImLgnzzo0ku0VKmLAGIiuT7r0YLRwfHY2zGjW
         WIb56+KRqXp2mFSjMu6T1jGnMciOJF2lM/qF8XeaWc/Z/VyBO5nI8+KAob1MeGboyuHH
         3kSuy6osmiYSjK4o2y6Ze7381MADRt15/lok0LDGZuIW5U/7eY4SHvePj02S+5XBooBg
         Xmus3TxVCgByO+NJ5oVj3UIzwMwuripX5sx1IVyDn2Cma7bZsgHv8UctbGdf3h+YjcVr
         v8laJV8bKQ5pPg+qGEFMwNOQqt2QjwN2Y/NE4n5TnKGMJCJJuWNr+jv8KMNcH487xXpG
         TFhg==
X-Gm-Message-State: AGRZ1gKesVbG0NDGgY4yjfSLV+abmC/OaH/qSqZMWivt3Z50f/hrnPLH
        9m1wVm16yKzfzX9/BmvViYzAH2NPOTzfJr11nWKK5A==
X-Google-Smtp-Source: AJdET5deoaExYnnktCHj5yM9YT4hpmsoY6Ko0RP2xl/R0a2nxq6x8WCot5izY0MYuWyE4Pj2d4ukCYWXOLuqoxAfrZE=
X-Received: by 2002:a63:480d:: with SMTP id v13-v6mr18691506pga.308.1540917837132;
 Tue, 30 Oct 2018 09:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <1540913482-22130-1-git-send-email-Julia.Lawall@lip6.fr> <1540913482-22130-3-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1540913482-22130-3-git-send-email-Julia.Lawall@lip6.fr>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 30 Oct 2018 09:43:10 -0700
Message-ID: <CAJCx=gmixee=j_y9v__40x1StZXrtaK0wWrWDibMbYb3HAfnbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: video-i2c: hwmon: constify vb2_ops structure
To:     Julia.Lawall@lip6.fr
Cc:     kernel-janitors@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 9:06 AM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> The vb2_ops structure can be const as it is only stored in the ops
> field of a vb2_queue structure and this field is const.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> ---
>  drivers/media/i2c/video-i2c.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
> index 4d49af86c15e..cb89cda6553d 100644
> --- a/drivers/media/i2c/video-i2c.c
> +++ b/drivers/media/i2c/video-i2c.c
> @@ -336,7 +336,7 @@ static void stop_streaming(struct vb2_queue *vq)
>         video_i2c_del_list(vq, VB2_BUF_STATE_ERROR);
>  }
>
> -static struct vb2_ops video_i2c_video_qops = {
> +static const struct vb2_ops video_i2c_video_qops = {
>         .queue_setup            = queue_setup,
>         .buf_prepare            = buffer_prepare,
>         .buf_queue              = buffer_queue,
>
