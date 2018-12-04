Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C980C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B64B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLDPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:00:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:57371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDPAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:00:44 -0500
Received: from ls3530.dellerweb.de ([92.116.169.31]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxPgU-1hZnPV2sby-0170gw; Tue, 04
 Dec 2018 16:00:35 +0100
Date:   Tue, 4 Dec 2018 16:00:32 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fix for kernel v4.20-rc6
Message-ID: <20181204150032.GA29884@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:DVO82d2ax1Pf2p4kFgKyoegoxQcOb1VH2dJ2MbUnOYiCZtNlvY+
 Q84R/mhJwqe38Nm0qssBQQ62rwo67rQN9g8t505d99KeAxyrhEG8f/GzIa4WcQ3nOJy2Rla
 5+n8nKrCoEaVaWArE1m7NhIezFt7WFYzIpmf1cYcRBOAjJXaf+DviI3iYWB41j/wB2SIvNC
 pFnTi3I32sFAmYHvu+uNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rOPWwVB2cLU=:wmJkth7zc7f9whzb1zV1BT
 N3EL0JNrgceB7uaJeL9gMv5haYw0nwdkitaTsxJtx9JYYr6sNJpLZIFtW1XQ8jPJk+dDXUKJX
 bmWi9bU3GhT89cKnaU/9OXQqpAfFCha26IJ8wHBGYCSkBJvvIzbhOi5Njd2MoywCS1XRzWKwG
 JAeLit5fYzvMzMhpz8pqwLUJUucpAd98kFBKbpNJs6sj/jjvMURYkHZcP4xDRykuEt+nJi678
 ZQZ2nojYDZsj4QcGnX2nmRoGorIo2UaNtinql9oFpTCot2KJDHphV1l0kIDdUlIBUsAGjQ0CJ
 ZkN/vrNcUx5/hodKH0QOxPQS6tL0FdMAT1BsbW5KMe5gQQ2ZrvFwoEJw89o6UoIJyEmHJ4P5u
 pbNt4chQiU59XMAQxrXd8FJvnmTBv/fCkgBHC4lW0jbTm07P0HXdy46SvXZ3YQ+Jtw8ZdNtnQ
 EV7Npm9lLh0lYsusp0bdbqkqIt8PVHbdfpxw8rqm9LKsKaJgscbQ5ASUTdZyh0sEdaCoS8EZl
 iTXIkAXgq91O9V0gc/R4+ZWg/TAU+vfrsm1zwAplnJ7lvSEQg/3xYdtc3dKuoSjRsCkWxE+Tq
 pGnFO54c+C86Uf5jr+aSqi4dF3SonjFTHtRUihBDrAIqB7Ia7Vt8bcGoyQztxXDbnUnuG3hGT
 rF+MaGhC6347bVmx1w+HjsOUh2xjOeCztMuaKY5lr5g7pR9xSXqkHvkfzudNtAfuPn7rdZRAU
 Ui+p5hAuFx9r2u2J1cgrc11YJzJoLj+LkWR1QBfqjz+EMNrCXyfMMxiFLNTU0BQJj8o57mSFO
 DctNMPDrnWTKP/MmXFqe6ALeGBNk3EcbFHdv+i04yHzNgNEcuB4M/tJ1Ac7IOhyP8fsARrbYP
 BnTQmqIEq9uR7PcT0EBO/Qz7Law7goUq6DldobU0c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one patch for the parisc architecture for 4.20-rc6 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.20-4

On parisc, use -ffunction-sections compiler option when building 32-bit kernel
modules to avoid sysfs-warnings when loading such modules. This got broken with
kernel v4.18.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Enable -ffunction-sections for modules on 32-bit kernel

 arch/parisc/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)
