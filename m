Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED3EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F11215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWCUp0Jx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F11215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964887AbeF1Mcu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:32:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34259 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeF1Mct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:32:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so20629538wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TY7Cb884+Sla7/kOAhvrWdYiG0FoREBQjkAAHhprHOw=;
        b=rWCUp0Jx3FSzR9sp7coKleDMUvYapm6qGAYB4baglg+QxkXD3oy7uakSnxIcmB3xMr
         pnLw2Pa+qpcBBG81LYppoXGkW2h4D26aUb3UD4cAPDFN2OEkoqQIkvuJXf/RVBjLMNYw
         k+W5C1s9MLof6oAsLqSTGyiwJaV6UurPJUuRvUKZBgiwFJRxtwv31MoO0qs8EuGHjIKv
         G6NuaH9+UZr4hw4JrGtTKyj1KzByLWML0noPqL8avrryRCfLrChFKqztzy9oAEbhOGKG
         FIvwXCMsX3zhAsjUrrdenNcvMy4PO3IOW+w4vVmtnVXMoOWIZiObqUqy7UuMUL2QQxJ6
         jQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TY7Cb884+Sla7/kOAhvrWdYiG0FoREBQjkAAHhprHOw=;
        b=EK2XU4hYtmfQ1ojSd2Qk7sSesdwcKwEz1eZnbALl62i87D/4+KSXcRnEWoM6aX0+q/
         t3hDnDEMs0FCUzROu0eBOxPdjRmRn/IbFLYeDsO6/CV6AkRZJ0T+6VRQCGHzuCDMkYW/
         ewaRbGBc763xzGOmuMs81rRvGaiCu2aV6HdgpEadTKEmmMgWpCiVwkegl4R8tLymNKFE
         oA7MtMB91+mHI6KxzhGoR4c8sc9R3bGBnhOKhcu33baXt9XbpmmCqqCy1pYP38cNeOCJ
         HezyYfGQmGY4AlYrySrGx79XyKNc3bB8l5no+TI7ON7j3YFOp0p6Fb6ikkDrOueYiass
         Uoxw==
X-Gm-Message-State: APt69E1plFBIaOb/WZ4NR8mjmfvoPzdAhkTDSsYZBmb9eKL/0E46+3cq
        Jg3m+f+gHfxo3lpuS20rL/0=
X-Google-Smtp-Source: AAOMgpd8gCIV0z8qZ0FEg5R8GmLCKQafWcVgKquw59gcKyYOf1Li3w7mKJjGOe9aZK4vGvdm0T9ZXg==
X-Received: by 2002:a1c:8206:: with SMTP id e6-v6mr8258892wmd.24.1530189168083;
        Thu, 28 Jun 2018 05:32:48 -0700 (PDT)
Received: from xux707-tw ([109.77.208.206])
        by smtp.gmail.com with ESMTPSA id n14-v6sm7482487wrm.23.2018.06.28.05.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 05:32:47 -0700 (PDT)
Date:   Thu, 28 Jun 2018 13:32:41 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH v3 5/8] staging: rtl8192u: Use %s and __func__ instead of
 hardcoded string - Style
Message-ID: <20180628123239.xqv3lb3bqos467z6@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-6-johnfwhitmore@gmail.com>
 <20180626035624.GA26173@kroah.com>
 <20180627202248.mvohkxjhwsv5hcn6@xux707-tw>
 <20180628073828.hur7njmsstg2jwvx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628073828.hur7njmsstg2jwvx@mwanda>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:38:28AM +0300, Dan Carpenter wrote:
> On Wed, Jun 27, 2018 at 09:22:50PM +0100, John Whitmore wrote:
> > On Tue, Jun 26, 2018 at 11:56:24AM +0800, Greg KH wrote:
> > > On Sun, Jun 24, 2018 at 04:34:51PM +0100, John Whitmore wrote:
> > > > Changed a number of hard coded function names to use %s and __func__
> > > > 
> > > > Mailing list response suggest that there is a better method for debugging
> > > > using netdev_dbg(). I can't argue with that, but for the moment this change
> > > > will clear the checkpatch.pl Warning.
> > > > 
> > > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++++------
> > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > Did not apply :(
> > 
> > No worries, can I just ask is that because it should be changed to use
> > netdev_dbg as was suggested? And should that be across the whole file?
> 
> "Does not apply" means you save the raw email to email.txt then download
> the latest code from
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-next
> then `cat email.txt | git am` and it fails.
> 
> Probably someone else's patch was merged ahead of yours.  Fix it up and
> then resend.
> 
> regards,
> dan carpenter

Thank you for that. I read the sentence and filled in my own pronoun as there
wasn't one :( So I read it as "I did not apply" rather then "it did not
apply". That's great that 'it' did not apply, thought I'd done something
wrong. I'll have another crack at it later if I get a chance.

Once again thanks

John Whitmore
