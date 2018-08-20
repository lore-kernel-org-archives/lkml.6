Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F37C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C912088F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE4rK1QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C912088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeHTJIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:08:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45869 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeHTJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:08:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id y5-v6so14987970qti.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aCEercaU21ic7AarRefdSPPQevCBnjd97aDqkigi4Ks=;
        b=jE4rK1QOZtd2lK2W84xF1GzVA6c0US7SE06xn8tZ8v4Bk419DKHtS1uKiva2M90WoZ
         zcBcR6UmATXG9LhY5bXzkp1tN/RqN4v75XM1oHZ+Venj8Ry4W5zd8RpypbfZO5AvpaS/
         KfS1jRhRUmo4BKgw/7NRq9vdT9PGGWBHviQq9I5wHQ1jTua9V8dq5jG1vL0Ga+Krecxj
         Z85dpBB6wQ9IHOK9AXhp1O48uG/PpIU2aKuAIF5+a8Qkn2LaVDjtl3QAXqWq2d5S/bFj
         WNzxmc1uE1egV/K042cfcXQrmnCk3wVs4QWap50HCWKec+5dWLFHiEgW/IMZrSaoCmlw
         Bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aCEercaU21ic7AarRefdSPPQevCBnjd97aDqkigi4Ks=;
        b=DNTw7jy3a5f9XRvutvYfoQd7PqnAvrEf6Fy0GXA6Z5By502bSFwhqU/5rT7EgrreFe
         Mf/cGX82PI67KtEgzxeKmlg9gqDH0Tn0iE6YJawCI6yApUaiFu5dYWWBAtGSz6CtrDAj
         QGjDjWofHvoPMlPQLTMwWFuPItN9m+u3I506Z6E1GQ62SColemOI4Q4iSa5VXKDmvZ0M
         iHSj5qyYvPhiJJ28yBIUwVfayVQTV6YlwD8iwqEC3EGwwXQmvYAO7Imj7vzLOCTVoPJU
         0jlfG8JIy9aw3JwKZtdLTbkRAAQlXD6nTBOZUbc3XSWaxXQDnCohfZk1dX1jx89Hmy8o
         Pw7g==
X-Gm-Message-State: APzg51DZeEnJppN5oMjp7xiLtvwx+tsCJ9GlJyOjI3BYonf5Hfmg4E0b
        6N40CgUgiNaHp+H+GjwXuXhGoJXlyBevsKFdOMM=
X-Google-Smtp-Source: ANB0VdbcCKrFR18GN9ijIeCeZR8Zs5MmgNCXl32u6U22Yb14LE9Kg1c8O79mE8Bp4iwU+SV61uaGMRZYG2dyekf/Dm0=
X-Received: by 2002:a0c:bf96:: with SMTP id s22-v6mr803321qvj.48.1534744475410;
 Sun, 19 Aug 2018 22:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:54:35
 -0700 (PDT)
In-Reply-To: <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com> <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 19 Aug 2018 22:54:35 -0700
Message-ID: <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
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

On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> We assume to have only one reference counter for one uprobe.
> Don't allow user to register multiple uprobes having same
> inode+offset but different reference counter.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/events/uprobes.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 35065febcb6c..ecee371a59c7 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>         return u;
>  }
>
> +static void
> +ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
> +{
> +       pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
> +               "ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
> +               uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
> +               (unsigned long long) cur_uprobe->ref_ctr_offset,
> +               (unsigned long long) uprobe->ref_ctr_offset);
> +}
> +
>  static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>                                    loff_t ref_ctr_offset)
>  {
> @@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>         cur_uprobe = insert_uprobe(uprobe);
>         /* a uprobe exists for this inode:offset combination */
>         if (cur_uprobe) {
> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
> +                       ref_ctr_mismatch_warn(cur_uprobe, uprobe);
> +                       put_uprobe(cur_uprobe);
> +                       kfree(uprobe);
> +                       return ERR_PTR(-EINVAL);
> +               }
>                 kfree(uprobe);
>                 uprobe = cur_uprobe;
>         }
> @@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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
