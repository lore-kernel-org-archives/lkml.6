Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 01:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17821534
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 01:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E17821534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tlinx.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbeHSETe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 00:19:34 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:38498 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHSETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 00:19:34 -0400
X-Greylist: delayed 1271 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2018 00:19:34 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id w7J0mk11069990
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 17:48:48 -0700
Message-ID: <5B78BE6E.3080107@tlinx.org>
Date:   Sat, 18 Aug 2018 17:48:46 -0700
From:   Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: problem in building 4.8.0: references to non-existent util CLANG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is CLANG required for building now?

when I did a "make xconfig" (or any make, for that matter), I get:

>  make xconfig
scripts/kconfig/qconf  Kconfig
invocation line: ./scripts/clang-version.sh gcc     ## debug line I added
./scripts/clang-version.sh: line 15: ./COPYING: Permission denied
./scripts/clang-version.sh: line 23: printf: __clang_major__: invalid number
./scripts/clang-version.sh: line 23: printf: __clang_minor__: invalid number
./scripts/clang-version.sh: line 23: printf: __clang_patchlevel__: 
invalid number
init/Kconfig:24:warning: 'CLANG_VERSION': number is invalid
.config:50:warning: symbol value '00000' invalid for CLANG_VERSION

The reference to COPYING comes from me running make in the
top dir, where there is a text file named COPYING, however it is
not executable.

I put in an echo to see what command line the script was being passed,
"gcc"?

I'm guessing but I don't think the clang script should be getting
called at all.  I installed the sources by patching 4.17.0 (done via a
script).

Are there instructions somewhere for what command(s) to run for patching?
It seems to have changed from using the standard patch program to using
a git version that isn't compatible w/the gnu version.  I adapted the
script to the git version and that's seemed to work since I did
the change.  But with 4.18.0, I am uncertain if it is working correctly.

If the above was the only problem, I'd be less concerned, but
scripts run after the main build to build external modules failed.
It seems unlikely the two problems are related, but I wanted to fix
this first before going on to the compile-fails.

Please Cc me, as I'm not currently on the list.

Thanks,
Linda W.

