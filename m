Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531A520878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="VI/MXcDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531A520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGIVJA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:09:00 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:26208 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933003AbeGIVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1531170312; x=1562706312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ruv/ZAHqOeNW5QewbXaHXOJzpWr92TKq4ZFmMNqJ6KY=;
  b=VI/MXcDtz5incQOWOWEFmO1f8WaJ1vyklpVxzMmTuhE7JizsuJpeuR9q
   GuIHoI1B9BfpxuV0Ui6d1k71LNDJfQBsiA1AJxHvZH+vd1RbvF1BnS/H1
   cHaCeWxcj5UjVRPmLqwK8QKAIndfZR20buWPF36TEPt4sSQZoTysBktOH
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FKAQAGzkNbh8uZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQdgQ0oCpgoggeINo52C4RsAoJGITgUAQIBAQIBAQIBAQIQAQE?=
 =?us-ascii?q?BCgsJCCkvgjUigmEBAQEBAzo0AwgMBAIBCBEEAQEBHgkHISUDAQUIAgQOBQiDG?=
 =?us-ascii?q?IFoAxWsJ4cQDYEugTqIboIVhB6CVoIII4VPApkkKwcCjBmDA41liweHCYFYgXR?=
 =?us-ascii?q?wUIJpgiQOCY4XbwGNF4EaAQE?=
X-IPAS-Result: =?us-ascii?q?A2FKAQAGzkNbh8uZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?dgQ0oCpgoggeINo52C4RsAoJGITgUAQIBAQIBAQIBAQIQAQEBCgsJCCkvgjUig?=
 =?us-ascii?q?mEBAQEBAzo0AwgMBAIBCBEEAQEBHgkHISUDAQUIAgQOBQiDGIFoAxWsJ4cQDYE?=
 =?us-ascii?q?ugTqIboIVhB6CVoIII4VPApkkKwcCjBmDA41liweHCYFYgXRwUIJpgiQOCY4Xb?=
 =?us-ascii?q?wGNF4EaAQE?=
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 16:05:12 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 02:58:28 +0600
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.51,330,1526360400"; 
   d="scan'208";a="1183425463"
X-DLP:  DLP_GlobalPCIDSS
To:     <dvhart@infradead.org>
CC:     <srinivas.pandruvada@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <alex.hung@canonical.com>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>
Subject: RE: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Topic: [PATCH v2] platform/x86: intel-hid: Add support for Device
 Specific Methods
Thread-Index: AQHUDwyTs6nsEeHVokGyB9ujS48v7KR3cjWwgARzsgGAABHaIIAG9Ny+gAE6MACAAjcPYIABaVkA//+sXUA=
Date:   Mon, 9 Jul 2018 21:08:56 +0000
Message-ID: <b79253ee160b4d08a48ac0a805939296@ausx13mpc120.AMER.DELL.COM>
References: <20180628181906.54910-1-srinivas.pandruvada@linux.intel.com>
 <74ac9bf130074e0a8f86a7904783d091@ausx13mpc120.AMER.DELL.COM>
 <95b3748fcb911c7305bd2bbcfd4e368f044f8b14.camel@linux.intel.com>
 <CAHp75VdX+i_N_GttiL3QZrpivpUeJa0ofGfeJR1FkfuiBWocqA@mail.gmail.com>
 <cc4bc804434a40d9bdd2fa03bbb875aa@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VerxQrPwHTU9PF_q_8xkRm7=cBTPf2tb_5xPEoBQKcL8A@mail.gmail.com>
 <20180706235907.GE3041@fury>
 <ccb18d853b254f680895c45862274ec8bdd70ab0.camel@linux.intel.com>
 <1dfb07bd3461414e8db492e643d7de88@ausx13mpc120.AMER.DELL.COM>
 <20180709210646.GA30247@fury>
In-Reply-To: <20180709210646.GA30247@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Monday, July 9, 2018 4:07 PM
> To: Limonciello, Mario
> Cc: srinivas.pandruvada@linux.intel.com; andy.shevchenko@gmail.com;
> alex.hung@canonical.com; andy@infradead.org; platform-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org; rjw@rjwysocki.net
> Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Device S=
pecific
> Methods
>=20
> On Mon, Jul 09, 2018 at 04:38:16AM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com=
]
> > > Sent: Saturday, July 7, 2018 8:44 AM
> > > To: Darren Hart; Andy Shevchenko
> > > Cc: Limonciello, Mario; Alex Hung; Andy Shevchenko; Platform Driver; =
Linux
> Kernel
> > > Mailing List; Rafael J. Wysocki
> > > Subject: Re: [PATCH v2] platform/x86: intel-hid: Add support for Devi=
ce Specific
> > > Methods
> > >
> > > On Fri, 2018-07-06 at 16:59 -0700, Darren Hart wrote:
> > > > On Mon, Jul 02, 2018 at 05:06:14PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, Jul 2, 2018 at 4:51 PM,  <Mario.Limonciello@dell.com>
> > > > > wrote:
> ...
> > > Mario can add more.
> > > But I think Dell has released a BIOS fix, so that power button can
> > > still work using non _DSM way. So I think we can wait for normal
> > > release cycle.
> >
> > Yeah, I added some comments on a separate reply already indicating this=
.
> >
> > The affected system we know about has reverted the new interface.
> >
> > This all stems from an expectation that the _DSM has been there for "ma=
ny"
> > releases on the Windows side.  Long enough that even all the corporate
> downgrade
> > scenarios to older Windows versions and the drivers with them all worke=
d
> properly.
> >
> > If this doesn't end up being a candidate for backporting to stable we'l=
l probably
> > end up asking our various OS partners to backport it as a SAUCE type pa=
tch in
> distro
> > kernels to eventually be able to turn this back on.
>=20
> Thanks Mario. We'll skip the RC. We can discuss -stable as a separate
> issue.  This patch fixes a demonstrable bug, the biggest obstacle here
> is the size. At 240 lines with context, it more than doubles the maximum
> patch size for stable.
>=20
> My recommendation is that we treat the stable backport of this as a
> special case, e.g. Andy and I don't tag it, but you or Srinivas propose
> it and specifically make the case for why an exception should be made to
> Greg.
>=20
> How self contained and isolated this change is will be an important part
> of the argument. On the one hand, it's all one file, on the other hand,
> this is a fairly generic driver in use in more and more platforms, with
> the potential for widespread impact if this introduces a new bug.
>=20

In that case, how about we let it bake for a while and maybe by the time
4.19 comes out is when we do the proposal of a stable backport?
