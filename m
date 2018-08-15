Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0851208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0851208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHOVdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:33:11 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:56937 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbeHOVdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:33:11 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 912DB90082;
        Wed, 15 Aug 2018 21:39:51 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 7E28A220991; Wed, 15 Aug 2018 21:39:49 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 819A92207C6;
        Wed, 15 Aug 2018 21:39:49 +0300 (EEST)
Date:   Wed, 15 Aug 2018 21:39:49 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     sparclinux@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: apparmor unaligned accesses on sparc64 in 4.18+git
Message-ID: <alpine.LRH.2.21.1808152136370.4724@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 4.18.0-02978-g1eb46908b35d on a sparc64 box with Debian Ports 
sparc64 unstable (apparmor packages recommended by linux-image package) 
and got the following on bootup:

[   46.315721] Kernel unaligned access at TPC[6b8b98] aa_dfa_unpack+0x38/0x620
[   46.412375] Kernel unaligned access at TPC[6b8ba8] aa_dfa_unpack+0x48/0x620
[   46.412392] Kernel unaligned access at TPC[6b8c28] aa_dfa_unpack+0xc8/0x620
[   46.698283] Kernel unaligned access at TPC[6b8ce8] aa_dfa_unpack+0x188/0x620
[   46.789536] Kernel unaligned access at TPC[6b8cfc] aa_dfa_unpack+0x19c/0x620

-- 
Meelis Roos (mroos@linux.ee)
