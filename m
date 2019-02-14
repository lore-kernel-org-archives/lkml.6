Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B1E222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438106AbfBNKNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:13:43 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:61655 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727061AbfBNKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:13:35 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id BD/58-12934-B4F356C5; Thu, 14 Feb 2019 10:13:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42IJ73Q4rOttnxp
  jsPk3q8Wplj3sFlcuHmKymPrwCZvFtysdTBaXd81hs+jc1c9qseH7WkYHdo8Nn5vYPFov/WXz
  2DnrLrvHplWdbB773i5j81i/5SqLx+dNcgHsUayZeUn5FQmsGd92r2YraOaseDLjLGMD4wb2L
  kYuDiGBbYwS+36/h3LWM0o0Luhg7WLkBHIqJOaemgtkc3DwCrhJrOhjBwmzCVhITD7xgA3EZh
  FQldi27x1YubCAt8SMN0uZQGwRgS5GifNHvUFmMgvMZ5TYtvAqWBGvgKDEyZlPWEBsZgEJiYM
  vXjBD7DKQOL2gESwuIWAvMf39VWaQvRIC+hKNx2IhwoYS32d9gyoxl2jb2MWMrHwCo+AsJBtm
  IdmwgJFpFaNFUlFmekZJbmJmjq6hgYGuoaGxrrGupaFeYpVuol5qqW5yal5JUSJQUi+xvFivu
  DI3OSdFLy+1ZBMjMGpSCpmjdzCuWJp+iFGSg0lJlNf4YkqMEF9SfkplRmJxRnxRaU5q8SFGGQ
  4OJQleFZvUGCHBotT01Iq0zBxg/MKkJTh4lER4u22B0rzFBYm5xZnpEKlTjIpS4rx/QBICIIm
  M0jy4NljKuMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHcRyBSezLwSuOmvgBYzAS1+KpIC
  srgkESEl1cBY9PSmuX9scctd724XxSauCfIOi95saROwVnn+r+fxnTuiC/YUZ4pJd/UlTf256
  nvNkfw5bWLZ7sxLVH/aT33XymMqtu7U17/ZB+2fmaZdYe3vP7363cH3SfpKbJczlb8yHhPb8W
  xZ3gOLhwvn74+dyHB/9SWX/YKdL5VMzSS5PS4///1DbWGEEktxRqKhFnNRcSIAihA7MhQDAAA
  =
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-44.tower-223.messagelabs.com!1550139210!1180341!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16124 invoked from network); 14 Feb 2019 10:13:31 -0000
Received: from unknown (HELO NB-EX-CASHUB02.diasemi.com) (87.137.64.195)
  by server-44.tower-223.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 10:13:31 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB02.diasemi.com (10.1.16.142) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 11:13:29 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 10:13:28 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 684E73FBCD; Thu, 14 Feb 2019 10:13:28 +0000 (GMT)
Message-ID: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Thu, 14 Feb 2019 10:13:28 +0000
Subject: [PATCH v2 0/2] ASoC: da7219: BCLK and TDM flexibility improvements
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
X-KSE-Antivirus-Info: Clean, bases: 14/02/2019 07:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
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

Changes in v2:
 - Update 0001 patch to use '&&' instead of '&' in hw_params() to decide if
   BCLK rate should be configured or not.

Adam Thomson (2):
  ASoC: da7219: Add support for master mode BCLK rate adjustment
  ASoC: da7219: Update TDM usage to be more flexible

 sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/da7219.h |   1 +
 2 files changed, 74 insertions(+), 43 deletions(-)

-- 
1.9.1

