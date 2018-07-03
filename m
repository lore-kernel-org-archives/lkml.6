Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FBDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791D2443A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791D2443A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeGCJOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:14:21 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57340 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754096AbeGCJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:14:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3124299|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.CLhT.gp_1530609249;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CLhT.gp_1530609249)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 03 Jul 2018 17:14:09 +0800
Date:   Tue, 3 Jul 2018 17:14:09 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
Message-ID: <20180703091407.GA31664@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
 <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiswb+SmdAi9qV80Yum3Uf=ohrSMpZKWkvJXK8n=GjTzxhQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 09:33:51PM -0600, Rob Herring wrote:
> > +config CSKY_BUILTIN_DTB
> > +       bool "Use kernel builtin dtb"
> > +
> > +config CSKY_BUILTIN_DTB_NAME
> > +       string "kernel builtin dtb name"
> > +       depends on CSKY_BUILTIN_DTB
> > +endmenu
> 
> These options generally exist for backwards compatibility with legacy
> bootloaders that don't support DT which shouldn't apply here given
> this is a new arch. If we need this for other reasons, it should not
> be an architecture specific option.
We want the BUILTIN_DTB for some boards and they don't need change dtb
at all. And I just follow other archs BUILTIN_DTB in their Kconfig. eg:
xtensa, h8300, mips, nds32, sh, openrisc, arc ...

I just keep this in Kconfig.debug and it's not a recommended method.

Guo Ren
