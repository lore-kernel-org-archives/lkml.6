Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8828C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911EB21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfAXBBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:01:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAXBBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:01:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9A52100A50C2;
        Wed, 23 Jan 2019 17:00:59 -0800 (PST)
Date:   Wed, 23 Jan 2019 17:00:57 -0800 (PST)
Message-Id: <20190123.170057.1824955058543142908.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     antoine.tenart@bootlin.com, sd@queasysnail.net, andrew@lunn.ch,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 03/10] net: macsec: move some definitions in a
 dedicated header
From:   David Miller <davem@davemloft.net>
In-Reply-To: <955d1bdf-037e-ae26-a9da-8da2a51a7cbd@gmail.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
        <20190123155638.13852-4-antoine.tenart@bootlin.com>
        <955d1bdf-037e-ae26-a9da-8da2a51a7cbd@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Jan 2019 17:01:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 23 Jan 2019 12:11:37 -0800

> On 1/23/19 7:56 AM, Antoine Tenart wrote:
>> This patch moves some structure, type and identifier definitions into a
>> MACsec specific header. This patch does not modify how the MACsec code
>> is running and only move things around. This is a preparation for the
>> future MACsec hardware offloading support, which will re-use those
>> definitions outside macsec.c.
>> 
>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>> ---
>>  drivers/net/macsec.c | 164 +--------------------------------------
>>  include/net/macsec.h | 178 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 179 insertions(+), 163 deletions(-)
>>  create mode 100644 include/net/macsec.h
>> 
>> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
>> index 56e354305f76..c3a138dd4386 100644
>> --- a/drivers/net/macsec.c
>> +++ b/drivers/net/macsec.c
>> @@ -17,10 +17,9 @@
>>  #include <net/sock.h>
>>  #include <net/gro_cells.h>
>>  
>> +#include <net/macsec.h>
>>  #include <uapi/linux/if_macsec.h>
> 
> I would probably go with include/linux/if_macsec.h and have
> uapi/linux/if_macsec.h include that file directly. This would be
> consistent with other types of network interfaces: bridge, vlan etc.

Agreed.
