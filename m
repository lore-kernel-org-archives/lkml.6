Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC743222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437597AbfBNIpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:45:25 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:4874 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbfBNIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:45:23 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 0F/30-04268-89A256C5; Thu, 14 Feb 2019 08:45:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRWlGSWpSXmKPExsUS3ulwWHeGVmq
  MwaVHqhanWvawW1y5eIjJYurDJ2wW3650MFlc3jWHzaJzVz+rxYbvaxkd2D02fG5i82i99JfN
  Y+esu+wem1Z1snnse7uMzWP9lqssHp83yQWwR7Fm5iXlVySwZvTsvsBW8Je9omfWIaYGxhNsX
  YxcHEIC2xglTv/qYIZw1jNKzL3xk6WLkRPIqZBY+vAomM0r4CZx58xrVhCbTcBCYvKJB2wgNo
  uAqsT3uSvYuxg5OIQFPCTm75IBCYsIdDFKnD/qDTKTWWA+o8S2hVdZIeYISpyc+QRsJrOAhMT
  BFy+YIXYZSJxe0AgWlxCwl5j+/iozyEwJAX2JxmOxEGFDie+zvkGVmEvs3LGcDVU5ppo/p34y
  Y6pBZltLXP8wi20Co9gsJNfNQnLdAkamVYwWSUWZ6RkluYmZObqGBga6hoZGuoaW5rqGxqZ6i
  VW6SXqppbrlqcUluoZ6ieXFesWVuck5KXp5qSWbGIHRmlJwtH0H44/l6YcYJTmYlER5jS+mxA
  jxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4NXVTI0REixKTU+tSMvMAaYNmLQEB4+SCK8gSJq3uCA
  xtzgzHSJ1ilFRSpz3MkhCACSRUZoH1wZLVZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfMm
  gkzhycwrgZv+CmgxE9DipyIpIItLEhFSUg2MRVn7eJ6f0jbbNe+lno/eIeZLdUm82wNXpmTni
  HzMeV1d2L6oL3pq/EXjG6nP/Nc6Gq2bxdi/buK5irS0KakPZM2LIl3PVjge653ktmvDyzfLaj
  dKuM9aoCAZI7OmoMLVdd1/oT2T3oQoLK4XZJ/0/om+6gPNS3q85lyOqpF7n7R2Ry7NWK2pxFK
  ckWioxVxUnAgAoMAD9lADAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1550133911!2392454!5
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12469 invoked from network); 14 Feb 2019 08:45:12 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-15.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 08:45:12 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.141) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 09:45:11 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 17:47:31 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 A1C223FB79; Wed, 13 Feb 2019 17:47:31 +0000 (GMT)
Message-ID: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 13 Feb 2019 17:47:31 +0000
Subject: [PATCH 0/2] ASoC: da7219: BCLK and TDM flexibility improvements
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 13/02/2019 16:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14/02/2019 04:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set updates the driver to be more flexible regarding the BCLK and
TDM configurations of the device.

Previously the BCLK rate was fixed at 64 periods per WCLK, when the codec is
DAI clock master, but to satisfy devices which prefer a lower rate, and to save
power, the BCLK rate is now calculated based on hw_params() data.

As a fallout of the BCLK efforts it was also apparent that the TDM code could be
made more flexible as well. The device is capable of automatically detecting
the BCLK rate when it is clock slave, so previous limitations imposed were
not necessary. The mask handling is now used as an input to determine the BCLK
offset to align closer with other examples within ALSA.

Adam Thomson (2):
  ASoC: da7219: Add support for master mode BCLK rate adjustment
  ASoC: da7219: Update TDM usage to be more flexible

 sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/da7219.h |   1 +
 2 files changed, 74 insertions(+), 43 deletions(-)

-- 
1.9.1

