Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B850C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4A0214D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4A0214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbeHBNwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:52:07 -0400
Received: from foss.arm.com ([217.140.101.70]:56702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbeHBNwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:52:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76D987A9;
        Thu,  2 Aug 2018 05:01:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 480DE3F5D0;
        Thu,  2 Aug 2018 05:01:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C2F161AE30FD; Thu,  2 Aug 2018 13:01:17 +0100 (BST)
Date:   Thu, 2 Aug 2018 13:01:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, herbert@gondor.apana.org.au,
        ard.biesheuvel@linaro.org
Subject: [GIT PULL] arm64 regression fix for 4.18
Message-ID: <20180802120117.GB14419@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Ard found a nasty arm64 regression in 4.18 where the AES ghash/gcm code
doesn't notify the kernel about its use of the vector registers, therefore
potentially corrupting live user state. The fix is straightforward and
Herbert agreed for it to go via arm64.

Please pull.

Thanks,

Will

--->8

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to c7513c2a2714204d3588ecaa170ae628fd0d217e:

  crypto/arm64: aes-ce-gcm - add missing kernel_neon_begin/end pair (2018-07-31 13:20:30 +0100)

----------------------------------------------------------------
arm64 regression fix

- Fix potential clobbering of user vector register state by AES ghash code

----------------------------------------------------------------
Ard Biesheuvel (1):
      crypto/arm64: aes-ce-gcm - add missing kernel_neon_begin/end pair

 arch/arm64/crypto/ghash-ce-glue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
