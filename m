Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D829EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964082083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964082083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeHaR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:28:21 -0400
Received: from foss.arm.com ([217.140.101.70]:57996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeHaR2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:28:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8304E7A9;
        Fri, 31 Aug 2018 06:20:53 -0700 (PDT)
Received: from [10.4.13.35] (ostrya.emea.arm.com [10.4.13.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCABD3F5BC;
        Fri, 31 Aug 2018 06:20:50 -0700 (PDT)
Subject: Re: [RFC 09/13] iommu/smmuv3: Get prepared for nested stage support
To:     Eric Auger <eric.auger@redhat.com>, "\"eric.auger.pro"@gmail.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
        jacob.jun.pan@linux.intel.com, "yi.l.liu\""@linux.intel.com,
        will.deacon@arm.com, robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-10-git-send-email-eric.auger@redhat.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <538a2b88-dec5-a6fa-d918-486284eb56a9@arm.com>
Date:   Fri, 31 Aug 2018 14:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535026656-8450-10-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 13:17, Eric Auger wrote:
>  	if (ste->s1_cfg) {
> -		BUG_ON(ste_live);

Scary! :) The current code assumes that it can make modifications to the
STE in any order and enable translation after a sync. So far I haven't
been able to find anything that violates this rule in the spec: "If
software modifies the structure while it is valid, it must not allow the
structure to enter an invalid intermediate state." So maybe it's fine,
though to be safe I would have started with disabling the STE
(http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=936e49f923e101c061269eadd5fa43fef819d2e9)

Thanks,
Jean
