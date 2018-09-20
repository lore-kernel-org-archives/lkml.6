Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7204C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0C421529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0C421529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbeITQUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:20:32 -0400
Received: from ozlabs.org ([203.11.71.1]:60109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbeITQUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:20:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42GCq83TtNz9sBq;
        Thu, 20 Sep 2018 20:37:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        robh@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 20
In-Reply-To: <20180920151243.5524c6ca@canb.auug.org.au>
References: <20180920151243.5524c6ca@canb.auug.org.au>
Date:   Thu, 20 Sep 2018 20:37:37 +1000
Message-ID: <87d0t8jvym.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Changes since 20180919:
>
> Dropped trees: xarray, ida (temporarily)
>
> The input-current tree lost its build failure.
>
> I still disabled building some samples in the vfs tree.
>
> Non-merge commits (relative to Linus' tree): 4279
>  4792 files changed, 166265 insertions(+), 93138 deletions(-)

Oodles of:

  # < make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-  allnoconfig
  # make -s -j 48 ARCH=arm64 O=/kisskb/build/linux-next_arm64-allnoconfig_arm64 CROSS_COMPILE=/opt/cross/kisskb/br-aarch64-glibc-2016.08-613-ge98b4dd/bin/aarch64-linux-  
  /bin/sh: 1: pkg-config: not found
  make[3]: pkg-config: Command not found
  /kisskb/src/scripts/dtc/yamltree.c:23:10: fatal error: yaml.h: No such file or directory
   #include <yaml.h>
            ^~~~~~~~
  compilation terminated.
  make[3]: *** [scripts/Makefile.host:107: scripts/dtc/yamltree.o] Error 1
  make[3]: *** Waiting for unfinished jobs....
  make[2]: *** [/kisskb/src/scripts/Makefile.build:536: scripts/dtc] Error 2
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [/kisskb/src/Makefile:1067: scripts] Error 2
  make: *** [Makefile:146: sub-make] Error 2

http://kisskb.ellerman.id.au/kisskb/head/a0cb0cabe4bbeacf5ed9e81a41abcbae47ba925a/


I guess we've got a yaml dependency now?

cheers
