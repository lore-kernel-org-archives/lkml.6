Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE8ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8D20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC8D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeIOEpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 00:45:42 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42560 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725198AbeIOEpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 00:45:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07906491|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01454;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.Cr.AkNN_1536967707;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cr.AkNN_1536967707)
          by smtp.aliyun-inc.com(10.147.40.44);
          Sat, 15 Sep 2018 07:28:28 +0800
Date:   Sat, 15 Sep 2018 07:28:26 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        DTML <devicetree@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180914232826.GA1497@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <20180914143719.GA27689@guoren-Inspiron-7460>
 <CAK8P3a0fZYbd4a2nBnExPVXKs-898R9vaCSa4kXyz0qA=rCzZQ@mail.gmail.com>
 <20180914160231.GA32161@guoren-Inspiron-7460>
 <CAK8P3a0ZBBL8LHoV=tDr3Ner6wRK=QcrepciZqCPNEHk=B2n7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0ZBBL8LHoV=tDr3Ner6wRK=QcrepciZqCPNEHk=B2n7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:09:35PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 14, 2018 at 6:02 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Fri, Sep 14, 2018 at 04:46:56PM +0200, Arnd Bergmann wrote:
> > > On Fri, Sep 14, 2018 at 4:37 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > > One level below that, you can of course choose to build
> > > a distro with only 64-bit time_t regardless of whether there
> > > is still support for 32-bit time_t in kernel and glibc or not.
> > Do you mean I could merge kernel port into linux-4.19 or linux-4.20.
> > But let glibc merged after linux-4.21 and csky glibc only support
> > time64 syscalls ?
> 
> Yes, that's what I meant. Note that it won't get merged into 4.19:
> the merge window for that was after the 4.18 release and no
> new features are getting merged for 4.19 that have not made it
> into 4.19-rc1 already.
> 
> Getting your code into linux-next now is the prerequisite for you
> sending a pull request during the 4.20 window.
Got it, thank you very much.

 Guo Ren
