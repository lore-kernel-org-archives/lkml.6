Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE590C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB40620878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB40620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeLCMa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:30:29 -0500
Received: from icp-osb-irony-out2.external.iinet.net.au ([203.59.1.155]:10084
        "EHLO icp-osb-irony-out2.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbeLCMa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:30:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ADAAA/IAVc/0KLqnwNVRoBAQEBAQI?=
 =?us-ascii?q?BAQEBBwIBAQEBgVIEAQEBAQsBhBKDeZRuAQEEBoEICCV8iCOJMIR5gXqEeQK?=
 =?us-ascii?q?DYzUIDQEDAQEBAQEBAoZSAQEBAyMVQRALDgoCAiYCAlcGDQYCAQGDHYF1pCB?=
 =?us-ascii?q?wgS+FQIRegQuLKHiBB4ERJwyCKjWIBYJXAo90kEwIAZE2HpEmLJoJAoIJMxo?=
 =?us-ascii?q?IKAiDJ5BtYItzAQE?=
X-IPAS-Result: =?us-ascii?q?A2ADAAA/IAVc/0KLqnwNVRoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?VIEAQEBAQsBhBKDeZRuAQEEBoEICCV8iCOJMIR5gXqEeQKDYzUIDQEDAQEBA?=
 =?us-ascii?q?QEBAoZSAQEBAyMVQRALDgoCAiYCAlcGDQYCAQGDHYF1pCBwgS+FQIRegQuLK?=
 =?us-ascii?q?HiBB4ERJwyCKjWIBYJXAo90kEwIAZE2HpEmLJoJAoIJMxoIKAiDJ5BtYItzA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.56,310,1539619200"; 
   d="scan'208";a="160635324"
Received: from 124-170-139-66.dyn.iinet.net.au (HELO [192.168.0.106]) ([124.170.139.66])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 03 Dec 2018 20:29:33 +0800
Subject: Re: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-4-phil.edworthy@renesas.com>
 <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
 <20181129163258.GA26511@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <0c51e641-7806-33b3-6c3e-d5ff44926a45@linux-m68k.org>
Date:   Mon, 3 Dec 2018 22:29:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129163258.GA26511@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 30/11/18 2:32 am, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 09:54:37PM +1000, Greg Ungerer wrote:
>> Hi Phil,
>>
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
> 
> Any chance we could just get coldfire moved over to the common clock
> framework?

Sure, I will have a look at it.

Regards
Greg


