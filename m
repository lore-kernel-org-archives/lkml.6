Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B982173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAGQCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:02:01 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40895 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfAGQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:02:00 -0500
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C1B6F240005;
        Mon,  7 Jan 2019 16:01:57 +0000 (UTC)
Message-ID: <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
From:   Bastien Nocera <hadess@hadess.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Jan 2019 17:01:56 +0100
In-Reply-To: <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
         <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
         <20190105225147.le5fgpnvq7sctxe5@penguin>
         <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 16:56 +0100, Bastien Nocera wrote:
> Given that we do have access to the datasheet, it would also be
> useful
> for the patch to mention where in the datasheet it says that the
> reset
> line can be left pulled-up, or mention on which shipping device this
> setup is already used (and if so, what the DTS or ACPI snippet that
> declares those is).

Or alternatively, and as Andreas pointed out in another thread, find
the code in the vendor driver that does support this setup:
https://github.com/goodix/gt9xx_driver_android
https://github.com/goodix/goodix_gt9xx_public

If it doesn't work with the vendor code, then we might not want to make
it work with our driver either.

Cheers

