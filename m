Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7358FC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2B2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YupNbHs7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfAYGZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:25:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45609 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:25:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so6101417lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 22:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWkGNsj9H+PPXdmDM8jphreLemaKpKVhG6fjRtFnO8Q=;
        b=YupNbHs7iQOuXsIbeTOXEVnZWfkYovxF20NQ9awvZDPy3o8iS3gw202JHD+bqIdggi
         UC14YfN4ZrjI7wuEC4DsSOrSczpv/7Y3Wf4HmgUgvtwNLvJKceDaTs8OI5dH73FH9cQD
         LY6TE4NtmLMKmcOTYdiuV4C8EDCAetO1QZCN9xqdK/xdCRgoQ6YoFfk4NseNKYsX3tLi
         Qc0/b7DsS7n+1jljKTJNoyZYK+mwbbZMW5CEsPWDVwNh7AN1d5Ycmr9yKEvU94TgPNyk
         JdQSXkO376pFgoEgPwv5M9iT0TLyDJytBSp3tnVR7+XNKX8CyRS3SRRnWZJuLkvJ1pKJ
         fUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWkGNsj9H+PPXdmDM8jphreLemaKpKVhG6fjRtFnO8Q=;
        b=bkvpVEsf1rykPccNnVu2spax88OMiZIqK8xYCxBg5bUKvcfOHrG59dXvewoV+uvB8j
         7mZuvnhrX7Gz/P64hrQ9ImqcSk91CKt+r/N3GIilSocy7azVD+lJr9WoqWVBe25W4/HA
         0gtFP9NDliheZVGg5mpEs0YXjk88UIKd+HGeEH8ZsRAQBC6Tt7X4mJWInMeZnSytPZm0
         p9aQ6p8qgyY16ZOwHet9yht5i6CeXKO7LCn8otjd59ahlCGhSNRJ5HZXVTwnh5SekNVG
         YUK+HVRIpEQz2zTxoMWZ1950KWEgXlcrRhQqWxdvVxx0k/JVlakHrDmAoFmYfO9z04Bv
         R+WQ==
X-Gm-Message-State: AJcUukdfPDYwgiP1cmc4gnHIhVQxDo2ElARdroHZ5tnYJbYSEgvZ3lSt
        BCdZrYbI+rTD6WJy+4bwVVuHkMiwnCBdgEKR1ic=
X-Google-Smtp-Source: ALg8bN4TGwzzV9+rDqN6jqokcuS2worneigqBlgltDsQYW2kgwnVOXojAkAzi6U2DdppgszxXxvosU25VS4BiX6F4FQ=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr7847121lfc.27.1548397514916;
 Thu, 24 Jan 2019 22:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 25 Jan 2019 11:55:03 +0530
Message-ID: <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
Subject: Re: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 8:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range_buggy to map range of kernel memory
> to user vma.
>
> This driver has ignored vm_pgoff and mapped the entire pages. We
> could later "fix" these drivers to behave according to the normal
> vm_pgoff offsetting simply by removing the _buggy suffix on the
> function name and if that causes regressions, it gives us an easy
> way to revert.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  drivers/firewire/core-iso.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> index 35e784c..99a6582 100644
> --- a/drivers/firewire/core-iso.c
> +++ b/drivers/firewire/core-iso.c
> @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
>  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
>                           struct vm_area_struct *vma)
>  {
> -       unsigned long uaddr;
> -       int i, err;
> -
> -       uaddr = vma->vm_start;
> -       for (i = 0; i < buffer->page_count; i++) {
> -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> -               if (err)
> -                       return err;
> -
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range_buggy(vma, buffer->pages,
> +                                       buffer->page_count);
>  }
>
>  void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
> --
> 1.9.1
>
