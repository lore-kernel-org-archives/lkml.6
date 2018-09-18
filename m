Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E8ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0375420858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="lEmUTxfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0375420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeIROHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:07:06 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41701 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeIROHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:07:05 -0400
Received: by mail-ed1-f41.google.com with SMTP id f38-v6so1176240edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pLLWcM4gQUZuoxdYcZ5Wwd2JH8nAR3Ld9T0G/svNncs=;
        b=lEmUTxfyCrVlcioWiZIKK32T4gKPycy+zcES4T7btp4H2i0zVHj1He8/8TxdB0lDTv
         m1Wse5tqMCFZhW5zPmstrLhUogbXRZi4IC6naruKltA2QndmH5REW+HTWxDNHQGr0v0v
         ym3GSFvVt5MJBKg5QxzogUaYKAV6xA7JIszya+qLmHI/jooqu0Xb+jV4nhrfv81itd06
         n/ZlBvxGPLJL8kXdKYmjXYRxomNZlFmOvRYfVf+Eg6l/UZ37PNMIUmAfx46FHl4gwwV/
         3MYW4F9HIMJVXfUKRGD2yIVlV47Jx4vQ736QQUMpqA+VrnZV8vw87MmV6lWepwqhu1nu
         TQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pLLWcM4gQUZuoxdYcZ5Wwd2JH8nAR3Ld9T0G/svNncs=;
        b=JD6iIMchgA9gmxtQ42z2DE+y6WSA9SFzRjuZSvWgfCPetYVk2eGhTmJ7rwMfib4hbc
         h7v3dQ4WfeNhQB1szNVXAOaPFLmZBM0X55kYnnOWT4CEYVyC8ZBkNkj43t9c22ah1M2j
         ySaI47NB+uOeMUMVma/BW7BvpiQfFyqJTlI45xAG1pXhr0N2Rr+WGgj+OZ6SJ5bmShmC
         qYoJlaBwVteErC+eKFWWzftPIcYyNHavccRmve/Z/mHlKMRZz5g9TKk/XN+IiQ14AjBE
         dHZ60OQYEwhOp1R1qyaapZUqn4wGU65HqHBwIu8okN2WbCTsvS+jhHDYhMojisU4HkfE
         w8Ow==
X-Gm-Message-State: APzg51CWIdBpeuP0ruhN0NS9qpbslufQma33FkbUBWd5BCez3/lQsls3
        mqTT0uApZFtO/MQcwC7NG1uQr3Gb6VgP/B/2UAAoiw==
X-Google-Smtp-Source: ANB0VdYv89TghLYK5w6aMM5ZaadZ4OvX+xFvWUHJBDUtc/fOZDukJGPFkSkFL4FdHsDWnhp8AfB2gTjY0OkIQbfuoV8=
X-Received: by 2002:a50:8141:: with SMTP id 59-v6mr49230774edc.61.1537259730633;
 Tue, 18 Sep 2018 01:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa7:d499:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 01:34:50
 -0700 (PDT)
In-Reply-To: <1536852930-18926-1-git-send-email-jinpuwang@gmail.com>
References: <1536852930-18926-1-git-send-email-jinpuwang@gmail.com>
From:   Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date:   Tue, 18 Sep 2018 10:34:50 +0200
Message-ID: <CAJX1YtapSbc3OZM+S3eqvOJRO6h1NG1tfxD-We8R81BLoLk7nw@mail.gmail.com>
Subject: Re: [PATCH] md: bitmap: use mddev_suspend/resume instead of ->quiesce()
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     shli@kernel.org, NeilBrown <neilb@suse.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 5:35 PM, Jack Wang <xjtuwjp@gmail.com> wrote:
> From: Jack Wang <jinpu.wang@profitbricks.com>
>
> After 9e1cc0a54556 ("md: use mddev_suspend/resume instead of ->quiesce()"=
)
> We still have similar left in bitmap functions.
>
> Replace quiesce() with mddev_suspend/resume.
>
> Also move md_bitmap_create out of mddev_suspend. and move mddev_resume
> after md_bitmap_destroy. as we did in set_bitmap_file.
>
> Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>

Reviewed-by: Gioh Kim <gi-oh.kim@profitbricks.com>





--=20
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
