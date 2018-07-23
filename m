Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA794ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E920874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884E920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbeGWXke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:40:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:48343 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388088AbeGWXke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:40:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 15:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="58866153"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.149]) ([10.7.153.149])
  by orsmga007.jf.intel.com with ESMTP; 23 Jul 2018 15:37:01 -0700
Subject: Re: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
 <c1abe3ec-fc26-d8b0-c769-e9295577ac05@infradead.org>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <98051293-6b30-af31-a5c6-56b0e1ac964a@linux.intel.com>
Date:   Mon, 23 Jul 2018 15:36:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c1abe3ec-fc26-d8b0-c769-e9295577ac05@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 7/23/2018 3:21 PM, Randy Dunlap wrote:
> On 07/23/2018 02:47 PM, Jae Hyun Yoo wrote:
>> This commit adds PECI client MFD driver.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: James Feist <james.feist@linux.intel.com>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
>> ---
>>   drivers/mfd/Kconfig                   |  14 ++
>>   drivers/mfd/Makefile                  |   1 +
>>   drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
>>   include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>>   4 files changed, 278 insertions(+)
>>   create mode 100644 drivers/mfd/intel-peci-client.c
>>   create mode 100644 include/linux/mfd/intel-peci-client.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index f3fa516011ec..e38b591479d4 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>>   	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>>   	  devices used in Intel Medfield platforms.
>>   
>> +config MFD_INTEL_PECI_CLIENT
>> +	bool "Intel PECI client"
>> +	depends on (PECI || COMPILE_TEST)
>> +	select MFD_CORE
>> +	help
>> +	  If you say yes to this option, support will be included for the
>> +	  multi-funtional Intel PECI (Platform Environment Control Interface)
> 
> 	  multi-functional
> 

Thanks for your pointing it out. Will fix it.

Thanks,

Jae

>> +	  client. PECI is a one-wire bus interface that provides a communication
>> +	  channel from PECI clients in Intel processors and chipset components
>> +	  to external monitoring or control devices.
>> +
>> +	  Additional drivers must be enabled in order to use the functionality
>> +	  of the device.
>> +
>>   config MFD_IPAQ_MICRO
>>   	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>>   	depends on SA1100_H3100 || SA1100_H3600
> 
> 
