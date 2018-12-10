Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA44020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mmBj57+j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oUivxD/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA44020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLJKFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:05:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeLJKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:05:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E43860B26; Mon, 10 Dec 2018 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544436312;
        bh=ymAMOIgQl9604MpjIu6aSGAG5Uuu82yLW2SLuBReK1Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mmBj57+jVnZxVBO5UfsAGkuzYACrkq9rcXAblbeRLmPB+xG+6rYAxUMdFUlbh4ZEK
         FbhnJr6lrlFnNImI99MFk1aNE899f3lZP3NEhszgwnI7MjBk4LcDUdlcQhBdR6vPri
         o991vN5dxbLVJNxvMHA57HRpL9MHhAHzVcRcV0P4=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B650F60241;
        Mon, 10 Dec 2018 10:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544436311;
        bh=ymAMOIgQl9604MpjIu6aSGAG5Uuu82yLW2SLuBReK1Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oUivxD/7b0QL1WQtsoMhpdaD/nseS4/YOyijTV8ZY+d8L685iL/xY5SH/oUlyM4IE
         h1vAmO937e7gtUFwaGV6JjQCIHIpitNyATziDYFewZveWjZ/nxZB8uhJkWe20e42Oe
         tYFgfv0AR94WWuyhBgLNPUprwNksFtoGQ/kQOu/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B650F60241
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v2 2/5] ASoC: qcom: sdm845: Create and setup jack in init
 callback
To:     Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org
References: <20181128090037.257359-1-cychiang@chromium.org>
 <20181128090037.257359-2-cychiang@chromium.org>
 <20181206202156.GD3084@sirena.org.uk>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3a99d252-1648-c6e3-e7db-1df2e6d33801@codeaurora.org>
Date:   Mon, 10 Dec 2018 15:35:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206202156.GD3084@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,


On 12/7/2018 1:51 AM, Mark Brown wrote:
> On Wed, Nov 28, 2018 at 05:00:34PM +0800, Cheng-Yi Chiang wrote:
>> Add a callback for init ops on dai_link to create and setup jack.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> This looks like you're forwarding a patch from Rohit but shows you as
> the author?

This was co-authored by me and Cheng-Yi. However, change is already 
merged from v1 itself.

Thanks,
Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

