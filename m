Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FCB2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uct1UE2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FCB2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHVAIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:08:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35281 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeHVAIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:08:05 -0400
Received: by mail-qt0-f193.google.com with SMTP id r21-v6so21916999qtm.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1u2tcyS1PsrjWtZqEcN4otxlYAJ/lNZ22ncHFxxHIaY=;
        b=uct1UE2gbdFFKASoZtl7UbBRqhWbpid++31L0JWoezFbSZZ5+lAHyfp7eUtA/Sz6CV
         GHaWDMmtI3Q+rBTkiKjPrp/MBRRYbK+WQs92KJRtZq3NrXJr8tb8LXB1rWAX+qSf+g5Z
         X1jxWhlfBW1lmFMlR6ko1FGTqYuTKU+3FVPoLfmPgy+c3X2FZkp9KSbqr3RiG9FO8VZO
         cc+mkmJydzN0P78g2S7pCG+C48r5bz+26cyXt6wMTho9fHxCJcUop6r1uXja1hcybWT+
         dplKuJ9Xq9CaTd/9Z79Dnp/T013NxgCC6WIVyqFtlhcq2MjmFqhfltXysUeMIc9hJ50H
         YnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1u2tcyS1PsrjWtZqEcN4otxlYAJ/lNZ22ncHFxxHIaY=;
        b=jvKaZjBRcyS7FUP/2bP5Q3vBhwLd9wW8Vxxn0vyj4mPfGJbhHPWoNF74EdnEE6rfom
         7RvAzaCq2NK0+tJM646zRIKnpWoLb8g/dRkWdwpekqWruUsWBZrWItLm3ACvxj4lpgR1
         oFmpYpPwJb8OeahqBgQar5lW9+y+bHplKs1yXBJOc0e4lqytd3SIQ2UdYeHKsg5KRplD
         ugO7T3Q+//5G+RvobBBCJA2+WYRsKaTGbnQkqO9flxe0LmzHSUVg8tMS5QRmP5J4vKGe
         Y+t7N83zV5YlhFLAGYL6aBKuw89efNZpho71dS4ZegZ0sCRzWSlTB5vRsC1r2cTUFPFa
         xRfQ==
X-Gm-Message-State: AOUpUlEiAbH8Ymq1Lq49X4cKfR58Q4FzVZKsY26MtagRbXCYM3zQhN8D
        OwS0yAsZH/GNnQiGuDPMIQufi1a7VHPMNvvgr7o=
X-Google-Smtp-Source: AA+uWPy6VnHEMH5ZJlTGAxzYNTUR8mSU9SzhuzlsuO6PCMWCik/lEcOQVVWgHM2K+3wM3jYOQeDP5nD2OEr5mryTuWE=
X-Received: by 2002:ac8:24b7:: with SMTP id s52-v6mr42455919qts.87.1534884383279;
 Tue, 21 Aug 2018 13:46:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 13:46:22
 -0700 (PDT)
In-Reply-To: <20180820044250.11659-4-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com> <20180820044250.11659-4-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 21 Aug 2018 13:46:22 -0700
Message-ID: <CAPhsuW4hZv7cdF37aAUyfMR5e_Wb-25Drzjg7=MNNf8Gb9dOMQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
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
> Don't allow user to add multiple trace_uprobe entries having
> same inode+offset but different reference counter.
>
> Ex,
>   # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
>   # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0xfffff)" >> uprobe_events
>   bash: echo: write error: Invalid argument
>
>   # dmesg
>   trace_kprobe: Reference counter offset mismatch.
>
> There is one exception though:
> When user is trying to replace the old entry with the new
> one, we allow this if the new entry does not conflict with
> any other existing entries.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/trace/trace_uprobe.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index a7ef6c4ca16e..21d9fffaa096 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -324,6 +324,35 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
>         return 0;
>  }
>
> +/*
> + * Uprobe with multiple reference counter is not allowed. i.e.
> + * If inode and offset matches, reference counter offset *must*
> + * match as well. Though, there is one exception: If user is
> + * replacing old trace_uprobe with new one(same group/event),
> + * then we allow same uprobe with new reference counter as far
> + * as the new one does not conflict with any other existing
> + * ones.
> + */
> +static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
> +{
> +       struct trace_uprobe *tmp, *old = NULL;
> +       struct inode *new_inode = d_real_inode(new->path.dentry);
> +
> +       old = find_probe_event(trace_event_name(&new->tp.call),
> +                               new->tp.call.class->system);
> +
> +       list_for_each_entry(tmp, &uprobe_list, list) {
> +               if ((old ? old != tmp : true) &&
> +                   new_inode == d_real_inode(tmp->path.dentry) &&
> +                   new->offset == tmp->offset &&
> +                   new->ref_ctr_offset != tmp->ref_ctr_offset) {
> +                       pr_warn("Reference counter offset mismatch.");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       return old;
> +}
> +
>  /* Register a trace_uprobe and probe_event */
>  static int register_trace_uprobe(struct trace_uprobe *tu)
>  {
> @@ -333,8 +362,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>         mutex_lock(&uprobe_lock);
>
>         /* register as an event */
> -       old_tu = find_probe_event(trace_event_name(&tu->tp.call),
> -                       tu->tp.call.class->system);
> +       old_tu = find_old_trace_uprobe(tu);
> +       if (IS_ERR(old_tu)) {
> +               ret = PTR_ERR(old_tu);
> +               goto end;
> +       }
> +
>         if (old_tu) {
>                 /* delete old event */
>                 ret = unregister_trace_uprobe(old_tu);
> --
> 2.14.4
>
