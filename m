Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E2A20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGXBr1Bk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGXBr1Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfALMd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:33:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfALMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:33:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D8BD5608C6; Sat, 12 Jan 2019 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547296437;
        bh=UP6SmaM4s/BZebnOzN4AAK5/EIXeewLol5TPNYVa6S4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGXBr1Bkx7S+yif7A+gns/7vHGW7wDMLBLraYlU47EiCe3Jau4L60dDp9lLUhMcBt
         qxnPrMhdrVBOmqql6I+ba+duJQZhcHMiMJfPxFoL/yGJu7Q67XOV3t8n8FE4B71jUr
         upHJy3i3UeBj0Dg2WwN8RVGV5jHpaGYTCQUfFKfI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 324C7601B4;
        Sat, 12 Jan 2019 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547296437;
        bh=UP6SmaM4s/BZebnOzN4AAK5/EIXeewLol5TPNYVa6S4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGXBr1Bkx7S+yif7A+gns/7vHGW7wDMLBLraYlU47EiCe3Jau4L60dDp9lLUhMcBt
         qxnPrMhdrVBOmqql6I+ba+duJQZhcHMiMJfPxFoL/yGJu7Q67XOV3t8n8FE4B71jUr
         upHJy3i3UeBj0Dg2WwN8RVGV5jHpaGYTCQUfFKfI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 12 Jan 2019 18:03:57 +0530
From:   saiprakash.ranjan@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] coresight: etm4x: Add support to enable ETMv4.2
In-Reply-To: <20190111185242.GB22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <4cb23e3bc414f3a1cac555d27b93e7e8cfeb68c9.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111185242.GB22691@xps15>
Message-ID: <2039d8fcb6c09efeeb5df3f373a4d6dd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> I think it would be better to simply mask out the minor version number 
> bits in
> function etm4_arch_supported().  That way we can add more intelligence 
> in there
> in the future if we have to and we don't have to touch the calling code 
> again.
> 

Thanks for the review. Yes it seems good, I will make this change in 
next version of the patch.

  - Sai
