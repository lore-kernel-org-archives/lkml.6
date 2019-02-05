Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1813217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PhtepKyq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V08Plt83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfBEThd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:37:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfBEThc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:37:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E125608EA; Tue,  5 Feb 2019 19:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549395451;
        bh=lHUU7rfue+fhxGnZ888AaeOr54QaA+8syQuGbk+mSsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PhtepKyq70hYJ+RCUV7lENVSWXv2+SWM1Lwq5WZ/av2mX9M8jb3clc+ZnbhF7ONKG
         B2Ye1S1Qnw3Iswr2+kg26WUs5xRaUUMrXplo9ebAvFoGW/JUjJe0f570PplglYeAsr
         ubzVBPcrDzdbGYWmFDjUVSBnhJI2f6xLpubu98V0=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F20036047C;
        Tue,  5 Feb 2019 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549395450;
        bh=lHUU7rfue+fhxGnZ888AaeOr54QaA+8syQuGbk+mSsU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V08Plt830pp7cI9qQqd8A1b78a9ohBFjdggtq2T3UsSKwF3KmWiQgl6G1kolHINak
         N+AuNIEPEoPrWC3aF9ik4OUcjU7ZiM5pnZg2dK3TjvTjxfGCVAYeFf1T/GaT6mm6cY
         d5nSJ7MJrZVt+NtfFIY+9Uu6ld/eEM9yCCW0+TK4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F20036047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Evan Green <evgreen@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
 <05d2d193-4181-12ce-b4fb-4e8dec5aef27@free.fr>
 <7610c262-1451-9bb2-48a6-4daf6f534f6c@free.fr>
 <CAE=gft5yAqLZDnYnjF2T1QbKfOKOagX+C1qQqD1DFU+2pr_WPw@mail.gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <fe4e6e20-2017-0a50-232d-52582983146d@codeaurora.org>
Date:   Tue, 5 Feb 2019 12:37:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft5yAqLZDnYnjF2T1QbKfOKOagX+C1qQqD1DFU+2pr_WPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2019 11:19 AM, Evan Green wrote:
> On Tue, Feb 5, 2019 at 9:52 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>>
>> On 05/02/2019 18:24, Marc Gonzalez wrote:
>>
>>> /*** system hangs here for several seconds, then reboots ***/
>>
>> Silly me. The system crashes in ufshcd_dump_regs() which is a bug
>> I fixed myself. Once I cherry-pick the appropriate fix, the board
>> no longer reboots, but UFS init does fail.
>>
>> Full boot log here:
>> https://pastebin.ubuntu.com/p/KwpRnWMFw5/
>>
>> In any case, it's obvious that disabling vccq on this system is
>> a mistake. How would you solve the problem? (A quirk on top of a
>> quirk sounds silly.)
>>
> 
> I think Bjorn is right that this whole quirk seems to be compensating
> for an incorrectly specified device tree (one that specifies
> vccq-supply but that doesn't go anywhere).... though maybe this was
> made to support boards with footprint-compatible UFS parts from
> different vendors? Like the same DT is used for two different SKUs,
> one which stamps down a UFS part that uses VCCQ, and another that
> doesn't use it, though the wire is there.

This doesn't make sense from a DT perspective, as I understand it.  If 
some board has different configurations (say different display panels), 
FW is supposed to somehow detect that, and edit the DT before passing 
the DT off to Linux.

In your example, if SKU1 has a UFS part that needs VCCQ, and SKU2 does 
not, then FW should somehow query the HW, determine which SKU the device 
is, and patch vccq in or out of the DT as necessary.

> 
> But the revert itself shouldn't really fix anything for you Marc,
> should it? It looks like this quirk turns on for Samsung and SKHynix
> parts, which presumably just don't use VCCQ. So maybe your device tree
> doesn't match your schematics, where the DT's vccq supply is actually
> the vccq2 supply going into the UFS chip?

I see the same issue on the reference device, the MSM8998 MTP.  The 
schematics for that indicate there is both vccq and vccq2, at different 
voltages.  vccq goes to both the UFS block, and the phy.

Digging into things, the problem doesn't seem to be that vccq is off - 
the phy will keep it on.  However, the load from the phy is minimal. 
What really loads the regulator is the UFS block.  Without the load from 
the UFS block, the regulator is likely in a low power mode.

I cannot tell if vccq is routed to the actual storage chip based on the 
documentation I see, however I can tell that it powers blocks within the 
host controller block which assist the controller in communicating with 
the storage chip.  These blocks consume quite a bit of power, so likely, 
if the regulator load is not properly accounted for, these blocks 
brownout, and communication with the storage chip is broken.

The schematics do refer to this input to the UFS block as "vccq".

So, at a minimum, the host controller itself consumes vccq, and 
therefore it is unfair to disable vccq solely based on the UFS storage 
chip that happens to be connected to the controller.

So, we've got two boards that are actually harmed by this quirk.  I've 
not seen anything indicating what harm happens without this quirk.  Can 
someone indicate what that is?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
