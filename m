Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B294ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11852084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11852084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbeGSQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:14:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40488 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbeGSQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:14:12 -0400
Received: from mail-wm0-f69.google.com ([74.125.82.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fgAsv-0004oD-U3
        for linux-kernel@vger.kernel.org; Thu, 19 Jul 2018 15:30:29 +0000
Received: by mail-wm0-f69.google.com with SMTP id v25-v6so2561119wmc.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8fSan+O4lEPAdgDPjChNqfahywNONez8+cWRiDNkgo=;
        b=BEkQ7NBvdWJld0lFfIP7H8Gm3mYpK08dg0p84kSQbBTy67wkpQP6EHUSDWesxLIr03
         PHR5JVboTxp8Ab0VuwsXrvBgEg8M6xRgfMKy8qPnV9RcfRKfSWzYJfJ581pi3ViQI09l
         z5PzEoUBfWJ9S0UfSOC1FoKdGRO56B8WphaniUboBYo8ImkqPqqxzIhZVEDclN9Y1uSN
         Xw9P+WjfYuHITahKrrQLO87j27IZBNSk8AU2ydiLcK6miAID27natv6D+Kf5MK8DfWRW
         KZ7d8gdafdpL6XKIba/M6KhSj28aVpd6CCGVJMOxrZoZp/RtWAVPJM29i4ciesmuynFj
         8Ofg==
X-Gm-Message-State: AOUpUlE9yXn4Rvqqi9ZR4MreZioUun8M3Mj6pXv6r68zPVtGvUbWLGN5
        e1K2mQYRKdqqVWxX73ZPRT4eLpDultsSIog0LGWx311fET/YWFw1d94QBoydjCX45xXzfmbRWnf
        YZgiNoI7+bJ9JujA0ERsgb/9rVyRF8k9ExCPcgeWD0g==
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr4478088wma.134.1532014229639;
        Thu, 19 Jul 2018 08:30:29 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpf517+CuwKYIFpcN10DqvT70FXYZkJBZJn63SinjbtEqX8+I7yIJ7ANYwQ0bE85o/u/rgeLhA==
X-Received: by 2002:a1c:3e92:: with SMTP id l140-v6mr4478068wma.134.1532014229403;
        Thu, 19 Jul 2018 08:30:29 -0700 (PDT)
Received: from gmail.com (eap108016.extern.uni-tuebingen.de. [134.2.108.16])
        by smtp.gmail.com with ESMTPSA id s5-v6sm7426162wro.33.2018.07.19.08.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 08:30:28 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Thu, 19 Jul 2018 17:30:28 +0200
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        linux-api@vger.kernel.org, ebiederm@xmission.com,
        seth.forshee@canonical.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/6 v1 resend] statfs: handle mount propagation
Message-ID: <20180719153027.GA21410@gmail.com>
References: <20180525124825.23875-1-christian@brauner.io>
 <20180613140625.GA31082@mailbox.org>
 <20180613142454.GA1845@kroah.com>
 <20180613150702.GA5403@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613150702.GA5403@mailbox.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:07:02PM +0200, Christian Brauner wrote:
> On Wed, Jun 13, 2018 at 04:24:54PM +0200, Greg KH wrote:
> > On Wed, Jun 13, 2018 at 04:06:25PM +0200, Christian Brauner wrote:
> > > On Fri, May 25, 2018 at 02:48:19PM +0200, Christian Brauner wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > 
> > > > Hey,
> > > > 
> > > > This is v1 of this patchset. All changes from v0 to v1 are non-functional.
> > > > Specifically, the commit messages and justification have been extended as
> > > > requested by Linus and Al.
> > > 
> > > Hey everyone,
> > > 
> > > Just a ping whether the requested changes have made this series suitable
> > > for inclusion. Would be excellent if someone could do another review. :)
> > 
> > It's the middle of the merge window, no new code gets accepted right
> > now, so just wait until next week at the _earliest_ before worrying
> 
> Ok, sorry. It was just that this was sent out before well over a month
> ago and I was just worried that it had been overlooked.

Hey everyone,

It's been a few weeks. I just wanted to check whether the changes made
to the series would make it suitable for inclusion. I checked against
current master and it should still apply cleanly.

Thanks!
Christian

> 
> Thanks!
> Christian
> 
> > about someone reviewing this.
> > 
> > thanks,
> > 
> > greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
