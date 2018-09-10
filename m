Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8F92087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8F92087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeIJRMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:12:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37311 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbeIJRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:12:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 018382074F; Mon, 10 Sep 2018 14:18:23 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7F99E206EE;
        Mon, 10 Sep 2018 14:18:22 +0200 (CEST)
Date:   Mon, 10 Sep 2018 14:18:20 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 01/16] nvmem: remove unused APIs
Message-ID: <20180910141820.6c715895@bbrezillon>
In-Reply-To: <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl>
        <20180907100750.14564-2-brgl@bgdev.pl>
        <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
        <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
        <7e138142-8161-3646-4daf-619995baf395@linaro.org>
        <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
        <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
        <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
        <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, 10 Sep 2018 12:47:19 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> On 10/09/18 12:31, Bartosz Golaszewski wrote:
> > About that: there are no users of nvmem_device_cell_read/write()
> > currently and with the new API I'm not sure this is still needed. Are
> > you alright with removing those two?  
> 
> Why do you want to remove them? Other than reason of no users.

I'm just sharing my (and probably other maintainers/developers) PoV
here, so please don't take this as an attempt to force you to change
your mind, but rather an attempt at explaining why APIs usually stay
private when they have no users.

Kernel maintainers tend to reject APIs that have no users because
adding something that nobody needs yet is hard to get right. I mean,
you can design an API on what you think will be needed/appropriate, and
then, when people actually start needing this feature, they realize it
does not quite match what they need, and they have to adjust/rework
this API.

> 
> All it boils down to if we support device based apis using cell info or 
> not?

But it looks like nobody is actually using it, and the first potential
user (Bart) proposed a different approach with the nvmem cell table
declaration.

> IMO, I see no harm in leaving these apis as it is, unless there is a 
> strong reason to do so.

It's harmless, but it's also unused. If people start using it and you
realize the API is not working for some use cases, then you'll have to
patch all existing users.

All this being said, it's your call to make, and if you think it makes
sense to keep these functions around for any reason, then be it.

Regards,

Boris
