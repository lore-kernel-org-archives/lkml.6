Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC61AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8062098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8062098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeGJXl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:41:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:57312 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732409AbeGJXl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:41:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6ANdFwe014016;
        Tue, 10 Jul 2018 18:39:17 -0500
Message-ID: <f3085f807e19d9c5d36ef9cded2b3ee59e560899.camel@kernel.crashing.org>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, joel@jms.id.au,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se
Date:   Wed, 11 Jul 2018 09:39:15 +1000
In-Reply-To: <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
         <20180709224114.4h47enyt4tucqcou@ninjato>
         <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 12:52 -0500, Eddie James wrote:
> 
> On 07/09/2018 05:41 PM, Wolfram Sang wrote:
> > > +	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr >> 1);
> > 
> > I just noticed this and wonder: Don't you need the LSB of the address?
> > It is not the RW flag, this is encoded in msg->flags.
> 
> So, the hardware interprets the LSB as the RW flag. It wouldn't be 
> possible to have a device addressed with the LSB set on this I2C master.

What do you mean ? That doesn't sound right... 
> 
> > 
> > Also, no seperate handling for 10 bit addresses? Technically, 7-bit 0x50
> > is different on the wire from 10-bit 0x050. This is minor, though. There
> > are no 10-bit devices out there. Still, did you test 10-bit support?
> 
> Indeed, real 10-bit addresses require some additional manipulation of 
> this I2C master in order to work. We don't support it right now.
> 
> Thanks,
> Eddie
> 
> > 
> > Rest looks good.
> > 
