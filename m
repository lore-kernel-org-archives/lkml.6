Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeB0UdX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:33:23 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44323 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB0UdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:33:21 -0500
X-Google-Smtp-Source: AH8x225RaV1xPUmlyqaFEI/Zx8bE1yPVcSpJciHQhK6ApLmWze3ohjrGTu+3NehIfsltECVBmgnGGA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/1] Re: Applied "ASoC: topology: Fix logical inversion in set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 21:33:16 +0100
Message-Id: <20180227203317.17274-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180227155758.GD11822@sirena.org.uk>
References: <20180227155758.GD11822@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark, Pierre-Louis, Pan, Liam,

As there are too much open questions regarding the bclk and fsync inversion in
set_link_hw_format(), I would like to suggest the alternative solution.

This solution will fit both use-cases:

* existing use-cases (Broadwell, etc.)
* new use-cases (Sound Open Firmware, etc.)

The solution includes 1 patch for linux + 1 patch for alsa-lib.
I will send them to this mailing thread.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org

Kirill Marinushkin (1):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()

 include/uapi/sound/asoc.h | 16 ++++++++++++++--
 sound/soc/soc-topology.c  | 12 +++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.13.6
