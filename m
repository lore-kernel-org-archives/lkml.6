Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46185C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 23:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A320828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 23:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82A320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJ1Hui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 03:50:38 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:44410 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbeJ1Hui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 03:50:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CB2871822324D;
        Sat, 27 Oct 2018 23:08:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose68_63865e543b553
X-Filterd-Recvd-Size: 1809
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Oct 2018 23:08:03 +0000 (UTC)
Message-ID: <8fbc5be59d4d6d0216db2e9c47a74c45e709e1fd.camel@perches.com>
Subject: Re: [PATCH 4/5] staging: rtl8188eu: change return type of
 rtw_hal_xmit()
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 27 Oct 2018 16:08:02 -0700
In-Reply-To: <bcb65c2930ae7efd78183f744059f2d29a743b88.camel@perches.com>
References: <20181027202850.25636-1-straube.linux@gmail.com>
         <20181027202850.25636-4-straube.linux@gmail.com>
         <bcb65c2930ae7efd78183f744059f2d29a743b88.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-27 at 15:57 -0700, Joe Perches wrote:
> On Sat, 2018-10-27 at 22:28 +0200, Michael Straube wrote:
> > The function rtw_hal_xmit() returns true or false.
> > Change the return type from s32 to bool.
> [] 
> > diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
> []
> > @@ -598,7 +598,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt,
> >   *	true	dump packet directly
> >   *	false	enqueue packet
> >   */
> > -s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
> > +bool rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
> >  {
> >  	s32 res;
> 
> Does "s32 res" need changing to bool too?

Perhaps all the functions regardless of types
with returns of only _SUCCESS and _FAIL could be
converted to bool.



