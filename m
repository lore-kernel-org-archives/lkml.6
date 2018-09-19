Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADDAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B00620877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeISUXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:23:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:62082 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbeISUXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:23:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 07:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="81693516"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.132]) ([10.122.105.132])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2018 07:44:54 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH V6 0/4] clk: new APIs to handle all available clocks
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
Date:   Wed, 19 Sep 2018 09:47:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/16/2018 08:24 AM, A.s. Dong wrote:
> Ping again
> 
>> -----Original Message-----
>> From: A.s. Dong
>> Sent: Thursday, September 6, 2018 11:23 AM
>> To: linux-clk@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
>> thor.thayer@linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
>> hdegoede@redhat.com
>> Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
>>
>> Gently ping...
>>
>>> -----Original Message-----
>>> From: A.s. Dong
>>> Sent: Friday, August 31, 2018 12:46 PM
>>> To: linux-clk@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org;
>>> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org;
>>> thor.thayer@linux.intel.com; dl-linux-imx <linux-imx@nxp.com>;
>>> hdegoede@redhat.com; A.s. Dong <aisheng.dong@nxp.com>
>>> Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
>>>
>>> This patch series is a continue of discussion from here,
>>> https://patchwork.kernel.org/patch/9986293/
>>> that some users may want to handle all available clocks from device
>>> tree without need to know the detailed clock information likes clock
>>> numbers and names. This is useful in writing some generic drivers to handle
>> clock part.
>>>
>>> Note:
>>> This patch series is tested on MX6Q SDB cpufreq driver with a minor
>>> change to switch to use clk_bulk_get_all.
>>> But patch 4 only test compiling. Hopefully someone could help test the
>>> function.
>>>
>>> v3->v4:
>>>   * improve 'devres->clks = *clks' according to Stephen's suggestion
>>> v2->v3:
>>>   * address all comments from Stephen
>>>   * fix build warnings on other architectures.
>>> v1->v2:
>>>   * add clk_bulk_{get|put}_all() which only supports DT platform
>>> currently
>>>   * remove _all variants and the wrapper struct clk_bulk
>>>   * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
>>>     proves they need it because they don't have a struct device pointer.
>>>
>>> Dong Aisheng (4):
>>>    clk: bulk: add of_clk_bulk_get()
>>>    clk: add new APIs to operate on all available clocks
>>>    clk: add managed version of clk_bulk_get_all
>>>    video: simplefb: switch to use clk_bulk API to simplify clock
>>>      operations
>>>
>>>   drivers/clk/clk-bulk.c         | 80
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   drivers/clk/clk-devres.c       | 24 +++++++++++++
>>>   drivers/video/fbdev/simplefb.c | 72 ++++++++++---------------------------
>>>   include/linux/clk.h            | 65
>>> +++++++++++++++++++++++++++++++++-
>>>   4 files changed, 186 insertions(+), 55 deletions(-)
>>>
>>> --
>>> 2.7.4
> 
Just checking on the status of this patch. The clock routines (patches 
1-3) are useful for one of my drivers but if they aren't accepted or 
will take a long time to be accepted, I'll need to refactor my driver.

Thanks,

Thor
