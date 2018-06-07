Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SWZ8N5yHGVtKSQAAmS7hNA
	; Thu, 07 Jun 2018 19:29:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 162AC608C1; Thu,  7 Jun 2018 19:29:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cup+qz/g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9msqXlS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86D3660290;
	Thu,  7 Jun 2018 19:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86D3660290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeFGT3b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:29:31 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41169 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeFGT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:29:29 -0400
Received: by mail-vk0-f65.google.com with SMTP id 128-v6so6777332vkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t0gsFFdZGR+xDoKWyJ6cXwo7VicnQIevVmGMpHASeh4=;
        b=cup+qz/gBGbDTg6nIU6CBWXTeOxpFtXyQJtObWdd21T1/LEF0iEPvspmbn2I70Nwth
         oZk+g07AFcnM6U4XykxXHfS+dqzurhICOh5eGjsRnXP3CBj+kkGbvTLEW3x8QWaTPUa0
         4GpspcwMPty9mlkn/480WcNsfe7t3jQSg5ikpY+AQkp7a4exDdcLjBygKPau3CRk6JwK
         g2cYUmHuoPkowx4Wuu+i1HbjncCOrHjUHAsgHLpapgjfttnDdkXnK5JAneYmCAPeroq1
         IyKoPIDw5eVNvVSTMYiEF9Pg2VvkZr4gTixKxJ8C4qGK0ANJvn974fMRwBmRwqtuUN/Q
         HWIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t0gsFFdZGR+xDoKWyJ6cXwo7VicnQIevVmGMpHASeh4=;
        b=c9msqXlSGS4aNMidzmvaxqluF8EGuL/HNZGz/ggH7RML7MWUs1GlCR+kYyU0qOReur
         M2Q6CXkhfVhAlv6di+qkCR/HwXJg0ZD/FEjaXa5Ii4tLcJrshwG+Jzw9/dvIjVEnkyyc
         9e3ZebxkEOjaTG/5j5YiSmf3t5U/m5pvcKVhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t0gsFFdZGR+xDoKWyJ6cXwo7VicnQIevVmGMpHASeh4=;
        b=fGao1RWKu+ZozQfXvnNSMkXv1Z9fCaiVfHE3EadTgVLcDA0+yk9udmOo30LgtECRD+
         jBEiq1m0pU5QcZ2e/yG4N56b4lLpHShenktjTKeXvUOnZhZRCZYGUDWBOXbLx+Fz2FI+
         R4fdmUL+t28S6gPR/DxtVBz8VdkLMXdOa9jQY4DiwOd5LZyHbRSitqJ9p+HT10SbM9Rw
         jWqpzrWnZsxYDD1vs79f4ViWjsJGqK1kraGV6DzganrwNgUsZNY/XkcP8bVnyQ+9LhAx
         jfI8ZKsed4jlWTw0Ug0fno12N7ynS+mvTONZX1LNu8B85zNTupD5pDwjudNc6ubYPV1h
         WU5Q==
X-Gm-Message-State: APt69E25XO5MeJ8gV6Pi/Kdy8HdcU4M8uuSD5hIJTKd0XPSWvTFCp7Cy
        I3FGATl07DWPA7G3HwH9B+gS37d7n1WgAo67Zp51Pw==
X-Google-Smtp-Source: ADUXVKI6ilo6v4kn2Ibj2kMcjmOPNxBepTj/TnGDH7etTM7k/yONHwtdSSMhdblA42W7gI2kYu8cKVA9YatI7VIBPlU=
X-Received: by 2002:a1f:8188:: with SMTP id c130-v6mr2026428vkd.96.1528399767521;
 Thu, 07 Jun 2018 12:29:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:29:26 -0700 (PDT)
In-Reply-To: <20180607145720.22590-2-willy@infradead.org>
References: <20180607145720.22590-1-willy@infradead.org> <20180607145720.22590-2-willy@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 7 Jun 2018 12:29:26 -0700
X-Google-Sender-Auth: Zio1P6d2k20gG5V1y5ENJ19Xq3w
Message-ID: <CAGXu5jJt_Y5KJwCKVPpTFOBt36aDAG9TqbB2bWAdu+2oGV5cZg@mail.gmail.com>
Subject: Re: [PATCH 1/6] Convert virtio_console to struct_size
To: Matthew Wilcox <willy@infradead.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:57 AM, Matthew Wilcox <willy@infradead.org> wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/char/virtio_console.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 21085515814f..4bf7c06c2343 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -433,8 +433,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
>          * Allocate buffer and the sg list. The sg list array is allocated
>          * directly after the port_buffer struct.
>          */
> -       buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
> -                     GFP_KERNEL);
> +       buf = kmalloc(struct_size(buf, sg, pages), GFP_KERNEL);
>         if (!buf)
>                 goto fail;

I feel like this one should have been caught by Coccinelle... maybe
the transitive case got missed? Regardless, I'll figure out how to
improve the script and/or take these.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
