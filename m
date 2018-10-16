Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4843C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CA62098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CA62098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJPSis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:38:48 -0400
Received: from mout.perfora.net ([74.208.4.197]:60191 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeJPSir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:38:47 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzIe7-1fYL5j3C3V-014Pxx; Tue, 16 Oct 2018 12:48:07 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzIe7-1fYL5j3C3V-014Pxx; Tue, 16 Oct 2018 12:48:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 9/9] ASoC: tegra_sgtl5000: fix platform name vs. of_node assignement
Date:   Tue, 16 Oct 2018 12:47:30 +0200
Message-Id: <20181016104730.4598-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MIunh8M8gL/uGufQy84VMDRM78SzrUFY0quxDQdowA0Wsci8h+a
 38ubtDDQBcvaJz9+ceurnZK6HKW9+1Xlv19w6emZe1YA5SU3lW01AKbyETAnabzStDOX0Dh
 a5tV+xrPwQi7Uk/kNDzJDJq2PJro4mjdXM8GmdR6RZ4tpjKYSE0+/N+zQ6vE8tnxfA3ia4C
 Zt9JlDlWQiofVpm5pmW1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C3uMcV8zHwI=:3lyw1gJjsmSoDHl2tc44Ea
 nKE3+a8aWKIOFCOYqfNa3a950WF/j9nEi2NE0gjtd0tZuWwaYJ9drKZ1w/4pJ0yiD1U0WBMEW
 83ZKjeD1UpNeAPRagy6rfwzdndoy+9HoyNuTH5tu9GZidP68uxEl4boql4DTN8c8wK+kwDOME
 GHpMT/ipAn5fq19FwDYHNypxdTIijYRdQ/UwnwQcHhG8cJOjlHwq8dbaYutGtJu6Yqm726Pcz
 U0gX/6qFIDWwc1FqYFkESge6oZpf/mUgWpXqgP0/0U9mrMpLdspSQ3hEG7uBmhucpC5SQXtft
 Mi/ADhNi8OqVu88Vui1/ru2ik4Z8nmolA+SQQA+e9bEZB+WT/ehE+VCm50Ov52YryvjeG7f0K
 9fKFb0DP1KQhZlJp2BV4SQCFMKxoCAnHbx9BOhqRV+t/YECYYVIlTNcGnGG369NetdOs2VpKi
 Vr0oTxYeRodJ42dEo4m0i7abQVzuzn2Wf11L2a/vwSRV5oUoGLFGXByO1A2gNZydTPF26NH3P
 E/y6541JZrz0+vaOdApWUWhLOxnP9fmS2+Ub4Gdr7x9kyh+IWiWqBE3RQcG9VTMwlM5ZPFQGX
 2KQTdTkfN+Z+X74vi/FvvlYzqQZ9Ca118B5Kb69sPMv8h/eMXyACgld8l6COUzY/fYECChcd5
 9hnVG9Kfh1707a9JsCH1UwHq7i8zEhpC1JRPlLmHd803Q/YQMYwqQF37KoIAqPmS74mU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error as seen post commit daecf46ee0e5
("ASoC: soc-core: use snd_soc_dai_link_component for platform"):

tegra-snd-sgtl5000 sound: ASoC: Both platform name/of_node are set for
 sgtl5000
tegra-snd-sgtl5000 sound: ASoC: failed to init link sgtl5000
tegra-snd-sgtl5000 sound: snd_soc_register_card failed (-22)
tegra-snd-sgtl5000: probe of sound failed with error -22

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: New patch

 sound/soc/tegra/tegra_sgtl5000.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
index 901457da25ec..eb702925cac3 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -168,6 +168,11 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 	return 0;
 
 err_fini_utils:
+	if (tegra_sgtl5000_dai.platform) {
+		devm_kfree(&pdev->dev, tegra_sgtl5000_dai.platform);
+		tegra_sgtl5000_dai.platform = NULL;
+	}
+
 	tegra_asoc_utils_fini(&machine->util_data);
 err_put_cpu_of_node:
 	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
-- 
2.14.4

