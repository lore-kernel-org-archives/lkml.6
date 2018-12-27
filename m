Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC1C20874
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYHQrOmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbeL0O4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:56:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40075 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeL0O4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:56:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so10938667qki.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1+FmvZXnUqqvWdNdU8jnu2ftZC3qkcxSQR84GGlPnk=;
        b=DYHQrOmVjRhU/96m9z85JNZPU7I3aev5+tJYC7upN5GBC+tIGiH+QMkNq6zO4viIeV
         W17JT2SXBN803hnhGW30ut60E1zH6LQ0IcywUwLDbT07g6l7/XlzEjvQZEeSAXGwDFtq
         jqF162MWlt3LAkhSWXTSaaLsxIjndhfCZwGtd1J26/1t0W/+BIkkG3Yj5WvkS4uiV1He
         OqvETd87PCibwQ0g/Rf1NTXy+sTpezd+UxUOVh3vzMAiXL/ogzwtOELPhzN6YAGLliGY
         jqTAEXAbtBjN1LMBhHFlEWQtSSrJQO0JqI0eLBNnmoFyO6oj1Q1ouYzFeIhqjRIxloJl
         zwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1+FmvZXnUqqvWdNdU8jnu2ftZC3qkcxSQR84GGlPnk=;
        b=fbk6nXwf9djHXRyRa2i6PklELvPbemHmk9fDa8lLAdgsHpzDIKZfbF6+en9oF5LFnI
         vIgZXpmrqd/0642Tf3ghiF6vCE3al/AyDtgW96nf+JlsAaTyKmXEgmG5xRlYFJUCOQy7
         iAImjLxp0JkZz9E4u9RqUHNzkUImh9SLHx53aQxSCPhmo4ib9/gkyttSI0EmKI6uauHi
         w5zCdv1ZD7F3TdqL/kvtLkhO5vbbuj+X0ezwHqcbPZpgX0bhzFoIv0bPCt5AES52KPUJ
         BZX50R3HQbbIP+F6F9wgo+F8nWieRGl5PtJd1X5PtwvIHgBEd8tzkLvO1z8fCG0QDbub
         iUDg==
X-Gm-Message-State: AJcUuke2u5FYXjkpL3DUdRy3ArSZFX/r4msJuUJAD33b9t0fFu/Ss1su
        j9oPPCw0HmmXp/arDluq3w3R4/mLtnOy/aHhN82d8KTd
X-Google-Smtp-Source: ALg8bN6VfblYnkztEanWXOEq431OCKsItGipVM8N2LQkZUPWn4fY+UxEjwes/D4yliDdPE0zxffxCBJrczk0l6gJdEg=
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr21550788qkf.127.1545922582209;
 Thu, 27 Dec 2018 06:56:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1528819790.git.dolinux.peng@gmail.com> <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
In-Reply-To: <b55024472e101a33b3d6b098aa2ce23c5b5dd6f7.1528819790.git.dolinux.peng@gmail.com>
From:   Donglin Peng <dolinux.peng@gmail.com>
Date:   Thu, 27 Dec 2018 22:56:10 +0800
Message-ID: <CAErzpmv94LHULidn4n-ChgeJkXqc=Z1Zf-DaanBJE1iFpRe_xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dump: Convert to use DEFINE_SHOW_ATTRIBUTE macro
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 9:15 AM Peng Donglin <dolinux.peng@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
> ---
>  arch/arm/mm/ptdump_debugfs.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87b..79002fe 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -11,18 +11,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>         ptdump_walk_pgd(m, info);
>         return 0;
>  }
> -
> -static int ptdump_open(struct inode *inode, struct file *file)
> -{
> -       return single_open(file, ptdump_show, inode->i_private);
> -}
> -
> -static const struct file_operations ptdump_fops = {
> -       .open           = ptdump_open,
> -       .read           = seq_read,
> -       .llseek         = seq_lseek,
> -       .release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ptdump);
>
>  int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>  {
> --
> 2.7.4
>

any suggestion?
