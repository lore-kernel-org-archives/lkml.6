Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EA0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4120831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA4120831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJYVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:48:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:43838 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbeJYVsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:48:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 06:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="102592435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2018 06:15:24 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gFfTv-0003Nh-5x; Thu, 25 Oct 2018 16:15:23 +0300
Date:   Thu, 25 Oct 2018 16:15:23 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan O'Donovan <dan@emutex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 1/3] mfd: upboard: Add UP2 platform controller driver
Message-ID: <20181025131523.GY10650@smile.fi.intel.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-2-git-send-email-dan@emutex.com>
 <CAHp75VdkwfcPdSmB0dYBF_xwwXMqkrLOa1tL0xkOJ4DVcx8h8g@mail.gmail.com>
 <20181025110505.GA4870@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025110505.GA4870@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:05:05PM +0100, Lee Jones wrote:
> On Sat, 20 Oct 2018, Andy Shevchenko wrote:
> > On Fri, Oct 19, 2018 at 8:26 PM Dan O'Donovan <dan@emutex.com> wrote:

> > > +       ret = upboard_init_gpio(dev);
> > > +       if (ret) {
> > > +               if (ret != -EPROBE_DEFER)
> > > +                       dev_err(dev, "failed to init GPIOs: %d", ret);
> > > +               return ret;
> > > +       }
> > 
> > I don't know if probe_err() helper is going to be a part of v4.21
> > (which this series targets), it would be good to use it.
> 
> Interesting.  What does it do?

The code will tell better than I
https://lore.kernel.org/lkml/20181017132205.5204-1-a.hajda@samsung.com/


-- 
With Best Regards,
Andy Shevchenko


