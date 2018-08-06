Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B11DC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DC9219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ghzk5Ipb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gkh5m1JZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DC9219C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHFFpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:45:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHFFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:45:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 650A560B11; Mon,  6 Aug 2018 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533526684;
        bh=vCepNhQdijnbyBn/vfDPr3AV5rxrrzGt0MtSiNfO39I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ghzk5IpbhE7orVnqdGmKE6vM04xhR6Pjw/7Zu8R6tk5LjLQNF98DvpUvzU5Wzqj00
         /6+IRmGUi0mKOZ0ZyS8JiVKyMVa/a8NB1FgzVa4uneFI8jtgGWPj68BT3k01R49msd
         WihHcadNBT4cU2jEXdI57PF+FQBj0OmHYA5xdpPM=
Received: from [10.79.128.16] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55FD560541;
        Mon,  6 Aug 2018 03:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533526683;
        bh=vCepNhQdijnbyBn/vfDPr3AV5rxrrzGt0MtSiNfO39I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gkh5m1JZlKq27QgJmQZN5riHB/NoXvdEiynALKcwQ7tumHcR9mVrsrjef0l8dHJgk
         FH/6uPdHrYnT/qojP79frp6DpYeieDexCgMcnArUeEDxrd6uCqpylN/xwiNnm4HEWr
         nifQGzyt7r7oeLTHzpMSSnoTmY+gUXguu2p1weQE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55FD560541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] remoteproc: q6v5: Add support to vote for rpmh power
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, sibis@codeaurora.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180629102035.2757-1-rnayak@codeaurora.org>
 <CAPDyKFq=7RrUcspzyZGxYrv8bFHC=hkqMTT1SFeb+H_=Yv_Cxg@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <33aa19da-314d-f349-6750-0216ac9ab891@codeaurora.org>
Date:   Mon, 6 Aug 2018 09:08:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq=7RrUcspzyZGxYrv8bFHC=hkqMTT1SFeb+H_=Yv_Cxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2018 3:40 PM, Ulf Hansson wrote:
> On 29 June 2018 at 12:20, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> With rpmh ARC resources being modelled as power domains with
>> performance state, add support to proxy vote on these for SDM845.
>> Add support to vote on multiple of them, now that genpd supports
>> associating multiple power domains to a device.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>> This patch is dependent on the rpmh powerdomain driver
>> still under review,
>> https://lkml.org/lkml/2018/6/27/7
> 
> I assume you intend to re-spin this to use the new
> dev_pm_domain_attach_by_name(), once 4.19 rc1 is out, right!?
> 
> Anyway, please keep me in the loop.

Yes, I do plan to respin this one with the new api.

> 
> [...]
> 
>> +       if (num_pds > 1) {
>> +               for (i = 0; i < num_pds; i++) {
>> +                       devs[i] = genpd_dev_pm_attach_by_id(dev, i);
> 
> This API is supposed to be called only by the driver core. Please use
> dev_pm_domain_attach_by_id|name() instead.

thanks, will change.

regards,
Rajendra
> 
> [...]
> 
> Kind regards
> Uffe
> 
