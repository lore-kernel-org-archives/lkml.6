Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDD3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F42087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J/J8yoci";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K0cDKOF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfAHKuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:50:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:50:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C52D601D7; Tue,  8 Jan 2019 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546944645;
        bh=IYS1Yo4HbfQWb/zjrjj4d0SeRG1Tg/BDJKjQAdb74ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J/J8yoci58+f5688+8GxS9OVsFKMwgyXBoOyJ6dyEdw671KVOkNKB0i5aU0VE606F
         z+mxKR6NQOIMhwyMtmVlBPtrTiSjEstIIHnw+2A7dZQ3ETnKbxd+HMVbbUdKAuPOZp
         JRUmhLJCtm3JTSpkbTnleK4/TOECD+wRRkIkSsZQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EB98C601D7;
        Tue,  8 Jan 2019 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546944642;
        bh=IYS1Yo4HbfQWb/zjrjj4d0SeRG1Tg/BDJKjQAdb74ds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K0cDKOF6SCyUKHAJ69azN8Xt+PeLhh+IgWwxRVpb9wtw5DblfwyVGWQTkyfqaAd5n
         6Pla12lCrvDFvdwqfpX8OjYMGA0cpTW6yknZbimm6pEA9F9K96tuhn6CB2fQEB7MHI
         Kpg3WuAPD6GGw2arTOynpxwdFWg6qOlpyZ+k3GHs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 16:20:41 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
In-Reply-To: <20190105015430.GA67838@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com> <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder> <20190104001158.GA200069@google.com>
 <20190105015430.GA67838@google.com>
Message-ID: <7f6eb454bb27d3c060bb415cba3f1b49@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian/Bjorn,
Thanks for the review!

On 2019-01-05 07:24, Brian Norris wrote:
> Hi again,
> 
> On Thu, Jan 03, 2019 at 04:11:58PM -0800, Brian Norris wrote:
>> On Thu, Jan 03, 2019 at 04:01:45PM -0800, Bjorn Andersson wrote:
>> > I share your concern about this, but I came to suggest this as the
>> > driver cares about platforms but the firmware is (often?)
>> > device/product-specific.
>> >
>> > E.g. we will serve the MTP and Pixel 3 with the qcom,sdm845-adsp-pas
>> > compatible, but they are unlikely to run the same adsp firmware. This
>> > allows the individual dtb to specify which firmware the driver should
>> > use.
>> 
>> I understand this, but that still doesn't mean we should be suggesting
>> each DTB to clutter the top-level firmware search path, especially 
>> since
>> lazy people will probably just use "modem.mdt" and similar. That means
>> you no longer can ship the same rootfs that supports both QCOM and
>> <other> modems, if <other> modem also uses the same lazy format.
>> 
>> It seems like a much better practice to at least enforce a particular
>> prefix to things. e.g., the driver could assume:
>> 
>>   qcom/sdm845-adsp-pas/ (or if you must, just qcom/)
>> 
>> and your DTB only gets to add .../<your-string-here> to that path.
>> 
>> In case it isn't clear: I think it's also severely misguided that the
>> existing driver gets away with lines like
>> 
>> 	request_firmware(&fw, "modem.mdt", ...);
>> 
>> today ;)
> 
> To add to my thoughts, since I think maybe Sibi was a little unclear of
> my thoughts:
> 
> One of my primary concerns with the existing approach is that it's
> basically a complete free-for-all. We should have some minimal 
> standards
> (enforced in code) such that our DTB can never point us at something
> like /lib/firmware/<other-vendor>/foo.bin (or /lib/firmware/modem.mdt;
> or lots of other bad examples). This could probably be done simply by
> always prefixing 'qcom/' (I don't remember -- does request_firmware()
> follow '..'? e.g., 'firmware-name = "../bar/foo.bin"'.)
> 
> As a bonus: it would be very nice if we can provide a little more
> structure by default, and avoid arbitrary hierarchy in the DTS. That's
> where I brought up ath10k's "variant" as an example; if we can use
> 'compatible' to capture most of this particular Hexagon core's
> properties, then we only leave a single level of variability to the 
> DTS.
> 
> But I might be off-base with the "bonus" paragraph. So I'd also be
> somewhat happy with something much less ambitious, like just a built-in
> prefix ('qcom/').
> 
> And you can also just ignore my thoughts entirely (and I'll be even 
> less
> happy), since Rob did already provide his Reviewed-by ;) I mostly 
> wanted
> to give food for thought, in the hopes that something in here would 
> help
> improve this a bit.

Bjorn,
let me know how you want it implemented.
I am okay with either of the following:
* (variant tag based solution)
or
* (simply going ahead with what we have now).

> 
> Regards,
> Brian

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
