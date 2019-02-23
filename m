Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0763FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CC020684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfBWJkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:40:03 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:63206 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBWJkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:40:03 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id EC33C19F5AE;
        Sat, 23 Feb 2019 10:39:05 +0100 (CET)
Subject: Re: [PATCH v5 0/2] Clean up UFSHC driver
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Martin Petersen <martin.petersen@oracle.com>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
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
        Lee Jones <lee.jones@linaro.org>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
Message-ID: <60e5da74-da0d-4ba7-6d29-2ca6008b6ceb@free.fr>
Date:   Sat, 23 Feb 2019 10:39:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

Could you send this series to -next so that it gets some exposure
and testing during the 5.1 RC cycle?

Regards.

On 11/02/2019 14:31, Marc Gonzalez wrote:

> Casting a wide net to get as many eyeballs on the subject as possible.
> 
> I'm splitting this mini series off from the main "UFS on APQ8098/MSM8998"
> as it's 1) ufs/scsi specific 2) controversial (to my surprise)
> 
> Please send all your Reviewed-by: tags if you agree with the patch,
> and/or voice your concerns ASAP.
> 
> This series removes the "disable-VCCQ-power-rail-for-some-Flash-chips" quirk,
> and cleans up after the dust settles.
> 
> Marc Gonzalez (2):
>   scsi: ufs: Do not disable vccq in UFSHC driver
>   scsi: ufs: Remove unused device quirks
> 
>  drivers/scsi/ufs/ufs.h        |  1 -
>  drivers/scsi/ufs/ufs_quirks.h | 29 ----------------
>  drivers/scsi/ufs/ufshcd.c     | 63 +++--------------------------------
>  3 files changed, 4 insertions(+), 89 deletions(-)
