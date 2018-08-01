Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C595620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C595620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeHAMdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbeHAMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofO-0006W8-QF; Wed, 01 Aug 2018 10:47:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] ALSA: remove redundant variables
Date:   Wed,  1 Aug 2018 11:47:33 +0100
Message-Id: <20180801104742.4328-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Clean up code by removing redundant variables that were
detected by clang

Colin Ian King (9):
  ALSA: asihpi: remove redundant variable max_streams
  ALSA: cs5535audio: remove redundant pointer 'dma'
  ALSA: emu10k1: remove redundant variable attn
  ALSA: ens137x: remove redundant array pcm_devs
  ALSA: sonicvibes: remove redundant pointer 'dir'
  ASoC: nau8540: remove redundant variable osrate
  ASoC: stm32: remove redundant pointers 'priv' and 'rtd'
  ALSA: usb-audio: remove redundant pointer 'urb'
  ALSA: intel_hdmi: remove redundant variable cfg_val

 sound/pci/asihpi/hpi6205.c          | 5 -----
 sound/pci/cs5535audio/cs5535audio.c | 7 +------
 sound/pci/emu10k1/emupcm.c          | 3 +--
 sound/pci/ens1370.c                 | 3 +--
 sound/pci/sonicvibes.c              | 2 --
 sound/soc/codecs/nau8540.c          | 3 ---
 sound/soc/stm/stm32_adfsdm.c        | 8 +-------
 sound/usb/endpoint.c                | 2 --
 sound/x86/intel_hdmi_audio.c        | 2 --
 9 files changed, 4 insertions(+), 31 deletions(-)

-- 
2.17.1

