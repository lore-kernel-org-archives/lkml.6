Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791CC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A081E24A36
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tv5BAHb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A081E24A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934433AbeFWALD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:11:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53318 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933934AbeFWALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:11:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so3668248wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEmPFdXvf0sw7TJkUTy6uePegI7ZtVokewO48Q9HrNA=;
        b=tv5BAHb50vsuaMCh3tP2BTIvIO4oB+oo9R14jAMRAXlI80x5O2K+d5Zb6aTRqDWDwS
         0TSdGE4oXf4E0jvokTQgCNgFh2sPbIUEceEfrl05erkyDlJOOUxZXZ24xkg6nZYtkcaL
         d6U80HO415HkbU8CvP8mbXpo+2+T6VF12O8UKl4J2ctSW13p+PpfSVrkmL1IPcQyD/sy
         vdia5lNy+52HWhL94kcivMK4btsm+NeBD47/J3icGilACdDkI93m7E1cPm1Nf8DpxvIz
         Aw5GPGDfZ5RY0g3+dhLKJAcL97zc7kIqDRZsw/5d2LCNXUQnRpl892Z/gVc36PHZmiE6
         v9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEmPFdXvf0sw7TJkUTy6uePegI7ZtVokewO48Q9HrNA=;
        b=Zx6BRxjYJfDvUEvLebV84FJ1yuHtfi91ILptPLDCcrGDe4ZFckDG6rCZn/dI7zuLZx
         0GWXJwiXtaN9sFF+rp3Fwjy2KIwl9WOsFT7lDrHPQJeo0VCnbwI7yxIv25t2p6SwCwLd
         ib1tCdeXJGzs6oXsJVHDX4ycRI6Huu5JDHHae/ElbBNY5dyKwQVfr8XB/jV9BsggKj9Q
         LH7953r0myjVnnXGFNGGJhdU07hVqccTLOPijXevTKIO6z0BDeeh+N1AxbTJWd2HBljO
         oJu00O3TDePQ/b1GInZGLP8b9+CtTvw2NB2LeIfvoreR8pUgIlcmn/EWu4k1XxduyhSN
         n9FA==
X-Gm-Message-State: APt69E2LlYkoTHdeF8caXQWiB10T3Z/Dsc+R91qgtpvBRj9x4lMVQeF2
        QoP4v6nWMJdMkxATfjkf1mgLwACob6b5QmTblHsyDA==
X-Google-Smtp-Source: AAOMgpf6yjHCn7mjITFi4ZLE401as1HjoGr0jUv9RkNaCscNWqLYBElDRyAUhbMrwrzEXjexS9fBknfRgwXwZd3Qcz8=
X-Received: by 2002:a1c:443:: with SMTP id 64-v6mr3292942wme.140.1529712660830;
 Fri, 22 Jun 2018 17:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7G-ggYTpmdDsNeQRf4upYa34ccOerVmEkEkLOVFrBr2w@mail.gmail.com>
 <20180623000600.5818-1-guro@fb.com> <20180623000600.5818-2-guro@fb.com>
In-Reply-To: <20180623000600.5818-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Jun 2018 17:10:48 -0700
Message-ID: <CALvZod7-VAjyHE7f7bLx7c_1LpWtCy2VV=fB0GLR4bNr1MMx9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: introduce mem_cgroup_put() helper
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 5:06 PM Roman Gushchin <guro@fb.com> wrote:
>
> Introduce the mem_cgroup_put() helper, which helps to eliminate
> guarding memcg css release with "#ifdef CONFIG_MEMCG" in multiple
> places.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/memcontrol.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index cf1c3555328f..3607913032be 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -383,6 +383,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>         return css ? container_of(css, struct mem_cgroup, css) : NULL;
>  }
>
> +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> +{
> +       css_put(&memcg->css);
> +}
> +
>  #define mem_cgroup_from_counter(counter, member)       \
>         container_of(counter, struct mem_cgroup, member)
>
> @@ -852,6 +857,10 @@ static inline bool task_in_mem_cgroup(struct task_struct *task,
>         return true;
>  }
>
> +static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> +{
> +}
> +
>  static inline struct mem_cgroup *
>  mem_cgroup_iter(struct mem_cgroup *root,
>                 struct mem_cgroup *prev,
> --
> 2.14.4
>
