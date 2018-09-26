Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C63C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774E72150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774E72150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeI0AVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:21:17 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51996 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0AVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:21:17 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 825E43A45D5;
        Wed, 26 Sep 2018 19:43:31 +0200 (CEST)
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DC79F240004;
        Wed, 26 Sep 2018 17:43:28 +0000 (UTC)
Message-ID: <b455a236b677c03f623ddbd5c28e602def439bc9.camel@hadess.net>
Subject: XBox One S controller, Bluetooth support (was Re: hid: microsoft:
 Add rumble support for Xbox One S controller)
From:   Bastien Nocera <hadess@hadess.net>
To:     Dollinger Florian <dollinger.florian@gmx.de>,
        andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-input@vger.kernel.org
Date:   Wed, 26 Sep 2018 19:43:28 +0200
In-Reply-To: <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
         <20180926125130.974-1-dollinger.florian@gmx.de>
         <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend to the correct Bluetooth list, sorry for the dupes)

On Wed, 2018-09-26 at 15:45 +0200, Bastien Nocera wrote:
> Hey Florian,
> 
> On Wed, 2018-09-26 at 14:51 +0200, Dollinger Florian wrote:
> > From: Florian Dollinger <dollinger.florian@gmx.de>
> > 
> > Hi there! Why do you re-engineer the wheel? :) There is already a
> > fully functional and tested driver out there (
> > https://github.com/atar-axis/xpadneo). Would be much easier to help
> > me (the owner of xpadneo) to push it into the kernel.
> 
> Probably because he didn't know about it, and how would he? I also
> didn't know about it, because it didn't exist last I worked on those
> joypads.
> 
> I spent quite a bit of time trying to get the XBox One S controller
> working over Bluetooth, without success, and I see that you have a
> patch for that which you didn't send upstream either:
> 
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

For this patch, after speaking with the Bluetooth maintainers, we would
need to:
- add relevant btmon outputs before and after the patch in the commit
message
- remove the mention of "many devices" (if you've seen other devices
with that problem in the wild, please mention them, otherwise mention
that it's for "XBox One S" controllers, and clones)
- run the patch against the "Profile Tuning Suite Tool" from the
Bluetooth SIG. This requires a Windows laptop, and a piece of hardware
from the Bluetooth SIG, see below.

The first 2 should be pretty easy to do, just send your patch using
"git send-email" to the linux-bluetooth list (CC:ed), with the data
attached.

For the qualification test, I was told Szymon has a test suite that he
could use to double-check the tests. If not, I should be able to buy
the adapter and run that test suite locally.

Cheers


