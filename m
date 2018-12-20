Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15816C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF69621905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TmFJi5+3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TmFJi5+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390269AbeLTW4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:56:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55312 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbeLTW4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:56:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BABA6071C; Thu, 20 Dec 2018 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545346559;
        bh=2q81xDlVMK1LYY7Ft2FsAkQfnkm3oyWtq+D5jE9HcG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmFJi5+3K8yefGDBWbsb4QVpvhWCZtEqK4/TiMqI/uY7PMRlU7gVOP7w1dY5IL6Ox
         AKU8l56GRBM4XjJ3l1y8DTp7R5mzeT2Km5MiUM3ckBajyQMRTKO7kgu9Sm94SdgIyg
         WX6bb6m40zFeIqRQm5yiAcskDb06aOIORGC6dzcE=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4DB86071C;
        Thu, 20 Dec 2018 22:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545346559;
        bh=2q81xDlVMK1LYY7Ft2FsAkQfnkm3oyWtq+D5jE9HcG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmFJi5+3K8yefGDBWbsb4QVpvhWCZtEqK4/TiMqI/uY7PMRlU7gVOP7w1dY5IL6Ox
         AKU8l56GRBM4XjJ3l1y8DTp7R5mzeT2Km5MiUM3ckBajyQMRTKO7kgu9Sm94SdgIyg
         WX6bb6m40zFeIqRQm5yiAcskDb06aOIORGC6dzcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4DB86071C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 20 Dec 2018 15:55:58 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
Message-ID: <20181220225557.GE14960@codeaurora.org>
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
 <20181130154145.GK18262@codeaurora.org>
 <CAD=FV=XWftL_aFb7rNPMW1AE+1y+Zh3W+qqtfSKHRPN+Qe_w2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=XWftL_aFb7rNPMW1AE+1y+Zh3W+qqtfSKHRPN+Qe_w2A@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2018 at 14:42 -0700, Doug Anderson wrote:
>Hi,
>
>On Fri, Nov 30, 2018 at 7:41 AM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Tue, Oct 30 2018 at 11:23 -0600, Raju P.L.S.S.S.N wrote:
>> >Add device bindings for cpuidle states for cpu devices.
>> >
>> >Cc: <devicetree@vger.kernel.org>
>> >Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> >---
>> >Changes in v2
>> > - Address comments from Doug
>> >---
>> >---
>> > arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>> > 1 file changed, 62 insertions(+)
>> >
>> >diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >index 0c9a2aa..3a8381e 100644
>> >--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> >@@ -96,6 +96,7 @@
>> >                       reg = <0x0 0x0>;
>> >                       enable-method = "psci";
>> >                       next-level-cache = <&L2_0>;
>> >+                      cpu-idle-states = <&C0_CPU_PD &C0_CPU_RPD &CLUSTER_PD>;
>> I think it might be better to use
>> <&C0_CPU_PD>, <&C0_CPU_RPD>, <&CLUSTER_PD>
>
>I disagree.  All existing examples in both bindings and other device
>trees use the syntax that Raju uses.  It doesn't matter
>functionality-wise, but I'd much rather match everyone else.  We
>should land what Raju has posted and if someone feels super strongly
>that the examples in the bindings are wrong then they should attempt
>to convince Rob Herring to Ack a change to the examples in the
>bindings.  Doesn't seem like a good use of time to me, though.
>
No strong preference from my end.

-- Lina

