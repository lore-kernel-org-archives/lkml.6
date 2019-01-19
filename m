Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACEC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17A42086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfASTvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:51:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:46834 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfASTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:51:03 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5E5CDCF340;
        Sat, 19 Jan 2019 20:58:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 1/5] usb: split code locating ACPI companion into port
 and device
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118223407.64818-1-rajatja@google.com>
Date:   Sat, 19 Jan 2019 20:51:00 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        rajatxjain@gmail.com, dtor@google.com,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <C103ADA0-68A0-4571-AE47-1744E64E0D7E@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190118223407.64818-1-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> In preparation for handling embedded USB devices let's split
> usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> usb_acpi_find_companion_for_port().
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> ---
> v4: Add Acked-by and Tested-by in signatures.
> v3: same as v1
> v2: same as v1
> 
> drivers/usb/core/usb-acpi.c | 133 +++++++++++++++++++-----------------
> 1 file changed, 72 insertions(+), 61 deletions(-)

what is the plan here? I take this via bluetooth-next tree?

Regards

Marcel

