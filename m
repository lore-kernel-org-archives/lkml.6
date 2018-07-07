Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF79DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D287208B1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 23:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D287208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754462AbeGGXhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 19:37:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:25924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754352AbeGGXhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 19:37:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2018 16:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,322,1526367600"; 
   d="scan'208";a="69491044"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.118.97])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2018 16:37:52 -0700
Message-ID: <82968804b607bf33550ba6fbaebc658db3953804.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Alex Hung <alex.hung@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Sat, 07 Jul 2018 16:37:52 -0700
In-Reply-To: <CAHp75VeW9y2z2N7bzwY-kztLvgJYmHECHRF1q5Mr8ude8LOMUQ@mail.gmail.com>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
         <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
         <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
         <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
         <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
         <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
         <20180706235907.GE3041@fury> <1530935335264.5774@Dell.com>
         <CAHp75VeW9y2z2N7bzwY-kztLvgJYmHECHRF1q5Mr8ude8LOMUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-07 at 19:24 +0300, Andy Shevchenko wrote:
> On Sat, Jul 7, 2018 at 6:48 AM,  <Mario.Limonciello@dell.com> wrote:
> > > I strongly advocate for vendors to have more control over their
> > > drivers,
> > > but this scenario really frustrates me. I don't think I can
> > > justify this
> > > to Linus as a fix. But before we just say "no" (because hey, I
> > > want
> > > these fixes available as early as possible too), let's ask Rafael
> > > if he
> > > has an opinion or if there is precedent for this in his
> > > experience with
> > > ACPI drivers in general:
> > 
> > Full disclosure - an updated FW has since been rolled out that
> > reverted this
> > behavior back to previous FW behavior due to lack of Linux support
> > for the
> > new _DSM.  There is desire to use the new interface (as it did fix
> > actual
> > problems with the old one) so at some point it may return.  When
> > that happens
> > it would be ideal that people who are (for example) running an LTS
> > kernel
> > or distro kernel that tracks stable can pick it up too.
> 
> I am all for the better user experience and bugs especially in FW
> should be fixed, but I think to support all kind of behaviour the new
> FW release should always provide a knob by which we can check if some
> feature is supported or not.
> 
> Above sounds to me as mistake in design of the fix.
The fix here takes care of all the combination. If the new _DSM is
available, it checks what functionality the _DSM interface can provide
(Fn 0). For those functionality it gets using _DSM matching new FW
interface. If there is no _DSM or _DSM doesn't provide the
functionality or _DSM provided method fails, it still revert to old FW
interface style using standalone method. Eventually because of
configurable 5-button array, all platforms will be using new FW
interface with consideration of backward compatibility.

Thanks,
Srinivas

