Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8060F20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8060F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbeGSLao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:30:44 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:57314 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeGSLao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:30:44 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w6JAlnZH028928;
        Thu, 19 Jul 2018 11:47:49 +0100
Date:   Thu, 19 Jul 2018 11:47:49 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color
 improvements
Message-ID: <20180719114749.00a7f979@alans-desktop>
In-Reply-To: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 05:01:52 +0200
Adam Borowski <kilobyte@angband.pl> wrote:

> Hi!
> Here's a patchset with two entangled improvements:
> 
> * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
>   allows disabling it, rendering such characters with a bright background
>   instead.

That's a matter of taste so needs to configurable. Changing the default
ought I think to be its own patch as it's a separate discussion to having
the choice there and easy to make.

For the palette why does it needs changing and exactly what standards
document defines 'right', especially given we don't do ICC in console
mode ? Have you tested the values used against multiple monitor types and
cards with a light meter ?

BTW visibly breaking the Nvidia crud is also fine. They'll then actually
bother to fix it and uually quite soon.

Alan


