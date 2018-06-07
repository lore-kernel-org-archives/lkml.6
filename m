Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 778fErdhGVvXTQAAmS7hNA
	; Thu, 07 Jun 2018 16:48:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6DA8B6074D; Thu,  7 Jun 2018 16:48:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD2aj8kx"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D1760601B4;
	Thu,  7 Jun 2018 16:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1760601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933562AbeFGQru (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:47:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46768 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932598AbeFGQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:47:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so6473261pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1vvE8/Q+vV9bIYURs2xz/1jXvh+r6/GRDdCY4r1ruig=;
        b=bD2aj8kxxJAbhZ2jLn9eHzsNCwYZc9CYHjI/2fAB5uqWd4w8ack0GXcoo95YfJ1AX9
         rySMxJkfUt8lG2uV9yPAwMxmAstv+DakymDwW/m83ykxer2bM7bS0KNfzaEAHEco8EGo
         H2YVe8R4zyv979B2z1nO8hVp3KiAEXSWsEEnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vvE8/Q+vV9bIYURs2xz/1jXvh+r6/GRDdCY4r1ruig=;
        b=G4d6D4wCdZmy3hjbSVpjTZLsZ9NcOXpPH1dKgy5gq1YK4qwcQA2rdyRwIUxl9DWsCr
         vhabD98sm0mmbVUtLiJz2GJnmLqHgQmJ9BS5584/mTqSJ78YG6AcA1vjgjsAolpPT2aq
         dY8dqtDQ7VisTOwOlFim/ZAkwYxMpLZYQFrQSY1vDxhUjCfu9AeJSnISKbVzkOd34U3I
         xrmn+pYJkoWgdwRg6UOET0yc60HXOud5VJUy96o6uWFRkyMimDRs+ELusZpzY97aKvoX
         6qeQQxInB6Dyay1XnOwiIY2FR+XoYBDMt3xGvSJO1GfOzc7ZBT8kDb9YT5e5vveZEW/7
         xhBQ==
X-Gm-Message-State: APt69E2jFUfwj7fYPzYZ0cArhwv4ScmwKZz02iqnQWuyVBkmfIeowtRQ
        d2U+aMezvV960V18YRO8BY/+UA==
X-Google-Smtp-Source: ADUXVKIxy3mcfWPjNnpvLOILfS1EGLCXtddRe7rVaXTG6GICE1NnSzzFduiKzbwXnaMnd50r1Ep2CQ==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr2887643pll.54.1528390064815;
        Thu, 07 Jun 2018 09:47:44 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k84-v6sm77551657pfh.110.2018.06.07.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 09:47:44 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:49:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Martijn Coenen <maco@android.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Arve Hj?nnev?g <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        Chris Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Josh Triplett <josh@joshtriplett.org>,
        dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180607164950.GP510@tuxbook-pro>
References: <20180408174014.21908-3-hdegoede@redhat.com>
 <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
 <20180508153805.GC27853@wotan.suse.de>
 <20180508161037.GE27853@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508161037.GE27853@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 May 09:10 PDT 2018, Luis R. Rodriguez wrote:

> On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> > On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > > On Wed, Apr 25, 2018 at 10:55 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
[..]
> > > 2) Most of those paths are not mounted by the time the corresponding
> > > drivers are loaded, because pretty much all Android kernels today are
> > > built without module support, and therefore drivers are loaded well
> > > before the firmware partition is mounted
> 
> I've given this some more thought and you can address this with initramfs,
> this is how other Linux distributions are addressing this. One way to
> address this automatically is to scrape the drivers built-in or needed early on
> boot in initamfs and if the driver has a MODULE_FIRMWARE() its respective
> firmware is added to initramfs as well.
> 

That could be done, but it would not change the fact that the
/sys/class/firmware is ABI and you may not break it.


And it doesn't change the fact that the ramdisk would have to be over
100mb to facilitate this.

> If you *don't* use initramfs, then yes you can obviously run into issues
> where your firmware may not be accessible if the driver is somehow loaded
> early.
> 

This is still a problem that lacks a solution.

> > > 3) I think we use _FALLBACK because doing this with uevents is just
> > > the easiest thing to do; our init code has a firmware helper that
> > > deals with this and searches the paths that we care about
> > > 
> > > 2) will change at some point, because Android is moving towards a
> > > model where device-specific peripheral drivers will be loaded as
> > > modules, and since those modules would likely come from the same
> > > partition as the firmware, it's possible that the direct load would
> > > succeed (depending on whether the custom path is configured there or
> > > not). But I don't think we can rely on the direct loader even in those
> > > cases, unless we could configure it with multiple custom paths.
> 
> Using initramfs will help, but because of the custom path needs -- you're
> right, we don't have anything for that yet, its also a bit unclear if
> something nice and clean can be drawn up for it. So perhaps dealing with
> the fallback mechanism is the way to go for this for sure, since we already
> have support for it.
> 
> Just keep in mind that the fallback mechanism costs you about ~13436 bytes.
> 

Remember that putting the firmware in the ramdisk would cost about
10000x (yes, ten thousand times) more ram.

> So, if someone comes up with a clean interface for custom paths I'd love
> to consider it to avoid those 13436 bytes.
> 

Combined with a way of synchronizing this with the availability of the
firmware, this would be a nice thing!

Regards,
Bjorn
