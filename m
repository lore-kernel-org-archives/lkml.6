Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806DC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962BC20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W7QnsZTi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ou3VPljm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962BC20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeINE5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:57:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeINE5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:57:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 411E460541; Thu, 13 Sep 2018 23:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536882363;
        bh=BhPfPuGFeGC1Db/tUUz4YSA2Mivq7EX9ugphwtvIB94=;
        h=Date:From:To:Subject:From;
        b=W7QnsZTi1nI+i8/X7gnTCBgCjtIjYRQ+yCrmtLJDJgtrmb3Xf5wQc25eqZIp08W7J
         WMRZ/PsbMB3A+bLzTpZ7yKdxi4JsamMYjSHKYNG/VJVcKiaZrPi8D/T/R/RuMq1yls
         16CZl63gkKMHd+5opw3/v+qri7GsDlBCSs2WddfQ=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DBD560558;
        Thu, 13 Sep 2018 23:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536882362;
        bh=BhPfPuGFeGC1Db/tUUz4YSA2Mivq7EX9ugphwtvIB94=;
        h=Date:From:To:Subject:From;
        b=Ou3VPljmb/Bh80L7tbDoLmeZvOFhTxJ/oIkro0fAbTZ9wp7Tvxl6Ajy3vkBm++dzi
         Ek6sCRZ+MjwLO7O0wfg9caI5m1T9+a84+zWN94wThf6OAxL0IRHTpa7ffohCZGKgX6
         vUeO5GNjfgh3AJxUxAUDndVdWerahwIgXeW2aKVY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DBD560558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Thu, 13 Sep 2018 18:46:01 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org
Subject: [GIT PULL] Hexagon cleanups
Message-ID: <20180913234600.GA2406@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following changes for Hexagon; they contain some fixes for compile
warnings.


Thanks,
Richard Kuo



The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 5c41aaad409c097cf1ef74f2c649fed994744ef5:

  hexagon: modify ffs() and fls() to return int (2018-09-10 19:42:15 -0500)

----------------------------------------------------------------
Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

 arch/hexagon/include/asm/bitops.h | 4 ++--
 arch/hexagon/kernel/dma.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
