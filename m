Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FAD214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FAD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeIZT6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:58:08 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46209 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeIZT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:58:08 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B67F224000E;
        Wed, 26 Sep 2018 13:45:03 +0000 (UTC)
Message-ID: <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
From:   Bastien Nocera <hadess@hadess.net>
To:     Dollinger Florian <dollinger.florian@gmx.de>,
        andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input-owner@kernel.org,
        linux-input@vger.kernel.org
Date:   Wed, 26 Sep 2018 15:45:02 +0200
In-Reply-To: <20180926125130.974-1-dollinger.florian@gmx.de>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
         <20180926125130.974-1-dollinger.florian@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Florian,

On Wed, 2018-09-26 at 14:51 +0200, Dollinger Florian wrote:
> From: Florian Dollinger <dollinger.florian@gmx.de>
> 
> Hi there! Why do you re-engineer the wheel? :) There is already a
> fully functional and tested driver out there (
> https://github.com/atar-axis/xpadneo). Would be much easier to help
> me (the owner of xpadneo) to push it into the kernel.

Probably because he didn't know about it, and how would he? I also
didn't know about it, because it didn't exist last I worked on those
joypads.

I spent quite a bit of time trying to get the XBox One S controller
working over Bluetooth, without success, and I see that you have a
patch for that which you didn't send upstream either:
https://github.com/atar-axis/xpadneo/blob/master/misc/kernel_patches/0001-fix_bluetooth_reconnect.patch

I can imagine that a large portion of the driver can be integrated in
the existing XBox pad driver, with each feature added in individual
patches.

If I get the time, there are good chances I will send a patch to
integrate the battery reporting in the existing driver at least, and
then add support for missing buttons if there's a problem there (I see
that mentioned in the README).

"Trigger Force Feedback" is likely something that would need to be
integrated at a lower level, this is probably not something we'd want
to have replicated in each driver.

Cheers

