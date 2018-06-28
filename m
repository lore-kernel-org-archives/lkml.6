Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7526BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0AC25533
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0AC25533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeF1UgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:36:23 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:55102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753042AbeF1UgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:36:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0EFEE837F252;
        Thu, 28 Jun 2018 20:36:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: book00_1a257b0e30a14
X-Filterd-Recvd-Size: 1713
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Jun 2018 20:36:19 +0000 (UTC)
Message-ID: <b0ff5f28e22e78cb8987f3f5e3a5ceafdc4e9c32.camel@perches.com>
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
From:   Joe Perches <joe@perches.com>
To:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 28 Jun 2018 13:36:18 -0700
In-Reply-To: <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
         <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
         <b5f394c5f8395cd72ecdd5b6f9b2ff2d24253cf7.camel@hadess.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 11:34 +0200, Bastien Nocera wrote:
> On Thu, 2018-06-28 at 10:22 +0200, Hans de Goede wrote:
> > On 28-06-18 09:43, Michael Straube wrote:
> > > ret = rtw_resume_process(padapter)
> > > Is this a bug or is the if else construct just pointless?
> > It probably is just pointless, my guess would be that once
> > upon a time there was a difference in the paths and at some
> > point that difference went away.
> 
> Quite:
> https://github.com/hadess/rtl8723bs/blob/7d36e26f78bbc709844c12ad0c62e3e8503fdbc5/os_dep/linux/sdio_intf.c#L1757

That #ifdef forest is/was quite unsightly.
No wonder the realtek code is unmaintainable.

