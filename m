Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F2ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E592A2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E592A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJRTUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:20:10 -0400
Received: from mout.perfora.net ([74.208.4.194]:59275 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJRTUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:20:09 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1HiQ-1fKAK81X9U-00tB6f; Thu, 18 Oct 2018 13:18:40 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1HiQ-1fKAK81X9U-00tB6f; Thu, 18 Oct 2018 13:18:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1 0/3] ASoC: last minute fixes
Date:   Thu, 18 Oct 2018 13:18:26 +0200
Message-Id: <20181018111829.27056-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:xVwpeqsK0g8iJArFTdAX0IOzbKjXk6XG/IKGs2ULCr3E+Wg19QK
 tu0v9Z6NZvefu3Kb18YyszFiqWrm+ASIwETRKr+zHxQ8dWzBEfB9LqRAOjhC+yWZ6qSu4Ok
 5yd6JGmktN6LtaGcx2SFda3sLAXzxMT2jEF7yvPs9OrH0wxP2LvirWp3RR5HiLKRaMIMCNK
 t4ImFkoxebGfQPpOCqhHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4Jj8C0YezyM=:EFPPRdHxipRqqydNEiPKYA
 DiQVjqJKS+ahguiFzJpbt9lz3einw1itPMONun/lzqQF9z3Wn/tjEoiRy+4P6amrT5X5ScX4X
 FnWx7lswjF+4jtA4iV5zLjoIHyZHfScpOnZedh5dOBryrliXvC9F6YF6zXoAJKpwU84n3pZaM
 j1hcTMK6PyS+IqL8mAfF1ZjxoE7LMAJryH+7iZKrhtZMUuw2uI88iAzY1Ea0W1f7ON55yGiGe
 SopItOvKL1rdrK/ynUSUgRwRtX/WDArsCK/oczv1a5hMrQhe2DFez1jFiBzEqerN78eP+r6Ro
 1f250Z2qqtH8TZ2lVSLlgOGCkxpwAyOFQxAEtIkQ4DFtu2mD8hLJuFz5WPjNtWiiPEktK1iN0
 gjVAtkqThrPUeDboUev/zfH7FEoDhM6BAGNirLYbVUKc1PbMQCmJvwkaJQR5K4trtrjQXWVLw
 e2naqlFTUXXdiFa3TCS0xc9sTPRfeAgitxkx+Nb1RlAqSxwuf6ltnzOYpUV+KnFf0FUON3obr
 GT0zPQKDH99KXqaTwoIikcP3jhK6JWJ9l0gFctr9MjaP+sRUqWXulgPp4NJPRqtF1PBJ87HYF
 tN2bniViOSSwXM9rcMRC54QaxNuuj1ClzpEgBCZXkDHZvvDyudvNAGP2aqEROVcdfkNzYPuVp
 OKs2LdenaT6qS+k3QvAEs6A8Ic0bZDatHDsEUrhDH+cFH1ieBcIdcs66L5jsW0hYEaYU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series comes with some last minutes fixes and clean-up.

Changes in v1:
- Split from the Tegra series as suggested by Mark.
- Fix issue in soc-core rather than working around it in tegra_sgtl5000.

Marcel Ziswiler (3):
  ASoC: tegra_sgtl5000: fix device_node refcounting
  ASoC: soc-core: fix trivial checkpatch issues
  ASoC: soc-core: fix platform name vs. of_node assignement

 sound/soc/soc-core.c             | 162 ++++++++++++++++++++++++---------------
 sound/soc/tegra/tegra_sgtl5000.c |  17 +++-
 2 files changed, 116 insertions(+), 63 deletions(-)

-- 
2.14.4

