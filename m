Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F76F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F76F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJZBhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:37:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49818 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbeJZBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:37:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.074414|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.D7uosep_1540487048;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D7uosep_1540487048)
          by smtp.aliyun-inc.com(10.147.42.198);
          Fri, 26 Oct 2018 01:04:09 +0800
Date:   Fri, 26 Oct 2018 01:04:08 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH V9 01/21] csky: Build infrastructure
Message-ID: <20181025170407.GA9747@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <801add6d63256a3bf0802e2b03efb0f9c206dab0.1539655731.git.ren_guo@c-sky.com>
 <20181023000834.GA20335@guoren-Inspiron-7460>
 <CAK8P3a2coXVaaiZUcxsp8DmWcVdBrDMomYAN--M42TuSnHxKNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2coXVaaiZUcxsp8DmWcVdBrDMomYAN--M42TuSnHxKNA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 11:53:05PM +0100, Arnd Bergmann wrote:
> On Tue, Oct 23, 2018 at 1:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Hi Arnd,
> >
> > Could you help me review the patch, seems the patch is skipped.
> > ref: https://lkml.org/lkml/2018/10/16/224
> 
> Ah right, I missed that. I think I originally had some thoughts on it but
> didn't immediately comment and then forgot about it. It's basically
> ok, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thx.

> 
> but please have a look below for a follow-up patch:
> 
> > > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> > > new file mode 100644
> > > index 0000000..014eb57
> > > --- /dev/null
> > > +++ b/arch/csky/include/asm/Kbuild
> > > @@ -0,0 +1,72 @@
> > > +generic-y += asm-offsets.h
> > > +generic-y += bitsperlong.h
> > > +generic-y += bugs.h
> > > +generic-y += clkdev.h
> > > +generic-y += compat.h
> > > +generic-y += current.h
> > > +generic-y += delay.h
> > > +generic-y += device.h
> > > +generic-y += div64.h
> ...
> > > +generic-y += errno.h
> ...
> > > +generic-y += ioctl.h
> > > +generic-y += ioctls.h
> 
> A number of the header files that are marked as generic-y in
> asm/Kbuild are also marked the same way in uapi/asm/Kbuild.
> I think this is a mistake, since we only need one of the two
> for each header.
> 
> When both exist, we just take the one from asm/, but then we install
> the uapi/asm/ version in the 'make headers_install' stage, and they
> both have the same contents, so I think you only need the uapi/asm/
> version here.
Ok, I've cleaned them up.

> 
> > > diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
> > > new file mode 100644
> > > index 0000000..b65252b
> > > --- /dev/null
> > > +++ b/arch/csky/include/uapi/asm/Kbuild
> > > @@ -0,0 +1,33 @@
> > > +include include/uapi/asm-generic/Kbuild.asm
> > > +
> > > +header-y += cachectl.h
> > > +header-y += stat.h
> 
> It also seems that the second statement here (for stat.h) is from
> an older version, since that header no longer exists, at least if
> I'm reading your patches correctly.
Yes, no "header-y += stat.h" and I've removed it.

Thx for the reviewed.

Best Regards
 Guo Ren
