Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71884C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FCE23FBC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ5+jcgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FCE23FBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeGFGou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:44:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40298 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeGFGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:44:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id a6-v6so8372716ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GWpCCjCrTnR7bFQik/iBBenF0bTw2/n/3ZimemmeXZk=;
        b=NZ5+jcgslYYUpK/U9X5L4cX0dDSfJhZDxP2XRZWK7ng33MSAEAY/HiBDGxtBLxInAw
         WmoaKnjCPG7mx7uIGKdkYpTP7kjEZG135YvA9NvFdHjX1Vl9lWaNbYulhJMMvnCauKTF
         Drn58QuoJoY0ClP+ZixUce4EtOX+Fg4SNucLUe2FYI/4DaZA35i7Uw2OXfBW/hXCiOfy
         KxdFiptcV6Et5dC51iHv442mRXfA0B5Yc6tGESblA3r74vcfW2/bMoN7/OhbzU4TttN2
         S3qBiqh+rGXd6ITgJuFYux4cPG3WsF4X6AGIsfctjtpZICO0jDsFKxRiHNcyoyIfIf07
         eSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GWpCCjCrTnR7bFQik/iBBenF0bTw2/n/3ZimemmeXZk=;
        b=AeZkh2x7yanmaq0SI+3dpTMWEILza/MkjEtFxQUOFmh0mcYKT6JtoPoXTwK1OQUasv
         +/g2IqbhQ/psTKaZycq/OqU934/DEEWoOs7aTjz9L8H/cLF4g06i1wauo9k0AUnHTF0i
         g+s8af3OabRdYJz8VIy8jSUBA4vhA++SOEkhFmGZlZg1FSWq5RPxt1DHKeaLBLn20K0q
         vlf0jzZA/bZOjxV369oZZ8PWJuWQMsfbpY7ACrPoKZ6jIroUA5H7SJKh/8LH29mEl/Q0
         /y7YtD7Xq0SkplzEYyzDrHxX60Db3+PFiXOtUMGgmGx04f3NSM/n9c8gVij8RcoVSkM8
         QLDQ==
X-Gm-Message-State: APt69E3IAEo2KwbfTb4uX09t3lzHFsrU/91rFxF6kKGNlaJ9xHtckV8j
        wUzim8X7kN98FLVn/qKbgdYuUOeaWpWD1ePI9D8=
X-Google-Smtp-Source: AAOMgpelkRb8pGZ9iaYtds0jxP/2zojwdICYKAeAeOUXCrvnwcVKQl/muLEE2HQhjXtiGHaqseRrMEan7hRcL0ShHrI=
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr1562181ljt.145.1530859487749;
 Thu, 05 Jul 2018 23:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 23:44:46 -0700 (PDT)
In-Reply-To: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
References: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 6 Jul 2018 12:14:46 +0530
Message-ID: <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com>
Subject: Re: [PATCH] orangefs: Adding new return type vm_fault_t
To:     Matthew Wilcox <willy@infradead.org>, hubcap@omnibond.com,
        martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:12 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For now,
> this is just documenting that the function returns a VM_FAULT
> value rather than an errno. Once all instances are converted,
> vm_fault_t will become a distinct type.
>
> See the following
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Fixed checkpatch.pl warning.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  fs/orangefs/file.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index db0b521..a5a2fe7 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>         return ret;
>  }
>
> -static int orangefs_fault(struct vm_fault *vmf)
> +static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>  {
>         struct file *file = vmf->vma->vm_file;
> -       int rc;
> -       rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
> +       int ret;
> +
> +       ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>             STATX_SIZE);
> -       if (rc == -ESTALE)
> -               rc = -EIO;
> -       if (rc) {
> -               gossip_err("%s: orangefs_inode_getattr failed, "
> -                   "rc:%d:.\n", __func__, rc);
> -               return rc;
> +       if (ret == -ESTALE)
> +               ret = -EIO;
> +       if (ret) {
> +               gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
> +                               __func__, ret);
> +               return VM_FAULT_SIGBUS;
>         }
>         return filemap_fault(vmf);
>  }
> --
> 1.9.1
>

Any comment for this patch ?
