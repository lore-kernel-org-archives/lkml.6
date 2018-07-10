Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19927C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C192089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C192089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeGJN56 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:57:58 -0400
Received: from ozlabs.org ([203.11.71.1]:36209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933379AbeGJN5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:57:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Q3gN5JL6z9s0W;
        Tue, 10 Jul 2018 23:57:52 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     kbuild test robot <lkp@intel.com>, Daniel Klamt <eleon@ele0n.de>
Cc:     kbuild-all@01.org, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de, Daniel Klamt <eleon@ele0n.de>,
        Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep with usleep_range
In-Reply-To: <201807100423.0p0r9QGb%fengguang.wu@intel.com>
References: <1531144679-31675-1-git-send-email-eleon@ele0n.de> <201807100423.0p0r9QGb%fengguang.wu@intel.com>
Date:   Tue, 10 Jul 2018 23:57:51 +1000
Message-ID: <87y3ej9ork.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Hi Daniel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc4 next-20180709]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Daniel-Klamt/powerpc-Replaced-msleep-with-usleep_range/20180709-231913
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/sysdev/xive/native.c: In function 'xive_native_configure_irq':
>>> arch/powerpc/sysdev/xive/native.c:113:2: error: expected ';' before '}' token
>      }
>      ^

There's also instructions here for building the powerpc kernel:

  https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels

cheers
