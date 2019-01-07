Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DATE_IN_PAST_24_48,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C9CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2002075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbfAIONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:13:42 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:17688 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730079AbfAIONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:42 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id AC/19-19156-391063C5; Wed, 09 Jan 2019 14:13:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRWlGSWpSXmKPExsVy8IPnUd1JjGY
  xBsfXGlmcatnDbnHl4iEmi6kPn7BZ7D3/kdni25UOJovLu+awWXTu6me12PB9LaMDh8eGz01s
  Hq2X/rJ57Jx1l91jwaZSj02rOtk89r1dxuaxfstVFo/Pm+QCOKJYM/OS8isSWDMO7bvCWrCbr
  eLU0WdMDYxrWLsYuTiEBNYxSsw5cxPI4QRyKiTmH/zJCGLzCrhJNG05zgRiswlYSEw+8YANxG
  YRUJGY0HKRBcQWFgiQmNn6E8wWEehilDh/1BtkKLPAIUaJXZt3skMMEpQ4OfMJWBGzgITEwRc
  vmCGWGUicXtAIFpcQsJeY/v4qUJwDyNaXaDwWCxE2lPg+6xtUibnEiocL2CYw8s9CMnUWkqkL
  GJlWMVokFWWmZ5TkJmbm6BoaGOgaGhrpGlqa6BoZmeolVukm6qWW6panFpfoGuollhfrFVfmJ
  uek6OWllmxiBMZFSsGhhzsYzy1PP8QoycGkJMq75btpjBBfUn5KZUZicUZ8UWlOavEhRhkODi
  UJXg8GsxghwaLU9NSKtMwcYITCpCU4eJREePmAUSrEW1yQmFucmQ6ROsWoKCXOy/kLaKYASCK
  jNA+uDZYULjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5i0D2c6TmVcCN/0V0GImoMWHGE1A
  FpckIqSkGhilHxZ5PfbeqjiDMUHY5/8mhnnrL9/sYvHeNulJ9FU91sZzBev5BLID374pVX25f
  F3Nn92/26/nbMjsPTDbSuhrZ9iaqCrLEjm97yxlDNUKR45Znfm+5E9Tm4hZ09OLCiEdL80vcE
  vxpopl7w4yjLsrFvRI4NaneRa/8g35zBTeBnTdTvZUfKvEUpyRaKjFXFScCABbrYecBQMAAA=
  =
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-268.messagelabs.com!1547043218!1157657!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6156 invoked from network); 9 Jan 2019 14:13:38 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-4.tower-268.messagelabs.com with AES128-SHA256 encrypted SMTP; 9 Jan 2019 14:13:38 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 9 Jan 2019 14:13:37 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 EAEBF3FBEC; Mon,  7 Jan 2019 16:11:45 +0000 (GMT)
Message-ID: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Mon, 7 Jan 2019 16:11:45 +0000
Subject: [PATCH 0/2] ASoC: da7219: Improvements to DAI clocks handling in driver
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09/01/2019 12:09:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patchset provides improvements to CCF based clock handling relating
to the DAI clocks. In the first patch MCLK is made parent of DAI clocks, if MCLK
has been provided to the driver, which means that MCLK will automatically be
enabled as a prerequisite to DAI clocks. The second patch adds the ability to
read the WCLK rate provided by the codec when DAI clocks are featured. This is
more useful than the returned rate simply being the rate of the parent clock,
which in this case would be MCLK.

Adam Thomson (2):
  ASoC: da7219: MCLK should be enabled before DAI clocks
  ASoC: da7219: Add recalc_rate function to return DAI clock rate

 sound/soc/codecs/da7219.c | 77 ++++++++++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 67 insertions(+), 11 deletions(-)

-- 
1.9.1

