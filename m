Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53B120C0B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53B120C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeHTTrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:47:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:23954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeHTTrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:47:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 09:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="78463471"
Received: from tthayer-hp-z620-workstation.an.intel.com (HELO [10.122.105.144]) ([10.122.105.144])
  by fmsmga002.fm.intel.com with ESMTP; 20 Aug 2018 09:29:42 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH V3 0/4] clk: new APIs to handle all available clocks
To:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB421114F8AFAE56B6D7C2D1E480770@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <ed7573b6-b8bf-9625-7c8f-7ee47a7be106@linux.intel.com>
Date:   Mon, 20 Aug 2018 11:32:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4211368561A415B255782CBE803D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/16/2018 09:33 PM, A.s. Dong wrote:
> Hi Stephen,
> 
> Do you want me to resend this series for review?
> It seems have been pending for quite a long time.
> 
> Thor just pinged me for its status as he wants to use it.
> 
> Regards
> Dong Aisheng
> 
>> -----Original Message-----
>> From: A.s. Dong
>> Sent: Wednesday, June 20, 2018 10:54 AM
>> To: linux-clk@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; dl-
>> linux-imx <linux-imx@nxp.com>
>> Subject: RE: [PATCH V3 0/4] clk: new APIs to handle all available clocks
>>
>> Ping....
>>
>>> -----Original Message-----
>>> From: A.s. Dong
>>> Sent: Friday, May 25, 2018 6:37 PM
>>> To: linux-clk@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org;
>>> sboyd@kernel.org; mturquette@baylibre.com; shawnguo@kernel.org; dl-
>>> linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
>>> Subject: [PATCH V3 0/4] clk: new APIs to handle all available clocks
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
>>>   drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
>>>   include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
>>>   4 files changed, 180 insertions(+), 55 deletions(-)
>>>
>>> --
>>> 2.7.4
> 
> 

Nice patchset!

FWIW, I've tested patches 1-3 on Stratix10 SOCFPGA for a SMMU driver I'm 
working on.

Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
