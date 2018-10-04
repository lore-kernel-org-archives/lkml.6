Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75286C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BCB20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NX4PELhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BCB20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDLc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:32:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56446 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbeJDLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:32:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 51C738EE23D;
        Wed,  3 Oct 2018 21:41:05 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HDiabn4ku5Km; Wed,  3 Oct 2018 21:41:05 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6ADA38EE0E9;
        Wed,  3 Oct 2018 21:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538628065;
        bh=k9E3ywKzu2M72+stQC+2PkkPyAcqiHxnxJTzEA8t7S4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NX4PELhqmgn/syFRRvbGYn6lhMEUb2o3qkiu3AsXIMzSA3J5yJg/7JlfkhrNdaI03
         BrE7LLpWKDLMGWQnwPv1V6yjuffGozTPBFbbvtOqd8i1klCYpt1B4bS8jaQ1pdMJVZ
         TjyACY5lUnkwsGtEucEsEho6P+VLFGJiTrFf/O60=
Message-ID: <1538628062.18776.5.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
Date:   Wed, 03 Oct 2018 21:41:02 -0700
In-Reply-To: <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
         <20180928020816.11251-4-leobras.c@gmail.com>
         <1538118915.3593.4.camel@HansenPartnership.com>
         <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 21:31 -0300, Leonardo Bras wrote:
> On Fri, Sep 28, 2018 at 4:15 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > On Thu, 2018-09-27 at 23:08 -0300, Leonardo Brás wrote:
> > > Avoids building driver if 'make drivers/parisc/' is called and
> > > CONFIG_PARISC is disabled.
> > 
> > Is that really a problem? The drivers/Makefile has this:
> > 
> > obj-$(CONFIG_PARISC)            += parisc/
> > And you just overrode that by forcing the build.  It's not even
> > clear we should refuse the build in that case; how would we know
> > you don't have a legitimate reason for the override?
> > 
> 
> Sorry I did not explained my reasons earlier. I sent everybody
> involved an e-mail explaining the full reason of this change.
> (For reference it's here: https://lkml.org/lkml/2018/10/3/707)

Well it's not really that persuasive.  Most people simply let the build
run to completion, but if you have a problem with a job control 3h
timelimit, then create a job that kills itself at 2:59 and then
resubmits itself.  That will produce a complete build in 3h chunks
without any need to call sub Makefiles.

All of our Makefiles are coded assuming the upper level can prevent
descent into the lower ones.  You're proposing to change that
assumption, requiring a fairly large patch set, which doesn't really
seem to provide a huge benefit.

James


> > Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> > > ---
> > >  drivers/parisc/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> > > index 3cd5e6cb8478..80049d763aa0 100644
> > > --- a/drivers/parisc/Makefile
> > > +++ b/drivers/parisc/Makefile
> > > @@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)          += eisa.o
> > > eisa_enumerator.o eisa_eeprom.o
> > >  obj-$(CONFIG_SUPERIO)                += superio.o
> > >  obj-$(CONFIG_CHASSIS_LCD_LED)        += led.o
> > >  obj-$(CONFIG_PDC_STABLE)     += pdc_stable.o
> > > -obj-y                                += power.o
> > > +obj-$(CONFIG_PARISC)         += power.o
> > 
> > If we conclude the use case is legitimate, that's not enough: the
> > two
> > inner symbols are PARISC only but CONFIG_EISA isn't.
> 
> You are right.
> It worked for my needs because I am only building the drivers, and
> not linking them. But i believe doing something like I did in
> zorro/Makefile would fix this all. (For reference,
> https://lkml.org/lkml/2018/9/28/150 )
> 
> If you agree, I will send the next patchset with this change.
> 
> Thanks for your help!
> 
> Leonardo Bras
> 

