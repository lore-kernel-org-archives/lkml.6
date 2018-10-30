Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29935C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11782081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GZ8gm+wA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hh0uLhoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11782081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJaBSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:18:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJaBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:18:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C133607E2; Tue, 30 Oct 2018 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540916648;
        bh=FThDWXVH3eS0uYWQ8+VI13MRxeZWsJAr9cV4QanMOZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GZ8gm+wAPEvMhatguCY2LnvZt46XB2VriqF94wvMBeeehQ856vH+iu3r/M58U5fHh
         y9FqjuRC3yAa2ejB/WdRkZTy6X3ZlhVdw83DnAU4UYBSblMoCkGEOlNGd9bOllbPUA
         4YOJira6GwxCMUudGyqLbsyxVclSE1r9CBKKx45I=
Received: from [192.168.1.4] (unknown [183.83.75.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47534607E2;
        Tue, 30 Oct 2018 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540916647;
        bh=FThDWXVH3eS0uYWQ8+VI13MRxeZWsJAr9cV4QanMOZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hh0uLhoqIytvw3QkhbpPTAUyebFXIexbpplkHJM9XdIDMkyAbCXJY6uCxrSivq1ei
         CUuei27NGoSgasyZsFzfyPJcwPU+MT4E2/j3+n9u8nM24FgMMqTxIqklxpi/AebUj5
         /f+eStMHBVaWDGjbALYK9887DF6To4xSPnGD539A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47534607E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
Date:   Tue, 30 Oct 2018 21:53:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2018 12:06 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
> <rplsssn@codeaurora.org> wrote:
>> +               idle-states {
>> +                       entry-method = "psci";
>> +
>> +                       C0_CPU_SPC: c0_spc {
> 
> nit: all these nodes should have dashes instead of spaces in the node
> names (labels can still have spaces).  AKA:
> 
> C0_CPU_SPC: c0-spc {

Sure. I will change this. (However, from device tree specification v0.2, 
I see that Table 2.1 mentions underscore as valid character for node. 
Please correct me if I'm missing something)

> 
> 
>> +                               compatible = "arm,idle-state";
>> +                               arm,psci-suspend-param = <0x40000003>;
>> +                               entry-latency-us = <350>;
>> +                               exit-latency-us = <461>;
>> +                               min-residency-us = <1890>;
>> +                               local-timer-stop;
>> +                               idle-state-name = "pc";
> 
> It seems weird that the idle state with the node name "spc" has the
> name "pc" and the idle state with the node name "pc" has the name
> "rail pc".  Can this be more consistent or is there a reason why they
> need to be mismatched?

Agree. They are confusing. Will change this.

> 
> Also: AAHTUFSWDKWTM (acronyms are hard to understand for someone who
> doesn't know what they mean).  If you really need to use an the
> acronyms "PC" and "SPC" please document them somewhere.  In the very
> least the commit message, but having a comment in the file is good
> too.  ...or (even better) don't use the acronym and spell out what
> you're talking about.  Please correct me if I'm wrong, but I don't
> think it's obvious what the "PC" and "SPC" idle states mean.

Sure. Will change this.


Thanks for feedback Doug.

> 
> 
> -Doug
> 
