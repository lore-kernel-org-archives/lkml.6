Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CED8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E7D20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldgt74xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E7D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeLKSEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:04:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39914 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:04:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so3246369wmd.4;
        Tue, 11 Dec 2018 10:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwWUMo6beCgCPrW5yYM3akx4k7A7+JHyKA351TyVZk0=;
        b=Ldgt74xpxmIV+6JnS6m63rEB2Kb680fv5IIh1Q+vf16i18Fa3lzAL7GT1yUcBnvK2Z
         0oiTXe4MwuWc+tZFbGHouGB3QyQcFgOl0Xq6NIYSrjS3Cm1gKRRX352mm5T7HzInjhnV
         ln0zJZeykB0ZVQaCJmfs9CKqFgu69cR6uh2GG+l2H5fjvGAVjXi9n4CsrnmFcxTxoK8P
         pG8XzQE2ZzCFOp2MlF1bWTALDdSPLSl9ZqmxBc+tmmycc5kbqe2lF0P5xZD5TM0rUPTw
         5DZ8C99m7YNyJxsRAN470+EYKn1DAU/4Fx9pQzQXG8p/X+zi80nayn35VodAlKXIp/Iy
         bNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwWUMo6beCgCPrW5yYM3akx4k7A7+JHyKA351TyVZk0=;
        b=LXLDnd6toYySHbCVT1xWy8RlOjLLg47xrOizV+tHNpbVl0v6/eCYvwsA9itbvISOBS
         XB66HWizAI4bGBoxP/wCZsf7gDvoFzvIrZh16JCDpcedXWGilWsdJWcfAa3q5ubdfN5S
         Tbg92e6grH+sq7mwElFWd2X54T6o0XwPhXuWCHzqtp7ywE0pJB68fUmG9RVa0hWuGH3e
         rloQvQa3dD43OiJsNgCw1bPsqDhUGPtP3ulgxU8FohzpAb+Fj4uxl4ggu2ccvofcrmzs
         P41SC/hKcJ3bft9lzqO5vPzVPZtK/XC2Nh4awHzyb0AAJs6do01VUBJq3r0O3uougJgI
         s9sw==
X-Gm-Message-State: AA+aEWYsI9GmqS/ae6izw6TxnoFHdglCC1RncCagkKQTHf1ZuTzIAQnr
        YywMBAZke7FjMIyT7Ajy4cz8x4lvROfZPQ==
X-Google-Smtp-Source: AFSGD/XKOa0F2x3vxauth/h0HvPbkZ+SqENRkpl7xU4xN1mcGgJygx/kcZrStaokMZsFu53+2rFHKg==
X-Received: by 2002:a1c:d7d3:: with SMTP id o202mr3516324wmg.135.1544551479444;
        Tue, 11 Dec 2018 10:04:39 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j8sm1074859wmd.0.2018.12.11.10.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 10:04:38 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:04:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181211180437.GA28010@flashbox>
References: <20181211182627.42b79e40@canb.auug.org.au>
 <20181211173851.GA29028@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211173851.GA29028@roeck-us.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:38:51AM -0800, Guenter Roeck wrote:
> On Tue, Dec 11, 2018 at 06:26:27PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20181210:
> > 
> > The arm64 tree gained a conflict against Linus' tree.
> > 
> > The f2fs tree gained a conflict against the fscrypt tree.
> > 
> > The ubifs tree gained a conflict against the fscrypt tree.
> > 
> > The rdma tree still had its build failure so I used the version from
> > next-20181203.
> > 
> > The tip tree gained a conflict against the hwmon-staging tree.
> > 
> > The gpio tree lost its build failure.
> > 
> > The akpm-current tree lost its build failure but gained conflist against
> > the arm64 tree.
> > 
> > Non-merge commits (relative to Linus' tree): 7744
> >  8462 files changed, 365061 insertions(+), 211977 deletions(-)
> > 
> 
> Build results:
> 	total: 152 pass: 150 fail: 2
> Failed builds: 
> 	arm:allmodconfig 
> 	arm64:allmodconfig 
> Qemu test results:
> 	total: 337 pass: 137 fail: 200
> 
> Build failures:
> 
> arm:
> 
> In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
>                  from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
> arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> 

Just FYI, I noticed this one yesterday on next-20181210 and sent a patch:
https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@gmail.com/

> arm64:
> 
> arch/arm64/kernel/entry-ftrace.o:(_kprobe_blacklist+0x0): dangerous relocation:
> 	unsupported relocation
> 
> The latter is with gcc 7.3.0. I'll build and try with gcc 7.4.0 and
> the most recent binutils later.
> 
> Most of the failing qemu tests fail with something like
> 
> Starting init: /sbin/init exists but couldn't execute it (error -95)
> 
> Others (such as aarch64) crash silently.
> 
> Has anyone reported this already, or do I need to run bisect ?
> 
> Guenter

Thanks,
Nathan
