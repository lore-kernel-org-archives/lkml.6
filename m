Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB070C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9420652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE9420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJEQ5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:57:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45304 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeJEQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:57:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so9900752oig.12;
        Fri, 05 Oct 2018 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2BhCLMsgb+FOgpDQDV9fQgmM+yaCg4hxSu2Pw9KY6+o=;
        b=B8/TIqwBA5jz3cgxOeOr7ul2GW9HBgiK3xSuHosV+CZrfknC1nb7wdJ9n4GGeqS1aF
         oXS4+kYLzq4pQxhrmJbNqHCEZl4ZHmvzGo0OwVNvCLu5GID7IWB5uk4J1CRH1EZc9ATW
         gzr+Qq2ti5h2jfQCFla1vcB4E7iJal7X20CipyQ97HWxBcnfm7Zsn2loWSE5A+KsNm1r
         qhN6+NdaFqef04mefQ3nXpEUlAp2JYoM0E28ztTJ30l54aiIKp7FabpvA8Hn3B1zZm1n
         f81jAgWYv0skqvMUIpuHbnFGZWUaA7tx25wn97n+ivfEZgrRyTmzKPs/A7YR0vblCO9A
         KUNw==
X-Gm-Message-State: ABuFfogeNmEB839crEnzPkWRkta46GOdwBgbwdQ5Br0782mZlKhe0LQl
        mrvUGqaF6S4fwvSwhD087yBJYrup4DBbQC/H++Q=
X-Google-Smtp-Source: ACcGV62I53Vqk1WnW4mULFOtxdDtUpnRIvTS3veqUBlGGblyais8+AegH40Naj8QGxpphtvpf7fI6WsFeD1FeD4gI6A=
X-Received: by 2002:aca:b5c6:: with SMTP id e189-v6mr1718159oif.51.1538733560945;
 Fri, 05 Oct 2018 02:59:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Oct 2018 11:59:09 +0200
Message-ID: <CAJZ5v0jforeFZjY6oTB3e7y_UHyzsixs7PxmW5=O6NQTemAomg@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.19-rc7
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc7

with top-most commit 69e445ab8b66a9f30519842ef18be555d3ee9b51

 PM / core: Clear the direct_complete flag on errors

on top of commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38

 Linux 4.19-rc6

to receive a power management fix for 4.19-rc7.

This fixes a bug that may cause runtime PM to misbehave for some
devices after a failing or aborted system suspend which is nasty
enough for an -rc7 time frame fix.

Thanks!


---------------

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

---------------

 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
