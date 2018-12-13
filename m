Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828D720989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828D720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeLMLXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:23:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbeLMLXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:23:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DDF730034DB;
        Thu, 13 Dec 2018 11:23:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id D1DF7600C5;
        Thu, 13 Dec 2018 11:23:44 +0000 (UTC)
Date:   Thu, 13 Dec 2018 12:23:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 6/6] tools gpio: Override CFLAGS assignments
Message-ID: <20181213112344.GA9866@krava>
References: <20181212102537.25902-1-jolsa@kernel.org>
 <20181212102537.25902-7-jolsa@kernel.org>
 <20181212131501.GR10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212131501.GR10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Dec 2018 11:23:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:15:01PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 12, 2018 at 11:25:37AM +0100, Jiri Olsa wrote:
> > So user could specify outside CFLAGS values.
> 
> For all three where I'm in Cc list
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

thanks, I should have cc-ed you on all of them ;-)

any idea who could I ask to pull these in?

thanks,
jirka

> 
> > 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/gpio/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> > index 240eda014b37..6ecdd1067826 100644
> > --- a/tools/gpio/Makefile
> > +++ b/tools/gpio/Makefile
> > @@ -12,7 +12,7 @@ endif
> >  # (this improves performance and avoids hard-to-debug behaviour);
> >  MAKEFLAGS += -r
> >  
> > -CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >  
> >  ALL_TARGETS := lsgpio gpio-hammer gpio-event-mon
> >  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> > -- 
> > 2.17.2
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
