Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A59C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA60E26D11
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blCmN+rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60E26D11
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbeFZSBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:01:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43329 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeFZSBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:01:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id c5-v6so6987121wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heX1f2CgGl3o496OINg/xkciw0CIxICRoeLjeNzNB8I=;
        b=blCmN+rB92ggkg97DX3WhoaU2AbUmshLBzwVLHRQPN/+/M8ilEObphnd1xr8/J+zsV
         AW8Rj8yOHxWnEljCjolT+El7uduYY88Bq/h3d9VPTmWkOFAjoNRLpYOhC+crvQOSq3RE
         zjr7sCZ1q7GwgVNlyasCg13F+XbWQC164E3byLPkx3e225YSUEyvyBtCaKwH94mf3RsC
         KGHvnm+EZD7rAIw25s4FMR6mNVRo9ZCZx9BnMndbPSoLmURDogisyU5aCIhf1YnqNnul
         84JWydFmIQQQYg+sq28n8zfcQeDlFu8U9for7PNm3+cB3LitFoPjxhyqtpDrKm6MRnUI
         c/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heX1f2CgGl3o496OINg/xkciw0CIxICRoeLjeNzNB8I=;
        b=XQmOSrya6im1qE2K/TDt9I7QACpPUgPbMDSJrhcJ09Pu1hzW8F1V3FTbFHPevSnufE
         sALzt9idDmi6y3o3LwhWXS40hB6yjVZSkAbJuCRVtA70E36WLLlKJJ88paDrGQFo4SYp
         FyR8xc+jFfUa5difd7XjagkslfznC3/LYp373wxvpRl/PsLpuh1AlW8QZ786kz3WB4/7
         Y/1kOkZb9yTC+KAgK8L0YMKVDAJFJZQyvJ9h2QUI6cLT1PqvN0YveWgZHLqHD/ob94GD
         xhB/CScUHFxlHl+YyXgQ2GOvlyjqOoH5GsdSr+ZvZ0GWTM5OnkEfFyZ35DxYj5c+PmLj
         WDPw==
X-Gm-Message-State: APt69E3huHBs4BMs7T2s4/HUCXl8E6U88yS5bzmmqdbnKnEuUwf/HLV0
        2oXkpr9BnxqIDKA5MLvdZM2gA1Vu9q4ejbRguaaZwA==
X-Google-Smtp-Source: AAOMgpeTQdnxRDM/MkNj2ivudoIOaIVjDSQFi9sqrKI3GBu+M7R7rb35OsoJ4DUCc+ED4PBpOXhvXMfEL9SIqsenpjA=
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr2553914wrm.8.1530036065492;
 Tue, 26 Jun 2018 11:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180625230659.139822-1-shakeelb@google.com> <20180625230659.139822-2-shakeelb@google.com>
 <CAOQ4uxiV75+X3dMLS93iXqwmSU6eKPOUocdkXiR7MQZhEjotQg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiV75+X3dMLS93iXqwmSU6eKPOUocdkXiR7MQZhEjotQg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 26 Jun 2018 11:00:53 -0700
Message-ID: <CALvZod5ARMZL+eD8-mrxeBvxJcuVPXaCwWEgUyQw85xXWxHauA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
...
>
> The verb 'unuse' takes an argument memcg and 'uses' it - too weird.
> You can use 'override'/'revert' verbs like override_creds or just call
> memalloc_use_memcg(old_memcg) since there is no reference taken
> anyway in use_memcg and no reference released in unuse_memcg.
>
> Otherwise looks good to me.
>

Thanks for your feedback. Just using memalloc_use_memcg(old_memcg) and
ignoring the return seems more simple. I will wait for feedback from
other before changing anything.

thanks,
Shakeel
