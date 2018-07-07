Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA5C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953D223E0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B953D223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeGGHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:21:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:1597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeGGHVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:21:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 00:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,319,1526367600"; 
   d="scan'208";a="53252645"
Received: from blu2-desk2.ccr.corp.intel.com (HELO [10.0.2.15]) ([10.239.13.1])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2018 00:21:24 -0700
Subject: Re: [PATCH 3/4] iommu/vt-d: Clean up pasid quirk for pre-production
 devices
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
 <1525410499-18632-4-git-send-email-baolu.lu@linux.intel.com>
 <153094688126.17577.10340360451966114779@cwilso3-mobl.ger.corp.intel.com>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Balestrieri, Francesco" <francesco.balestrieri@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5B4069F5.1020303@linux.intel.com>
Date:   Sat, 7 Jul 2018 15:21:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <153094688126.17577.10340360451966114779@cwilso3-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 07/07/2018 03:01 PM, Chris Wilson wrote:
> Quoting Lu Baolu (2018-05-04 06:08:18)
>> The pasid28 quirk is needed only for some pre-production devices.
>> Remove it to make the code concise.
> Every skylake mixing iommu and i915 is now inoperable on boot. Reads
> by the GPU from iommu map pages return zero, writes disappear into the
> void, no errors flagged.
>
> Please revert until the matter is resolved.

Yes. I also got reports about the i915 issue.

I will submit a revert patch as soon as possible.

I am sorry for the inconvenience.

Best regards,
Lu Baolu
