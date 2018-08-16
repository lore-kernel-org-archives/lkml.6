Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73867C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E8C213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E8C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeHPX1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:27:43 -0400
Received: from mail.monom.org ([188.138.9.77]:40692 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPX1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:27:43 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 69869500B0B;
        Thu, 16 Aug 2018 22:27:09 +0200 (CEST)
Received: from localhost (ppp-93-104-176-111.dynamic.mnet-online.de [93.104.176.111])
        by mail.monom.org (Postfix) with ESMTPSA id B938250051C;
        Thu, 16 Aug 2018 22:27:08 +0200 (CEST)
Date:   Thu, 16 Aug 2018 22:27:07 +0200
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.148-rt165
Data:   Thu, 16 Aug 2018 20:13:56 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20180816202709.69869500B0B@mail.monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.148-rt165 stable release.

This release is just an update to the new stable 4.4.148 version
and no RT specific changes have been made.

Known issues:

- 'stress-ng --ptrace 4' is able to trigger a latency spike of
   several ms. Usually around 2 - 3ms on two different x86_64 boxes I can
   test on. 4.9-rt seems to have the same problem. 4.14-rt and 4.16-rt
   work just fine. Still debugging the issue.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 581e591d5bda2fb9fd1d2802d98587f2555d20e4

Or to build 4.4.148-rt165 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.148.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.148-rt165.patch.xz


You can also build from 4.4.145-rt162 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.145-rt162-rt165.patch.xz

Enjoy!
   Daniel
