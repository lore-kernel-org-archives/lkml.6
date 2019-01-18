Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E16A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S8KZYzgp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S8KZYzgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfARFVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:21:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38098 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfARFVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:21:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0E2E6081E; Fri, 18 Jan 2019 05:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547788913;
        bh=OeLXSwt9SPv0Z6ZKu2EPP4bCBvBvPgfOhjfBAKW0jxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8KZYzgpFMOmugqF06l9+haMeTXkzvdm2t83F7P7ioFxwLBpVKRQUUVVXco6GRBbl
         ig5769d2p+i3vPGljJn+gyTqcKstpiXvtJKHs3FmDzYRD0ZXdMAWFxbAf2tl+9Gn8m
         b2Cxm+rSkJgZ3SLl8M1DnpDMfcRS6JXyNcNKJoKM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3604760585;
        Fri, 18 Jan 2019 05:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547788913;
        bh=OeLXSwt9SPv0Z6ZKu2EPP4bCBvBvPgfOhjfBAKW0jxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S8KZYzgpFMOmugqF06l9+haMeTXkzvdm2t83F7P7ioFxwLBpVKRQUUVVXco6GRBbl
         ig5769d2p+i3vPGljJn+gyTqcKstpiXvtJKHs3FmDzYRD0ZXdMAWFxbAf2tl+9Gn8m
         b2Cxm+rSkJgZ3SLl8M1DnpDMfcRS6JXyNcNKJoKM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jan 2019 10:51:53 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        sricharan@codeaurora.org, linux-soc-owner@vger.kernel.org
Subject: Re: [PATCH v6] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
In-Reply-To: <CAD=FV=V2XoaDVy9hnh-S=jbzU-Di0KoD7gM2CxpZm3646k9ZjA@mail.gmail.com>
References: <20190114192201.23779-1-sibis@codeaurora.org>
 <CAD=FV=V2XoaDVy9hnh-S=jbzU-Di0KoD7gM2CxpZm3646k9ZjA@mail.gmail.com>
Message-ID: <d3a814812039fdc7459656e2150e00a5@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 04:35, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jan 14, 2019 at 11:22 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> +               mss_pil: remoteproc@4080000 {
>> +                       compatible = "qcom,sdm845-mss-pil";
>> +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;
> 
> This will now need to be adjusted to:
> 
> reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;

Yup, this was on my todo list after Bjorn
posted out the patch

> 
> This fixes things up to deal with the patch ("arm64: dts: qcom:
> sdm845: Increase address and size cells for soc"), AKA:
> - https://patchwork.kernel.org/patch/10767511/
> - 
> https://lkml.kernel.org/r/20190117042940.25487-2-bjorn.andersson@linaro.org
> 
> 
> -Doug

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
