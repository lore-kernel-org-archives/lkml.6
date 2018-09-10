Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D668D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIKLno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:43:44 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:1478 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeIKLno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:43:44 -0400
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="19636419"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Sep 2018 23:45:52 -0700
Received: from ajaysk-VirtualBox (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Mon, 10 Sep 2018
 23:45:46 -0700
Date:   Mon, 10 Sep 2018 16:08:36 +0530
From:   Ajay Singh <ajay.kathat@microchip.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        driverdevel <devel@driverdev.osuosl.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <ganesh.krishna@microchip.com>, <aditya.shankar@microchip.com>
Subject: Re: [PATCH] staging: wilc1000: revert "fix TODO to compile spi and
 sdio components in single module"
Message-ID: <20180910160836.24efb0b9@ajaysk-VirtualBox>
In-Reply-To: <20180814084335.GB7208@kroah.com>
References: <20180813212108.2442868-1-arnd@arndb.de>
        <20180814105237.64b01528@ajaysk-VirtualBox>
        <CAK8P3a3bk7urG9zO=F1NtH8hTnGQQ_Hk0qq=o8fmeYY_nEyy5w@mail.gmail.com>
        <20180814084335.GB7208@kroah.com>
Organization: Microchip Technology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, 14 Aug 2018 10:43:35 +0200
gregkh <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 14, 2018 at 10:34:27AM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 14, 2018 at 7:22 AM Ajay Singh
> > <ajay.kathat@microchip.com> wrote:
> > >
> > > Hi Arnd,
> > >
> > > On Mon, 13 Aug 2018 23:20:33 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > The TODO item named "make spi and sdio components coexist in one
> > > > build" was apparently addressed a long time ago, but never
> > > > removed from the TODO file. However, the new patch that tries
> > > > to address it actually makes it worse again by duplicating the
> > > > common parts of the driver into two separate modules rather
> > > > than sharing them. This also introduces a build regression when
> > > > one of the two is built-in while the other is a loadable module:
> > >
> > > Thanks for sharing your inputs and submitting patch.
> > > I have also submitted a patch to address the compilation error[1].
> > > We can ignore my patch and proceed with your changes.
> > >
> > > [1].https://patchwork.kernel.org/patch/10563873/
> > 
> > That patch seems useful regardless, as it removes dead code,
> > but I'd still prefer to revert staging-linusthe 9abc44ba4e2f ("staging: wilc1000:
> > fix TODO to compile spi and sdio components in single module")
> > commit for the other reasons I explained.
> 
> I agree, I'll queue it up soon, I have other patches to get to Linus
> first.
> 

This patch is applied only to 'staging-linus' in commit f45b893 and
it's not applied to 'staging-testing/next' tree. 
Please apply this patch to 'staging-next' tree also. Because I have one
patch to submit on top of these changes to delete the 'wilc_debug.c'
unused file.


Regards,
Ajay
