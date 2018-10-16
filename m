Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB339C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6968A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6968A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJPQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:54:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:8288 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeJPQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:54:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 02:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="241690524"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.44]) ([10.226.39.44])
  by orsmga004.jf.intel.com with ESMTP; 16 Oct 2018 02:05:17 -0700
Subject: Re: [PATCH 00/14] serial: langtiq: Add CCF suppport
To:     Paul Burton <paul.burton@mips.com>
Cc:     "yixin.zhu@linux.intel.com" <yixin.zhu@linux.intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "hauke.mehrtens@intel.com" <hauke.mehrtens@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
 <20181015215845.5t7bkyks6hsxqwsb@pburton-laptop>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <068a7f6b-7b42-fa7a-393c-37e3a7d1fa7d@linux.intel.com>
Date:   Tue, 16 Oct 2018 17:05:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181015215845.5t7bkyks6hsxqwsb@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2018 5:58 AM, Paul Burton wrote:
> Hi Songjun,
>
> On Mon, Sep 24, 2018 at 06:27:49PM +0800, Songjun Wu wrote:
>> This patch series is for adding common clock framework support
>> for langtiq serial driver, mainly includes:
> s/langtiq/lantiq/ ...
Thanks, it will be fixed.
>> 1) Add common clock framework support.
>> 2) Modify the dts file according to the DT conventions.
>> 3) Replace the platform dependent functions with kernel functions
>>
>> Songjun Wu (14):
>>    MIPS: dts: Change upper case to lower case
>>    MIPS: dts: Add aliases node for lantiq danube serial
>>    serial: lantiq: Get serial id from dts
>>    serial: lantiq: Change ltq_w32_mask to asc_update_bits
>>    MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
>>    serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
>>    serial: lantiq: Rename fpiclk to freqclk
>>    serial: lantiq: Replace clk_enable/clk_disable with clk generic API
>>    serial: lantiq: Add CCF support
>>    serial: lantiq: Reorder the head files
>>    include: Add lantiq.h in include/linux/
>>    serial: lantiq: Replace lantiq_soc.h with lantiq.h
>>    serial: lantiq: Change init_lqasc to static declaration
>>    dt-bindings: serial: lantiq: Add optional properties for CCF
> It appears that you only copied me on patches 1, 2 & 5. I've applied
> patch 1 to mips-next for 4.20, but I have no clue whether your other
> patches were deemed acceptable by serial or DT maintainers & I have no
> context for the changes being made, so I can neither apply nor ack
> patches 2 & 5. Please copy me on the whole series next time.
>
> Thanks,
>      Paul
Thanks.
I will resend the patches and cc all the patches to you.
