Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E786F20851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfB0KjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:39:03 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:57741 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfB0KjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:39:03 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 0D34D13F8DC;
        Wed, 27 Feb 2019 11:38:27 +0100 (CET)
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
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Message-ID: <63df5f8f-1f0d-9fbd-ef41-d4780d1f580e@free.fr>
Date:   Wed, 27 Feb 2019 11:38:26 +0100
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

This mini-series removes the "disable-VCCQ-power-rail-for-some-Flash-chips"
quirk, and cleans up after the dust settles.

Differences between v5 and v6:
- Reword patch 1 commit message (per Martin)
- Collect tags

Marc Gonzalez (2):
  Revert "scsi: ufs: disable vccq if it's not needed by UFS device"
  scsi: ufs: Remove unused device quirks

 drivers/scsi/ufs/ufs.h        |  1 -
 drivers/scsi/ufs/ufs_quirks.h | 29 ----------------
 drivers/scsi/ufs/ufshcd.c     | 63 +++--------------------------------
 3 files changed, 4 insertions(+), 89 deletions(-)

-- 
2.17.1
