Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698421571
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6698421571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeI1UGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:06:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbeI1UGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4985EED1;
        Fri, 28 Sep 2018 06:42:57 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C983F5B7;
        Fri, 28 Sep 2018 06:42:55 -0700 (PDT)
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
To:     Will Deacon <will.deacon@arm.com>
Cc:     joro@8bytes.org, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
References: <cover.1537458163.git.robin.murphy@arm.com>
 <20180928133639.GF1577@brain-police>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c1bda944-6279-4393-1277-c9df18594ca0@arm.com>
Date:   Fri, 28 Sep 2018 14:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928133639.GF1577@brain-police>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 14:36, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:20PM +0100, Robin Murphy wrote:
>> Hopefully this is the last spin of the series - I've now dropped my light
>> touch and fixed up all the various prose text, plus implemented the proper
>> quirk support for short-descriptor because it's actually just a trivial
>> cut-and-paste job.
> 
> Did you manage to clarify how the lifetime of the domain/flush queue interacts
> with the periodic timer after the cookie has been freed?

Oh, yes - it turned out to be wrapped up in put_iova_domain() already 
(see free_iova_flush_queue()), so all looks good in that regard.

Robin.
