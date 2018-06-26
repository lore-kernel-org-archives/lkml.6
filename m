Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E718C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4454A26AC5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4454A26AC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFZURu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:17:50 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:54979 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933482AbeFZURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:17:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9539E181D340F;
        Tue, 26 Jun 2018 20:17:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girl64_269f09773ef39
X-Filterd-Recvd-Size: 1851
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 20:17:45 +0000 (UTC)
Message-ID: <96782a8bbc8d5a8a911447beda78ca4eed6b9f04.camel@perches.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: use ether_addr_copy() in
 rtw_macaddr_cfg()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 26 Jun 2018 13:17:44 -0700
In-Reply-To: <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
         <20180626081409.9518-3-straube.linux@gmail.com>
         <CAHp75Vc3gEyP+h_XtJV7zKZV0J++Nyr04au7Rtu3h5y0JJASXg@mail.gmail.com>
         <37cca7e4-3c1f-b1ab-14b3-fd3dbbae8b01@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 21:44 +0200, Michael Straube wrote:
> On 06/26/18 19:32, Andy Shevchenko wrote:
> > On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> > <straube.linux@gmail.com> wrote:
> > > Use ether_addr_copy() instead of memcpy() to copy the mac address.
> > > 
> > 
> > Suggested-by ?
> > 
> 
> I'll add it. Sorry, I was not aware of the Suggested-by tag.
> 
> > Btw, ensure that the source and destination buffers are aligned to u16
> > as required by API.
> 
> To be honest I'm not sure how to do that excactly.
> 
> Use __align(2) in the array declarations? e.g.:
> 
>          u8 mac[ETH_ALEN] __align(2);

All initial function automatics are naturally aligned.
> 
