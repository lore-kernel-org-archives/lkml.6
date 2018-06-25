Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F10C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6B25EEC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE6B25EEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeFYRP4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:15:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964790AbeFYRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:15:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFB4180D;
        Mon, 25 Jun 2018 10:15:49 -0700 (PDT)
Received: from [10.1.210.28] (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012673F5AD;
        Mon, 25 Jun 2018 10:15:46 -0700 (PDT)
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI support in common clock framework
To:     Stephen Boyd <sboyd@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
 <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
 <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
 <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <914341e7-ca94-054d-6127-522b745006b4@arm.com>
Date:   Mon, 25 Jun 2018 18:15:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/06/18 17:37, Stephen Boyd wrote:
> Quoting Rafael J. Wysocki (2018-06-16 08:50:18)
>> On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>>>
>>> Is this for clk_enable/disable? What about clk_set_rate() or
>>> clk_set_phase()? Is ACPI's AML taking care of that?
>>
>> That's for clk_enable/disable AFAICS.
>>
>> AML doesn't manage device performance states at all.
> 
> Alright. We may need to add a better way for device drivers to get
> handles to clk pointers on ACPI firmware so they can change frequencies
> or phase, etc. 

Is there any specific usecase/device needing this in the kernel ? SPI
slaves ?

> Right now it's all through clkdev and it looks to be
> mostly based on string matching of connection names instead of
> associating clks with devices.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Regards,
Sudeep
