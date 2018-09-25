Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC38C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D89A20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D89A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeIYPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:09:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:61565 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeIYPJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:09:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 02:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,301,1534834800"; 
   d="scan'208";a="86335100"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga003.jf.intel.com with SMTP; 25 Sep 2018 02:03:22 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Sep 2018 12:03:21 +0300
Date:   Tue, 25 Sep 2018 12:03:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        vincent.whitchurch@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: mockup: use device properties instead of
 platform_data
Message-ID: <20180925090321.GX2664@lahna.fi.intel.com>
References: <20180923111727.10378-1-brgl@bgdev.pl>
 <CAMRc=MfZ8jRZHgXBq9TeYm5VpmLzwG7gF-NMYay9Zg-iEgFQDQ@mail.gmail.com>
 <CACRpkdb7zKfa_e6WWHncg+gxGncsC_Bx7gpkhJyutH4tqJRkew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb7zKfa_e6WWHncg+gxGncsC_Bx7gpkhJyutH4tqJRkew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:53:30AM +0200, Linus Walleij wrote:
> On Mon, Sep 24, 2018 at 9:35 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > niedz., 23 wrz 2018 o 13:17 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
> > >
> > > Some users want to introduce device tree support to the mockup driver.
> > > Let's make it easier by switching to using generic device properties.
> > > The driver stays compatible with previous use cases and after this
> > > conversion there'll be no need to change the way probing of mockup
> > > GPIO chips works.
> > >
> > > Tested with libgpiod test suite.
> > >
> > > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> (...)
> > Linus, I just noticed that we either need to drop the check for
> > -ENOENT or add an else that returns on any other error. I'll need to
> > send a v2
> 
> OK business as usual.
> 
> > but I'll let you first tell me if you like the general idea.
> 
> I don't know, I'm a bit ignorant about the idea, scope and
> ambition with device properties.
> 
> In my book this relates to the fwnode concept, but maybe
> I'm wrong?

I think you are right.

> Mika, please fill us in here. The device properties in gpiolib
> came in the patch
> "gpio: Rework of_gpiochip_set_names() to use device property accessors"

I'm not sure what to answer to be honest :) The idea behind that patch
was that we would be able to use the same properties (DT properties,
ACPI _DSD properties, or possibly built-in properties) to set names for
GPIOs.
