Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FA02133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 20:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxmceM23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FA02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeIMB2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 21:28:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeIMB2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 21:28:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so3362792wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYejQ4MqVo6C11GsiURjpO1Gd3l4kbiTMkdbj5mr/9Y=;
        b=jxmceM23x9hXkShOGy10yfOgch5QNY19SSItPrkcOyITly9GiWwm8vgDYyKE+/6YX3
         AxqVxRsy02zwlqzLXj2PyDH6KBmTWPq8qSoABYATpJr07zSuAyH2y3eKp/FyLTxnnsoG
         V9al+JYVhNv+t1k14LKKIjl7cbmMBMBZtCLUMHr6XMA+QUGqfkBKsKDAfa0vefSxwkrh
         fmh3cz5++hmKAHUdMvh7z2t5km3MZPTlpIE5Gwh68Xye3nAMTJ+7gngM8HfxfMR2XU9N
         apKy2VoZhdfHTrnAKrwuRg3Dy7j5qmS0BLxzbyv60ZcPqGCh+vceehUQCRECaTq2PjJO
         4pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYejQ4MqVo6C11GsiURjpO1Gd3l4kbiTMkdbj5mr/9Y=;
        b=LW1yre0nlp/KnCaeIc+oWz/65vUulBYWxknazGf7p+wLyhWk86dY3ComPN7Gaxmfbi
         6WrPGlhtLvygBm3rd12SbDvnBCteAs/Wq6IQihOB8ABeqY0SD2FmumXPFunq62eIgum5
         DeWSLQ22rpPlZQkUMsHaW6ggZnQ40MCp2NQrJA6rC/Yf3HU80C1dpcIOFA30vPhawbzM
         eNGj6SktVzBpV1Vy4CSRUojKOewqRJiTvo3Monil+vEqTjsvYl2XoLs17AEl8y61WITq
         ivG7It1ENelJHegHSD85S61BfLRTBO/NjFrN7qqEt67rNYZhnFc60EytIl3gjJ2kmrST
         dE9A==
X-Gm-Message-State: APzg51ASwLiQCWwN5Va6mzyedNwKR/UyVvk0CYAnR0HxeENPjRCWQpQ1
        /ud3Gc2x6xzsyNctu67U6Dmrl8bk4OBa69Ga7huZ/Q==
X-Google-Smtp-Source: ANB0VdagcZSIPokTyBbe8Shp7CqwADTFJsf3wIqDXiRBES3DWLy4bvzKQwKTVjq7r/k3EZ2OykYoXvIvLyQgwhE5BYY=
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr2991925wrg.203.1536783727879;
 Wed, 12 Sep 2018 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <1535739600-8842-1-git-send-email-aaron.ma@canonical.com> <1535739600-8842-2-git-send-email-aaron.ma@canonical.com>
In-Reply-To: <1535739600-8842-2-git-send-email-aaron.ma@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 12 Sep 2018 16:21:53 -0400
Message-ID: <CADnq5_P=_Kxg8y48NRQZjKzPi-yaAwKRQhpQ6qEav2rZijHucw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vgaarb: Keep adding VGA device in queue
To:     aaron.ma@canonical.com
Cc:     Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gustavo Padovan <gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 5:39 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> If failed to find the deivice owning the boot framebuffer,
> try to use the first VGA device instead of the last one.
>
> Usually the 1st device is integrated GPU who owns the boot framebuffer.
>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/vga/vgaarb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 8d90e66994b0..dc8e039bfab5 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -676,7 +676,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>         vga_arbiter_check_bridge_sharing(vgadev);
>
>         /* Add to the list */
> -       list_add(&vgadev->list, &vga_list);
> +       list_add_tail(&vgadev->list, &vga_list);
>         vga_count++;
>         vgaarb_info(&pdev->dev, "VGA device added: decodes=%s,owns=%s,locks=%s\n",
>                 vga_iostate_to_str(vgadev->decodes),
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
