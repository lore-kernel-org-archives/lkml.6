Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DATE_IN_PAST_24_48,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D57206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfAIOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:15:12 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:17688 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731169AbfAIONn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:43 -0500
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 80/29-19156-391063C5; Wed, 09 Jan 2019 14:13:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsVy8IPnUd3JjGY
  xBg8PMVmcatnDbnHlIpA19eETNou95z8yW3y70sFkcXnXHDaLzl39rBYbvq9ldODw2PC5ic2j
  9dJfNo+ds+6yeyzYVOqxaVUnm8e+t8vYPNZvucri8XmTXABHFGtmXlJ+RQJrxqF9V1gLdrNVn
  Dr6jKmBcQ1rFyMXh5DAOkaJOWduAjmcQE6FxP2151lAbF4BN4mmLceZQGw2AQuJyScesIHYLA
  IqEn2n54HFhQUCJGa2/gSrFxHoYpQ4f9QbZCizwCFGiV2bd7JDDBKUODnzCVgRs4CExMEXL5g
  hlhlInF7QCBaXELCXmP7+KlCcA8jWl2g8FgsRNpT4PusbVIm5xIqHC9gmMPLPQjJ1FpKpCxiZ
  VjGaJxVlpmeU5CZm5ugaGhjoGhoa6RpaGuuamuslVukm6qWW6panFpfoGuollhfrFVfmJuek6
  OWllmxiBEZFSsFByx2Mp5anH2KU5GBSEuXd8t00RogvKT+lMiOxOCO+qDQntfgQowwHh5IErw
  eDWYyQYFFqempFWmYOMD5h0hIcPEoivHzAGBXiLS5IzC3OTIdInWJUlBLn5fwFNFMAJJFRmgf
  XBksJlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ85aBbOfJzCuBm/4KaDET0OJDjCYgi0sS
  EVJSDYxCrhxLW4oTOWU2pHlvDrTb727Jpn16v7GWXHGv2+7qVzGp5YLZL5J4aiOZvCKzgpvmK
  zleLldV0+fYZnPuz94keQvdcvWQU3G7stfP+LHly9TeqUdFthruZ/Daw8c9P3nPW++sxUnbt7
  AwRH59e6z1rHnHpUvfzl15N2XXxIXWG3pyDFdOKVBiKc5INNRiLipOBAANITDmBAMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-4.tower-268.messagelabs.com!1547043218!1157657!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6204 invoked from network); 9 Jan 2019 14:13:39 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-4.tower-268.messagelabs.com with AES128-SHA256 encrypted SMTP; 9 Jan 2019 14:13:39 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 9 Jan 2019 14:13:37 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 B6F1A3FADD; Tue,  8 Jan 2019 09:13:26 +0000 (GMT)
Message-ID: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 8 Jan 2019 09:13:26 +0000
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
Message-ID: <20190108091326.K8v-L4ZHbMTY_5WfNoGvwg0BbTIF3yqepQA80yDBEaM@z>

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

