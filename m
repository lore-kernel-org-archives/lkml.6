Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01455C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EC121B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549914896;
	bh=jLqyLyXK18ojtHyc76vRWvjOh2yn+6cTad3ij3KYZMY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fBR+MELlUgmzbGROZKFG3mBRdfBsiKeMl6d7rbYFs87StjmTXhSr13KIOaQ+7Dhtt
	 1to8Obslo2ZLuc+yTKwuDkglLAkvMGWfuE0GfrRfboEqdbJmPtVpNTQioJBGjs8bjW
	 hRWraWwPsFMaa9FaZl+aDZZAxznwB9tU86rQXcFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbfBKTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfBKTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:54:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 861E1218AD;
        Mon, 11 Feb 2019 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549914894;
        bh=jLqyLyXK18ojtHyc76vRWvjOh2yn+6cTad3ij3KYZMY=;
        h=From:To:Cc:Subject:Date:From;
        b=IS1pn/IqZo2IWwoajlx3m/h7IeRPNm3EKn7ZbqnYIh5VipE6UcFaD5QMlSjL9DjjY
         AML27hHIDBkprlRnKFkNLzqmBrg1NCrQ+bl9YR6FE7ga6EZ1w/NdXZUR/MpdtfX70R
         2UBkZv/oLsyuu+4nPkfwxJout2D4wmtMXHoobIg8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: samsung: mach/soc for v5.1
Date:   Mon, 11 Feb 2019 20:54:48 +0100
Message-Id: <20190211195448.19983-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.1

for you to fetch changes up to 4bdf2f3f20a9de9b07f97907820c42f3a49ba63d:

  ARM: exynos: Fix timeout when booting secondary CPUs (2019-02-01 20:07:47 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v5.1

Two fixes: one for handling timeout while booting secondary CPU of
Exynos and second for S3C24xx DVS notifier.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Stuart Menefy (1):
      ARM: exynos: Fix timeout when booting secondary CPUs

 arch/arm/mach-exynos/platsmp.c          | 4 ++--
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)
