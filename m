Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C83121569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C83121569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391697AbeIVFkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:40:02 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45365 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725748AbeIVFkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:40:02 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437939|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01534;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.Cu2F6QK_1537573694;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cu2F6QK_1537573694)
          by smtp.aliyun-inc.com(10.147.40.233);
          Sat, 22 Sep 2018 07:48:14 +0800
Date:   Sat, 22 Sep 2018 07:48:14 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
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
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180921234813.GA5469@guoren-Inspiron-7460>
References: <20180914143719.GA27689@guoren-Inspiron-7460>
 <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
 <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:18:51PM -0700, Arnd Bergmann wrote:
> On Thu, Sep 20, 2018 at 10:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> > > On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > >> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > I don't want to hijack this thread, but in RISC-V land we were hoping to have a
> > user ABI free of 32-bit time_t.  Our 32-bit glibc ABI hasn't been finalized
> > yet, and when I talked to the glibc guys a few weeks ago they were happy to let
> > us wait until 32-bit time_t can be removed before we stabilize the ABI.  We've
> > been maintaining out-of-tree glibc patches for a while now, so I'd really like
> > to get them into the next glibc release.
> >
> > Mapping out the schedule more explicitly, as I'm terrible with dates:
> >
> > * 4.19-rc4 was 2018-09-16
> > * 4.19 should be 2018-10-21
> > * 4.20 should be 2019-01-13 (skipping 2 weeks for the holidays)
> > * 4.21 merge window should close 2019-01-27
> > * glibc 2.29 is scheduled for 2019-02-01
Thx for the schedule info.

> >
> > That's very tight, but assuming we at least have a prototype of the API so we
> > can get the rv32i glibc patches in much earlier it might be OK.  There was some
> > talk of being able to use some workarounds to do a 32-bit time_t user ABI
> > without the cooresponding kernel ABI, so we could always go down that route to
> > start and then decide to deprecate or not deprecate the 32-bit kernel ABI at
> > the last minute -- not something I'm fond of doing, but an option.
> >
> > How close to done do you think the 32-bit time_t will be by the end of the 4.20
> > merge window?  If it's close enough to start our glibc push then that might be
> > OK.
> 
> It will be a bit of a stretch, but it's possible. Most syscalls are
> done in linux-next,
> I have a few more pending, and only clock_adjtime is really missing now (I had
> some earlier patches that I could revive).
Seems time schedule is OK. If we make csky get into linux-4.20, then csky glibc
port could remove 32-bit time_t in patchset before glibc 2.29 release.

> My plan was to get that all into 4.20, and then have a conversation about the
> actual syscall table changes in 4.21. If we need it for both csky and rv32,
> we might just change the generic syscall table that way in 4.21 without
> changing all the other ones along with them. I don't want to drag things out
> over too many merge windows though, and my plan was to do all architectures
> together to simplify the version checks in the libc code to only have to check
> for a single version.
Seems that's no problem.

Best Regards
 Guo Ren
