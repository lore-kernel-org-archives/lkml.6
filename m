Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218F820894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAN6vIGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218F820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeHBCfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:35:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41658 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbeHBCfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:35:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so365050wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLMmQZKGB306tF6nzhyBHI8F/ZUpMiIRks5yhPniuEk=;
        b=bAN6vIGX2l6N64KYwgH/B5ptNpPUl4KB40i4v8YV4d8DEW1UKeDCy549GxRv9X2tMB
         mH64GJ2qF590hyKhfoCdyOgEHVWFm2XlyJZYCwRbG5OZzvu2QKJbGJFZVlIHYH7a2diw
         s3qO4fmNHOcoVPwpR7fNAxVGWNPZasEwudAOw6VIPl4iXrjyda6vU17w9oSRPI6FL/aI
         hn3Wr+cm31wgWU7X6xQ8GRqUCAPgNrD7Zu0Io0tXxv8rS9U8ahUt+4zxDBCQnyUQHOHW
         ZsdtrdsIjGZaT6zDgswccLrQz6WMw+e/6V25dIgbpUuPLwn71g6E8DGIOrl6lAEqCJoc
         hiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLMmQZKGB306tF6nzhyBHI8F/ZUpMiIRks5yhPniuEk=;
        b=Hq9HJPcrNdhceBwBqvY4JXYL3oOgIHigdNlQ8CevbB6Hd5Vfq2LbeO7A06hd0p4BWs
         oUlMhjMheXBTbX4Ms0PdEwR2UuVh95vdnCqoz4MkulOBN4I4MjP3FPLoBa4FwAPoJw0D
         ymbK/MGqED3W/Hd1pGAjqErAnEcpTEbsoi+70izxVWJ4qCIVs/NPaz7EBa8ftKibERIO
         nGfEpti4XfJczbZ1ZhpA2FXeq8SUO++VPUJMZllWWBCt/TxOfVpx026pLce1FYy07bj7
         IV62YJ4MR2dikynWYeZXgyLA5XT4jZCSZDemFnCkN6XyDp6lS/WQIxh1l9/fgh/mnkUG
         g3Qw==
X-Gm-Message-State: AOUpUlHJOo297xbgwE5aBNPYVPofpcWvKXJGuKxHDY0jyioJOD28O4gt
        R99YmuhtCHW+6ugw1YUahPBXsqMlvy7H37v8TQ2xRw==
X-Google-Smtp-Source: AAOMgpewqAo61xrQa5SU9rgmN/Hz393rElahlGFrOBSLsAmsWCw5fBWEjmAHxX+CBpsMtl66HBc92JafD2HL+IvngX8=
X-Received: by 2002:a5d:4410:: with SMTP id z16-v6mr356516wrq.272.1533170832924;
 Wed, 01 Aug 2018 17:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180802003201.817-1-guro@fb.com> <20180802003201.817-2-guro@fb.com>
 <20180802103648.3d9f8e6d@canb.auug.org.au>
In-Reply-To: <20180802103648.3d9f8e6d@canb.auug.org.au>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 1 Aug 2018 17:47:01 -0700
Message-ID: <CALvZod6OU=qPQy6bjovTQcAu8tm=XLoSxuaVpZibJsoGUgs4qA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: introduce mem_cgroup_put() helper
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 5:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Roman,
>
> On Wed, 1 Aug 2018 17:31:59 -0700 Roman Gushchin <guro@fb.com> wrote:
> >
> > Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> > memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
> >
> > Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Michal Hocko <mhocko@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> I have no idea why my Signed-off-by is attached to this patch (or
> Andrew's for that matter) ...
>

Roman might have picked this patch from linux-next and sent as it is.

Shakeel
