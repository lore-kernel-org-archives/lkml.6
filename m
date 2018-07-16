Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F94ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63C208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMQkyLoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A63C208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeGPFPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:15:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46205 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeGPFPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:15:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so31236758lfc.13;
        Sun, 15 Jul 2018 21:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JOqP//9sjc1/fqzAwoRS2F89wQ2LBNGxhfBwQdQK23s=;
        b=EMQkyLoVG4voqWzEPSEwQNIcF4HZeVWljKosybsv66AzEd1SptQhDAvKX0ErLAReDR
         KYu2vgex78fRZmnmboYsU07TjkZuxvGDnuKQRIRTJ03lBYbLoaORktHysOCywXRhRNWe
         ptqIM+nEYau10excHTZbU8pZ9h0UOxAH+MIYuisgqEJqXk7XeK7l07l5ANlU0zZBUHdb
         zpSMmUv/I6yqtx5Gid1un7XF0S0V7xcEKcAus+YU8kXki8szGIgnaFa4CaDZs0ShPFvi
         dKEteI11WucoROvDtKSpCftyjRdtc4s25DBObZAQCtrIPqA7QyKzXDhLkNTE6XXDraOU
         DeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JOqP//9sjc1/fqzAwoRS2F89wQ2LBNGxhfBwQdQK23s=;
        b=Qq1Xrky4BVTexIrLmahOhXs3v9XFJ95RXHktFauNqgA5y8t2N9xSnbIWfmECmUh5q8
         C6mmrg7KBWJV+VLV637dOIaWo8c3yVAufanpB0PgCsfqGVptL3QYl88fOB8D4UhRjOsa
         YCiYeJHUhW7GlGVn9qopBv3sWEeeWOaHYYbF/q4Kuc3YZ3mPw6tg6ifIYVl8o55jmVgQ
         hJnfwWpr+C9S2ATiGscTTOG/VdQS/YteJw0VvE2esw/Y6yqBa8C87Y/ckrlmQ4bBqxZC
         vnSlOrcD9B5kSZ8VhdTeOh7/kwnaKMvOS16XYB6wYzjLPDFQx6SjvcHtI5r1ePpMdNTA
         GMMg==
X-Gm-Message-State: AOUpUlHM1KJka7CR/tf3NoYWGS5mWP5MtplPromnKOmYSrp82t2N9KvM
        zq1Ii2GHsoEcw05c1giGyUyvPESeiKFsZ/0onvM=
X-Google-Smtp-Source: AAOMgpdLAtQCXqinBIeIXJmiAz9ARA+vXeZh3o489y/UnmjFpizgDyY8bVzp47Je5dCnDmo7p3xYJ0HcLcmnxecGMBw=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr9900264lfg.39.1531716578270;
 Sun, 15 Jul 2018 21:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 21:49:37
 -0700 (PDT)
In-Reply-To: <20180707103029.GA13365@jordon-HP-15-Notebook-PC>
References: <20180707103029.GA13365@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 16 Jul 2018 10:19:37 +0530
Message-ID: <CAFqt6zaEou5CPYCqi=HezSK-UA7AnRECZNe373Nw+bDd1aF0zw@mail.gmail.com>
Subject: Re: [PATCH] fs: ext4: use new return type vm_fault_t
To:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 4:00 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler
> ext4_filemap_fault.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?
> ---
>  fs/ext4/ext4.h  | 2 +-
>  fs/ext4/inode.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0b12785..aec0010 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2470,7 +2470,7 @@ int do_journal_get_write_access(handle_t *handle,
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
>                              loff_t lstart, loff_t lend);
>  extern int ext4_page_mkwrite(struct vm_fault *vmf);
> -extern int ext4_filemap_fault(struct vm_fault *vmf);
> +extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
>  extern qsize_t *ext4_get_reserved_space(struct inode *inode);
>  extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
>  extern void ext4_da_update_reserve_space(struct inode *inode,
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2ea07ef..03ac322 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6205,14 +6205,14 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
>         return ret;
>  }
>
> -int ext4_filemap_fault(struct vm_fault *vmf)
> +vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
>  {
>         struct inode *inode = file_inode(vmf->vma->vm_file);
> -       int err;
> +       vm_fault_t ret;
>
>         down_read(&EXT4_I(inode)->i_mmap_sem);
> -       err = filemap_fault(vmf);
> +       ret = filemap_fault(vmf);
>         up_read(&EXT4_I(inode)->i_mmap_sem);
>
> -       return err;
> +       return ret;
>  }
> --
> 1.9.1
>
