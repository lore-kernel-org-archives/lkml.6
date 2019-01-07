Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A7B218AD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfAGNsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:48:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:48910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727943AbfAGNs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:48:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00337AE5F;
        Mon,  7 Jan 2019 13:48:27 +0000 (UTC)
Message-ID: <1546868906.3037.37.camel@suse.com>
Subject: Re: [PATCH RFC 4/5] usb: cdc-acm: Enable serdev support
From:   Oliver Neukum <oneukum@suse.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 07 Jan 2019 14:48:26 +0100
In-Reply-To: <20190104112131.14451-5-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
         <20190104112131.14451-5-afaerber@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-01-04 at 12:21 +0100, Andreas Färber  wrote:
> Switch from tty_port_register_device() to tty_port_register_device_serdev()
> and from tty_unregister_device() to tty_port_unregister_device().
> 
> On removal of a serdev driver sometimes count mismatch warnings were seen:
> 
>   ttyACM ttyACM0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
>   ttyACM ttyACM0: tty_port_close_start: tty->count = 1 port count = 0
> 
> Note: The serdev drivers appear to probe asynchronously as soon as they
> are registered. Should the USB quirks in probe be moved before registration?
> No noticeable difference for the devices at hand.

That is quite drastic a change.
Johan, how complete in terms of features is serdev?

Are you refering to CLEAR_HALT_CONDITIONS in terms of quirks?

	Regards
		Oliver

