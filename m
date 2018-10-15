Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F16C208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v255xtDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F16C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJPC2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:28:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45546 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeJPC2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:28:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so15902689oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECbZabpTWBi5U8iQOEAyv+gwu6PoqzYbBAs5iD63fwo=;
        b=v255xtDuzxjy6o81wRgpT6Nb1kQ/D7aHu/kEV55+rYZRij/54kVItxKWpTJ0SAj8G9
         6g86lojOuc7YvKUApOi0zukpKP+O5tWkkPVcR1vVeI/yR75rDPRmvnM2QTaGxRzpmYQ7
         POwqelLBiWIZOQtTwbowXSkj7bg9TRGftDdvcSBQ9rOU5mOoZm68DhQnGQ90amyincXr
         dkZUrNK1NN/nwhZsyYNdCCQ/g/Ww2RSzJKFEwBwb9oOhRU9ldEm5cKqDfBxKoqW3iI/F
         UYWqUYipf+F44uCkCLqjbEhFMKnQa4jjvHo6iuNsMJhizsLkpu2GqUG+R8TBogr+Up+/
         Q+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECbZabpTWBi5U8iQOEAyv+gwu6PoqzYbBAs5iD63fwo=;
        b=Sgp8rysd1TgPp6aONeTik5EjUaXQ+2C3DdmsUqMovWqPc79cFCsPLLgYwss2mxvwcU
         YEMehomTyJ3EJ80IBJptQmo2o1tVtoNrfubdZRB3PwcW6jhOevCQNiu9paYI4F2Ey/xr
         pqwSBEwzkogM4qXKJn6rgH4OphjTXaW7ZgusYGJAbav9CwjH1cDL80P9hyg2Y/y/JvVl
         INAiHntnNxiYz5UYk2ItIjO+km9ouQ6w1j7IDl2d0uGbtZi0WmXnx1c8MSHbkvcjWPBW
         BJ1RlInlb4LoM909tbj0V2fLE0xWXFhT/jVZESB8XdLeL+CYcfvdL2b2qW9+1SqGFvj1
         843g==
X-Gm-Message-State: ABuFfohY+l5qiJ/JxSERIHHh12l6jZ0zBDiSqKWIFPt9DbAGrXPisN1u
        ns6fMOaj0GxIdxVQfGynaQgNx+hfAztEr9+WpGU1Sg==
X-Google-Smtp-Source: ACcGV63iQ+LcHl7EnWfIUonLEUuB1UhQAkvGlSM9917rdzzKW8lW5N1pRYnfLssuBYGXNoTZoI6PV+wQr12DnPjU0XE=
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr9370144oih.3.1539628939304;
 Mon, 15 Oct 2018 11:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181015183841.114341-1-yuzhao@google.com>
In-Reply-To: <20181015183841.114341-1-yuzhao@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 20:41:52 +0200
Message-ID: <CAG48ez1AEpYx_nDCaNUbw7RdtsCBvAR8=SKSgyaoeSrhqRZ27w@mail.gmail.com>
Subject: Re: [PATCH] mm: detect numbers of vmstat keys/values mismatch
To:     yuzhao@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, jack@suse.cz,
        David Rientjes <rientjes@google.com>, kemi.wang@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        bigeasy@linutronix.de, kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:38 PM Yu Zhao <yuzhao@google.com> wrote:
> There were mismatches between number of vmstat keys and number of
> vmstat values. They were fixed recently by:
>   commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
>   commit 28e2c4bb99aa ("mm/vmstat.c: fix outdated vmstat_text")
>
> Add a BUILD_BUG_ON to detect such mismatch and hopefully prevent
> it from happening again.

A BUILD_BUG_ON() like this is already in the mm tree:
https://ozlabs.org/~akpm/mmotm/broken-out/mm-vmstat-assert-that-vmstat_text-is-in-sync-with-stat_items_size.patch

> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/vmstat.h |  4 ++++
>  mm/vmstat.c            | 18 ++++++++----------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index f25cef84b41d..33fdd37124cb 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -78,6 +78,10 @@ extern void vm_events_fold_cpu(int cpu);
>
>  #else
>
> +struct vm_event_state {
> +       unsigned long event[0];
> +};
> +
>  /* Disable counters */
>  static inline void count_vm_event(enum vm_event_item item)
>  {
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 7878da76abf2..7ebf871b4cc9 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1647,23 +1647,21 @@ enum writeback_stat_item {
>         NR_VM_WRITEBACK_STAT_ITEMS,
>  };
>
> +#define NR_VM_STAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + NR_VM_NUMA_STAT_ITEMS + \
> +                         NR_VM_NODE_STAT_ITEMS + NR_VM_WRITEBACK_STAT_ITEMS + \
> +                         ARRAY_SIZE(((struct vm_event_state *)0)->event))
> +
>  static void *vmstat_start(struct seq_file *m, loff_t *pos)
>  {
> +       int i;
>         unsigned long *v;
> -       int i, stat_items_size;
> +
> +       BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) != NR_VM_STAT_ITEMS);
>
>         if (*pos >= ARRAY_SIZE(vmstat_text))
>                 return NULL;
> -       stat_items_size = NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long) +
> -                         NR_VM_NUMA_STAT_ITEMS * sizeof(unsigned long) +
> -                         NR_VM_NODE_STAT_ITEMS * sizeof(unsigned long) +
> -                         NR_VM_WRITEBACK_STAT_ITEMS * sizeof(unsigned long);
> -
> -#ifdef CONFIG_VM_EVENT_COUNTERS
> -       stat_items_size += sizeof(struct vm_event_state);
> -#endif
>
> -       v = kmalloc(stat_items_size, GFP_KERNEL);
> +       v = kmalloc_array(NR_VM_STAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
>         m->private = v;
>         if (!v)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.19.1.331.ge82ca0e54c-goog
>
