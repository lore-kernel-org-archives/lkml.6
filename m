Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A9C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F008214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QDY/jDYX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QDY/jDYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F008214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJJAjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:39:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJAje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:39:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A877605A2; Tue,  9 Oct 2018 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539105695;
        bh=9qYDaUtlne1qg7maX7qv+Ed4E9xf9DlIvl37anUnnBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QDY/jDYXx4TAhglMvAlY2yS/SLVCdZnZwz+MaIF5vR8HNrdz9Qw1j0p1sIpL3e6NL
         IVPlHg9PO30aZSE7i+uaIkWWBhX9bPmxDJlqmn67u9PLjferPXdwoxy+kKIQ+eiVO8
         t5Ht59lTYJfm57ux95Gahd+xsb1Ts8xxm1103HCw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 09CE3605A2;
        Tue,  9 Oct 2018 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539105695;
        bh=9qYDaUtlne1qg7maX7qv+Ed4E9xf9DlIvl37anUnnBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QDY/jDYXx4TAhglMvAlY2yS/SLVCdZnZwz+MaIF5vR8HNrdz9Qw1j0p1sIpL3e6NL
         IVPlHg9PO30aZSE7i+uaIkWWBhX9bPmxDJlqmn67u9PLjferPXdwoxy+kKIQ+eiVO8
         t5Ht59lTYJfm57ux95Gahd+xsb1Ts8xxm1103HCw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Oct 2018 22:51:35 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-pil: add SCM probe dependency
In-Reply-To: <20181009170232.GA86621@ban.mtv.corp.google.com>
References: <20181009020805.143982-1-briannorris@chromium.org>
 <20181009062125.GA2518@tuxbook-pro>
 <20181009170232.GA86621@ban.mtv.corp.google.com>
Message-ID: <68bfe0ebe76c7a071f3c2c53a88a6508@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-10-09 22:32, Brian Norris wrote:
> On Mon, Oct 08, 2018 at 11:21:25PM -0700, Bjorn Andersson wrote:
>> On Mon 08 Oct 19:08 PDT 2018, Brian Norris wrote:
>> 
>> > Similar to qcom_q6v5_pas and qcom_wcnss drivers, probe will fail if SCM
>> > is not up.
>> >
>> 
>> Thanks Brian, this dependency was introduced with the memory ownership
>> support.
> 
> That's a good point. I'm actually not that familiar with this 
> particular
> driver--I was just trying to resolve an OOPS I saw while bringing this
> driver up--but that does look correct.
> 
>> I applied it with an updated conditional to make it explicit that it
>> related to need_mem_protection, updated the commit message to describe
>> actual relationship to the memory protection mechanism and added a
>> Fixes: tag.
> 
> Your version looks good, thanks.
> 
>> Don't we also need to add the ability to disable need_mem_protection
>> when we're running ATF?
> 
> I'm not sure exactly, but FWIW I'm running some form of ATF on SDM845
> and I'm running with 'needs_memory_protection' (hence, this patch).
> 

AFAIK ATF will eventually support the hyp assign calls even though they
are just stubs as of now.

> Regards,
> Brian

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
