Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91F0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8420848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D8420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJZAtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:49:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:8884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeJZAtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:49:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 09:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="244339326"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2018 09:16:01 -0700
Subject: Re: [PATCH v8 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
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
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-9-jae.hyun.yoo@linux.intel.com>
 <20181024105903.GB4939@dell>
 <db7570cb-8f63-b551-d119-c54270ce6139@linux.intel.com>
 <20181025053030.GD4939@dell>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <509c4c0e-eabb-2276-3ffd-3fc675801142@linux.intel.com>
Date:   Thu, 25 Oct 2018 09:16:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025053030.GD4939@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2018 10:30 PM, Lee Jones wrote:
> On Wed, 24 Oct 2018, Jae Hyun Yoo wrote:
>> On 10/24/2018 3:59 AM, Lee Jones wrote:
>>> On Tue, 18 Sep 2018, Jae Hyun Yoo wrote:
>>>
>>>> This commit adds PECI client MFD driver.
>>>>
>>
>> <snip>
> 
> [...]
> 
>>>> +bool peci_temp_need_update(struct temp_data *temp)
>>>> +{
>>>> +	if (temp->valid &&
>>>> +	    time_before(jiffies, temp->last_updated + UPDATE_INTERVAL))
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(peci_temp_need_update);
>>>> +
>>>> +void peci_temp_mark_updated(struct temp_data *temp)
>>>> +{
>>>> +	temp->valid = 1;
>>>> +	temp->last_updated = jiffies;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(peci_temp_mark_updated);
>>>
>>> These are probably better suited as inline functions to be placed in
>>> a header file.  No need to export them, since they only use their own
>>> data.
> 
> Also move them into the HWMON header file.
> 
> They have no business in MFD.
> 

Agreed. I'll move them into the HWMON header.

> [...]
> 
>>>> +int peci_client_rd_pkg_cfg_cmd(struct peci_mfd *priv, u8 mbx_idx,
>>>
>>> This is gobbledegook.  What's rd?  Read?
>>>
>>
>> Yes, the 'rd' means 'read'. I intended to keep command names as listed
>> in the PECI specification such as RdPkgConfig, WrPkgConfig and so on.
>> Should I change it to 'peci_client_read_package_config_command' ?
> 
> I looks/reads a lot nicer, don't you think?
> 

Okay. I'll change it too.

Thanks again for your review, Lee!

Jae

> [...]
> 
