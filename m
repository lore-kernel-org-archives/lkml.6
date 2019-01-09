Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7942C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8084206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0tKtF4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfAIQQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:16:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45139 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731219AbfAIQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:16:55 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so6037340lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guTeVeqW9KLhp8/c6KawSHCWPSc4BbHsuX5EpTBXe4Q=;
        b=o0tKtF4yQrmQxwfrlRXVheuHHZtBgHvb3NozqG4C0b4owVYXoP8CXsWB2hn1LzrbkL
         Cu78l0TfbmiJIHHA7NBpRZBy2GQPHVZ68EMv4zAUnSPxButnaO3gbLgK6rpQA5yUkGjJ
         Zb9M8nyYhYDADOePrU+MGnv2oEn1qcrqEjAsIBE3nNidMD4gU04E8KiajvoCa2A6RuhC
         gWIigZ643mRaEHMsDAJXyYr/Ob9ivq0WzF8k9QmvCc4hFhcLVvxBHnJfVeNRlx6egG1/
         ERrMa4A8XcxoS41mrfdKlhatMtB1TzVzxJugo9rp4lgVxNK46DvXdv8cMC+7A+V4BMJc
         VkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guTeVeqW9KLhp8/c6KawSHCWPSc4BbHsuX5EpTBXe4Q=;
        b=fDGNTd4Dcg+yQ6fIdNF37q3KvY/qduBSv9rCuic7w6sckBH59kwkKaU2ADLQ3phz76
         cFrEJRCQtMDWQlTgzif2YYlHjDV9+IF5L18DbE/04P70NmJVKgOrtjF/VvsVDTW62YDJ
         drsim0+CAvR1l3jWpTaBfi/FiYh20pVAmE3pvwflJUkOnjLVdJhYr2zAN51glmc0lLfD
         KVVwP8O79V1P2InUFVTsGBmJDL8fw8iE9b50aH/KdYAkKnjG/My1k514CozzS2MAFpPV
         dJWRAXyc5YgWxvZ+M5rDcv8O/2YEcyvnx/gOBjRzbj1PrpChWJWd6798Ccpw5U2BgaL+
         pJOw==
X-Gm-Message-State: AJcUukehwz6qr5fogQTnbU00dh07K8hJopwQ6e828KGFgm56vfXHrJnA
        cNa99fhiWTY63m/gUIrjsLnev44Az92JEZVu2Mc=
X-Google-Smtp-Source: ALg8bN6L/1v9lG/onJDkftwo5CLjSVh6yjnoXg6BMYTz1TsHsWSZwZtjHWHD4JJDm4oN2uTJ0xf5zCWDrGqYkoopjAs=
X-Received: by 2002:a19:c70a:: with SMTP id x10mr3764528lff.88.1547050612929;
 Wed, 09 Jan 2019 08:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20190109161916.GA23410@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190109161916.GA23410@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 9 Jan 2019 21:50:44 +0530
Message-ID: <CAFqt6zbeHPs359c03q8wCENfW5DJ3W6_ber78fCmoQzYcUhpCQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/hmm.h: Convert to use vm_fault_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jglisse@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 9:45 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> convert to use vm_fault_t type as return type for
> fault handler.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

kbuild reported a warning during testing of final vm_fault_t patch integrated
in mm tree.

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc1 next-20190109]
[if your patch is applied to the wrong git tree, please drop us a note
to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Souptick-Joarder/mm-Create-the-new-vm_fault_t-type/20190109-154216

>> kernel/memremap.c:46:34: warning: incorrect type in return expression (different base types)
   kernel/memremap.c:46:34:    expected restricted vm_fault_t
   kernel/memremap.c:46:34:    got int

This patch has fixed the warning.

> ---
>  include/linux/hmm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 66f9ebb..7c5ace3 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -468,7 +468,7 @@ struct hmm_devmem_ops {
>          * Note that mmap semaphore is held in read mode at least when this
>          * callback occurs, hence the vma is valid upon callback entry.
>          */
> -       int (*fault)(struct hmm_devmem *devmem,
> +       vm_fault_t (*fault)(struct hmm_devmem *devmem,
>                      struct vm_area_struct *vma,
>                      unsigned long addr,
>                      const struct page *page,
> --
> 1.9.1
>
