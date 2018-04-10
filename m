Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbeDJXUq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 19:20:46 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34786 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755091AbeDJXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 19:20:42 -0400
X-Google-Smtp-Source: AIpwx49kIoSJobzcz9hUb+ryNlB81CbQ3XZGm7TORgBY0P/X4gYvvlr17brnLCAr9NkUn0UAAd3vng==
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
 3-byte addressing.
To: NeilBrown <neil@brown.name>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <874lkmw54j.fsf@notabene.neil.brown.name>
 <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
 <87sh85uzu3.fsf@notabene.neil.brown.name>
 <a3bb28f9-1185-3dbb-1a1f-1bfe03a8798c@gmail.com>
 <87efjnvpjl.fsf@notabene.neil.brown.name>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a203432c-0565-114c-74c5-27b5da77a5c5@gmail.com>
Date: Wed, 11 Apr 2018 01:20:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87efjnvpjl.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 03:05 AM, NeilBrown wrote:

Skipping the previous discussion, I think there are actually two
problems here. One is the reset and the other is braindead behavior of
this flash. TLDR, you are right and this patch is needed (with minor
tweak to make it winbond-only and possibly clean up the conditions a
bit, maybe even pull it into separate function with some sensible name),
sorry for the noise.

I had to read up the datasheet and the discussion again, the behavior of
the flash is horrid.

[...]

-- 
Best regards,
Marek Vasut
