Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2405C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB90921B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfBKNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:34:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:64132 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfBKNeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:34:44 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 8433B13F86F;
        Mon, 11 Feb 2019 14:33:49 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v5 0/2] Clean up UFSHC driver
To:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Message-ID: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
Date:   Mon, 11 Feb 2019 14:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting a wide net to get as many eyeballs on the subject as possible.

I'm splitting this mini series off from the main "UFS on APQ8098/MSM8998"
as it's 1) ufs/scsi specific 2) controversial (to my surprise)

Please send all your Reviewed-by: tags if you agree with the patch,
and/or voice your concerns ASAP.

This series removes the "disable-VCCQ-power-rail-for-some-Flash-chips" quirk,
and cleans up after the dust settles.

Marc Gonzalez (2):
  scsi: ufs: Do not disable vccq in UFSHC driver
  scsi: ufs: Remove unused device quirks

 drivers/scsi/ufs/ufs.h        |  1 -
 drivers/scsi/ufs/ufs_quirks.h | 29 ----------------
 drivers/scsi/ufs/ufshcd.c     | 63 +++--------------------------------
 3 files changed, 4 insertions(+), 89 deletions(-)

-- 
2.17.1
