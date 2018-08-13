Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F04C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF72217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC2ahVI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF72217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeHMOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:30:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43866 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeHMOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:30:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id f135-v6so11003260lfg.10;
        Mon, 13 Aug 2018 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7MNtO+SnBwn7ldU/8CiVYDIz//r/E/2DbGvzOFQyu4=;
        b=gC2ahVI1KxCU4Ixm9N8deh/gsAqGLQnoWfTfLjPIyZJFJj767QQiYV/mvz5BrV+C0d
         nBvz7wC+WMnY6t6LUu/1xSrz5jLc+xUA2A/yb40NwZrQGiUrF03dSzOVV3b80nCkUS45
         JmvApEK7W5Vzsapij/9HCYzLtkJlstHck7QQFFD6UlbyUqNJs04eEtvlAmHao9chLUVH
         8KXiLFsITI/KuLkEKfy6/njcQ1pZtLobbqCZk4CbVwEUxMO3lSe6VjwN9iRQkqWDQc7O
         /SSQkFu794nK50gdG/6DYbVdH7Gs7eLJPertOJtfyWNrX2ayUFNMhaNxeb8r7K691Ozm
         tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7MNtO+SnBwn7ldU/8CiVYDIz//r/E/2DbGvzOFQyu4=;
        b=Uj1SpQksZa65X4yyAUpEUiqYecM4609cragCZmPEkn8/8Vc6EbP9UIQyOmWTtmhcNg
         nsFGy8L4X4moKadGanLd1/GNowHRUOCbO5EOWaOOoGorF+7qsox3LVxlTns0r7eV40rq
         srWDKVE4p2KWIckdTXllFa4EJz8cEsCkSGjgCKYCo/cWY4X23mbEi5w/2RA5lBQZpLKG
         mXajzdjkK1akb3J8qXcProH+4TAo8ysUyZEd4iFLqXAJQSj8ycr19+QhzRsMS+8ZOp2n
         TLwcCzz5i9G+3sFqDxcr+xD/88psC725y087VNTD9+i0C54vtU3DKQ0XKOTQJJqCZxPv
         EHHQ==
X-Gm-Message-State: AOUpUlEYF59AhzvEwPuMu2zev6AjWhbrrZPk3mVMOMkR3grhP+dBXHGh
        zqLH1TksrOUzNYw6igCPciic7jza2r5IJ6FthMUwNt7O
X-Google-Smtp-Source: AA+uWPyAEeQdsqev3hS2iKN6YQkgQ0tkfvpWcsBRcGIs7oIuWx6MPEF43j0gsq7vMISSOSjgKCv98LERCsxOgQak8lI=
X-Received: by 2002:a19:c64c:: with SMTP id w73-v6mr2476412lff.2.1534160897463;
 Mon, 13 Aug 2018 04:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8vXEiZ6widPZRdiw-0QejFHwDcTtMz5iKfkHc9gZLZ79Q@mail.gmail.com>
 <20180806155025.8912-1-vasilyev@ispras.ru>
In-Reply-To: <20180806155025.8912-1-vasilyev@ispras.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 13 Aug 2018 12:47:50 +0100
Message-ID: <CA+V-a8vw+1CF=DJuyDp=To-QNzzynritdDcCvvv3DeL+6KehWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: davinci: vpif_display: Mix memory leak on
 probe error path
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch.

On Mon, Aug 6, 2018 at 4:50 PM Anton Vasilyev <vasilyev@ispras.ru> wrote:
>
> If vpif_probe() fails on v4l2_device_register() then memory allocated
> at initialize_vpif() for global vpif_obj.dev[i] become unreleased.
>
> The patch adds deallocation of vpif_obj.dev[i] on the probe error path.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: divided the original patch into two and made stylistic fixes based
> on the Prabhakar's rewiev.
> ---
>  drivers/media/platform/davinci/vpif_display.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad
