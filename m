Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C74FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10F920657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfANWMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:12:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:41020 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:12:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="291531361"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2019 14:12:48 -0800
Subject: Re: [PATCH v10 05/12] ARM: dts: aspeed: peci: Add PECI node
To:     Joel Stanley <joel@jms.id.au>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-6-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xf-54Q7s_z8J=ZBoYqiFuy7_QAvsDqgT2CO0LFOvx8tqg@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <8e3e2dd8-b1fc-7746-f7bb-d95676b20ba0@linux.intel.com>
Date:   Mon, 14 Jan 2019 14:12:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACPK8Xf-54Q7s_z8J=ZBoYqiFuy7_QAvsDqgT2CO0LFOvx8tqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 1/13/2019 9:45 PM, Joel Stanley wrote:
> Hi Jae,
> 
> On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit adds PECI bus/adapter node of AST24xx/AST25xx into
>> aspeed-g4 and aspeed-g5.
> 
> This looks good, aside from the alias.
> 
> It will go via my aspeed tree once the bindings are merged. Send them
> to linux-aspeed@lists.ozlabs.org at that time.
> 
> In the future I suggest leaving the changes to arch/arm/boot/dts until
> after the bindings and driver patches have landed. They will rarely go
> in before hand as the bindings need to be agreed on.
> 

I thought that it would be helpful if it shows an actual example in this
series because it is trying to add a new subsystem. In the future, I'll
submit a dts patch separately from bindings and drivers, but I'd like
to keep this dts changes in this series because it has been already
submitted. I'll CC linux-aspeed list from the next version. Thanks!

> 
>>                  serial3 = &uart4;
>>                  serial4 = &uart5;
>>                  serial5 = &vuart;
>> +               peci0 = &peci0;
> 
> I don't think this is necessary. Can you explain why you think you need it?
> 

You are right. This alias is not necessary at all. Will drop it.

Thanks,
Jae

> Cheers,
> 
> Joel
> 
