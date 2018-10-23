Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A478204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A478204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbeJXDsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:48:02 -0400
Received: from smtprelay0249.hostedemail.com ([216.40.44.249]:38756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727758AbeJXDsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:48:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CE197837F24A;
        Tue, 23 Oct 2018 19:23:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: floor50_56873ae492538
X-Filterd-Recvd-Size: 2526
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Oct 2018 19:23:14 +0000 (UTC)
Message-ID: <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
From:   Joe Perches <joe@perches.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Date:   Tue, 23 Oct 2018 12:23:13 -0700
In-Reply-To: <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
References: <20180421085009.28773-1-javier@emutex.com>
         <1539969334-24577-1-git-send-email-dan@emutex.com>
         <1539969334-24577-3-git-send-email-dan@emutex.com>
         <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-23 at 20:50 +0200, Jacek Anaszewski wrote:
> > diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
> > new file mode 100644
> > index 0000000..34a6973
> > --- /dev/null
> > +++ b/drivers/leds/leds-upboard.c
> > @@ -0,0 +1,104 @@
[]
> > +#include <linux/kernel.h>
> > +#include <linux/leds.h>
> > +#include <linux/mfd/upboard.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/acpi.h>
> 
> The last include should go first to keep alphabetical order.

There is no accepted single kernel style for #include
file ordering.

drivers/leds does not use a single style nor is this
particular variant documented anywhere to my knowledge.

Until such a time when either a local preferred style
document or a treewide preferred style exists, please
stop asking people to modify #include ordering for
various styles like reverse christmas tree by length,
alphabetic ordering, or other individual styles.

My preferred style would always have kernel.h first
as that may help with precompiled headers and overall
kernel compilation time one day.

