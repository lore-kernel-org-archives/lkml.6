Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8A820C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfBZPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:30:54 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:37010 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBZPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:30:54 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 0FFE713F80A;
        Tue, 26 Feb 2019 16:30:10 +0100 (CET)
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
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
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr> <yq1ftsad2yi.fsf@oracle.com>
 <b7f37c2d-27c7-9b58-20c8-52624783a6fa@free.fr> <yq1bm2yd2kr.fsf@oracle.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <026c10b1-48e8-ab9f-fda8-6e3557b841a7@free.fr>
Date:   Tue, 26 Feb 2019 16:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <yq1bm2yd2kr.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Drop codeaurora.org devs ]

On 26/02/2019 15:52, Martin K. Petersen wrote:

>>>> Revert the original patch, and clean up loose ends in the next patch.
>>>
>>> This commit isn't a revert. Why not?
>>
>> What do you mean?
> 
> Your commit states it reverts the original patch but the submission is
> not a git revert. If there are reasons why simply reverting the original
> commit didn't work, I'd like to see them documented in the commit
> message.

Martin,

I indeed started off from 'git revert'

$ git revert 60f0187031c0
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at least 18258 and retry the command.
error: could not revert 60f0187031c0... scsi: ufs: disable vccq if it's not needed by UFS device
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

So I had to resolve the conflict in ufshcd_probe_hba()

The line:

	ufs_advertise_fixup_device(hba);

was modified by commit 93fdd5ac64bbe80dac6416f048405362d7ef0945


It's not clear to me if you want me to

1) document that there was a conflict
2) change the title of the patch
3) both
4) something else altogether

Regards.
