Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66DCC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DF7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DF7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeK2XPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:15:33 -0500
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:11413
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbeK2XPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:15:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AEAABX1v9b/zXSMGcNWBoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgVIEAQEBAQsBgmmBKYN5lGwBAQEBAQEGgQgtfIgiiS2Ed4F?=
 =?us-ascii?q?6MIRJAoNTNQgNAQMBAQEBAQECgQmFSQEBAQMjFUEQCw0LAgImAgJXBgEMBgI?=
 =?us-ascii?q?BAYMdAYF0HKUjcIEvGoQTAYEShGgFgQuBc4kveIEHgREngjY1iAWCVwKPapA?=
 =?us-ascii?q?5CAGGfoouHol8A4cdLIhMhF+MPQOCCDMaCCgIgyeLHIVRYI4/AQE?=
X-IPAS-Result: =?us-ascii?q?A2AEAABX1v9b/zXSMGcNWBoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VIEAQEBAQsBgmmBKYN5lGwBAQEBAQEGgQgtfIgiiS2Ed4F6MIRJAoNTNQgNA?=
 =?us-ascii?q?QMBAQEBAQECgQmFSQEBAQMjFUEQCw0LAgImAgJXBgEMBgIBAYMdAYF0HKUjc?=
 =?us-ascii?q?IEvGoQTAYEShGgFgQuBc4kveIEHgREngjY1iAWCVwKPapA5CAGGfoouHol8A?=
 =?us-ascii?q?4cdLIhMhF+MPQOCCDMaCCgIgyeLHIVRYI4/AQE?=
X-IronPort-AV: E=Sophos;i="5.56,294,1539619200"; 
   d="scan'208";a="129484610"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 29 Nov 2018 20:10:21 +0800
Subject: Re: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-4-phil.edworthy@renesas.com>
 <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
 <TY1PR01MB1769821858C257F94E9470BAF5D20@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <c1fe6ac5-b1f0-b11b-68c8-6178eca55123@linux-m68k.org>
Date:   Thu, 29 Nov 2018 22:10:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB1769821858C257F94E9470BAF5D20@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On 29/11/18 10:02 pm, Phil Edworthy wrote:
> On 29 November 2018 11:55, Greg Ungerer wrote:
>> On 17/11/18 12:59 am, Phil Edworthy wrote:
>>> clk_get_optional() returns NULL if not found instead of -ENOENT,
>>> otherwise the behaviour is the same as clk_get().
>>>
>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>
>> Acked-by: Greg Ungerer <gerg@@linux-m68k.org>
>>
>> Looks good. Do you want me to take this in the m68knommu git tree?
>> Or is the whole series going through some other tree?
> This patch is no longer needed as I found a better way to implement this:
> [PATCH v8] clk: Add (devm_)clk_get_optional() functions
> https://patchwork.kernel.org/patch/10690437/
> 
> Apologies for any confusion,

No problem, I'll just drop it then.

Regards
Greg


>>> ---
>>>    arch/m68k/coldfire/clk.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c index
>>> 7bc666e482eb..b221cabc7f54 100644
>>> --- a/arch/m68k/coldfire/clk.c
>>> +++ b/arch/m68k/coldfire/clk.c
>>> @@ -87,6 +87,17 @@ struct clk *clk_get(struct device *dev, const char *id)
>>>    }
>>>    EXPORT_SYMBOL(clk_get);
>>>
>>> +struct clk *clk_get_optional(struct device *dev, const char *id) {
>>> +	struct clk *clk = clk_get(dev, id);
>>> +
>>> +	if (clk == ERR_PTR(-ENOENT))
>>> +		clk = NULL;
>>> +
>>> +	return clk;
>>> +}
>>> +EXPORT_SYMBOL(clk_get_optional);
>>> +
>>>    int clk_enable(struct clk *clk)
>>>    {
>>>    	unsigned long flags;
>>>
