Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B59C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBD1213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cjGMAxSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBD1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeIMHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:35:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41063 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeIMHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:35:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so3431763lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTBAiOhJjXdpy7pTQ3EM/qRpEIA9FGKANOyCbhWLtsU=;
        b=cjGMAxShqfwmgLUfj19Q/pn+WXgDbe3dwzTU5DmlrE1rLuaJTxAUETdjBo5XibGh+u
         SbF+oI0canFL31kU412agnng4TOVpr3ElU9Um5JMltlU6xjNmCs0F4BthqaBu61DHjMu
         3FWyI6UU3V2N5puF6e7nD3+R3qt+Po3ZlApWeoNsJ0EotkcC306m39jSfnEheM+Lydn4
         1aLQhwmrVm60p8/y/RVUy9CqkD0ihyodtZuRAaDicnLgeqSjb1y3F+VrqS9gDJCCRSru
         s10A50Q+dPlSIauR7LlTJifkxfJ7wD1/5BcJiOPdp5F4hhMoxDsS7dye5e0fuUmgSspt
         Ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTBAiOhJjXdpy7pTQ3EM/qRpEIA9FGKANOyCbhWLtsU=;
        b=A9cMH1YFVnktIaJFpO9C66pbDT1mmqnum7Zx710IFRXrPSoLvcB0Qvbsw/3ekoBRlY
         ygYsbSjzB2DVYjZZQ+wDV94lvLEguLg+hqeBoeCogxkY+p1JhDc6oXew/cpwemJpaZ/a
         Nj72lmVwxorUKhFzQ4aTdoOXaQJaPbG2hK1IEQD7Ak2TE5bRxIyZKcbdT2SRikt7jUXM
         ZzN4Qip8uRTEfTA9MKC2kk0QwIyYmo13+neK91utUZt/+WKrBkKdpgTXaM93sgLr1uii
         4L/KVfWai3sElQ2BkyG27njnmLeLAPDkEhWFgx1O0GVcRj7o/VS927Kv9lru93EgKNIY
         1Ssg==
X-Gm-Message-State: APzg51CaZeXeJKZC+flfjY+XGkZXfqb4xTN3h3LAKJBwPMnH2oTfrcbp
        95aPnbGHk5OEtd89I/KN7bwGk3MmUedGmUpm1TzY
X-Google-Smtp-Source: ANB0Vdb0ZQcMslZjYFw3109JK3hS/6yBbc1AScJXHtbIYgh+QZWkJVT9Oo/MznIHZs3AEp80OEq4Fr9jauUSGcYqVxQ=
X-Received: by 2002:ac2:4308:: with SMTP id l8-v6mr3286339lfh.35.1536805672071;
 Wed, 12 Sep 2018 19:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-4-kent.overstreet@gmail.com> <89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
 <20180907175014.GA29485@kmo-pixel>
In-Reply-To: <20180907175014.GA29485@kmo-pixel>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Sep 2018 22:27:40 -0400
Message-ID: <CAHC9VhS=CaEd4quGRv97Dn_2gm7=jMq+nHJvSOnuBtoA=DZvDQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] selinux: convert to kvmalloc
To:     kent.overstreet@gmail.com, selinux@tycho.nsa.gov
Cc:     penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, willy@infradead.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 1:50 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, Sep 08, 2018 at 02:08:03AM +0900, Tetsuo Handa wrote:
> > On 2018/09/08 1:56, Kent Overstreet wrote:
> > > @@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> > >             nslot = MAX_AVTAB_HASH_BUCKETS;
> > >     mask = nslot - 1;
> > >
> > > -   h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> > > -                                GFP_KERNEL | __GFP_ZERO);
> > > +   h->htable = kvmalloc_array(nslot, sizeof(void *), GFP_KERNEL);
> > >     if (!h->htable)
> > >             return -ENOMEM;
> > >
> >
> > kvmalloc_array() does not imply __GFP_ZERO.
>
> Thanks, fixed

When you resubmit this patch, please make sure you submit it to the
SELinux list (added to the To line above) so that it can be properly
reviewed and merged.

Thanks.

-- 
paul moore
www.paul-moore.com
