Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE74C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C50214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TAZr24Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C50214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJSDSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:18:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35001 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSDSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:18:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so34884366wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3X8ou2N3Qjk3uAGT+ho6wSC4R/w7pkwUTWegc+yYDWQ=;
        b=TAZr24NvMbiwy2rJwtTacgPAB/SAVlUgZFBA30OMvpg3/R0N7fOL4xx6iFQLBBRCWL
         sEPp2xGXVRLEtMbXofwdkHtgXx6+56Bg7Mt82THOH/7dbz7xYZcTo4c3JBLAVep2J9MG
         bdcecD5giaXbVw+/tl+3oAiHnV9XmcaipZuoelmxX8U5Ec/jwHfhAf8CnfB8lJbFWf/H
         y5tSz1Oa77ASR/5/DC5J+aX53lJpEG0L4KsGQogCGzGHG6xuOMFUR/6aBNJBFcCUtuV6
         mqs/61Uiv4QSKkaencIua1kbfrR3w+7gpAS3rN+47175u24ytEE475bmy/G6t+NKLIik
         bodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3X8ou2N3Qjk3uAGT+ho6wSC4R/w7pkwUTWegc+yYDWQ=;
        b=otaaaXA1PD6S1axR7xrC3xIXN+JG5ll7uJb/8tImtLpbbMv/EPT8BMPJ0SWarzgZj/
         NWK/y62uW6ZV+JBM9MMabIRcAGbW+V0uZPIriROwtmkpn0YEfL+oiE8dS+C2ztHIO1CL
         dWVMQOdZhsIbxQuZC4GPrH66ME26nJNZo9KCjlFQDgKBgpNDWBSGTdp9oK3R6MfBYnWI
         Dn5QEWYbILy73P8xjm00Kh3JCZKtBEWsltXDIR8AYlT42W/PtmPFBpli4JH/m8PjhB79
         4CdAMQMxJasbiJx9Cgfl3jludI9dCED59HUSsjIHjTeBn6AvKV/CwShmjUeO87dsbcjs
         dQ5g==
X-Gm-Message-State: ABuFfoi1RQlIDI1UEcAkjhLC1kUrnGCMWqHNXhZNb/F6VNKT59x6bA6R
        y1MDVsZOCODwKy0xYJaP4q7z6w==
X-Google-Smtp-Source: ACcGV61Q2QJ3EIxqUdhrkA+WMiaISmy91UuApVFalzD/INnkyKch4cy4z9myxupzWP4IXCk+Y76roQ==
X-Received: by 2002:adf:a144:: with SMTP id r4-v6mr29792474wrr.169.1539890174954;
        Thu, 18 Oct 2018 12:16:14 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u76-v6sm1728921wmd.10.2018.10.18.12.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:16:14 -0700 (PDT)
Date:   Thu, 18 Oct 2018 21:16:12 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     andrew@lunn.ch, davem@davemloft.net, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: fec: Add missing SPEED_
Message-ID: <20181018191612.GB31736@Red>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com>
 <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:55:49AM -0700, Florian Fainelli wrote:
> On 10/18/2018 11:47 AM, LABBE Corentin wrote:
> > On Thu, Oct 18, 2018 at 11:39:24AM -0700, Florian Fainelli wrote:
> >> On 10/18/2018 08:05 AM, Corentin Labbe wrote:
> >>> Since commit 58056c1e1b0e ("net: ethernet: Use phy_set_max_speed() to limit advertised speed"), the fec driver is unable to get any link.
> >>> This is due to missing SPEED_.
> >>
> >> But SPEED_1000 is defined in include/uapi/linux/ethtool.h as 1000, so
> >> surely this would amount to the same code paths being taken or am I
> >> missing something here?
> > 
> > The bisect session pointed your patch, reverting it fix the issue.
> > BUT since the fix seemed trivial I sent the patch without more test then compile it.
> > Sorry, I have just found some minutes ago that it didnt fix the issue.
> > 
> > But your patch is still the cause for sure.
> > 
> 
> What you are writing is really lowering the confidence level, first
> Andrew is the author of that patch, and second "just compiling" and
> pretending this fixes a problem when it does not is not quite what I
> would expect.
> 
> I don't have a problem helping you find the solution or the right fix
> though, even if it is not my patch, but please get the author and actual
> problem right so we can move forward in confidence, thanks!

Sorry again, I wanted to acknoledge my error but I did it too fast and late.
And sorry to have confound you with Andrew.
