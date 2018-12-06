Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80253C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9F1208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544119343;
	bh=VbqyMpy65wsMnbzE71zc5MW+SoNBLt+LnHDvNOTzt9c=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=ApULNKedEjjBXdySVkkNpmjcery2mNSEeaMAQnLxoiR5HVXtr1fRF9XYNh5OjSUAC
	 uKUfm0SAnbrtNXPIn7T7K5PPd0PJu8lvUBHLWuTovqbe4qGStFRFdKhizIetO3eHY/
	 t5EF3usU1Lye3IZ1IL6fFEqk0I3UavJ1EjqtihY4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLFSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbeLFSCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:02:21 -0500
Received: from localhost (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D326D20878;
        Thu,  6 Dec 2018 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544119340;
        bh=VbqyMpy65wsMnbzE71zc5MW+SoNBLt+LnHDvNOTzt9c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kuLlbkDbjs8KPiWwDCDuYYYvxJhVAs7CwEmOQw38DEJ94DfKhiHIvjA/vHrq2mR1e
         S5wfwDMiJqzW+sAfPAkepxIDkHa9eIY11xL575OGXjTNQcizzOXP+hTgMQY7ldwTFR
         e9cOPvwIdxb+x4m8pikX1ABhQodMUntNjWrghc4A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alex Elder <elder@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <6ffdf6ca-51b5-a968-bb4e-c4d6d46f63aa@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
 <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
 <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
 <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
 <6ffdf6ca-51b5-a968-bb4e-c4d6d46f63aa@codeaurora.org>
Message-ID: <154411934006.88331.2149751521264448532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Thu, 06 Dec 2018 10:02:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2018-12-05 17:24:18)
> =

> =

> On 12/4/2018 11:15 PM, Stephen Boyd wrote:
> > Quoting David Dai (2018-12-04 17:14:10)
> >> On 12/4/2018 2:34 PM, Stephen Boyd wrote:
> >>> Quoting Alex Elder (2018-12-04 13:41:47)
> >>>>
> >>> But then we translate that clock rate into a bandwidth request to the
> >>> BCM hardware? Seems really weird because it's doing the opposite of w=
hat
> >>> you say is abusive. What does the IPA driver plan to do with this clk?
> >>> Calculate a frequency by knowing that it really boils down to some
> >>> bandwidth that then gets converted back into some clock frequency? Do=
 we
> >>> have the user somewhere that can be pointed to?
> >> The clock rate is translated into a unitless threshold value sent as
> >> part of the rpmh msg
> >> that BCM takes to select a performance. In this case, the unit
> >> conversion is based on
> >> the unit value read from the aux data which is in Khz. I understand th=
at
> >> this wasn't
> >> explicitly mentioned anywhere and I'll improve on that next patch.
> > How is this different from bus bandwidth requests? In those cases the
> > bandwidth is calculated in bits per second or something like that, and
> > written to the hardware so it can convert that bandwidth into kHz and
> > set a bus clk frequency in the clock controller? So in the IPA case
> > we've skipped the bps to kHz conversion step and gone straight to the
> > clk frequency setting part? Is a BCM able to aggregate units of
> > bandwidth or kHz depending on how it's configured and this BCM is
> > configured for kHz?
> =

> The data written to the hardware is just a 14bit scalar value that it =

> takes to select a performance/frequency from a preset table. It's not =

> really doing any sort of conversion in hardware in this case, instead =

> the value is computed by software based on the aux data given. Think of =

> it as a generic aggregator as opposed to being strictly bandwidth and =

> the aggregator itself does not care what type of value it is(be it Khz =

> or BW/s).
> =


Got it. Thanks!

