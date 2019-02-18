Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD05C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5321738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfBRJ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:28:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728342AbfBRJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:28:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99325AF56;
        Mon, 18 Feb 2019 09:28:18 +0000 (UTC)
Message-ID: <1550481432.11088.4.camel@suse.com>
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
From:   Oliver Neukum <oneukum@suse.com>
To:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 18 Feb 2019 10:17:12 +0100
In-Reply-To: <20190217175901.3986-1-pados@pados.hu>
References: <20190217175901.3986-1-pados@pados.hu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2019-02-17 at 18:59 +0100, Karoly Pados wrote:
> Current GPIO code in cp210x fails to take USB autosuspend into account,
> making it practically impossible to use GPIOs with autosuspend enabled
> without user configuration. Fix this like for ftdi_sio in a previous patch.
> Tested on a CP2102N.

Hi,

your patch is looking good to me, but I am afraid there are issues.
How do the GPIO lines on the device interact with USB reset and system
suspend?

	Regards
		Oliver

