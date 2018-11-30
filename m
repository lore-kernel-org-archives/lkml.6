Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2919C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B968C21479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln2Iew7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeLADPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbeLADPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:15:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B5920868;
        Fri, 30 Nov 2018 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543593967;
        bh=1Io3+zQzmuDNbIABfVtn+o1GgrAeTUjL8an8PwlMCiM=;
        h=Date:From:To:Cc:Subject:From;
        b=ln2Iew7tN4VNHNHnkIR7Fsq91ONMZtuk5jRKSoRdA6n/B32WLYEookLw+fYRjx9uj
         gAKX9AYX6RYJiNjWbCNOxYaZsgbVjfEmF0Nv77jEM1SsnQzRBY5nn4LTFy1/1kNwaC
         fKiPFnHV/D4htUdjdZRt7OMgTy4tyyM3cD4zHAZg=
Date:   Fri, 30 Nov 2018 17:06:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core fix for 4.20-rc5
Message-ID: <20181130160605.GA3000@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.20-rc5

for you to fetch changes up to a66d972465d15b1d89281258805eb8b47d66bd36:

  devres: Align data[] to ARCH_KMALLOC_MINALIGN (2018-11-11 11:40:04 -0800)

----------------------------------------------------------------
Driver core fix for 4.20-rc5

Here is a single driver core fix for 4.20-rc5

It resolves an issue with the data alignment in 'struct devres' for the
ARC platform.  The full details are in the commit changelog, but the
short summary is the change is a single line:
-       unsigned long long              data[]; /* guarantee ull alignment */
+       u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];

This has been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Brodkin (1):
      devres: Align data[] to ARCH_KMALLOC_MINALIGN

 drivers/base/devres.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
