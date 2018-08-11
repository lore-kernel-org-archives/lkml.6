Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88EC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF98223FF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 08:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCqiRjNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF98223FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeHKKqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 06:46:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32868 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 06:46:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id c15-v6so12775928qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o/M+1IBC3Rqq5DOdqfmm82fc4zlpQX+5ynqgob8xkyE=;
        b=MCqiRjNWlMRXktlq++HNVT/QVra1RpRKyyuAvW0yatC72uRWA+bJjs5whvTcC1quLF
         SegDGq6wPRGTU78e7VGQKhL7AwgrH/7vnjNesF/bcOnrJCkfqHj7qxcF2/NA0+z8D40i
         ci9lgmnDOEdABiQdPFrEJbn+BL5RKyn7cISVWFEypIHYet1ieprsv80hXWg+2R7Aq5fC
         wgRLmtdtP6vHsu+IPvRaeGmlatrMsxJBL43V7RhTKA/9SzUCZuflTfjhlv1J+nsucviW
         hsp/AigDLwUgEFb01OYSDj6/kFthGRxFFVvlJTxG1TdJJ4Jdn/y1HffBBZT/qCdMLcHC
         GrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o/M+1IBC3Rqq5DOdqfmm82fc4zlpQX+5ynqgob8xkyE=;
        b=DrceJ2OwioS6ZfXqlp3NUXvglT0H1sdcR2tmBnficB5Dx2G3kYc6AfJAFCqbHHZPkr
         TmXlGmP2THW09rhgRBfvb1yxrwX87xwu2Eou19i1mbw5VN1yD3+dfRulfGO7+AT7ug8S
         ip2b/Lky8w4CVMWAZPF1WVUecTFJlh995+N/mMdMV9/rPxvsx+A0MBV6Gvu9lKcK4WhQ
         YQznajhGiTfiD/9+CWujyEnJt/HaEF4lqRkl7+br1Cb5TxM4mKSg5xyuPnbhfPot/tC4
         htTBA8KA7K0NCuHLxsryRPC/PGeU6ousvTJEFexd7U9l6qV8lkgaBJK4l4HMRi4cONY6
         n2aA==
X-Gm-Message-State: AOUpUlFNELG5x/QezVilGGCF4HTXF/TNLwhN/Ak4wq7J6qxJtPXlCB3R
        V2L4Uzij0C/uZP0bkluGccLynCXmh7ojPSVoHN0=
X-Google-Smtp-Source: AA+uWPzuvJrrrXF8zsaHJbeludt4pcl5U7U1HJXuD5sg0BYjUW0IsPhnTljVwSUtjPzSrO72/CM7UHnyEMUPXEAZ09I=
X-Received: by 2002:aed:3688:: with SMTP id f8-v6mr9656903qtb.276.1533975179248;
 Sat, 11 Aug 2018 01:12:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:12:58
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:12:58 -0700
Message-ID: <CAPhsuW5g1dOnceA=kqfpC+rR6EguJaR+wPwY9nSWLbGSSj5XjQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
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

Do we really need this given we already have PATCH 4/6?
uprobe_regsiter() can be called
out of trace_uprobe, this patch won't catch all conflicts anyway.

Song

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
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
> ---
>  kernel/trace/trace_uprobe.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index bf2be098eb08..be64d943d7ea 100644
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
