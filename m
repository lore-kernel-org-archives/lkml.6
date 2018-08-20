Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA848C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0362154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0362154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHTPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:54:55 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39541 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHTPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:55 -0400
Received: by mail-qt0-f169.google.com with SMTP id o15-v6so9921324qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 05:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvN3XEWBw2sKCXhR31ZDRtKOW08hMSGdIM4K16zF6OA=;
        b=T+YbXry2aqo2pwqhAEWHUwjahOULJRGTOKPDIhWX8oYpXDcSfrg9IAq/x3ZOEY5KUA
         cdi7sNk2uEOMJf1p1SVynee2wOTJYC7ERWnq1ia1UY83/Yu9wJek5Bdtuus97t8VdPk9
         iatpwbNsHhyJ9qeAJEOmjIDN6DtMDCm7ik3mrfT/OTsqcEMnxfhiHL9NeX7LYzeUu9Sp
         qfWHuYYuoNLW/669a/7VOQBkAXq8w7g1G+QIWPYb9J0r+O+AFFO6yD4t2ZsfuYQwilT3
         yLUduDJZu4w4oGAnCQpMenU6roEcbMCn8FUKavcANA28K7rr83+gpXAG9LMvThM3vU03
         8J0Q==
X-Gm-Message-State: APzg51BvzBdXi+fnFRFSkTRGJunxE6ks3V/1HWc1H/l1fQitQJKeH+z5
        2JlZ5vDkSaByjyibfJw6m9dJNwzk6kHIZFy6EhvW/w==
X-Google-Smtp-Source: ANB0VdaAjo+vdpa1++sr5dHsjvzVFxZa/4tDCpocyMVslph06jJWUm1xkJRwNv2bO2/+/pUnKqAgYyqXu70vdsGxGK0=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr2363631qvh.40.1534768765765;
 Mon, 20 Aug 2018 05:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <87zhxkjyww.fsf@mail.parknet.co.jp>
In-Reply-To: <87zhxkjyww.fsf@mail.parknet.co.jp>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Aug 2018 14:39:09 +0200
Message-ID: <CAK8P3a3SVi2odjavRy-ktzcU2sMREVc+8EKxmDq3cv2nGeTeCg@mail.gmail.com>
Subject: Re: [PATCH] Cleanup "fat: propagate 64-bit inode timestamps" patch
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 2:34 AM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
>
> Looks like I missed the email to read for a patch
> (mmots/broken-out/fat-propagate-64-bit-inode-timestamps.patch).  Well,
> so FWIW,
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> And additionally cleanup patch here (this would be better to be folded
> into his patch).
>
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> [PATCH] Cleanup "fat: propagate 64-bit inode timestamps" patch
>
> - Remove useless temporary variable
> - Remove needless long long
>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  /* Linear day numbers of the respective 1sts in non-leap years. */
> -static time64_t days_in_year[] = {
> +static long days_in_year[] = {
>         /* Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
>         0,   0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0,
>  };

While this is correct, changing it back to a signed 'long' type seems
rather arbitrary. I tried to pick a type that would be the same on 32-bit
and 64-bit architectures, the other choice would have been 'u16',
which saves a few bytes.

A completely different approach would be to just use mktime()
and avoid reimplementing it.

     Arnd
