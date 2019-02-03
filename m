Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B5EC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53DC2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJsGlez9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfBCMLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 07:11:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBCMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 07:11:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so9436865ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 04:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SrF1ldydTiBZNiCjzZif0i3Yfeug4ftFhfixRtZHpw=;
        b=pJsGlez92rrWhCVjLzcirAg32UfgdzZmz3h7IHlwSMeHDraTB7Az+ntFTMkWHQT8N2
         vhuMi+jS1XIhIbR3VzbVgsxBQJI1didJosDf31B6hngRyB8PS53CxxYR/Rc5tc/g+EYC
         zJW8XqZe9g+X3OJiIUGV76zTpSaLQ3B+WeQIaHaQcNJHwOIq5HAbUnaog2y1NXfRrOlb
         btsjOSK1MNVgF/sYbuPDBRUk7whc5WI3p+6ho8cI6vTN0WddJ0eogXaxBMwINDFHl6pM
         pkS10Z9mC82aOkfkX6hczwBIxYVrdI8c+OqCSfWf1Gfh4lE8hHKYtOqfYbtQNFaJkPbA
         jflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SrF1ldydTiBZNiCjzZif0i3Yfeug4ftFhfixRtZHpw=;
        b=LRRL8EIMVS+Ve6wNqzAZUuLOcsgnKeddgcTbhVv2w+vzApUXkr+551vHIirE3BinaC
         MF8QEd/87v5jS24uiEuhSc5a5VWdt3AT0E/kAMS8LxkRGQmtXCJPwXOJ8RL/8mjvyyZJ
         qQl6j88KZ7BcQYkGySrc16BDDSvWD5/1H9mm+Dhf2/fSPnVp1yiVNoUqXdYNHd/H9K5l
         zFe35OqFkKxz9n33yM4Qzmeub6S0ldEF1Woymhd4rnPWf/puJyLl/Ucj5nHoe6xMfIBs
         gfXIS+AJhRZVKrR4hlFIHDlHSa+Z0S488usbLc3pCNJMawfDlpbVAeZzBZHuMenH2/cF
         JvGw==
X-Gm-Message-State: AJcUukcjDQCbbP/axZk0LzOs4fryz6aGWIPRXIc2N9XNZh0Oe3ymopfc
        FnN2lzBlFVCI8QUsmJunb+piDnjbyhmtVl1zGIWRtA==
X-Google-Smtp-Source: AHgI3IbCzFQD/+Uqz0DfjLSsX4iVK4fMId5Z87LLJDmoXHAA42wXu6RBQ0/v6b3cLh38pZaQBHcIfOlK/fsOvmLRX+E=
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr24761848ljb.106.1549195860175;
 Sun, 03 Feb 2019 04:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 3 Feb 2019 17:40:51 +0530
Message-ID: <CAFqt6zaN-AJuhVf8_=z3KDCjcuu+zTN_GorxDzcpAUqcM04m2w@mail.gmail.com>
Subject: Re: [PATCHv2 3/9] drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
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

Hi Stefanr,

On Thu, Jan 31, 2019 at 8:35 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
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

Can you please help to review this patch ?

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
