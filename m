Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DE08DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3FD208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3FD208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbeFNIx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:53:57 -0400
Received: from foss.arm.com ([217.140.101.70]:56836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754992AbeFNIxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0771F1529;
        Thu, 14 Jun 2018 01:53:51 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8AF3F318;
        Thu, 14 Jun 2018 01:53:48 -0700 (PDT)
Subject: Re: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
To:     Matt Sealey <Matt.Sealey@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>,
        John Horley <John.Horley@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
 <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
 <075b99a1-2a29-f6dc-e9f2-99f895c27d35@arm.com>
 <CANLsYkx9cjV-bWg7aLg-kJT7x7DtwTHdsYzzM8A3+cFFnu_mNg@mail.gmail.com>
 <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <5e013d65-9931-6b8d-ce7c-4333309d4ada@arm.com>
Date:   Thu, 14 Jun 2018 09:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB24121F0EEF8D7D643BC391A1EE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 22:07, Matt Sealey wrote:
> 
> 
>> -----Original Message-----
>> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>>
>>> So, if the suggestion is to use an existing property "unit", I am fine
>>> with it, if people agree to it.
>>
>> If we're going to have something sharply different than ACPI I prefer
>> Rob's idea.

No, the above comment is about using "unit" ( if it is a standard property
for specifying something specific to hardware) instead of "coresight,hwid".
I would prefer to stick to the DT graph bindings, because :

1) The connections are bi-directional => Well, not necessarily bi-directional
in terms of the data flow. But the connection information is critical. i.e,
we need information about both the end-points of a connection, which the DT
graph bindings solves.

All we are missing is a way for specifying the "hardware port" number and the
direction of flow. I don't see why do we need to create something new just for
these two properties for something that exists today and works reasonably well
for the usecase.

> 
> What are you trying to say about being sharply different than ACPI?

The proposed Coresight ACPI draft bindings are based on the ACPI Graph bindings
(just like the DT graph bindings and is compatible with it, in terms of the APIs.
i.e, fwnode_graph_* operations work for both ACPI and DT  alike).

So, what Mathieu, in turn means is, if we depart from the DT Graph bindings, which
I personally don't see any benefit in.

Suzuki
