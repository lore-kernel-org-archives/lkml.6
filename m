Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078852148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeL0ELh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:11:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:56032 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbeL0ELg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:11:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 20:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,403,1539673200"; 
   d="scan'208";a="113511082"
Received: from wangdan1-mobl1.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.210.154])
  by orsmga003.jf.intel.com with ESMTP; 26 Dec 2018 20:11:33 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gcN1A-0004IK-H2; Thu, 27 Dec 2018 12:11:32 +0800
Date:   Thu, 27 Dec 2018 12:11:32 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Fan Du <fan.du@intel.com>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC][PATCH v2 01/21] e820: cheat PMEM as DRAM
Message-ID: <20181227041132.xxdnwtdajtm7ny4q@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.106676005@intel.com>
 <20181227034141.GD20878@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181227034141.GD20878@bombadil.infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 07:41:41PM -0800, Matthew Wilcox wrote:
>On Wed, Dec 26, 2018 at 09:14:47PM +0800, Fengguang Wu wrote:
>> From: Fan Du <fan.du@intel.com>
>>
>> This is a hack to enumerate PMEM as NUMA nodes.
>> It's necessary for current BIOS that don't yet fill ACPI HMAT table.
>>
>> WARNING: take care to backup. It is mutual exclusive with libnvdimm
>> subsystem and can destroy ndctl managed namespaces.
>
>Why depend on firmware to present this "correctly"?  It seems to me like
>less effort all around to have ndctl label some namespaces as being for
>this kind of use.

Dave Hansen may be more suitable to answer your question. He posted
patches to make PMEM NUMA node coexist with libnvdimm and ndctl:

[PATCH 0/9] Allow persistent memory to be used like normal RAM
https://lkml.org/lkml/2018/10/23/9

That depends on future BIOS. So we did this quick hack to test out
PMEM NUMA node for the existing BIOS.

Thanks,
Fengguang
