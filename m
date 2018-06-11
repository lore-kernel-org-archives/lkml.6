Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DEXxFQOVHltdLwAAmS7hNA
	; Mon, 11 Jun 2018 15:28:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 557E3607BB; Mon, 11 Jun 2018 15:28:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C6F23601C3;
	Mon, 11 Jun 2018 15:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6F23601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeFKP2U convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 20 others);
        Mon, 11 Jun 2018 11:28:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52956 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754013AbeFKP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:28:18 -0400
Received: from marcel-macpro.fritz.box (p5B3D24B5.dip0.t-ipconnect.de [91.61.36.181])
        by mail.holtmann.org (Postfix) with ESMTPSA id F38EFCF186;
        Mon, 11 Jun 2018 17:34:58 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
Date: Mon, 11 Jun 2018 17:28:16 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com>
 <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
 <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

>> the commit message is misleading me. If I build something with ACPI or DT support, then modinfo will show all modalias information for ACPI and DT compatible strings. What else does udev/modprobe actually need? Is something broken with the modalias export?
> 
> The main purpose is to autoload drivers for devices that have been
> created via sysfs or another module.
> 
> Eg1: We have a serial port on a standard computer that has connected a
> GPS module. Since it is something that is not in the ACPI nor the DT
> table the user will run
> 
> echo serdev_gps > /sys/bus/serial/devices/serial0/new_device
> 
> Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846ebe5409589b8e1e3004f55a/drivers/tty/serdev/test_platform.c
> 
> Modprobe does not know what module to load for that device unless
> there is a matching MODULE_DEVICE_TABLE
> Today, we have the same functionality for i2c devices
> https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

but why does this have to be the driver name? I would rather say, create a generic string that describes the hardware and then use that. I think you also want the special handling, as from USB for example, that lets you reference an existing .compatible or ACPI ID as reference so that the driver_data is copied.

Regards

Marcel
