Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0069C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F1F216F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXhm0Clj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F1F216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeHCIGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:06:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40799 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeHCIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:06:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so3299180qkd.7;
        Thu, 02 Aug 2018 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=no/jOIE21X8Xkokb0gVPzfOsDFcu8RUDjm0Ga7io9Zk=;
        b=CXhm0CljIHNp3DHVN0JP+B2UimdHHtw/jxqq6WT1GXwlwjXTxQRQoK5QsiS+zP2zCE
         WsA+6Qlj/b0EuJ+5sNwP4pZHrmxO8kwrXW07P7W7e8zdEVRFg7xnTDPUoDR22jUwDDJS
         vDgKSkjh+oZ+U/NHBuWzzGv12dEoYC/d9Zat4NAis7koJxXvWQdxz5XiglaoVihZ0bOV
         RV/mUOKKEnokQQ4zkpZpUA7fnmFbMe36LRqZ+jOm1+FXi9cIsDwK0afnUD/9txSTR3K9
         nmHgPrZGITSTAtRGvKF9N6S+xgTZa6q/WkpmpVJ5QrGDy0YGtoNOaGgo7NZK7F30nduO
         vPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=no/jOIE21X8Xkokb0gVPzfOsDFcu8RUDjm0Ga7io9Zk=;
        b=AuNNhdJjG+6Q+dnK4byhjpEBJeH0WHMH3NV6o64ZAfnhBljm1GeKYrNuXcYo/rM1+0
         QtmJOQXQ3a78KbkOhKmBizjM9YjpA2/fCL6QeH7sVImX610jI0krHVBNhg5+WWLYs8O2
         G8pASQxdiscscnvxyfkYctLQBuWDiY720ngnjQmCOWna1JSbNbDeykpXh73fvGoOZcPk
         3mHw0cKE0/qAfj3BUdVF0ad2gsKLXu5WCuHKB1cH/cctleCu4G8sIt6h7OaPJcrFNOO3
         NOhAZ3jhSad6JYr+nVkp4gj0mTMPSQqa74jv98N1BVEKeCroXEr5oei3rM9OSTbyuqZe
         pFlA==
X-Gm-Message-State: AOUpUlEF7ua6D1FRvz379PVvD5GuDqdIa63MqYIYDhPHzdcmjtyAq6q/
        6/HKVCfMSFuL1sPbmyvpuw+dMp9uKIrDH1bhk1s=
X-Google-Smtp-Source: AAOMgpeDp/5xloFY7wj4LS6wdEKufkb/rihm0KHicwwIxNzi/1a07KRl83enTcg/neFOQB6uwHAanCQhT7SUS5JQ3EA=
X-Received: by 2002:a37:3515:: with SMTP id c21-v6mr2364432qka.355.1533276698112;
 Thu, 02 Aug 2018 23:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
In-Reply-To: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 3 Aug 2018 14:11:26 +0800
Message-ID: <CAGWkznE_Z+eJ+81eZN_KT7KXSFyCxfoafeMFSzirT7OaL+vbRA@mail.gmail.com>
Subject: Re: [PATCH v1] mm:memcg: skip memcg of current in mem_cgroup_soft_limit_reclaim
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 1:48 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> for the soft_limit reclaim has more directivity than global reclaim, we40960
> have current memcg be skipped to avoid potential page thrashing.
>
The patch is tested in our android system with 2GB ram.  The case
mainly focus on the smooth slide of pictures on a gallery, which used
to stall on the direct reclaim for over several hundred
millionseconds. By further debugging, we find that the direct reclaim
spend most of time to reclaim pages on its own with softlimit set to
40960KB. I add a ftrace event to verify that the patch can help
escaping such scenario. Furthermore, we also measured the major fault
of this process(by dumpsys of android). The result is the patch can
help to reduce 20% of the major fault during the test.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
> ---
>  mm/memcontrol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0280b..9d09e95 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2537,12 +2537,21 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>                         mz = mem_cgroup_largest_soft_limit_node(mctz);
>                 if (!mz)
>                         break;
> -
> +               /*
> +                * skip current memcg to avoid page thrashing, for the
> +                * mem_cgroup_soft_reclaim has more directivity than
> +                * global reclaim.
> +                */
> +               if (get_mem_cgroup_from_mm(current->mm) == mz->memcg) {
> +                       reclaimed = 0;
> +                       goto next;
> +               }
>                 nr_scanned = 0;
>                 reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
>                                                     gfp_mask, &nr_scanned);
>                 nr_reclaimed += reclaimed;
>                 *total_scanned += nr_scanned;
> +next:
>                 spin_lock_irq(&mctz->lock);
>                 __mem_cgroup_remove_exceeded(mz, mctz);
>
> --
> 1.9.1
>
