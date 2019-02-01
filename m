Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D5218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549017610;
	bh=qByhUeDooaxKJsiXSjntmq0f95C64O6z0fVaFT3BMxo=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=NKcLGTYX8egZ0VTP6Vwhu91raYJW1minXP3MfNJl0VOt1YyXh/aB5eh852NJBI60R
	 XjY0leo0w8BYDjMFG1gv5h/AclhMhtV79po0D8nwMevUUDKaz67EqlDJ/rFdGmDE1U
	 k6tiSpl5KeIOrxx59eYvqbHGXuV0qOAt2lri5HI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfBAKkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:40:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41551 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfBAKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:40:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so5389983oii.8;
        Fri, 01 Feb 2019 02:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xiwbF4pa336P16PUaPVCquJps7qsVTE1ohYHZiWVeSs=;
        b=qxtxeYil5hv0kmOlvGfAxHQTFCbMMsAmGWoJrPhA5UOgHwpbdkAdstXYEWKHhQY8f1
         1SYdTzs6t+F0F/QKujxrVqBYPtx1IV3Mi8rsDr23m7dP3ZE3TWL0GYXEqzkmBMsIyVEi
         U06Io9wZ2A3HJ6ig3EqEjeXNqhltN4SydDi5XW15S2lkVcfAezT/stVdOIxmWQf0Ync0
         6WVlap+VN3rUdTn1jWc0kAEPJG4MK5ANekQU9cdB+wsbesUAPxlAbkVhP/BLArGb9Bai
         KJfJKIRjkOOTPSAYB2K62vVMSGV9CMtef90eUC2RWDaFIaXZjXF8FApje0e8sVeKMYzp
         SIJQ==
X-Gm-Message-State: AHQUAuZMu1EpuuqpI3Ftrx46fDXFIcFeX+CFfhWKbah+qdKFhMJBMF9l
        QaLCcoiNnAgj01xB1MmFxkoWUzfUFbcqgHUMOnKEzoSZ
X-Google-Smtp-Source: ALg8bN7nnFeNylBf6lDT8gIM4N7v7uqiiGmFLBUU9spvtQIcEq3jLrD9DpS5NX9WfLo2J6MVWdyz10EbEOaT++ETEUc=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr18469931oia.95.1549017607503;
 Fri, 01 Feb 2019 02:40:07 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Feb 2019 11:39:56 +0100
Message-ID: <CAJZ5v0gSNtDedxn=zfxCN93srU3BidOH2Uuon8WK9CvM_01oqg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.0-rc5

with top-most commit cbffab6825731f1baac7a950f6b7dd9239f55594

 Merge branch 'pm-cpuidle-fixes'

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive power management fixes for 5.0-rc5.

These fix a PM-runtime framework regression introduced by the
recent switch-over of device autosuspend to hrtimers and a
mistake in the "poll idle state" code introduced by a recent
change in it.

Specifics:

 - Since ktime_get() turns out to be problematic for device
   autosuspend in the PM-runtime framework, make it use
   ktime_get_mono_fast_ns() instead (Vincent Guittot).

 - Fix an initial value of a local variable in the "poll idle state"
   code that makes it behave not exactly as expected when all idle
   states except for the "polling" one are disabled (Doug Smythies).

Thanks!


---------------

Doug Smythies (1):
      cpuidle: poll_state: Fix default time limit

Vincent Guittot (1):
      PM-runtime: Fix deadlock with ktime_get()

---------------

 drivers/base/power/runtime.c | 10 +++++-----
 drivers/cpuidle/poll_state.c |  2 +-
 include/linux/pm_runtime.h   |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
