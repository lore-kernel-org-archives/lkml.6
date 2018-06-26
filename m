Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B80C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8C0268C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8C0268C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeFZVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:36:06 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:37565 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752213AbeFZVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:36:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 44125181D340F;
        Tue, 26 Jun 2018 21:36:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goat28_8c0a1a41cd856
X-Filterd-Recvd-Size: 2137
Received: from XPS-9350 (unknown [172.58.27.131])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 21:36:02 +0000 (UTC)
Message-ID: <997ac97e1dcfcaf4d0b1fa7003d4611dd7821f5d.camel@perches.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 26 Jun 2018 14:36:00 -0700
In-Reply-To: <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
         <20180626081409.9518-3-straube.linux@gmail.com>
         <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
         <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
         <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
         <2a49e8e7-15ef-af4f-1039-b15ae60df11b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 22:32 +0200, Michael Straube wrote:
> On 06/26/18 22:17, Joe Perches wrote:
> > On Tue, 2018-06-26 at 21:44 +0200, Michael Straube wrote:
> > > On 06/26/18 19:32, Andy Shevchenko wrote:
> > > > On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> > > > <straube.linux@gmail.com> wrote:
> > > > > Use ether_addr_copy() instead of memcpy() to copy the mac address.
[]
> > > > Btw, ensure that the source and destination buffers are aligned to u16
> > > > as required by API.
> > > To be honest I'm not sure how to do that excactly.
> > > Use __align(2) in the array declarations? e.g.:
> > >           u8 mac[ETH_ALEN] __align(2);
> > All initial function automatics are naturally aligned.
> So there is nothing to change? Now I'm confused.

There's nothing to change.  You could add __aligned(2)
if you wanted to, but it's already aligned.

