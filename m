Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3173218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OTZlV/TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391739AbfBNMKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:10:37 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46048 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbfBNMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:10:36 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 44E2A10C1382;
        Thu, 14 Feb 2019 04:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550146236; bh=IXE4P3fdgx0sgtcbMgaYdSaMhEIIpDb5vPuER83fEt4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OTZlV/TZGILP1vVh6kPmq/I4nUSi4qszwiGuRsoNAAYVJp1Xc3ylEtrcEMdF9Jy3T
         XZzpPe+XxD3XCVZq3Fag3RXohTVmiGNeVA2sBel+mk+64IfXD7BDf/kDNh8csi9G7N
         C9K09aCJWa51UfmK6k0EHxULjxH3c7oUk1n1PeQotYlLwwRu2oyst30wlsSCzl7wPq
         4YE9+MtVQL3nxGP9w2XGXwlKs+mBoG37xMiOf+pgegBtV8wgL8jW2xSCVxlOzpp4bv
         ua9lCA9xHgXNX1C0EBvlg/zJYMKR+e62MXGXWldGPYlLSj5fTqPPffOM8ldRT5YKBT
         OcstpzZSHuGDg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8EAACA005D;
        Thu, 14 Feb 2019 12:10:35 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 04:05:49 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 14 Feb 2019 13:05:48 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        "Arnd Bergmann" <arnd.bergmann@linaro.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: RE: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Topic: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN = 8
Thread-Index: AQHUv5zONn7dHynHO02cFkcDzI3gNKXcXZ6AgAADuwCAAARCgIABQZSAgACvHQCAALqoAIAAETfg///4/4CAABIzoA==
Date:   Thu, 14 Feb 2019 12:05:47 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE64681DB202@DE02WEMBXB.internal.synopsys.com>
References: <20190208105519.26750-1-abrodkin@synopsys.com>
 <81017fe4-b31f-4942-e822-a7b70008b74d@synopsys.com>
 <f83412d1e7fd4d67b4632c1f81fae963@AcuMS.aculab.com>
 <bfc65835-21f9-6d5e-791d-ee49113d939c@synopsys.com>
 <20190213125651.GP32494@hirez.programming.kicks-ass.net>
 <e6138aeb-9ce4-fbfa-4d6a-b76f189a3e47@synopsys.com>
 <20190214103140.GG32494@hirez.programming.kicks-ass.net>
 <4881796E12491D4BB15146FE0209CE64681DB122@DE02WEMBXB.internal.synopsys.com>
 <20190214110813.GK32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214110813.GK32494@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWJyb2RraW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1kYjRkOGY4MC0zMDUwLTExZTktYmVkMi0wMGUw?=
 =?us-ascii?Q?NGM2ZTAzNDJcYW1lLXRlc3RcZGI0ZDhmODEtMzA1MC0xMWU5LWJlZDItMDBl?=
 =?us-ascii?Q?MDRjNmUwMzQyYm9keS50eHQiIHN6PSI0MTgwIiB0PSIxMzE5NDYxOTU0NTg3?=
 =?us-ascii?Q?NTE4NTgiIGg9IjNmZmQrNFRFM2JmbWZTU2NDam80ZnA1ZEF2OD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QnlmY2lkWGNUVUFla2xqYUVmSEpCUDZTV05vUjhja0U4T0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBZWZ4U2p3QUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: 
x-originating-ip: [10.225.15.89]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> -----Original Message-----
> From: linux-snps-arc <linux-snps-arc-bounces@lists.infradead.org> On Beha=
lf Of Peter Zijlstra
> Sent: Thursday, February 14, 2019 2:08 PM
> To: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Mark Rutland <mark.rutland@arm.com>; Vineet Gupta <vineet.gupta1@syno=
psys.com>; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; David Laight <David.Laigh=
t@ACULAB.COM>; Arnd Bergmann
> <arnd.bergmann@linaro.org>; linux-snps-arc@lists.infradead.org
> Subject: Re: [PATCH] ARC: Explicitly set ARCH_SLAB_MINALIGN =3D 8
>=20
> On Thu, Feb 14, 2019 at 10:44:49AM +0000, Alexey Brodkin wrote:
> > > On Wed, Feb 13, 2019 at 03:23:36PM -0800, Vineet Gupta wrote:
> > > > On 2/13/19 4:56 AM, Peter Zijlstra wrote:
> > > > >
> > > > > Personally I think u64 and company should already force natural
> > > > > alignment; but alas.
> > > >
> > > > But there is an ISA/ABI angle here too. e.g. On 32-bit ARC, LDD (lo=
ad double) is
> > > > allowed to take a 32-bit aligned address to load a register pair. T=
hus all u64
> > > > need not be 64-bit aligned (unless attribute aligned 8 etc) hence t=
he relaxation
> > > > in ABI (alignment of long long is 4). You could certainly argue tha=
t we end up
> > > > undoing some of it anyways by defining things like ARCH_KMALLOC_MIN=
ALIGN to 8, but
> > > > still...
> > >
> > > So what happens if the data is then split across two cachelines; will=
 a
> > > STD vs LDD still be single-copy-atomic? I don't _think_ we rely on th=
at
> > > for > sizeof(unsigned long), with the obvious exception of atomic64_t=
,
> > > but yuck...
> >
> > STD & LDD are simple store/load instructions so there's no problem for
> > their 64-bit data to be from 2 subsequent cache lines as well as 2 page=
s
> > (if we're that unlucky). Or you mean something else?
>=20
> u64 x;
>=20
> WRITE_ONCE(x, 0x1111111100000000);
> WRITE_ONCE(x, 0x0000000011111111);
>=20
> vs
>=20
> t =3D READ_ONCE(x);
>=20
> is t allowed to be 0x1111111111111111 ?
>=20
> If the data is split between two cachelines, the hardware must do
> something very funny to avoid that.
>=20
> single-copy-atomicity requires that to never happen; IOW no load or
> store tearing. You must observe 'whole' values, no mixing.
>=20
> Linux requires READ_ONCE()/WRITE_ONCE() to be single-copy-atomic for
> <=3Dsizeof(unsigned long) and atomic*_read()/atomic*_set() for all atomic
> types. Your atomic64_t alignment should ensure this is so.

Thanks for explanation!

I'm not completely sure about single-copy-atomic for our LDD/STD instructio=
ns
(need to check with HW guys) but given above requirement:
---------------------------->8--------------------------
READ_ONCE()/WRITE_ONCE() to be single-copy-atomic for <=3Dsizeof(unsigned l=
ong)
---------------------------->8--------------------------
that's OK for them (LDD/STD) to not follow this, right? As they are obvious=
ly
longer than "unsigned long".

Though I'm wondering if READ_ONCE()/WRITE_ONCE() could be used on 64-bit da=
ta
even on 32-bit arches?

Now as for LLOCKD/SCONDD which implement single instruction 64-bit atomics =
require
double-word alignment and so cannot possible span between cache lines.

So what am I missing here?

> So while I think we're fine, I do find hardware instructions that tear
> yuck (yah, I know, x86...)
>=20
> > > So even though it is allowed by the chip; does it really make sense t=
o
> > > use this?
> >
> > It gives performance benefits when dealing with either 64-bit or even
> > larger buffers, see how we use it in our string routines like here [1].
> >
> > [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_tree_arch_=
arc_lib_memset-2Darchs.S-
> 23n81&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DlqdeeSSEes0GFDDl656eViXO7=
breS55ytWkhpk5R81I&m=3Dm60hCzPFQMtxeg
> 9HR5zZOJcRFMs6WLFJNSc6TNDqd4Y&s=3DTapp7zbAmYYaTIaO5yKM0yUKfnaURFxdr56TS-J=
appQ&e=3D
>=20
> That doesn't require the ABI alignment crud.

I'm not saying it has something to do with our ABI - that's just how we use=
 it.

-Alexey
