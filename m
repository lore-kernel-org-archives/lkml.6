Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KY9/N9NZGVs3CwAAmS7hNA
	; Thu, 07 Jun 2018 16:16:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 012C1608BA; Thu,  7 Jun 2018 16:16:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGES3tCm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7B4E76089E;
	Thu,  7 Jun 2018 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B4E76089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeFGQQr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:16:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41406 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933320AbeFGQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:16:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so5144328pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jvsNRDy7GwCi4B3W0Qz0Xptd9eM87EAdMLoW6eVLTvM=;
        b=MGES3tCmogM/cAkXP0eedsuNt6Dehg6/YBsK8qPypV3gI8wABJ1+/UWPMJl0kCQzfv
         cmgydhWUCp5UZ3TxdevnOGhG59FomZbchu0QqROBEVyKIJrG5GUhBv/ITJ6NKcRgC1VD
         OzcC5mrxU+dmUwi74fNe7ZBwKKSY6MUMSMNC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jvsNRDy7GwCi4B3W0Qz0Xptd9eM87EAdMLoW6eVLTvM=;
        b=DXMSLGE6DmWjDsm/E2UsYy6c2T1krofO6o0Eb7/a3V3l+ShkSuUpzeNaXRvGQcux38
         ZhbKn9Clb+ODcm+r6EY9j4T2oxCSlIE1zuDr3aGS/ybdVfQXFuOk+MhEbTyi/fARpWvT
         5Xzf0zzNZ/adJDnsulVJzo3BUWjf5XWu7StrJcNX3rYTE7X0eCCV67EhzCM4ox9Wu8V2
         B7l4TOhCueXa6no1GPJeNveH//LE7TvgYrqWaGwOQiPfZ22iZL6ZEVYT2amkb8FdXLl0
         7V80HJgl+meGy5gCydAtpddvZPRsvkX6e6KgeLCRLzs1xOuFEiErRuxULEIdvg4s9xjd
         jIeA==
X-Gm-Message-State: APt69E3wDxAheDaFzqCazqbEZ3iSKoSSaPeLQN0fblvho3/IEUDJH28P
        hQ2sMvXL1ulIeOVI3DrWcrgRSg==
X-Google-Smtp-Source: ADUXVKI+KfgJH91YnshlR9I+y1FF+x/BmhkhygvWAsgrNrnAyq0KxjdGbJHJdc/QXPHE6KASOvAn/A==
X-Received: by 2002:a63:7f4f:: with SMTP id p15-v6mr2119076pgn.312.1528388201747;
        Thu, 07 Jun 2018 09:16:41 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j15-v6sm25384570pgv.17.2018.06.07.09.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 09:16:40 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:18:47 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Laura Abbott <labbott@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Martijn Coenen <maco@android.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Arve Hj?nnev?g <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        linux-security-module@vger.kernel.org,
        Chris Wright <chrisw@sous-sol.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <alan@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
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
        dmitry.torokhov@gmail.com, Jonathan Corbet <corbet@lwn.net>,
        mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nbroeking@me.com, Torsten Duwe <duwe@suse.de>, x86@kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: Do Qualcomm drivers use DMA buffers for
 request_firmware_into_buf()?
Message-ID: <20180607161847.GN510@tuxbook-pro>
References: <20180423211143.GZ14440@wotan.suse.de>
 <71e6a45a-398d-b7a4-dab0-8b9936683226@redhat.com>
 <1524586021.3364.20.camel@linux.vnet.ibm.com>
 <20180424234219.GX14440@wotan.suse.de>
 <1524632409.3371.48.camel@linux.vnet.ibm.com>
 <20180425175557.GY14440@wotan.suse.de>
 <CAB0TPYGnCu+anWHBGvkaigxD--8uHQaQJ2c62kegJ7mTqvkmnA@mail.gmail.com>
 <20180508153805.GC27853@wotan.suse.de>
 <20180601192346.GQ4511@wotan.suse.de>
 <20180606203257.GH4511@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606203257.GH4511@wotan.suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jun 13:32 PDT 2018, Luis R. Rodriguez wrote:

> On Fri, Jun 01, 2018 at 09:23:46PM +0200, Luis R. Rodriguez wrote:
> > On Tue, May 08, 2018 at 03:38:05PM +0000, Luis R. Rodriguez wrote:
> > > On Fri, May 04, 2018 at 12:44:37PM -0700, Martijn Coenen wrote:
> > > > 
> > > > I think the Qualcomm folks owning this (Andy, David, Bjorn, already
> > > > cc'd here) are better suited to answer that question.
> > > 
> > > Andy, David, Bjorn?
> > 
> > Andy, David, Bjorn?
> 
> A month now with no answer...
> 

The patch at the top of this thread doesn't interest me and you didn't
bother sending your question To me.

As a matter of fact I'm confused to what the actual question is.

> Perhaps someone who has this hardware can find out empirically for us, as
> follows (mm folks is this right?):
> 
> page = virt_to_page(address);
> if (!page)
>    fail closed...
> if (page_zone(page) == ZONE_DMA || page_zone(page) == ZONE_DMA32)
> 	this is a DMA buffer
> else
> 	not DMA!
> 

Where do you want to put this?

> Note that when request_firmware_into_buf() was being reviewed Mimi had asked back
> in 2016 [0] that if a DMA buffer was going to be used READING_FIRMWARE_DMA should be
> used otherwise READING_FIRMWARE_PREALLOC_BUFFER was fine.
> 
> If it is a DMA buffer *now*, why / how did this change?
> 

>From what I can see [0] says is to use READING_FIRMWARE_PREALLOC_BUFFER
regardless of where the memory comes from.

Regards,
Bjorn

> [0] https://patchwork.kernel.org/patch/9074611/
> 
>   Luis
