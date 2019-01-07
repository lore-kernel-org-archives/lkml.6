Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D531C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB4A20854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAGJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:57:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:15279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfAGJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:57:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 01:57:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,450,1539673200"; 
   d="scan'208";a="116051963"
Received: from tiwuxiex-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.147])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2019 01:57:54 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ggRfN-00076b-8P; Mon, 07 Jan 2019 17:57:53 +0800
Date:   Mon, 7 Jan 2019 17:57:53 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [RFC][PATCH v2 10/21] mm: build separate zonelist for PMEM and
 DRAM node
Message-ID: <20190107095753.7feee5fxjja5lt75@wfg-t540p.sh.intel.com>
References: <20181226131446.330864849@intel.com>
 <20181226133351.644607371@intel.com>
 <87sgyc7n9a.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87sgyc7n9a.fsf@linux.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 02:44:41PM +0530, Aneesh Kumar K.V wrote:
>Fengguang Wu <fengguang.wu@intel.com> writes:
>
>> From: Fan Du <fan.du@intel.com>
>>
>> When allocate page, DRAM and PMEM node should better not fall back to
>> each other. This allows migration code to explicitly control which type
>> of node to allocate pages from.
>>
>> With this patch, PMEM NUMA node can only be used in 2 ways:
>> - migrate in and out
>> - numactl
>
>Can we achieve this using nodemask? That way we don't tag nodes with
>different properties such as DRAM/PMEM. We can then give the
>flexibilility to the device init code to add the new memory nodes to
>the right nodemask

Aneesh, in patch 2 we did create nodemask numa_nodes_pmem and
numa_nodes_dram. What's your supposed way of "using nodemask"?

Thanks,
Fengguang
