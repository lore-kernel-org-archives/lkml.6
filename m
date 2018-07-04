Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59286C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15011242C8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15011242C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeGDN56 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:57:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:44010 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeGDN54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:57:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 06:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="70064808"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2018 06:57:49 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 06:57:48 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 06:57:48 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.115]) with mapi id 14.03.0319.002;
 Wed, 4 Jul 2018 16:57:45 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Julia Lawall <julia.lawall@lip6.fr>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Thread-Topic: [PATCH] mei: bus: type promotion bug in mei_nfc_if_version()
Thread-Index: AQHUE3png2dbGFvDeUeKteEow93QvaR+w5sAgAAErwCAAEz8kA==
Date:   Wed, 4 Jul 2018 13:57:44 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D95BC46@hasmsx108.ger.corp.intel.com>
References: <20180704093449.vryluk7khaudstgp@kili.mountain>
 <alpine.DEB.2.20.1807041358580.4387@hadrien>
 <20180704121600.hrezydpvpe4hyie3@mwanda>
In-Reply-To: <20180704121600.hrezydpvpe4hyie3@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzlhMDY3YzQtNDM5Yy00MzVlLTk4YTAtZDMwNmI2NmJiZjVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSXMrWU5iQW5kNlVzYTllbDM0cHVMSEFLdmtnVmlMYXBON2ppMmpWS0lFRTd0a0JoNlZmY055a0RxN1BaU3F1ZSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.179]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jul 04, 2018 at 01:59:14PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 4 Jul 2018, Dan Carpenter wrote:
> >
> > > We accidentally removed the check for negative returns without
> > > considering the issue of type promotion.  The "if_version_length"
> > > variable is type size_t so if __mei_cl_recv() returns a negative
> > > then "bytes_recv" is type promoted to a high positive value and
> > > treated as success.
> > >
> > > Fixes: 582ab27a063a ("mei: bus: fix received data size check in NFC
> > > fixup")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > diff --git a/drivers/misc/mei/bus-fixup.c
> > > b/drivers/misc/mei/bus-fixup.c index 0208c4b027c5..fa0236a5e59a
> > > 100644
> > > --- a/drivers/misc/mei/bus-fixup.c
> > > +++ b/drivers/misc/mei/bus-fixup.c
> > > @@ -267,7 +267,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
> > >
> > >  	ret = 0;
> > >  	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0);
> > > -	if (bytes_recv < if_version_length) {
> > > +	if (bytes_recv < 0 || bytes_recv < if_version_length) {
> >
> > Is this preferred to adding an int cast?
> 
> I don't think it matters.  I kind of like explicitly testing for negative but
> maybe later people will just remove the check like we did here?  You could
> do it a bunch of different ways:
> 
> 1: if (ret < 0 || ret < ARRAY_SIZE(xxx))
> 2: if (ret < (int)ARRAY_SIZE(xxx))
> 3: if (ret != ARRAY_SIZE(xxx))
> 
> They're all equivalent.  I guess I don't like casting too much.  My first
> approach to fixing this was just to declare if_version_length as an int, but
> then I saw that originally there was a "bytes_recv < 0"
> check and decided to go that way instead.

Actually bytes_recv should be probably of ssize_t type,  so could be the if_version_length. 

How did you find this, I haven't seen it in reported by sparse, smatch and I believe -Wsign-compare is suppressed in compilation warnings.
Thanks
Tomas
