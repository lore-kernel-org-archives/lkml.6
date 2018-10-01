Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B094C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210BB206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210BB206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJBAYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:24:31 -0400
Received: from foss.arm.com ([217.140.101.70]:53314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeJBAYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:24:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7B8C7A9;
        Mon,  1 Oct 2018 10:45:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A882C3F5B7;
        Mon,  1 Oct 2018 10:45:37 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 640A61AE3E30; Mon,  1 Oct 2018 18:46:01 +0100 (BST)
Date:   Mon, 1 Oct 2018 18:46:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com
Subject: [GIT PULL] Late arm64 fixes for 4.19
Message-ID: <20181001174600.GB14755@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull these late arm64 fixes for 4.19. Details in the tag, but we've
fixed a hugetlb livelock issue that was reported by Fujitsu as well as
removing some useless flexibility in our KVM SET_ONE_REG ioctl().

Cheers,

Will

--->8

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2a3f93459d689d990b3ecfbe782fec89b97d3279:

  arm64: KVM: Sanitize PSTATE.M when being set from userspace (2018-10-01 14:38:26 +0100)

----------------------------------------------------------------
Late arm64 fixes

- Fix handling of young contiguous ptes for hugetlb mappings

- Fix livelock when taking access faults on contiguous hugetlb mappings

- Tighten up register accesses via KVM SET_ONE_REG ioctl()s

----------------------------------------------------------------
Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Marc Zyngier (1):
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Steve Capper (2):
      arm64: hugetlb: Fix handling of young ptes
      arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags

 arch/arm64/kvm/guest.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/mm/hugetlbpage.c | 50 +++++++++++++++++++++++++++++++++++------
 2 files changed, 97 insertions(+), 8 deletions(-)
