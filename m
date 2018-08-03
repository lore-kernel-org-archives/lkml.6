Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2BC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE1821708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BynFY7Oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1821708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeHCCHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:07:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35752 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeHCCHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IeB3GYzKkJzHXXydeNb5n4BpCJGaH3NgGKDy0S00Qbc=; b=BynFY7Oj/EFE/9+wq5VNe7OCzU
        s87/lb0Ln8UGId9XudKIHs7TZ0DzGrRF/7KS9ZyCQQqxTTQw7ke4CdnrjXVKNZiV83usGSzeWa3P3
        ZJmeMZNeWUi4lIvJdpPGzBSi83EP+BSnO6e5yBudwlGfb7uF+lwWv8vnUFHCwmp4vUaRaLE78ArZg
        ga+LNhiBz4an3xxl+KyihbqepJOyYm99rOs54yEHTNbdoNl3r+rQ4Ln5DXIyeW2hI3XiEi/2bBj5G
        0g+o32QjYPIj7kzEolBYhn6o76r14IAoP550sER6/RFkh8aWNcPtNVVUlesr2VFwp/FAvDySj2sSp
        g+EwxJsg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flNjJ-0001U9-Dz; Fri, 03 Aug 2018 00:14:05 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: kbuild: ARCH=um archheaders failed
Message-ID: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
Date:   Thu, 2 Aug 2018 17:13:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

I see this every few weeks.  It's not reproducible (it depends
on the moon, Mars, etc.).

I'm using O=builddir.  The build log is short (below).

Do you see a makefile problem here?  (nothing to do with mmotm;
I see it more frequently with linux-next since I do many daily
builds with it)


thanks.
-- 
make[1]: Entering directory '/home/rdunlap/mmotm-2018-0802-1529/UM64'
  UPD     include/generated/uapi/linux/version.h
  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
  WRAP    arch/x86/include/generated/asm/export.h
  WRAP    arch/x86/include/generated/asm/early_ioremap.h
  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  GEN     ./Makefile
make[2]: *** No rule to make target 'archheaders'.  Stop.
arch/um/Makefile:119: recipe for target 'archheaders' failed
make[1]: *** [archheaders] Error 2
make[1]: *** Waiting for unfinished jobs....
  UPD     include/config/kernel.release
make[1]: *** wait: No child processes.  Stop.
Makefile:146: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

