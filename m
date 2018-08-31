Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F1AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF47F20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF47F20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeHaUUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:20:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32906 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbeHaUUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C7E9ED1;
        Fri, 31 Aug 2018 09:12:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D2D33F557;
        Fri, 31 Aug 2018 09:12:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CC3FA1AE30C7; Fri, 31 Aug 2018 17:12:13 +0100 (BST)
Date:   Fri, 31 Aug 2018 17:12:13 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20180831161213.GH30626@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A few arm64 fixes came in this week, specifically fixing some nasty
truncation of return values from firmware calls and resolving a VM_BUG_ON
due to accessing uninitialised struct pages corresponding to NOMAP pages.
Details in the tag.

Please pull, thanks.

Will

--->8

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to f52bb98f5aded4c43e52f5ce19fb83f7261e9e73:

  arm64: mm: always enable CONFIG_HOLES_IN_ZONE (2018-08-31 11:06:45 +0100)

----------------------------------------------------------------
A handful of arm64 fixes

- Fix typos in SVE documentation
- Fix type-checking and implicit truncation for SMCCC calls
- Force CONFIG_HOLES_IN_ZONE=y so that SLAB doesn't fall over NOMAP regions

----------------------------------------------------------------
James Morse (1):
      arm64: mm: always enable CONFIG_HOLES_IN_ZONE

Julien Grall (1):
      Documentation/arm64/sve: Couple of improvements and typos

Marc Zyngier (2):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters

 Documentation/arm64/sve.txt |  4 ++--
 arch/arm64/Kconfig          |  1 -
 include/linux/arm-smccc.h   | 38 ++++++++++++++++++++++++--------------
 3 files changed, 26 insertions(+), 17 deletions(-)
