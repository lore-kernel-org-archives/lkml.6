Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC941C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66892080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfBHKEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:04:30 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:60939 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfBHKE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:04:29 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 4C33B13F8C9;
        Fri,  8 Feb 2019 11:03:51 +0100 (CET)
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
 <05d2d193-4181-12ce-b4fb-4e8dec5aef27@free.fr>
 <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
 <42c86292-22e9-4c5e-d64d-bc6107af45bf@free.fr>
 <740e6332-b54f-ab62-915a-0aec6be450d3@samsung.com>
 <2a59c11a-037f-c8c3-235a-9b21183a0801@free.fr>
 <90f24b35-89b0-cea0-1ab3-13c2a419b138@samsung.com>
 <81b85f39-49b5-901b-ec79-19708509965e@codeaurora.org>
 <2c0e5f03-0bb8-e5db-b5de-790da439fcfe@samsung.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a1ae54dd-7294-90e1-db6b-1f2f5de7fe64@free.fr>
Date:   Fri, 8 Feb 2019 11:03:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2c0e5f03-0bb8-e5db-b5de-790da439fcfe@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yaniv (just in case)
+ Hannes (if he remembers)

We're discussing commit 60f0187031c05e04cbadffb62f557d0ff3564490

On 08/02/2019 10:09, Alim Akhtar wrote:

> On 07/02/19 8:22 PM, Jeffrey Hugo wrote:
> 
>> Did you see https://lkml.org/lkml/2019/2/5/659 where I indicated VCCQ 
>> powers components within the host controller, and by not setting load on 
>> the regulator properly, we are likely undervolting those components due 
>> to the current draw?
>
> In theory may be true. But looks like we dont have a solid evidence yet 
> (correct me if I am wrong or misunderstood anything here)
> So that means its some short of hardware/board quirk, right?
> Can you please recheck the schematic and see what Bjorn is telling 
> (about having right entries in the DT for regulator) resolve your issue?

I think there might be a misunderstanding on your side.

Basically, Bjorn is saying that code to disable a regulator is not needed.
(Therefore he is in favor of the patch to revert.)

If a board does not require some power rail, then it should simply *not*
list it in the DT. My board *does* require that power rail, so I must
list it in the DT. The driver should not attempt to work around that
simple fact (by disabling a regulator that was erroneously listed).

> Marc, Can you disabled pmic on that board (hope your board boots with 
> default PMIC supply) and see if this issue still occurs?
> I am just trying to understand and see what is the real cause.

I don't know how to disable the PMIC.

> @Yaniv Gardi, will you be able to comment on reason for adding 
> 60f0187031c05e04cbadffb62f557d0ff3564490 (any issue faced)?

AFAIU, Yaniv no longer works for CA, so he is unlikely to reply.

I'll resend the series and CC the regulators maintainers so they
can share their thoughts.

Regards.
