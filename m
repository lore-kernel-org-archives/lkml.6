Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A09208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YOAHYQJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A09208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGaQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:38:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37544 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbeGaQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:38:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so17002975wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WPjz4ZAXqi3j8IMmVRI4g0N/TxCqLpc/2GFPRLhFTc=;
        b=YOAHYQJwv/EkWDPkKcoansdSwL0xGJ8wHS4GZPCR5dZayAf+nAhd0lINBsunLkt5ML
         VMCbndQkE7ZSH16gMoKg9jEm0Xef6FNQSF+G6dmT6tlb4sNxkzevqj3InHGWXyJUZJ/l
         dkDdDH5PFJzedSsSRBR3EPoRzunrhulr9AcrxXaLNufJOEPkORZIrk9xyNAV+yIG12b7
         QcnRTYL1EnHgSyKcUOEN7ofiPI+S7Xl7WpMFM9C7O/pIVr5PDvZkNAaMzkl455OCxiE0
         nLBICwNdZi+xn2W2gkPZLiCtJyXfXJBwydPWhjyqAXubuuHbTOFoQqcpLa4nz0n5hBak
         aDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WPjz4ZAXqi3j8IMmVRI4g0N/TxCqLpc/2GFPRLhFTc=;
        b=PiLKjWHuZsHGwpIb/+xWObggvHlrgbMP83w10QMr9dXiiPWSXVL4bFRdWdHbToIzlW
         2lglNRJyQiqn6cXMiADS8bu2eYQR+Slkf9u+oeY+NwhQjSGLrTXKE/VCN4vnUGOPPOye
         pLJzAi8xCSqphkbqqCXrlGyi0DEyX/yATaFaIXCSsp1rLdKckXVGvWjClyCwWocISIjD
         ZLcBxLdXvCDwiNvAGV7IkmnoeQlODn0o1CUm/sUyuxJ49T5fS/8cpb/U2qIfzFpS7NXn
         Fxzx9M/u7M24OKAW5O8HdP/8a/xxooZ21MK1lINX1EtxYVLjO4SDVOyrKT+ysfL+CNP3
         9WXg==
X-Gm-Message-State: AOUpUlG4nw5zI+IjOySeQiNKJmEddoDg4/Y5Ntkq1SIoCBlXhykuEC8s
        OduBkOUFe7Jg2j5kiQRCuQJPpjKNpVgrAdahQlsEpw==
X-Google-Smtp-Source: AAOMgpcsSz9U1uo7tasuATppkA+O21V//qXDt9Ln86LmE13zQe4HyFMadqj6sUflSTUMJjtTKWITzInT5oPPNL4r7ec=
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr21595693wrq.272.1533049091996;
 Tue, 31 Jul 2018 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180730180100.25079-1-guro@fb.com> <20180730180100.25079-2-guro@fb.com>
 <20180731084509.GE4557@dhcp22.suse.cz>
In-Reply-To: <20180731084509.GE4557@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 31 Jul 2018 07:58:00 -0700
Message-ID: <CALvZod75t+uK=FDtpuBCMZCk7cb4vQMy7DpXQ53Aj7ZLiYsTQQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce mem_cgroup_put() helper
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 30-07-18 11:00:58, Roman Gushchin wrote:
> > Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> > memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
>
> Is there any reason for this to be a separate patch? I usually do not
> like to add helpers without their users because this makes review
> harder. This one is quite trivial to fit into Patch3 easilly.
>

The helper function introduced in this change is also used in the
remote charging patches, so, I asked Roman to separate this change out
and thus can be merged independently.

Shakeel

> > Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  include/linux/memcontrol.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 6c6fb116e925..e53e00cdbe3f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -375,6 +375,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
> >       return css ? container_of(css, struct mem_cgroup, css) : NULL;
> >  }
> >
> > +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > +{
> > +     css_put(&memcg->css);
> > +}
> > +
> >  #define mem_cgroup_from_counter(counter, member)     \
> >       container_of(counter, struct mem_cgroup, member)
> >
> > @@ -837,6 +842,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
> >       return true;
> >  }
> >
> > +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > +{
> > +}
> > +
> >  static inline struct mem_cgroup *
> >  mem_cgroup_iter(struct mem_cgroup *root,
> >               struct mem_cgroup *prev,
> > --
> > 2.14.4
> >
>
> --
> Michal Hocko
> SUSE Labs
