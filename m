Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AC724BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AC724BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbeF1MjF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:39:05 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:55238 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752207AbeF1MjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:39:03 -0400
Received: from [IPv6:2001:16b8:4699:cc00:6163:d7c:5db5:b655] (200116b84699cc0061630d7c5db5b655.dip.versatel-1u1.de [IPv6:2001:16b8:4699:cc00:6163:d7c:5db5:b655])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 317F028BFE0;
        Thu, 28 Jun 2018 12:35:48 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] power: ds2760_battery: add device tree glue
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
References: <20180628075540.1757-1-daniel@zonque.org>
 <20180628075540.1757-5-daniel@zonque.org>
 <20180628115246.6qqa3nwxwx2qpls6@earth.universe>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <cceb2363-9976-3f62-24f3-03022b0cdec5@zonque.org>
Date:   Thu, 28 Jun 2018 14:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628115246.6qqa3nwxwx2qpls6@earth.universe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 28, 2018 01:52 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 09:55:40AM +0200, Daniel Mack wrote:
>> The w1 slave device used by this driver now has a of_node in case it
>> was matched against a devicetree sub-node of the bus master. This can
>> now be passed down to the power supply core which will parse more
>> properties from the node, such as 'power-supplies'.
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
> 
> Thanks for the patch series. Having proper DT support is a nice
> addition. But instead of extending the platform device hack, please
> merge the w1 driver into ds2760_battery.c as it happened to the
> bq27000 driver already. The intermediate platform device is completly
> useless and only makes things more complicated.
> 
> Basically move all code from w1_ds2760.c into ds2760_battery.c,
> drop some EXPORT_SYMBOL and make functions static instead. Then
> move content from probe/remove function into add_slave/remove_slave
> callbacks and drop all platform device things.

Okay, yes, that makes sense. I never understood why there are multiple 
drivers for this.


Thanks,
Daniel

