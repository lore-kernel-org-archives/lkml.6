Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kcoNHXofG1vaCwAAmS7hNA
	; Sat, 09 Jun 2018 00:33:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7C0D46089E; Sat,  9 Jun 2018 00:33:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdNItCiK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E19BB602FC;
	Sat,  9 Jun 2018 00:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E19BB602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeFIAdQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:33:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeFIAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aukOO0HPl/mCQ+SiE+ZdsI1IEF4QiZwx97LqPvobG9w=; b=KdNItCiK/7t9IIxv8pDVCze0u
        QT8oQPF8u7WNrh4+DZ3xNnGu93Sm6WdjW2/B2piXhJF+SPrB4F4a2SR+EakNU8eOsqr+JKjKw5K4D
        xaCHIJqxS8pydlHmtABKGJ/CGQ39mjiFnvQjds3N7CSprbsKJ+d6lrN2jxr61i+aNDJLe5Dmw89ZM
        BiYy+Hxh7WmqDffI3+B7OCXUweP5eDuxO5nmDtpftrAVvX3y8eybWN93n2N//qG9VyxlpDK43FgY0
        5fKIgrJN4NjqpdDxudlMRltqsReQZ6s7y/SBHjwQX4zsleGVFE9R0MhbEm9+IjIZIFGuyT4tIqZ+v
        KxvEdbYgw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRRoW-0000uS-U9; Sat, 09 Jun 2018 00:33:04 +0000
Date: Fri, 8 Jun 2018 17:33:03 -0700
From: Darren Hart <dvhart@infradead.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
        Chris Chiu <chiu@endlessm.com>,
        Bastien Nocera <hadess@hadess.net>,
        Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: Call new led hw_changed API
 on kbd brightness change
Message-ID: <20180609003303.GD111314@localhost.localdomain>
References: <38cb3527-8480-bdb9-a5d9-b601bc494a5f@redhat.com>
 <71df09bc89619aba975147e6b07920f1dfc2f46f.camel@hadess.net>
 <cd6a5d86-1fdb-2561-1e29-0553be53c41a@redhat.com>
 <94789b55b88ae5a296e1fca3b0311318e7b507ee.camel@hadess.net>
 <0443419b-3147-163b-374d-bb8651b08837@redhat.com>
 <cfb6ff791a9034f8ade738085475e946b3d7519b.camel@sipsolutions.net>
 <362131bf-3b6b-58aa-bda6-003f5ffb5e8e@redhat.com>
 <CAB4CAwfZtA8mf4MwJq1AA1wqwJB-HLXuiMmkzkow3NykRsHkSw@mail.gmail.com>
 <33c55842c8d9ce199f0f8ef314dea85fb848b0be.camel@sipsolutions.net>
 <173fdeb2-8129-57eb-fe2e-3ae16eec54b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173fdeb2-8129-57eb-fe2e-3ae16eec54b6@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 05:32:52PM +0200, Hans de Goede wrote:

> > > > > If we are adding hwdb entries anyway to control the userspace
> > > > > interpretation of the TOGGLE key, then we could also add the new CYCLE
> > > > > key and explicitly re-map it to TOGGLE. That requires slightly more
> > > > > logic in hwdb, but it does mean that we could theoretically just drop
> > > > > the workaround if we ever stop caring about Xorg.
> > > > 
> > > > Hmm, interesting proposal, I say go for it :)
> > > > 
> > > 
> > > So maybe the next stop is that I can follow Darren's suggestion to eliminate
> > > the is_kbd_led_event() and send a v2 for review?
> > 
> > I believe the best compromise we have right now is to do what Hans
> > suggested in an earlier proposal. That is implementing the two separate
> > behaviours in the kernel
> > 
> >   1) handle this in the kernel as if the hardware changed it, and
> >   2) send a new KEY_KBDILLUMCYCLE event [default].
> 
> I think you mean or, not and, depending on a module option the
> code should do either 1) or 2) not both :)
> 
> Darren, Andy could you live with a module option for this?

We are of course strongly opposed to adding module options.

I agree we can't ignore Xorg.

I agree policy in general should not be in the kernel.

I also see many of these drivers as the last mile to getting a platform
fully working. If there is a place for one-off fixes, it's in these
drivers. I'd love to refactor and use proper abstractions and all that
as the patterns make those abstractions clear - but I don't want to
delay getting something working waiting for the ideal solution.

So I have two questions I'd like to confirm before saying "OK" to a
module option.

1) Hans I think you said that doing the code conversion from TOGGLE to
UP based on the LED value and the max value was racy with userspace.
What is the failure mode here? Is it not easily recoverable? And how do
I enter it? Do I have to simultaneously modify the software brightness
control AND press the keyboard brightness control? How practical is
that? If recoverable AND hard to trigger, I think there is value in the
very simple 3 level brightness cycle being handled in the kernel.

2) Why is a module option preferable to a compile time option? It seems
to me the policy will be largely distro dependent, and the same kernel
needing to support both modes seems likely to be pretty rare.

-- 
Darren Hart
VMware Open Source Technology Center
