Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCAEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7DD24D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ska-ac-za.20150623.gappssmtp.com header.i=@ska-ac-za.20150623.gappssmtp.com header.b="UmN3pxy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7DD24D25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ska.ac.za
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753735AbeGCGn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:43:26 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38291 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeGCGnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:43:25 -0400
Received: by mail-ua0-f195.google.com with SMTP id 59-v6so534706uas.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ska-ac-za.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=g5nAIXTMO/Jd0ITM222qzzXwkBOtP+U4Jtn6YoMu5ew=;
        b=UmN3pxy++N/Guu4hyCGPRoxBsd9puxVtaDteW0Axvf0+OjHtqzOKThEnhVJ3MRWO9T
         2b5NqWVi3qLPvygKE73o8Y0kHnFKuHDRW7RwNOkeCtJLcmmqWGnTxcb+MIE7Zf5Homn3
         HHierxD+vmHwY5oz0L3g3pzuVqlHhhmMnPhMJG+qzmUX9GIXAersH99fROQwqdorxG8M
         oXAG66mVn76wCBDbi1iK14+HeUgSIaMQgU/5FAo9QI40qH7t8FCfRXSQH+VmrK845L8f
         fN8SwigjUo4ve7o0+Pufo/icTk4ESyNvFI/mujqM61WhOvr0HDp3iOudtiINiLSGTBNn
         8EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g5nAIXTMO/Jd0ITM222qzzXwkBOtP+U4Jtn6YoMu5ew=;
        b=ZvWTXPc61AT3yHKIetzuDPyGVyj2IM4/Eetb6PjihJiIRccL0VLkEFWKgM/5WdyAHO
         bu46EWm9fnqyeLw7RRO9bncoEM/5ZkWe2tMgT3vTop87cybZ5CeoS4E8jQIY6P02tQ9x
         v4rPYmCRytaY5PL1+ZfP6YslJNKoxHs8eIGlLXrVy2PfdS+IIWWVNTWtmX7zgbKesCYo
         k4y6ujT6cKEZxTQNiS+RyquJN1iARFPwA/hhac/iIC5k6yWQdjhT7z+IzzMbMaIX/viq
         35QxwjOQvCC/eZTfDnf4HvVcCr+A/qaBpim5INr3nPdPTzgmRURttDbkpQvf7ZOl9gtl
         Dnhw==
X-Gm-Message-State: APt69E3fYp6HVi/RdRSO9G8aX0wg77PUyCOVVLI9DvuNkUCvfz+CaNBF
        HPGwQCedhZJNV9LLvRndpgNNLorHoWLJ9y9Q6PTB8/js
X-Google-Smtp-Source: AAOMgpeJOc1wlPn3do8AZ0xesSlwTtXPV5H+IGtad84WtLa1ZcTR7JBupoLTU65KKHTQlnr9AUiL620yjQ+KcB13A0E=
X-Received: by 2002:a9f:3861:: with SMTP id q30-v6mr17408037uad.170.1530600203854;
 Mon, 02 Jul 2018 23:43:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:d96:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 23:43:23 -0700 (PDT)
From:   Bruce Merry <bmerry@ska.ac.za>
Date:   Tue, 3 Jul 2018 08:43:23 +0200
Message-ID: <CAOm-9arwY3VLUx5189JAR9J7B=Miad9nQjjet_VNdT3i+J+5FA@mail.gmail.com>
Subject: Showing /sys/fs/cgroup/memory/memory.stat very slow on some machines
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've run into an odd performance issue in the kernel, and not being a
kernel dev or knowing terribly much about cgroups, am looking for
advice on diagnosing the problem further (I discovered this while
trying to pin down high CPU load in cadvisor).

On some machines in our production system, cat
/sys/fs/cgroup/memory/memory.stat is extremely slow (500ms on one
machine), while on other nominally identical machines it is fast
(2ms).

One other thing I've noticed is that the affected machines generally
have much larger values for SUnreclaim in /proc/memstat (up to several
GB), and slabtop reports >1GB of dentry.

Before I tracked the original problem (high CPU usage in cadvisor)
down to this, I rebooted one of the machines and the original problem
went away, so it seems to be cleared by a reboot; I'm reluctant to
reboot more machines to confirm since I don't have a sure-fire way to
reproduce the problem again to debug it.

The machines are running Ubuntu 16.04 with kernel 4.13.0-41-generic.
They're running Docker, which creates a bunch of cgroups, but not an
excessive number: there are 106 memory.stat files in
/sys/fs/cgroup/memory.

Digging a bit further, cat
/sys/fs/cgroup/memory/system.slice/memory.stat also takes ~500ms, but
"find /sys/fs/cgroup/memory/system.slice -mindepth 2 -name memory.stat
| xargs cat" takes only 8ms.

Any thoughts, particularly on what I should compare between the good
and bad machines to narrow down the cause, or even better, how to
prevent it happening?

Thanks
Bruce
-- 
Bruce Merry
Senior Science Processing Developer
SKA South Africa
