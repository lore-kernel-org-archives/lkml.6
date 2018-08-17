Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A07C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D066C21938
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D066C21938
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeHQO0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:26:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:55331 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeHQO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:26:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7HBMYVW008259;
        Fri, 17 Aug 2018 06:22:35 -0500
Message-ID: <6a2826055a33cbca45c3e8e03b1b0935b9f1d1af.camel@kernel.crashing.org>
Subject: Re: [PATCH] platform/x86: acer-wmi: Silence "unsupported" message a
 bit
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Aug 2018 21:22:34 +1000
In-Reply-To: <CAHp75VfjZe7XqJjv0CYFHXi95_v7R9B9E9eix+0xRwqn2tq6nQ@mail.gmail.com>
References: <7ccdc39d7e255547e851497ef9f449715b45f8bd.camel@kernel.crashing.org>
         <CAHp75Vd1ZZDJtASfFpr=eE+zaEiOxH3ohdSOe1aTcE3qEMd_QA@mail.gmail.com>
         <CAHp75VfjZe7XqJjv0CYFHXi95_v7R9B9E9eix+0xRwqn2tq6nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 14:09 +0300, Andy Shevchenko wrote:
> On Fri, Aug 17, 2018 at 2:07 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 16, 2018 at 2:27 AM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > This driver prints that "Unsupported machine..." message on every boot on
> > > ThinkPad X1 Carbon laptops (and I assume a number of other systems), which
> > > causes graphical boots to "glitch" a bit and is rather annoying ...
> > > 
> > > Make it a pr_debug instead.
> > 
> > Thanks for the patch. Unfortunately it doesn't apply.
> > Please, check your mail clients and tools for formatting patch (it
> > produced at the end spaces instead of tabs)
> 
> No need to resend _this_ time. I have pushed to my review and testing queue.

Thanks, odd. Not sure what's going on with the latest evolution, it's
the second time it's done this. I'll try to investigate. Small patch
like that I tend to just copy/paste in an email in "preformat" style
;-)

Cheers,
Ben.
> 
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > ---
> > > 
> > > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> > > index 8952173dd380..7f7192e8fdab 100644
> > > --- a/drivers/platform/x86/acer-wmi.c
> > > +++ b/drivers/platform/x86/acer-wmi.c
> > > @@ -2216,7 +2216,7 @@ static int __init acer_wmi_init(void)
> > >         if (wmi_has_guid(AMW0_GUID1) &&
> > >             !dmi_check_system(amw0_whitelist) &&
> > >             quirks == &quirk_unknown) {
> > > -               pr_err("Unsupported machine has AMW0_GUID1, unable to load\n");
> > > +               pr_debug("Unsupported machine has AMW0_GUID1, unable to load\n");
> > >                 return -ENODEV;
> > >         }
> > > 
> > > 
> > 
> > 
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> 
> 

