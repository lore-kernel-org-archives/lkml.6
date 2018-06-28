Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18F6261FA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YybDsPYj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YybDsPYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18F6261FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeF1Dtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:49:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbeF1Dto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:49:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8275C60B10; Thu, 28 Jun 2018 03:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530157784;
        bh=Pwb6UILJ2uhwh5NL/FjLxXqtwwlO2qFPQQcSCc0mMC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YybDsPYjkOFSkN9v83/bLpKfWnDKV3oz5wEi0Wqx3D75xU9iTRZTUwxofYHmuJW3M
         5zhr58Ca2rE4/viYmMwgsxwczRFUl+kTuQfI3u7Lkcc0MmeyH5gPVSu0QM7kpY5RH1
         n+i/0w+RvavVDqJW8DwR2+M1PTUaDr1nPFzPudOw=
Received: from [10.206.25.22] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 849E260117;
        Thu, 28 Jun 2018 03:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530157784;
        bh=Pwb6UILJ2uhwh5NL/FjLxXqtwwlO2qFPQQcSCc0mMC4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YybDsPYjkOFSkN9v83/bLpKfWnDKV3oz5wEi0Wqx3D75xU9iTRZTUwxofYHmuJW3M
         5zhr58Ca2rE4/viYmMwgsxwczRFUl+kTuQfI3u7Lkcc0MmeyH5gPVSu0QM7kpY5RH1
         n+i/0w+RvavVDqJW8DwR2+M1PTUaDr1nPFzPudOw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 849E260117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v7 1/4] phy: Update PHY power control sequence
To:     Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180619083647.10116-1-cang@codeaurora.org>
 <20180619083647.10116-2-cang@codeaurora.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <bd1ceedd-25db-7105-6005-c38678b10584@codeaurora.org>
Date:   Thu, 28 Jun 2018 09:19:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619083647.10116-2-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2018 2:06 PM, Can Guo wrote:
> All PHYs should be powered on before register configuration starts. And
> only PCIe PHYs need an extra power control before deasserts reset state.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Manu Gautam <mgautam@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
