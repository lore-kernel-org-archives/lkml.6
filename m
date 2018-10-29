Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EEFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E812082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E812082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ3C2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:28:35 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36333 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbeJ3C2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:28:35 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1131714|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.DAAOCic_1540834732;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DAAOCic_1540834732)
          by smtp.aliyun-inc.com(10.147.42.253);
          Tue, 30 Oct 2018 01:38:52 +0800
Date:   Tue, 30 Oct 2018 01:38:52 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, peterz@infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        guoren1983@gmail.com
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Message-ID: <20181029173852.GB3532@guoren-Inspiron-7460>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
 <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGisxiWaQn9qDqpfxEWcckkGJfMzFvSPGvuhQK7oB404-6DQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:54:26AM -0500, Rob Herring wrote:
> On Fri, Oct 26, 2018 at 11:09 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:
> >
> >   Linux 4.19 (2018-10-22 07:37:37 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/c-sky/csky-linux.git tags/csky-for-linus-4.20
> >
> > for you to fetch changes up to 2347e7e1aea410865e3c3f92014b07ff7d4c5b02:
> >
> >   dt-bindings: interrupt-controller: C-SKY APB intc (2018-10-26 00:54:31 +0800)
> >
> > ----------------------------------------------------------------
> > This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> > Release, which has been through 10 rounds of review on mailing list.
> >
> > We almost got the Acked-by/Reviewed-by of all patches except "Process
> > management and Signal", but all've been tested.
> 
> I just noticed a couple of build related issues. First, you agreed to
> remove the built-in dtb part way back on v1[1], but that's still
> there. Please remove it. As Arnd mentioned that is for legacy use and
> we shouldn't be adding that for new arches.
> 
> Second, the dtb build infrastructure was re-worked for 4.20. See
> commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build
> rules"). You'll need similar changes for c-sky as other arches. It's
> mostly deleting lines.
Ok, I'll give an another patch include deleting built-in dtb and
deleting lines in Makefile for 4.20 dtb build infrastructure. 

> Rob
> 
> [1] https://lkml.org/lkml/2018/3/21/332
