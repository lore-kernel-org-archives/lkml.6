Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349E52063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfANWyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:54:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:62626 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfANWyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:54:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="291540833"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2019 14:54:23 -0800
Subject: Re: [PATCH v10 09/12] Documentation: hwmon: Add documents for PECI
 hwmon client drivers
To:     Joel Stanley <joel@jms.id.au>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
 <20190107214136.5256-10-jae.hyun.yoo@linux.intel.com>
 <CACPK8XdK-VpV7y1UT81QUo7CXuUp=gjjnZmTbvLvRVERtv5fDA@mail.gmail.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <879f5254-2575-6a40-07ed-a80b2d944cb6@linux.intel.com>
Date:   Mon, 14 Jan 2019 14:54:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CACPK8XdK-VpV7y1UT81QUo7CXuUp=gjjnZmTbvLvRVERtv5fDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/2019 3:43 AM, Joel Stanley wrote:
> On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> This commit adds hwmon documents for PECI cputemp and dimmtemp drivers.
>>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 

Hi Joel,

Thank you so much for your careful review on this patch series. I'll
submit v11 soon to address your review comments.

Regards,
Jae
