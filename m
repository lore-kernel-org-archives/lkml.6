Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB75C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRYFiLEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5856620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbeGYBql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:46:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbeGYBql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oPgJZl4y9Of/Z/PzjVVkchUsAvpXd7VFB85l24ABxRs=; b=iRYFiLEk+OHEIdfCxp1Kt3ArG
        3bGz0PnHuaWE78i6WeB0FgMudmYE6jBcuyiVk15ECf/ea7iYvCJFp8uuj3HVnjRzp1YrroSJuT/bK
        X/EKWto09UMafvN+wYOkJkGmQL+aVMoTovfBplJWWgeLroz0of/qcquLeUpP/ZeyvZcGSv/q6AcGa
        oAUtgtpZAmlNQ11hi9FwJV2gT0dcUiuC1UjHFBrIT3hsNnPGonsjwAFxFKgedegBzL+YslJxABOuD
        Ci0WTL+C/LFrj4pYUy4J/s9Kl3LrCkcdkH6LLrXgV4KiQmXW44JJ32yxG5PTYkc2weySWtSikouaq
        wfU/wp2Rg==;
Received: from 177.41.135.13.dynamic.adsl.gvt.net.br ([177.41.135.13] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi7o9-00047Q-9d; Wed, 25 Jul 2018 00:37:37 +0000
Date:   Tue, 24 Jul 2018 21:37:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: staging: tegra-vde: Replace debug messages
 with trace points
Message-ID: <20180724213733.6c8b6b4b@coco.lan>
In-Reply-To: <3929419.8vW2TRoUPb@dimapc>
References: <20180707162049.20407-1-digetx@gmail.com>
        <20180724190652.2befcaf6@coco.lan>
        <3929419.8vW2TRoUPb@dimapc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 25 Jul 2018 01:38:37 +0300
Dmitry Osipenko <digetx@gmail.com> escreveu:

> On Wednesday, 25 July 2018 01:06:52 MSK Mauro Carvalho Chehab wrote:
> > Em Sat,  7 Jul 2018 19:20:49 +0300
> > 
> > Dmitry Osipenko <digetx@gmail.com> escreveu:  
> > > Trace points are much more efficient than debug messages for extensive
> > > tracing and could be conveniently enabled / disabled dynamically, hence
> > > let's replace debug messages with the trace points.  
> > 
> > This patch require some work:
> > 
> > $ make ARCH=i386  CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y C=1
> > W=1 CHECK='compile_checks' M=drivers/staging/media
> > 
> > ./include/linux/slab.h:631:13: error: undefined identifier
> > '__builtin_mul_overflow' ./include/linux/slab.h:631:13: warning: call with
> > no type!
> > fixdep: error opening file: drivers/staging/media/tegra-vde/trace.h: No such
> > file or directory  
> 
>   CHECK   drivers/staging/media/tegra-vde/tegra-vde.c
> /bin/sh: compile_checks: command not found
> 
> Upstream kernel doesn't have "compile_checks" script and I can't find it 
> anywhere else.

This is just a call for smatch/sparse:

#!/bin/bash
/devel/smatch/smatch -p=kernel $@
# This is too pedantic and produce lots of false-positives
#/devel/smatch/smatch --two-passes -- -p=kernel $@
/devel/sparse/sparse $@

However, the problem here is that you're doing a 64 bits division.
That causes compilation to break with 32 bits. you need to use
do_div & friends.


Thanks,
Mauro
