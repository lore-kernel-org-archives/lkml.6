Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70952086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550828574;
	bh=5HO6AnDdzbZ0mEhV7ftcq7wigBLFB323yBxcbj3ahaw=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=ypfo+82gaPvtR3RUckHwCzLJo2Nb6/7GPshWIS/RGj8SUVSPKXgu1Oh9TB0GNLMU2
	 cM6BYQc8e/8BdO7IDh2z3yUd5HgMbPuYzD6fbidhDprsNZx3+++GzA1tMeBwPYieHX
	 Y+XYb1TDcN8gZ01BHR5+Q//K1voqy1eftMqj+wlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfBVJmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:42:53 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39644 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfBVJmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:42:52 -0500
Received: by mail-oi1-f171.google.com with SMTP id b4so1248404oif.6;
        Fri, 22 Feb 2019 01:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uj1AcNj6VoNcVrMyN7B0mvDFhBNfeiCi/5B3nTuKf48=;
        b=kXT6uLiTRX6yRVD8+V3J/A0QktE/uR8wp+YqMAkKGnZVrKQ53+QHvutVizIAPwVUcq
         +8oz4LWi/hZxD0ik5ooTPdQR2eL3X5UBk8eiOjlYoWDagRtrWS446evmRbyR8xUbjA7U
         GrG7Ko5uVFlUMv69V67aNZgc6ylZHXxFBftuk1pDohNmtTjJUHhqP1LAcBQgFRa+Rsld
         qAeNo8GP+FX+nLqBnCumsWi7bXNp+C6LvaH634CUhcONozChh0VR/unEXoAhs2xCXoVt
         pWTJ/1zJlkmV/xBYDwYpoVBNoyQaSDvcC7Xdme0of5K840jxaQD4pJWzOd8at43gBjIf
         Om3w==
X-Gm-Message-State: AHQUAuYlgOLoCUHbVYAKYUe01AIVTaH3moHDnRxDAHoBF/IyXWdVndBZ
        13x19Rx+8AVY+2XrQ4wH4cgArTnn7NmBO6G29qhlvhbr
X-Google-Smtp-Source: AHgI3IaQyiVHN/1JWF/J76CTvp/BqiZQpOlOjuDfONwBhU6caKbRm0yF7c1FvammdaP+C2CzUSezFV3802aZI6d7GUQ=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr2042409oih.76.1550828571256;
 Fri, 22 Feb 2019 01:42:51 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Feb 2019 10:42:40 +0100
Message-ID: <CAJZ5v0i-UVM7BwRgC2cDf93RguVaYxXViLQOACHGPETEM9a7jg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for final v5.0
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
 pm-5.0

with top-most commit 5b317cbf2bcb85a1e96ce87717cb991ecab1dd4d

 Merge branch 'pm-cpufreq-fixes'

on top of commit a3b22b9f11d9fbc48b0291ea92259a5a810e9438

 Linux 5.0-rc7

to receive power management fixes for final 5.0.

These fix a regression in the PM-runtime framework introduced
by the recent switch-over of it to using hrtimers and a
use-after-free introduced by one of the recent changes in the
scmi-cpufreq driver.

Specifics:

 - Use hrtimer_try_to_cancel() instead of hrtimer_cancel() in the
   PM-runtime framework to avoid a possible timer-related deadlock
   introduced recently (Vincent Guittot).

 - Reorder the scmi-cpufreq driver code to avoid accessing memory
   that has just been freed (Yangtao Li).

Thanks!


---------------

Vincent Guittot (1):
      PM-runtime: Fix deadlock when canceling hrtimer

Yangtao Li (1):
      cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

---------------

 drivers/base/power/runtime.c   | 2 +-
 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
