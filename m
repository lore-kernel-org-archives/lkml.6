Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F00C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE6F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE6F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeKTFa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:30:29 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:13960 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeKTFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:30:29 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zowDCvpOU="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.4 DYNA|AUTH)
        with ESMTPSA id c01a4cuAJJ5NFE6
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 19 Nov 2018 20:05:23 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/5] gnss: sirf: add support for w2sg0004 + lna
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181119194414.1c7d6887@aktux>
Date:   Mon, 19 Nov 2018 20:05:23 +0100
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7506654C-2601-4252-BB30-0DE9AF692309@goldelico.com>
References: <20181118215801.12280-1-andreas@kemnade.info> <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com> <20181119194414.1c7d6887@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 19.11.2018 um 19:44 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> Hi,
> 
> On Mon, 19 Nov 2018 09:22:59 +0100
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
>> Hi,
>> 
>>> Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
>>> 
>>> Here is another chapter of the story to get gta04 gnss power
>>> management into the mainline kernel.
>>> There is a w2sg0004 without wakeup line in there, so power state
>>> can only be determined indirectly by looking at the serial data lines.
>>> Then there as also an lna which needs to be powered for real gps
>>> reception. That part needs probably more discussion, since it might
>>> be an idea to have it more generalized since it has nothing todo
>>> with the chip itself.  
>> 
>> On the other hand if we follow the "SoC is the spider in the net"
>> way of looking at DTS hierarchy, we have the uart as a child of the
>> SoC and the gnss receiver as a serdev child of the UART. The LNA
>> is even one step more distantly connected to the gnss. So it makes
>> sense to me to have it as a property/reference of the gnss chip's
>> DTS record which is a sibling of the compatible records. So the only
>> place where it can be reasonably processed is the driver.
>> 
> Or the lna is a child of the gnss receiver.

Well, this IMHO would assume the gnss receiver is a bus master...

> The whole thing
> should probably not be overdesigned, but it does not make sense that
> every gnss chip driver has some lna logic.
> Maybe the regulator should just be stored in the struct
> gnss_device and then drivers/gnss/core.c takes care.

Probably yes, but likely not difficult to refactor and generalize later
if users of other chips report a similar need. More important is to
get upstream support for the gta04 with this chip.

BR,
Nikolaus

