Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7282077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7282077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeJKT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:58:46 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:41760 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbeJKT6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:58:45 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9BCVZhB023345;
        Thu, 11 Oct 2018 13:31:35 +0100
Date:   Thu, 11 Oct 2018 13:31:34 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     hpa@zytor.com
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Insanely high baud rates
Message-ID: <20181011133134.085624af@alans-desktop>
In-Reply-To: <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
        <20181010211717.30c1f052@alans-desktop>
        <16D6AB22-697E-498C-A5B2-3AD90B567E86@zytor.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm mostly wondering if it is worth future-proofing for new transports. It sounds like we can have a consensus on leaving the upper 4 bits of the speed fields reserved, but leave the details of implementation for the future?

It seems reasonable, although I think the reality is that any future
transport is not going to be a true serial link, but some kind of serial
emulation layer. For those the speed really only matters to tell editors
and the like not to bother being clever.

I mean - what is the baud rate of a pty  ?

Alan
