Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D591224F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D591224F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbeGFRiE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:38:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:56201 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbeGFRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:38:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 10:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,317,1526367600"; 
   d="scan'208";a="55650576"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2018 10:38:02 -0700
Subject: Re: [PATCH linux-next v6 03/13] peci: Add support for PECI bus driver
 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jason M Biils <jason.m.bills@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Peter Rosin <peda@axentia.se>,
        David Kershner <david.kershner@unisys.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Fengguang Wu <fengguang.wu@intel.com>,
        Alan Cox <alan@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Julia Cartwright <juliac@eso.teric.us>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194014.20729-1-jae.hyun.yoo@linux.intel.com>
 <20180706070332.GV496@dell>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <926ac149-5ff4-a345-0e0e-95f3f994e353@linux.intel.com>
Date:   Fri, 6 Jul 2018 10:38:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180706070332.GV496@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2018 12:03 AM, Lee Jones wrote:
> On Thu, 21 Jun 2018, Jae Hyun Yoo wrote:
> 
>> This commit adds driver implementation for PECI bus core into linux
>> driver framework.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Julia Cartwright <juliac@eso.teric.us>
>> ---
>>   drivers/Kconfig                 |    2 +
>>   drivers/Makefile                |    1 +
>>   drivers/peci/Kconfig            |   12 +
>>   drivers/peci/Makefile           |    6 +
>>   drivers/peci/peci-core.c        | 1438 +++++++++++++++++++++++++++++++
>>   include/linux/peci.h            |  104 +++
>>   include/uapi/linux/peci-ioctl.h |  265 ++++++
>>   7 files changed, 1828 insertions(+)
>>   create mode 100644 drivers/peci/Kconfig
>>   create mode 100644 drivers/peci/Makefile
>>   create mode 100644 drivers/peci/peci-core.c
>>   create mode 100644 include/linux/peci.h
>>   create mode 100644 include/uapi/linux/peci-ioctl.h
> 
> I'm struggling to see the justification for adding an entirely new
> subsystem for what looks like a bespoke, and perhaps more damning,
> *proprietary* 1-wire interface.  Especially one which has such
> limited use.  Between yourself and the other silicon chip vendors
> there must be 100s of these knocking about.  What makes this one
> special?  Or even useful?  Will there ever be more than a single
> source file in this directory?
> 
> Don't get me wrong, I'm all for upstreaming code, but to create a new
> subsystem and bus for this kind of device seems very over the top.
> 
> Since PECI's main purpose in life is Thermal Management, perhaps the
> whole thing should live in drivers/thermal or drivers/hwmon.  I've
> also seen you reference this as a kind of BMC too, so maybe
> drivers/platform/x86 would also be a nice place for it to reside.
> 

I think, I already discussed about it with other reviewers but I have to
explain it again. Yes, PECI is yet not a popular interface but plays a
vital role in BMC system, so most of BMC chip vendors provide PECI
interface in their BMC chipsets, and it is the reason why the PECI
subsystem is added by this implementation because we should provide a
generic bus system for those BMC chipsets from multiple vendors so
that they can add their chip set specific driver to support that through
the generic interface. At this moment, the folder has only PECI core and
ASPEED PECI adapter drivers but other vendors' (i.e. Nuvoton) driver
could be added into the folder.

As you said, PECI's main purpose is Thermal Management but it's not
limited on that. As I already said in another thread and the cover
letter, PECI also can provide other sideband functions such as Platform
Manageability, Processor Tuning and Diagnostics and Failure Analysis.

AFAIK, only ARM core based BMC chipsets are rolled out so this
PECI implementation will be running on an ARM kernel at this moment.
It's not an x86 limited implementation.

Thanks,

Jae
