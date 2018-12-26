Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2630C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D92171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545850879;
	bh=ShHdJ013zxf+d5ecxKQ5vQR2sdjLAToz+CPOCNpiOeE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=knyNy6cDxGOyAS0Ixu3eP74QuLQlI7mjatL9SKqcOlENRuTRIhK10g2I6lBsSkrQ/
	 f4czcjN29wzOdTT+Abe2S35nNYHDA87hGX01UyS2a5mX+NGE6FKZGLH36KJ4isiRKc
	 4Lzylw1u+87OJjo1rKzz1hzWh8/dHXOCBRsABchw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeLZTBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbeLZTBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:01:18 -0500
Received: from linux-8ccs (unknown [47.154.107.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663E82171F;
        Wed, 26 Dec 2018 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545850877;
        bh=ShHdJ013zxf+d5ecxKQ5vQR2sdjLAToz+CPOCNpiOeE=;
        h=Date:From:To:Cc:Subject:From;
        b=MZg182sSQ9m7V7Yz54g89zRHb5srBsSBNzzCpFMMNE9MX/MfKcNFCCiQmeH9Xsn27
         ec5fYStvX1I1d/Nm0tNeGreqMX6jMHrHqT61OSK5/+1y/7myx1r49NAAphPhIRYpFC
         WXo2/utXO84aWdUNbDaP9NCt0GjNuDQMcG4XUSVo=
Date:   Wed, 26 Dec 2018 20:01:15 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules updates for v4.21
Message-ID: <20181226190114.GA16407@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull below to receive modules updates for the 4.21 merge window.
Details can be found in the signed tag.

Thanks,

Jessica

---

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v4.21

for you to fetch changes up to 93d77e7f1410c366050d6035dcba1a5167c7cf0b:

  ARM: module: Fix function kallsyms on Thumb-2 (2018-12-14 20:27:29 +0100)

----------------------------------------------------------------
Modules updates for v4.21

Summary of modules changes for the 4.21 merge window:

- Some modules-related kallsyms cleanups and a kallsyms fix for ARM.

- Include keys from the secondary keyring in module signature
  verification.

Signed-off-by: Jessica Yu <jeyu@kernel.org>

----------------------------------------------------------------
Jessica Yu (1):
      module: make it clearer when we're handling kallsyms symbols vs exported symbols

Ke Wu (1):
      modsign: use all trusted keys to verify module signature

Vincent Whitchurch (2):
      module: Overwrite st_size instead of st_info
      ARM: module: Fix function kallsyms on Thumb-2

 arch/arm/include/asm/module.h |  11 ++++
 include/linux/module.h        |   7 +++
 kernel/module.c               | 123 ++++++++++++++++++++++++------------------
 kernel/module_signing.c       |   3 +-
 4 files changed, 92 insertions(+), 52 deletions(-)

