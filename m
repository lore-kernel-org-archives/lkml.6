Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A590B218B0
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ilc28H51";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i5XEGlVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBGG5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:57:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBGG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:57:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4CDD3607F5; Thu,  7 Feb 2019 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549522639;
        bh=6oG/ng01LTZ1ofG+1Y1bjCjJWaESok/espDPCFydyG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ilc28H51dL6anPPywUD8RZogB9KhBxSMNFVKrvrTnRA6sBpUdDPxsHF/VwwR/7ZM8
         h24IqrDKDWsTd2DRlNb21Vk80IslOUC6UCK59Y26hskcidd7lAKnRghM1Qm1wr9f4H
         S36fOQTPLiR2KXtNXxhj2KFZX1DtrcPH9+ipkZeQ=
Received: from [10.79.128.202] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73C11601CF;
        Thu,  7 Feb 2019 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549522638;
        bh=6oG/ng01LTZ1ofG+1Y1bjCjJWaESok/espDPCFydyG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i5XEGlVZk6yWZQsxbnMdl1R1rZcQ7fyYiGe6fZ3V5Zv7wBc1suUavCeHm//YCYL8I
         f6pfJJ3pVKI2wma8dXoo3KcqJmUcJlza1fKuwLbZUc262AZwZN2pbkHVz+0Xy5ojaY
         o+he9SHsvhKJV9zO9mdIpfjt1XKmp7uSj8ZdRUEQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73C11601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <7af27aa5-3ff6-d4ee-1dc0-bac797c2bdbc@codeaurora.org>
Date:   Thu, 7 Feb 2019 12:27:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 3) How do we handle devices that already have power-domains specified in
> DT? The opp binding for required-opps doesn't let us specify the power
> domain to target, instead it assumes that whatever power domain is
> attached to a device is the one that OPP needs to use to change the
> genpd performance state. Do we need a
> dev_pm_opp_set_required_opps_name() or something to be explicit about
> this? Can we have some way for the power domain that required-opps
> correspond to be expressed in the OPP tables themselves?

I was converting a few more drivers to use the proposed approach in this
RFC, in order to identify all outstanding issues we need to deal with,
and specifically for UFS, I end up with this exact scenario where UFS already
has an existing power domain (gdsc) and I need to add another one (rpmhpd) for
setting the performance state.

If I use dev_pm_opp_of_add_table() to add the opp table from DT, the opp
layer assumes its the same device on which it can do a dev_pm_genpd_set_performance_state()
with, however the device that's actually associated with the pm_domain when we
have multiple power domains is infact the one (dummy) that we create when
the driver makes a call to dev_pm_domain_attach_by_name/id().

Any thoughts on whats a good way to handle this?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
