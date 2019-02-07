Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98977C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100B2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBGVbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:31:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:55823 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGVbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:31:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 13:31:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="113234116"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Feb 2019 13:31:43 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 125605802E1;
        Thu,  7 Feb 2019 13:31:43 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables
 PASID.
To:     David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
 <20190207210936.GH103220@otc-nc-03>
 <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <cdb6fb16-157e-059e-44ee-515fb4aca9af@linux.intel.com>
Date:   Thu, 7 Feb 2019 13:30:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/7/19 1:15 PM, David Woodhouse wrote:
> On Thu, 2019-02-07 at 13:09 -0800, Raj, Ashok wrote:
>> You are right.. they are completely orthogonal. We just don't have
>> a way to handle the page-requests for request without PASID's.
>>
>> There are some of the vIOMMU work to pass the PRI to who owns
>> the device, and we can certainly relax it then. This is just to reflect
>> what support exists today. FWIW, even the native driver maybe be able
>> to resolve this if supported.
> As things stand, if a device makes a PRI request without a PASID, it'll
> get told that we didn't manage to bring the page in for it. Which is
> true.
>
> What's the actual problem being fixed by this patch?
Since the request is going to fail any way why go through the process of 
enabling it ? Once the functionality (PRI without PASID) is supported, 
then they can revert this patch. Just we are trying to expose whats 
currently supported clearly.
> Yes, we're going
> to want to hook up a way to pass the PRI to the right place... but why
> add *another* thing that's just going to have to be fixed, by reverting
> this patch?
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

