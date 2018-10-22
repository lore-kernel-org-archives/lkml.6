Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8EEC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F81205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F81205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJVRL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbeJVRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:11:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4448F3082E02;
        Mon, 22 Oct 2018 08:53:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id E72015D9CC;
        Mon, 22 Oct 2018 08:53:50 +0000 (UTC)
Date:   Mon, 22 Oct 2018 10:53:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] tools iio: Override CFLAGS assignments
Message-ID: <20181022085350.GE2452@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-10-jolsa@kernel.org>
 <20181021132616.34e3bc95@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021132616.34e3bc95@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 22 Oct 2018 08:53:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 01:26:34PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Oct 2018 17:06:14 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > So user could specify outside CFLAGS values.
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to poke at them.

thanks,
jirka

> 
> Thanks
> 
> Jonathan
> 
> > 
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/iio/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> > index 332ed2f6c2c2..e22378dba244 100644
> > --- a/tools/iio/Makefile
> > +++ b/tools/iio/Makefile
> > @@ -12,7 +12,7 @@ endif
> >  # (this improves performance and avoids hard-to-debug behaviour);
> >  MAKEFLAGS += -r
> >  
> > -CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >  
> >  ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
> >  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> 
