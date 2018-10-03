Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17722098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17722098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeJDAAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:00:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:28201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeJDAAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:00:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 10:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="238212232"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2018 10:10:24 -0700
Subject: Re: [PATCH i2c-next v4 2/3] i2c: aspeed: Add 'timeout' DT property
 reading code
To:     Joel Stanley <joel@jms.id.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
 <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <9951c217-70c1-81cf-a43d-baf6bb02beb9@linux.intel.com>
Date:   Wed, 3 Oct 2018 10:10:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 10/3/2018 12:49 AM, Joel Stanley wrote:
> Hello Jae,
> 
> On Mon, 1 Oct 2018 at 22:28, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> @@ -918,6 +919,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>>                  bus->bus_frequency = 100000;
>>          }
>>
>> +       ret = of_property_read_u32(pdev->dev.of_node, "timeout",
>> +                                  &timeout_ms);
>> +       if (ret)
>> +               timeout_ms = 0; /* then adap.timeout will be set by i2c-core */
> 
> Is it possible to implement the parsing of this property in the i2c
> core instead?
> 

Yes, that's possible but I'm not sure that could be acceptable or not.
Let me try.

Thanks,
Jae
