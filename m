Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24271C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAF8208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAF8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeGIDMZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:12:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:38696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754394AbeGIDMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:12:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 20:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,328,1526367600"; 
   d="scan'208";a="54977577"
Received: from pgsmsx112.gar.corp.intel.com ([10.108.55.201])
  by orsmga007.jf.intel.com with ESMTP; 08 Jul 2018 20:12:19 -0700
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.62]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.172]) with mapi id 14.03.0319.002;
 Mon, 9 Jul 2018 11:12:18 +0800
From:   "Chiang, AlanX" <alanx.chiang@intel.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Rob Herring <robh@kernel.org>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "jcliang@chromium.org" <jcliang@chromium.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Thread-Topic: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
 property
Thread-Index: AQHUEeT4VFqceYAHhEmICxBvoofczKSAoooA///v2QCABZxPkA==
Date:   Mon, 9 Jul 2018 03:12:18 +0000
Message-ID: <0772C36F3434E145A062D024A4869A09010B1E4D@PGSMSX101.gar.corp.intel.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
 <1530522740-2798-2-git-send-email-alanx.chiang@intel.com>
 <20180705212204.GA10449@rob-hp-laptop>
 <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1807051623400.12206@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzQxZmZhNWYtMzk1My00YmEyLTliNWItZDk5MTFlYWUwMDgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9VdDhycEIzTmtDZ0Ezb1Z5NkNNSlJ1eFFnZE95a1lGRjRlbzQyYlMyMm5MZ2dRaGJOTkxGVnltbUwzRzVlZXoifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

> -----Original Message-----
> From: Robert P. J. Day [mailto:rpjday@crashcourse.ca]
> Sent: Friday, July 6, 2018 4:24 AM
> To: Rob Herring <robh@kernel.org>
> Cc: Chiang, AlanX <alanx.chiang@intel.com>; linux-i2c@vger.kernel.org; Yeh,
> Andy <andy.yeh@intel.com>; sakari.ailus@linux.intel.com;
> andriy.shevchenko@linux.intel.com; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com;
> tfiga@chromium.org; jcliang@chromium.org; brgl@bgdev.pl;
> mark.rutland@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width
> property
> 
> On Thu, 5 Jul 2018, Rob Herring wrote:
> 
> > On Mon, Jul 02, 2018 at 05:12:19PM +0800, alanx.chiang@intel.com wrote:
> > > From: Alan Chiang <alanx.chiang@intel.com>
> > >
> > > The AT24 series chips use 8-bit address by default. If some chips
> > > would like to support more than 8 bits, the at24 driver should be
> > > added the compatible field for specfic chips.
> > >
> > > Provide a flexible way to determine the addressing bits through
> > > address-width in this patch.
> > >
> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> > > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > >
> > > ---
> > > since v1:
> > > -- Remove the address-width field in the example.
> > > since v2:
> > > -- Remove redundant space.
> > > since v3:
> > > -- Add Acked-by.
> > >
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
>   "... should be added the compatible field ..."??
> 
> rday

Maybe I should modify the sentence as below that makes it clear.
"The compatible field should be added in the at24.c for specific chips.".

I quote Andy's words in patch v2:
"The current at24 driver has no address width support, thus, reusing same
(allocated) IDs (non-DT case) is hard."

This is the reason that I submitted the patch.

Thanks

> 
> --
> 
> ==========================================================
> ==============
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                   http://crashcourse.ca/dokuwiki
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ==========================================================
> ==============
