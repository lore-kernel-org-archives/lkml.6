Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBADBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D3B20821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBKKab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:30:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:57344 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfBKKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:30:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 02:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="142399600"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga002.fm.intel.com with SMTP; 11 Feb 2019 02:30:25 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 12:30:24 +0200
Date:   Mon, 11 Feb 2019 12:30:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Granata <egranata@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to
 platform_get_irq()
Message-ID: <20190211103024.GY7875@lahna.fi.intel.com>
References: <20190207185917.167829-1-egranata@google.com>
 <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
 <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
 <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
 <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_wzQ_RLC7N=jzj693d42T4K-CtSA-ckavt1FNDFZmLcXkB6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 07, 2019 at 12:29:17PM -0800, Dmitry Torokhov wrote:
> >
> > > Do you have a suggestion as to how to write ACPI tables to avoid the issue?
> >
> > 1. Allocate new ID and use it (perhaps not the best path).
> > 2. Use GPE(s).
> >
> 
> Or just solve the issue of intermixing Interrupt() with GpioInt(). We
> have similar issue with i2c and spi, but we sidestep that there as we
> only parse the first interrupt and do not give option of fetching 2nd,
> 3rd, etc. Maybe we should only GpioInt parsing for the first interrupt
> in platform_get_irq() as well for the first iteration and then see if
> we need to improve it if we see devices with multiple interrupts.

I think it should be fine to intermix them or do what you suggest and
start supporting index 0 for now and then maybe extend it in the future
to cover more.
