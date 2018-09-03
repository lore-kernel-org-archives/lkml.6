Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC70C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AD720867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AD720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeICQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:39:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeICQjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:39:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BC7318A;
        Mon,  3 Sep 2018 05:19:46 -0700 (PDT)
Received: from [10.4.13.76] (ostrya.emea.arm.com [10.4.13.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208783F614;
        Mon,  3 Sep 2018 05:19:43 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 01/13] iommu: Introduce bind_guest_stage API
To:     Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@linux.intel.com, will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
 <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
 <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
Message-ID: <58418b7b-44f4-9659-98df-b5f24bed3e15@arm.com>
Date:   Mon, 3 Sep 2018 13:19:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2018 14:52, Auger Eric wrote:
> Do we agree here we can get rid of the struct device * parameter?

That's fine by me, in my opinion the bind operation should only be on
the domain, like map/unmap. For the invalidation however, I think we
need to keep the device as an optional parameter, because the guest may
want to invalidate the ATC (DTLB) of a single device.

Thanks,
Jean
