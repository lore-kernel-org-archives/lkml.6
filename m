Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980B02170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LwdBT7AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980B02170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI1EtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:49:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27551 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1EtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538087330; x=1569623330;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QXGBpjou41IlEYutkrf87r4e6Z+A+gmWSTaqlxwJQsU=;
  b=LwdBT7AGl+KUDMtVx3ZsFNkotHqxf9W33nrp4YkJPexq/WrsiMceVRG5
   ngjulRKb2NH/OR3ftqpm6cOxsXa/Cdp0JD2eLCqQYEIJxYeR+MglgrsVU
   HVNXfwIk8S5ixxLavGR9beAi2Bws9fS56cWtD3z4zu2P++fDFtqd6VPKa
   TVHB8YN4wC7sSMwlG1nr9RlFP+c9J26xo2Gr0Fj8Qca8Vm4YC728iEPNR
   j4DfGvNwXktDX1ZNPULEypdexkvd8M5sTkdXjPdO9I9x/5ItHfspbXiSD
   E3XNxFbzkV4HjsSIYeJQmPBhH2oVnI9xQyRpoyIf9sisVBXoaOJd8RfYH
   A==;
X-IronPort-AV: E=Sophos;i="5.54,312,1534780800"; 
   d="scan'208";a="91821599"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2018 06:28:50 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Sep 2018 15:14:39 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2018 15:28:50 -0700
Subject: Re: [PATCH v2] RISC-V: Show CPU ID and Hart ID separately in
 /proc/cpuinfo
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20180923133737.22693-1-anup@brainfault.org>
 <a7c64e1a-405e-6a2c-cb42-211c4f89367d@wdc.com>
 <CAAhSdy2ZOXk3fDt8W_G1=h_OrifFsXP3XwZ2xnXwt9ztzW4GEg@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <d0c811f0-02f0-3503-fb03-4a07ebdfb477@wdc.com>
Date:   Thu, 27 Sep 2018 15:28:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2ZOXk3fDt8W_G1=h_OrifFsXP3XwZ2xnXwt9ztzW4GEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 9:17 PM, Anup Patel wrote:
> On Tue, Sep 25, 2018 at 11:29 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> On 9/23/18 6:37 AM, Anup Patel wrote:
>>> Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
>>> is in-correct. This patch shows CPU ID and Hart ID separately
>>> in /proc/cpuinfo using cpuid_to_hardid_map().
>>>
>> I noticed it should be cpuid_to_hartid_map instead of
>> cpuid_to_hardid_map. It was a typo in my smp cleanup patch series.
>> Sorry for the inconvenience here.
> 
> Thanks for pointing.
> 
>>
>> I can include this patch in into my series fixing the typo if you want.
> 
> Yes, please.
> 

Great.

> You can also include "RISC-V: Show IPI stats" patch in your series.
> This patch was reviewed by Christoph.
> 

I already had that included as a part of v5.

Regards,
Atish
> Thanks,
> Anup
> 

