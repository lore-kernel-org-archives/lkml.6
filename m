Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08720842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfBUIls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:41:48 -0500
Received: from mail.steuer-voss.de ([85.183.69.95]:46390 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfBUIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:41:47 -0500
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 689274CFC0; Thu, 21 Feb 2019 09:41:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 675994CFBD;
        Thu, 21 Feb 2019 09:41:44 +0100 (CET)
Date:   Thu, 21 Feb 2019 09:41:44 +0100 (CET)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
In-Reply-To: <8dc1a931-c9f7-a46a-42dc-fdcd2274343b@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1902210938420.18662@fox.voss.local>
References: <20190220110017.BFA344CE86@mail.steuer-voss.de> <20190220151138.12332-1-nv@vosn.de> <8dc1a931-c9f7-a46a-42dc-fdcd2274343b@roeck-us.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenther,

On Wed, 20 Feb 2019, Guenter Roeck wrote:
> On 2/20/19 7:11 AM, Nikolaus Voss wrote:
>> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> 
>> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
>> adapters, but the problem described with regmap-i2c not handling
>> SMBus block transfers (i.e. read and writes) correctly also exists
>> with writes.
>> 
>> As workaround, this patch adds a block write function the same way
>> 1a2f474d328f adds a block read function.
>> 
>> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately 
>> with plain-I2C adapters")
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery 
>> controllers")
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Note that tps6598x_exec_cmd() is only called with in_len == out_len == 0
> and NULL data pointers.

That's probably why I didn't notice I missed patching tps6598x_exec_cmd() 
in spite of running and testing the driver for half a year ;-).

Thanks,
Nikolaus
