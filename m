Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB90C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeK2JjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:39:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:11652 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbeK2JjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:39:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 14:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,292,1539673200"; 
   d="scan'208";a="93727556"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.122.32.196]) ([10.122.32.196])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2018 14:36:09 -0800
Subject: Re: [PATCH i2c-next v9 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20181030210917.32711-2-jae.hyun.yoo@linux.intel.com>
 <20181128215458.GB1666@kunai>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <5dde6770-ce7a-720a-f1db-56d9ef044a99@linux.intel.com>
Date:   Wed, 28 Nov 2018 16:36:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181128215458.GB1666@kunai>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2018 3:54 PM, Wolfram Sang wrote:
> On Tue, Oct 30, 2018 at 02:09:12PM -0700, Jae Hyun Yoo wrote:
>> This commit adds 'bus-timeout-ms' and '#retries' properties as
>> common optional properties that can be used for setting 'timeout'
>> and 'retries' values of 'struct i2c_adapter'. With this patch, the
>> bus timeout value and the master transfer retries count can be set
>> through these properties at the registration time of an adapter.
>> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
>> on cdev at runtime too.
>>
>> These properties may not be supported by all drivers. However, if
>> a driver wants to support one of them, it should adapt the
>> bindings in this document.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Definately NACK on the #retries part. This is purely a configuration
> thing. Besides that it is kind of ancient cruft, too. I don't recommend
> it, at all.
> 
> On the timeout thing, I am still not fully convinced that this is a HW
> description. I said that before. But maybe I need to understand your
> problem case better.
> 

Okay, I got it. I'll leave those as configuration things. Will remove
this part in the next version.

Thanks for your comment.

Jae
