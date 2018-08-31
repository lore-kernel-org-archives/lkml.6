Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497C9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7222083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7222083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeHaSTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:19:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbeHaSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:19:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A24940201BD;
        Fri, 31 Aug 2018 14:11:44 +0000 (UTC)
Received: from [10.36.116.26] (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C76AC49B0D;
        Fri, 31 Aug 2018 14:11:38 +0000 (UTC)
Subject: Re: [RFC 09/13] iommu/smmuv3: Get prepared for nested stage support
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "\"eric.auger.pro"@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
        alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        "yi.l.liu\""@linux.intel.com, will.deacon@arm.com,
        robin.murphy@arm.com
Cc:     marc.zyngier@arm.com, peter.maydell@linaro.org,
        christoffer.dall@arm.com
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-10-git-send-email-eric.auger@redhat.com>
 <538a2b88-dec5-a6fa-d918-486284eb56a9@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <012d4950-7a06-2d59-85a0-44d511ad893b@redhat.com>
Date:   Fri, 31 Aug 2018 16:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <538a2b88-dec5-a6fa-d918-486284eb56a9@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 14:11:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 14:11:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On 08/31/2018 03:20 PM, Jean-Philippe Brucker wrote:
> On 23/08/18 13:17, Eric Auger wrote:
>>  	if (ste->s1_cfg) {
>> -		BUG_ON(ste_live);
> 
> Scary! :) The current code assumes that it can make modifications to the
> STE in any order and enable translation after a sync. So far I haven't
> been able to find anything that violates this rule in the spec: "If
> software modifies the structure while it is valid, it must not allow the
> structure to enter an invalid intermediate state." So maybe it's fine,
> though to be safe I would have started with disabling the STE
> (http://www.linux-arm.org/git?p=linux-jpb.git;a=commitdiff;h=936e49f923e101c061269eadd5fa43fef819d2e9)

Yep this works with my setup but I was waiting for such kind of comments
to turn this prototype into something more "production level" ;-) Did
you send anything upstream, related to this branch?

Thanks

Eric
> 
> Thanks,
> Jean
> 
