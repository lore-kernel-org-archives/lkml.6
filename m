Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443CC2088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443CC2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeIQUGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:06:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39664 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbeIQUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:06:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08021893|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.Cs.KY0z_1537195080;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cs.KY0z_1537195080)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 17 Sep 2018 22:38:00 +0800
Date:   Mon, 17 Sep 2018 22:37:59 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180917143759.GA2612@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
 <20180917215443.3b5808c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917215443.3b5808c5@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:54:43PM +1000, Stephen Rothwell wrote:
> Hi Guo,
> 
> On Sun, 16 Sep 2018 12:53:26 +0800 Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > I'm Guo Ren from C-SKY and I'm working on csky linux port upstream.
> > I've prepared my git-tree based on linux-4.19-rc3:
> > git clone -b linux-next https://github.com/c-sky/csky-linux.git
> > 
> > Here is the pre-built cross compiler for fast test from our CI:
> > https://gitlab.com/c-sky/buildroot/-/jobs/97941896/artifacts/file/output/images/csky_toolchain_csky_ck860_platform_defconfig_72371bf75a51f27ea59fc34eeaf236e06b75bf69.tar.xz
> > 
> > You can also build newest gcc, binutils and they are upstreamed but not
> > released on gnu.org. Glibc is uptreaming now.
> > 
> > Please have a look and any feed back is welcome.
> 
> Added from today (called "csky").
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

 I am very excited to receive your mail. I have been preparing for this
 for nearly 3 years.

 - All files are under GPL v2
 
 - All Contributors have been Signed-off.

 - All have been reviewed.

 - For develop detail you can find in: https://github.com/c-sky/csky-linux
   It records from 'Dec 2015' to 'Sep 2018'.

 - Here is the newest ltp test result: https://gitlab.com/c-sky/buildroot/-/jobs/98061317

 Best Regards
  Guo Ren
