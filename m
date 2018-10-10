Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65460C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170952086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170952086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeJKDlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:41:25 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:38460 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:41:25 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9AKHVNp010612;
        Wed, 10 Oct 2018 21:17:31 +0100
Date:   Wed, 10 Oct 2018 21:17:17 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Insanely high baud rates
Message-ID: <20181010211717.30c1f052@alans-desktop>
In-Reply-To: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 12:19:04 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> [Resending to a wider audience]
> 
> In trying to get the termios2 interface actually implemented in glibc,
> the question came up if we will ever care about baud rates in excess of
> 4 Gbps, even in the relatively remote future.

Even RS485 at 4MBits involves deep magic. I think we are fairly safe. Not
only that but our entire tty layer isn't capable of sustaining anything
even remotely in that range.

I think its non issue.

Alan
