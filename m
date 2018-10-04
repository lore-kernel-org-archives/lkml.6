Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtkCvvYI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jxsg4gUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJEBoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:44:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJEBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:44:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E6E960C6A; Thu,  4 Oct 2018 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538678985;
        bh=uOXFksYigTZ6g/WmDdTdwe33JIX+gima0wvwtIVL4ck=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KtkCvvYIabarWEwX6WlPxLfvBEObYlDnCZbwAu9fzkpN+K/AgbL/0RD5U91SPHRbm
         jKLjNaerpg0xSVQJPJhANRHxfkFSR8aZ9Wvk4LRNUrt9gvH44MeYeT6Yx5t+YuEiSJ
         atd75nE0jctclmEUXw4kngAPRSU6NuElQkVQON1I=
Received: from [192.168.0.3] (unknown [115.99.100.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D00160866;
        Thu,  4 Oct 2018 18:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538678984;
        bh=uOXFksYigTZ6g/WmDdTdwe33JIX+gima0wvwtIVL4ck=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Jxsg4gUIPin+ICkumOZ8EYBWTi8QbBHilVnbT0myeOTdyzjKDApLIGe3diX4uKJ6v
         i3ciQC1dKToaSfT1tG1AFAR3D92R8zaaRRtfJtFjauL7bDUICoq4kIdb//3tAZtgia
         NTk5ydo02eqSY3uAwW3+UpeHYfF0qswJlBy0ulWs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D00160866
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
To:     thor.thayer@linux.intel.com, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
 <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
Date:   Fri, 5 Oct 2018 00:19:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thor,


On 10/4/2018 3:58 AM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add a clock to the SMMU structure. In the device tree case,
> check for a clock node and enable the clock if found.
>
> This patch is dependent upon the following patches that add
> a device tree bulk clock function.
> "[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
> https://patchwork.kernel.org/patch/10583133/
> "[V6, 2/4] clk: add new APIs to operation on all available
> clocks"
> https://patchwork.kernel.org/patch/10583131/
> "[V6, 3/4] clk: add managerged version of clk_bulk_get_all"
> https://patchwork.kernel.org/patch/10583139/
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

The clock part is already handled by one of the patch in the
runtime pm series of arm-smmu [1]. This patch should not be needed.

[1] https://patchwork.kernel.org/patch/10581899/

[...]

Regards
Vivek
