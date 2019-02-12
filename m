Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F12C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20E021905
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549998940;
	bh=+T6iMZR98yStttVuBCMQSJVXWob/p7EZfFCQLAMFzOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UHIBA5MGvKDEP+9RgO79/iYrmrnTpKhD+n6NDUD7C1+r4XLmmmFqQ3oXRLiPXIYac
	 bfh0Owcn60sCejl9iGD1W+TkJ7PI4dnYV6/EsyBGXvUfKE8ukpqnRfY9QOytNbx19a
	 gpUWPq3CwPOOlDglmbdcDzM6rGS17zoVwsZp9Yto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfBLTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLTPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:15:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B774521905;
        Tue, 12 Feb 2019 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549998938;
        bh=+T6iMZR98yStttVuBCMQSJVXWob/p7EZfFCQLAMFzOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUidc779KOV+niIQmVn8vTqFPm8uc4qDwDEV5Psae4hKZgOl436U4eflGX1mW0731
         u3d/6PDVV9x7Vv31VhSpvEK4GCSI9VbmBOBOCbAjIftKWmDmYPliBOaF51v6WtMQ/c
         wRLn23/lP7nOvkR7q0qe5ayF8Ap137Ch9zbbJypY=
Date:   Tue, 12 Feb 2019 20:15:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xiang xiao <xiaoxiang781216@gmail.com>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] lib/string: add memrchr function
Message-ID: <20190212191535.GA22741@kroah.com>
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212183408.GA14892@kroah.com>
 <CAH2Cfb_ZQiHiL2pGCB4j2a3U60=78w6a9if_Z+pgk2qEi+8pZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2Cfb_ZQiHiL2pGCB4j2a3U60=78w6a9if_Z+pgk2qEi+8pZQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 03:09:19AM +0800, xiang xiao wrote:
> On Wed, Feb 13, 2019 at 2:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Feb 13, 2019 at 02:06:49AM +0800, Xiang Xiao wrote:
> > > Here is the detailed description for memrchr:
> > > https://linux.die.net/man/3/memrchr
> >
> > Please put it in the changelog, as web pages move and go away :(
> 
> Sure.
> 
> >
> > >
> > > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > > ---
> > >  include/linux/string.h |  1 +
> > >  lib/string.c           | 21 +++++++++++++++++++++
> > >  2 files changed, 22 insertions(+)
> > >
> > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > index 7927b87..f380f4b 100644
> > > --- a/include/linux/string.h
> > > +++ b/include/linux/string.h
> > > @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> > >       memcpy(dst, src, cnt);
> > >  }
> > >  #endif
> > > +void *memrchr(const void *s, int c, size_t n);
> >
> > Who is going to use this?
> 
> This patch will use memrchr:
> https://github.com/thesofproject/linux/pull/177/commits/a0b7009fede5552dc98733f2996a8140bff62455
> I am preparing to upstream it.

Great, make it part of the patch series for your driver, no need to
submit it separately.

thanks,

greg k-h
