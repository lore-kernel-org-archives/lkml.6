Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3ADC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C322243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C322243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbeKMHOR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:14:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:17371 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeKMHOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:14:17 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSUXA0LOA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id J0aaaduACLJ3xGQ
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 12 Nov 2018 22:19:03 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via serdev/devicetree
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181112215812.18ebca35@aktux>
Date:   Mon, 12 Nov 2018 22:19:02 +0100
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
References: <20181110232034.17277-1-andreas@kemnade.info> <20181111024648.7rt7rlhaqihtqecv@earth.universe> <20181112215812.18ebca35@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 12.11.2018 um 21:59 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> Hi,
> 
> On Sun, 11 Nov 2018 03:46:48 +0100
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
> 
>> Hi,
>> 
>> On Sun, Nov 11, 2018 at 12:20:34AM +0100, Andreas Kemnade wrote:
>>> This is a first try to be able to use h4 devices specified in
>>> the devicetree, so you do not need to call hciattach and
>>> it can be automatically probed.
>>> 
>>> Of course, proper devicetree bindings documentation is
>>> missing. And also you would extend that by regulator/
>>> enable gpio settings.
>>> 
>>> But before proceeding further it should be checked if the
>>> general way of doing things is right.
>>> 
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---  
>> 
>> Patch looks good to me, just one note
>> 
> I found one thing myself:
> Shouldn't we have a generic compatible string like "generic-h4".
> ehci-platform.c has for example:
>        { .compatible = "generic-ehci", },

There might be differences in h4 compatible devices (e.g. default
baud rate) so that I would not bet there a "generic-h4" suffices
in the long run.

And, shouldn't there be a vendor prefix anyways?

I.e. something like "bluetooth,h4"? Because it seems to be defined in
https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=41266

On the other hand, with hci-ll protocol the compatible strings are chip variants.
Well, this seems to be required to decide which firmware to download.

So it boils down to if DT compatibility should be compatible to generic
functions or specific chips? AFAI see this is more or less random and
there seems to be no general rule.

Just some thoughts but no strong preference.

BR,
Nikolaus

