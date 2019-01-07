Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B42183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BiSHT/nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfAGXuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:50:25 -0500
Received: from ozlabs.org ([203.11.71.1]:59099 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfAGXuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:50:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YXFT34gLz9sCr;
        Tue,  8 Jan 2019 10:50:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546905023;
        bh=BaCAFdpLvs/L0Spdiv9XieCnXuiRk7Njqvo2+XSPHbM=;
        h=Date:From:To:Cc:Subject:From;
        b=BiSHT/nuMMHkAK3aV463mx0SNw77BavTrNHarNawWLxpW41kMFYAyQIkanWFbB+1G
         N3X+BZiGaVlssdNBwiXc8LQieZc1vxo9C294MeIFyQSP7rKZyahF9lUwvWrX/RFQHV
         J9qmjX3l8PnJKNQMmijbXWibe7nYLQr/qeQqZvy3iaUPNQiYSK3TrBspZNTvo2NE17
         3eBJfL+UngsrexfdPhAtqXmTqw+iWoR1h+WunvFFCkwbub9paN0S4NVR1b2XEXSwFG
         SCFGJibt7tqXF2Qr8WfrO8/OVO1MIoT8mqAKDIfISicDQqYCUxFFAHSoP+wlgg3T2x
         V1P+sY0oioJAg==
Date:   Tue, 8 Jan 2019 10:50:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: linux-next: build warnings after merge of the drm-intel tree
Message-ID: <20190108105011.619cf6be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) produced these warnings:

In file included from include/linux/printk.h:7,
                 from include/linux/kernel.h:14,
                 from include/asm-generic/bug.h:18,
                 from arch/x86/include/asm/bug.h:83,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:15,
                 from include/linux/io-mapping.h:22,
                 from drivers/gpu/drm/i915/i915_drv.h:36,
                 from drivers/gpu/drm/i915/intel_hangcheck.c:25:
drivers/gpu/drm/i915/selftests/intel_hangcheck.c: In function 'igt_atomic_reset_engine':
include/linux/kern_levels.h:5:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
include/linux/printk.h:303:9: note: in expansion of macro 'KERN_ERR'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
drivers/gpu/drm/i915/selftests/intel_hangcheck.c:1564:3: note: in expansion of macro 'pr_err'
   pr_err("%s(%s): Failed to start request %llx, at %x\n",
   ^~~~~~
In file included from drivers/gpu/drm/i915/intel_hangcheck.c:315:
drivers/gpu/drm/i915/selftests/intel_hangcheck.c:1564:46: note: format string is defined here
   pr_err("%s(%s): Failed to start request %llx, at %x\n",
                                           ~~~^
                                           %x

Introduced by commit

  921f3a60e54e ("drm/i915/selftests: Verify we can perform resets from atomic context")

-- 
Cheers,
Stephen Rothwell
