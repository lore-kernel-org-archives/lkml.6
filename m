Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8075C2184D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbfBETAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:00:06 -0500
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:45850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730642AbfBES7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:44 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 43EB7181D341D;
        Tue,  5 Feb 2019 18:59:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: time64_1a6071a67571f
X-Filterd-Recvd-Size: 2425
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Feb 2019 18:59:41 +0000 (UTC)
Message-ID: <7771453cf380ce43d906f6648edecd8b58fec38a.camel@perches.com>
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 10:59:40 -0800
In-Reply-To: <20190205184431.GD22198@kroah.com>
References: <20190205150620.GA17522@nishad>
         <20190205184431.GD22198@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 19:44 +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> > This patch corrects the style for SPDX license Identifier in mac.h
> > by using "/* */" in place of "//" as per Linux kernel licensing rules.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/vt6656/mac.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> > index 94e700fcd0b6..75166020f7c6 100644
> > --- a/drivers/staging/vt6656/mac.h
> > +++ b/drivers/staging/vt6656/mac.h
> > @@ -1,5 +1,5 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0+
> 
> Should really be:
> 
> /* SPDX-License-Identifier: GPL-2.0+ */

There's a fair number of style inconsistencies in the kernel
sources for that already.

~8% of the .h files that have an 'SPDX-License-Identifier:'
don't use the recommended style.

$ git grep -h "SPDX-License" -- '*.h' | \
  perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
  sort | uniq -c | sort -rn
   8506 /* SPDX-License-Identifier: ... */
    593 // SPDX-License-Identifier:
    154 /* SPDX-License-Identifier:
     53  * SPDX-License-Identifier:
      1  * SPDX-License-Identifier:	GPL-2.0
      1 //SPDX-License-Identifier:
      1 /*  SPDX-License-Identifier: ... */


