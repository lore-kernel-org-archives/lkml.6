Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E2BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811E2208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qff1LNlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811E2208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbeHAJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387647AbeHAJo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:44:59 -0400
Received: from [172.20.7.115] (unknown [209.119.211.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA5F20841;
        Wed,  1 Aug 2018 08:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533110433;
        bh=D95V/XUHIA4QiJdI7PpDddAwXb39A6952OncwSruPcU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qff1LNlS8PMPFw/LlrSG97Q3C6qo0HWPcw2H33/vw22E0N4HQw89tHg79UEZ4BnRc
         O17iJ0/iiKAt9okFtX4cYFvhgIK+p7yKwkokvLoOw3bgJ3bDLwdWw7Mqu6JQx09Etp
         5Jkw3Pp3/yBYuPjGcRwTvbo1ghRB+rP0UmiIPsac=
Subject: Re: [PATCH] ia64: fix barrier placement for write* / dma mapping
To:     Christoph Hellwig <hch@lst.de>, okaya@codeaurora.org
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20180731172031.4447-1-hch@lst.de>
 <20180731172031.4447-2-hch@lst.de>
 <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
 <20180801072947.GD20224@lst.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <6ac80566-be1b-3dfc-e6b7-3c38131673ef@kernel.org>
Date:   Wed, 1 Aug 2018 01:00:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801072947.GD20224@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2018 12:29 AM, Christoph Hellwig wrote:
>> I asked this question to Tony Luck before. If I remember right,
>> his answer was:
>>
>> CPU guarantees outstanding writes to be flushed when a register write
>> instruction is executed and an additional barrier instruction is not
>> needed.
> That would be great.  It still doesn't explain the barriers in the
> dma sync routines.  Those have been there since the following commit
> in the history tree:

Yeah, I'll let Tony confirm my understanding.
