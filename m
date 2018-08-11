Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F6C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9606223E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0nL+iRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9606223E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHKKhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 06:37:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38272 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 06:37:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id w26-v6so12735321qto.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xAETR19d5IUpzUdaI/152Glto0UkKj2/dMJxnNag+/M=;
        b=Z0nL+iRZN1oUo+2VW2KXuTxk1pbRml6n172x8wDs3uykiM716X0JEnwSfN2+fWHrq9
         eak1AsbuMUhULMcPNHLUnicEWnHLkDLG+zNpYB3MURNKtSaJwjnqejwGB5+363FvUk2k
         22kM646kYpZLWxNOudCXyDf2xgRAeOynfqrsgeFXyTNoeM/GgJpRgPjJDlZ/wZKK0CNk
         UeuvbykQd4Kg3mCd8OvetR/FvgKHl42kLkX++TyEyxz+ef7brtSHWpYQjyGJXB1LGUDB
         s4U3FqYy7+qkuTxJnwtUIrNNOO0fCiVXUyt+YfzRWfhKnZmFPSQpfNW77kLxswVvqJdw
         zmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xAETR19d5IUpzUdaI/152Glto0UkKj2/dMJxnNag+/M=;
        b=CWw9wqfeMsTKE+2tos7sexnNSyO7VmOornAEPe7OX5YyS6I4ZjAFAGbj+LqceTu/zS
         lhdo2xjvBLHE0I2Q6237qAKPkPsRRKQl3gcI69b43pwlfZtfGsDNBR40zpSKQFXnpTuG
         2wKgr91bJdKdet0nCIU83d8ljJxujXWn/KepXXlTQnTI2yCrE+d4eoR9PCiCD5hA9yxd
         HeapWguxYEY5fElpynZY0aSTWge7cAjJ5p0lSCUl81VJXi/TerBVDzGhx+/fgy66mf3c
         sRHwrjhxoL5sepIBvYlvYy9x44buDV5aHTltiwySBmGQgBQzFwti2hIG4VnL0cvFQpSS
         QY2A==
X-Gm-Message-State: AOUpUlF4LOXaEKdn6v89+6kWLGjZFzCVos67N50Y2wmmDV6nyFnMJVkM
        KntkX/QonTjRfITy5r1V4fCiLUdIcKFBYwkRk2c=
X-Google-Smtp-Source: AA+uWPx9SUl2dsEigls3jPExN9Uv/wuy8elpqgSgQhzFxZD3gcQfguHAvRHnQMMuoyGgXSVXx4dE7i39aGUKLIeG/EY=
X-Received: by 2002:ac8:1abd:: with SMTP id x58-v6mr9654757qtj.180.1533974660404;
 Sat, 11 Aug 2018 01:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:04:19
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:04:19 -0700
Message-ID: <CAPhsuW5GXqS3Ce326Uf2PQQO8qfMkWU3MxOeUDKaCeG3b0euAA@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> We assume to have only one reference counter for one uprobe.
> Don't allow user to register multiple uprobes having same
> inode+offset but different reference counter.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  kernel/events/uprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 61b0481ef417..492a0e005b4d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -689,6 +689,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>         cur_uprobe = insert_uprobe(uprobe);
>         /* a uprobe exists for this inode:offset combination */
>         if (cur_uprobe) {
> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
> +                       pr_warn("Reference counter offset mismatch.\n");
We should print more information here, including the inode, the offset
and both ref_ctr_offset.

> +                       put_uprobe(cur_uprobe);
> +                       kfree(uprobe);
> +                       return ERR_PTR(-EINVAL);
> +               }
>                 kfree(uprobe);
>                 uprobe = cur_uprobe;
>         }
> @@ -1103,6 +1109,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>         if (!uprobe)
>                 return -ENOMEM;
> +       if (IS_ERR(uprobe))
> +               return PTR_ERR(uprobe);
> +
>         /*
>          * We can race with uprobe_unregister()->delete_uprobe().
>          * Check uprobe_is_active() and retry if it is false.
> --
> 2.14.4
>
