Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0896C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9963120894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia9PZFig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeH1SWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:22:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32858 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1SWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:22:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so1817008wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUz93StQ5jKFHi+4JPQAe3s9E3Rgax5hcGjp/PBUEhk=;
        b=ia9PZFigpw9oPtPELcNdGvF7f40BD06g9sE28wIzxFQCunN+XQVm+qfEsQzqgb2DSH
         v75Rn9JzCu1AX8E2NU+2KJmeiWjPX4js4fNVohUoFTsvSxcbh7n5N2wCZv/Vpd9O+9ZE
         wE40qRdTJqwDhhMIMsU5ziMNWLuXb3hVpqqEZl4r4sq1zqTrSZabeDJ9FIWzY03E9Kdi
         Nda0e10JSooOU7aZiOjHndVbsG5cHrkwdmlTs2RaHcwoXoAwXTOlCXLtdXQ6RRCZUcde
         fHgAkEUPAT4TaV1dA2D+1j+9qG8vCv9qqem2581DJpHnGKIRD/YV2mPrfclvr+IsrOKk
         zVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUz93StQ5jKFHi+4JPQAe3s9E3Rgax5hcGjp/PBUEhk=;
        b=uKaX9wevMG5bio+RnfU9cmj4q8uDsKzRiuX4mtgY22r9LIohlTcXv2qpPAvUtHSpj5
         WXl66sTnLQY25ZJZnxSW1Dkhr5wV/ZtM1nDhcaQDznb83x8WXPAykjzeLpgrfJELwpX0
         NoDE0tX/aNE5p6AOQjpiWASGrSF87h++yemqAGKwMyZtgklVsGqXr17E8BztlbnbPwNa
         D5wc6b9FEm2HUWBuGk51IKRF+ciRvGS+FsEMJDlvQ+QkDutSg+qwt9IznFutOxvoRXfz
         kXiOaTCPPw9i4qUDzwRr+TJz8HQ9+kCW7ikWEVXdHKkUPBvSd6OLku586fYvaGc8fgEY
         kG7g==
X-Gm-Message-State: APzg51CfhnyVV3LrPvXfWronF1Bvlrhr/TGHLXbdCQnoilR6a4tqq30P
        gjvP7TLGcmKmcR+34C98il4=
X-Google-Smtp-Source: ANB0VdZf8diVwCh86ePXrDlIX2blgO5KRxNIhZ/SffrqWOSkf9whT/iS8NGWjaC5fUGBqMItS3uQ1w==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr1280987wrj.62.1535466655622;
        Tue, 28 Aug 2018 07:30:55 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id q5-v6sm771463wru.79.2018.08.28.07.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 07:30:54 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:30:49 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, Simon Que <sque@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        John Joseph <jnjoseph@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Springer <rspringer@google.com>,
        devel@linuxdriverproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Todd Poynor <toddpoynor@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 4.19-rc1
Message-ID: <20180828143049.GA7388@darwi-kernel>
References: <20180818155724.GA22569@kroah.com>
 <20180828103817.GB1397@do-kernel>
 <20180828123607.GB13441@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828123607.GB13441@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Aug 28, 2018 at 02:36:07PM +0200, Greg KH wrote:
> On Tue, Aug 28, 2018 at 10:38:17AM +0000, Ahmed S. Darwish wrote:
> > [ re-send; forgotten lkml CC added; sorry ]
> >
> > Hi,
> >
> > On Sat, 18 Aug 2018 17:57:24 +0200, Greg KH wrote:
> > [...]
> > > addition of some new IIO drivers.  Also added was a "gasket" driver from
> > > Google that needs loads of work and the erofs filesystem.
> > >
> >
> > Why are we adding __a whole new in-kernel framework__ for
> > developing basic user-space drivers?
> >
> > We already have a frameowrk for that, and it's UIO. [1] The UIO
> > code is a very stable and simple subsystem; it's also heavily used
> > in the embedded industry..
>
> As Todd said, the code will end up being a simple UIO driver, if even
> that big, in th end.  It is just going to take him a while to constantly
> refactor things until he achieves that goal...
>
> > I've looked at the gasket documentation [2], and the first user
> > of this new in-kernel API [3], and this is almost replicating UIO
> > it's not funny. [4] True, the gasket APIs adds some extra new
> > conveniences (PCI BAR re-mapping, MSI, ..), but there's no
> > technical reason this cannot be added to the UIO code instead.
>
> {shh} That's my plan :)
>

Cool, thanks a lot.

Can we then merge something like below patch?

[ I've searched the gasket included TODO file before posting,
  but did not find any mention of UIO. Below patch will make
  sure this will not be forgotten over time.. ]

==>

Subject: [PATCH] gasket: TODO: re-implement using UIO

The gasket in-kernel APIs, recently introduced under staging,
re-implements what is already long-time provided by the UIO
framework and subsystem.

Before moving it out of staging, make sure we add the new bits
to the UIO subsystem instead, then transform its signle client,
the Apex driver, to become a UIO driver (uio_driver.h)

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
 drivers/staging/gasket/TODO | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index 6ff8e01b04cc..5b1865f8af2d 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -1,9 +1,22 @@
 This is a list of things that need to be done to get this driver out of the
 staging directory.
+
+- Implement the gasket framework's functionality through UIO instead of
+  introducing a new user-space drivers framework that is quite similar.
+
+  UIO provides the necessary bits to implement user-space drivers. Meanwhile
+  the gasket APIs adds some extra conveniences like PCI BAR mapping, and
+  MSI interrupts. Add these features to the UIO subsystem, then re-implement
+  the Apex driver as a basic UIO driver instead (include/linux/uio_driver.h)
+
 - Document sysfs files with Documentation/ABI/ entries.
+
 - Use misc interface instead of major number for driver version description.
+
 - Add descriptions of module_param's
+
 - apex_get_status() should actually check status.
+
 - "drivers" should never be dealing with "raw" sysfs calls or mess around with
   kobjects at all. The driver core should handle all of this for you
   automaically. There should not be a need for raw attribute macros.

Ciao,

--
Darwish
http://darwish.chasingpointers.com
