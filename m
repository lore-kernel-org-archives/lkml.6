Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A87720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="k4uc/QEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfBDVtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:49:19 -0500
Received: from vern.gendns.com ([98.142.107.122]:55360 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbfBDVtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uds3FsX1OUygQ/WX9g1UoP7XiXV41z6tAWMhYI1MAsM=; b=k4uc/QEPyAftYu5BIVPoTDL12r
        8+8WE1cjX798x7kpxnH4DHsEe9DsCtm45NzeXsNRKad9zBtniMwHuxBGwtgAXSdVRpZsm+g3uNPod
        mBFt5HAI/baNZRXmOiPm9GPbtMgAbk5MfWg05dYKpcckQ8TPcNtyksnIsZtXaccz1UXTAjVGVg0A8
        aHEr7JxHi/DjZJK1gJEo6uk+XLGxOVcp46GwfuQQ6wtDaMiE/dEVWbHEO0GnBwTOpkhCMifiZlHlO
        c7EBIUpWO1w0FfHzWDybhz8xDcU5toz1SnXhGJt7KidpF7c9efXFIKuVxQyOt8QQqaJ1ARRQEjCtc
        CTzvwvLQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57336 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqm3f-0006ZE-BG; Mon, 04 Feb 2019 16:45:39 -0500
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
Date:   Mon, 4 Feb 2019 15:49:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series ports the davinci platform to using SPARSE_IRQ, cleans up
> the irqchip drivers and moves them over to drivers/irqchip.
> 

This has been on my todo list for years, but I've never had enough
time to figure it out. Nice to see it finally getting done!

Series tested on LEGO MINDSTORMS EV3 (da850-like). I can now use
IIO triggers without having to patch the kernel to add extra
interrupts.

Tested-by: David Lechner <david@lechnology.com>


