Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A21C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487C120867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487C120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeICRJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:09:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbeICRJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E5F908010FDF;
        Mon,  3 Sep 2018 12:49:03 +0000 (UTC)
Received: from [10.36.116.60] (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CC22166BA1;
        Mon,  3 Sep 2018 12:48:59 +0000 (UTC)
Subject: Re: [RFC 09/13] iommu/smmuv3: Get prepared for nested stage support
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
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
 <012d4950-7a06-2d59-85a0-44d511ad893b@redhat.com>
 <e6de91f7-2410-b0dd-b118-674c32bae5e8@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a1c79d41-ad83-1883-dd80-c1153ccfd777@redhat.com>
Date:   Mon, 3 Sep 2018 14:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e6de91f7-2410-b0dd-b118-674c32bae5e8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 12:49:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 03 Sep 2018 12:49:04 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Philippe,

On 09/03/2018 02:29 PM, Jean-Philippe Brucker wrote:
> On 31/08/2018 15:11, Auger Eric wrote:
>> Yep this works with my setup but I was waiting for such kind of comments
>> to turn this prototype into something more "production level" ;-) Did
>> you send anything upstream, related to this branch?
> 
> No I didn't have time to clean it up yet, and don't know when I'll be
> able to send it out. With host SVA and virtio-iommu, I have enough
> patches in flight to keep me busy for a while :) But you can obviously
> pick patches from that branch if they help.

I understand ;-) I will update the uapi according to our last
discussions and I will look at your patches, especially smmu-v3 changes,
adding your Sob when relevant.

Thanks

Eric
> 
> Thanks,
> Jean
> 
