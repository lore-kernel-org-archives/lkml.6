Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEFCC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2838920882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfY/fh+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2838920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeGINCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:02:46 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37048 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGINCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:02:45 -0400
Received: by mail-yb0-f193.google.com with SMTP id r3-v6so7143111ybo.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a3levn8RdYaAisr0+pTjRZUoRkRGFmn6qqRGP8BQMjo=;
        b=HfY/fh+o7kd96kt63A1cyXaVBHYEtu5hBNjllVJmHDO/eqg2PGcLOu5erSqwtztns2
         jJKY5U4NfWBoOYGt8VvV711cNHsc72DejkWimwa5bq2HvEniN6WdvkAH0X8dKXvKAENH
         bqnBJgEJ/0L27zX6VsMjk5ockG8kNy+2Hj2Y03KssjD+nvfN5/7ZeSMebwCyAZPmk4oR
         N6/a41xhh9xQrvl6LxPUXVxYHQSV8JF9mIv/fHMB43s0X3Q/xsKs9k7URQbphCI2d8Iy
         myOEdKX1eNKhUQGccWhlG3MnJ3ILC5XkZML4cZhCHEcsTvQaT3DKUhEpYxWaIGXtngJv
         lfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a3levn8RdYaAisr0+pTjRZUoRkRGFmn6qqRGP8BQMjo=;
        b=YtpemaZkmoZx6UiOGy9q4PG9hNnkt914ltyX5A9aNKOOzqESuUc0NbAPnU324mw/Iw
         Y5vAso/fixjgX4aTapE499wtawyCawcGEQwmBvuCR8H21nJOHsTppD4mOgvu2mTsnNwH
         4kax+OFeXVoKPQmpaF7rKkVPPrL/L2XHSy2OArKl5d0UYSbDCxLsRfYufYmjEpGNRs9F
         /z/MvdRGCuCVBUiMbiW5uudNoj0P/qdfvMvFlYBTejeLtuYgaiwsrFsqgSQNzHqAjmr6
         lFQbINjXf2DtiaHquDqlRcWRwper8tOxDNQu37kkDlweTf/XrNvNxcWISxjOiSTivuBm
         RQeA==
X-Gm-Message-State: APt69E2uyMxFlO/YHuDQ32OT9MED3DzepMAVyMFkI6A91eXMr/5EM4tL
        iyr1vXxNl+gBOvz7mRP45bQNlpaoW9RmO7HvcvM=
X-Google-Smtp-Source: AAOMgpf76XOQnGZUqYmtsYmfmtcJdufqI/e9k2Tc5bYjVq5msDtFEtlDXjMKaZwY8chq1emxjPPSwgxgRj3+Yojn7/o=
X-Received: by 2002:a25:1a04:: with SMTP id a4-v6mr10527011yba.53.1531141364656;
 Mon, 09 Jul 2018 06:02:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:f414:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 06:02:44 -0700 (PDT)
In-Reply-To: <20180709125636.x4t5t7bgo632vowj@mwanda>
References: <20180709123632.5682-1-rjdurga@gmail.com> <20180709125636.x4t5t7bgo632vowj@mwanda>
From:   Jaya Durga <rjdurga@gmail.com>
Date:   Mon, 9 Jul 2018 18:32:44 +0530
Message-ID: <CAKGJ+jx3EX96q0xUnng_w0DHAT+d91KhGnzXHN8U3a7aw_Q0TQ@mail.gmail.com>
Subject: Re: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        deanahn@gctsemi.com, quytelda@tamalin.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
I have updated the patch --subject-prefix="PATCH v3" and made the
commit as per your suggestion ,
i don't know why does the script doesn't update my changes,will try to
sort out the issue ,
sorry for the inconvenience.

Regards,
Jaya Durga

On Mon, Jul 9, 2018 at 6:26 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> I don't understand why you have sent this patch four times.
>
> Are you a script which has a bug?  Please answer us so that we know you
> are a human being.
>
> regards,
> dan carpenter
>
