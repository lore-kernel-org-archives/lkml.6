Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF46C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1589217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBIJzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:55:00 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:14904 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfBIJzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:55:00 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 1953A19F5B6;
        Sat,  9 Feb 2019 10:54:22 +0100 (CET)
Subject: Re: [PATCH v4 6/7] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Avri Altman <Avri.Altman@wdc.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <09ce9c20-c47b-f936-a8a9-6c8ec8f0f867@free.fr>
 <817ff724-2a30-99fb-8a92-c77797651bde@free.fr>
 <SN6PR04MB49252A044910AC48672F1043FC6A0@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b09a33a2-65fd-55b0-f3c4-1b071d086a22@free.fr>
Date:   Sat, 9 Feb 2019 10:54:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB49252A044910AC48672F1043FC6A0@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2019 10:07, Avri Altman wrote:

> On 08/02/2019 23:20, Marc Gonzalez wrote:
>
>> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
>>
>> Calling ufshcd_set_vccq_rail_unused() breaks UFS init on two boards.
>> I would say that vccq is *not* not needed.
>>
>> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>
> Those tags got switched off.

What do you mean?

> I still think that If you are reverting the quirk implementation,
> you should remove the quirk listing as well.

You're right, of course. I just thought it could wait until
after this series was accepted, but I can fold it in v5, as
a follow-up patch.

> Also, as the v3 discussion held on several threads,
> and new people might be joining in, 
> maybe you could reply to this patch with a couple of sentences summing-up
> the various theories that this bring-up raised.

Will do in v5, either in the commit message, or in the
sub-text that is not committed.

Regards.
