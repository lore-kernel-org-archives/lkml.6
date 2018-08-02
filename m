Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B969C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C3621525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HFGg0RD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C3621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbeHBRK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:10:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33781 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbeHBRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:10:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so1093557edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtBjHKBRWCTND0nq29zdYttazcwXXmGJgqYkpmhpM60=;
        b=HFGg0RD5Fj6clhPSUOZd/4T3XzAISnjU0+RNDwI4X7L5EY9d/zFCOZcVohV0eA5frZ
         mV95S0jgBwaVBCfORJqO/PmMBiQNn9kCxuDhmL/PN5MQufrKJ8j8yDPRTPkWzcn75vY5
         5bywSrzksk5otuACjqFE1AhbcSp0h8TpRKBG9H6aT4mnCFzEOXTniwEuUm2ClKCl/fp7
         i03QyzsnQpX0iuc08rvxW1F6I6gVRYasKuRBtesesX0ku52SHXe1z6ZNt7f9O7P2/vMB
         eBSe1fTiy/E+BzFrjMFNzpwSAk5384jvhrk3UK6lBRe6hYz6kLBtL8Jo3Fgf+Z9r1+Zu
         ZX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtBjHKBRWCTND0nq29zdYttazcwXXmGJgqYkpmhpM60=;
        b=UNHFX/vI/5u3t33n95JdDpeVZzFkYTpNAPngcmRH8IsnxwAypJdc8r2fBq3pdIl3Ey
         sRXRV3Lm3LkRw64Bas1dSr9TZjFxx+VxbyHEYwFG1d7I/NjTs4i+8Lv65C5T4wAINz0l
         Wax59YPqv+TwNgfWOyJBTyUHBKyCzxwTCUsqJarSFi/sWmxy1CYOMiCbWBUVgk8oDhTQ
         UnTXtlX5uT8I5Tlznxf/qeaEvL8TWF7gOKW6/n8vogpaPFaMa/8Op9TJ/utbSkKeNvf5
         rEzRNSri2Ugr3k7xCbZlWHIm07q2p1zPe+0oaJpNK3PgGQ+QIN9TYzPJVcsobLW4ImDb
         50mg==
X-Gm-Message-State: AOUpUlFBYT/daE/kINA1+LLMeIThc8DY3vKUth/8zL/BgRmRUykQ0wRE
        QM3RLJ28Wyi9Cv7iC3F4VO9hZw==
X-Google-Smtp-Source: AAOMgpdyED36QLv8abxDILBk2cS1GVpv7p3xgtVHN9Qr3qMUKM3R+01Zb6gCEZJkgYtcjeS+xJhu+w==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr3855999edz.79.1533223160091;
        Thu, 02 Aug 2018 08:19:20 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c25-v6sm865750edt.54.2018.08.02.08.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:19:16 -0700 (PDT)
Message-ID: <1533223155.2679.136.camel@arista.com>
Subject: Re: [PATCHv3] lib/ratelimit: Lockless ratelimiting
From:   Dmitry Safonov <dima@arista.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Thu, 02 Aug 2018 16:19:15 +0100
In-Reply-To: <20180801214855.3ae1abb9@vmware.local.home>
References: <20180703225628.25684-1-dima@arista.com>
         <1531789154.18720.3.camel@arista.com>
         <CAHp75VdmQ1YLzWpYb7878zKOCCyOEicdLAtpohbmY2hL1h1RNg@mail.gmail.com>
         <20180720150948.nv57fjmmrmo2r7rx@pathway.suse.cz>
         <1532100816.18720.44.camel@arista.com>
         <20180801214855.3ae1abb9@vmware.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Thanks for your reply,

On Wed, 2018-08-01 at 21:48 -0400, Steven Rostedt wrote:
> I'm just catching up from my vacation. What about making rs->missed
> into an atomic, and have:
> 
> 	if (!raw_spin_trylock_irqsave(&rs->lock, flags)) {
> 		atomic_inc(&rs->missed);
> 		return 0;
> 	}
> 
> ?

Uhm. Do you mean as a preparation patch to split this on two patches?
Because it will not solve the issue where one CPU has taken rs->lock,
and is updating rs->printed, checking burst and whatnot; while the
second CPU will loose the message which was even *under* burst limit.

I.e.: there are enough of printk_ratelimit() users in tree and a
message from one can be suppressed, while shouldn't.

> You would also need to do:
> 
> 	if (time_is_before_jiffies(rs->begin + rs->interval)) {
> 		int missed = atomic_xchg(&rs->missed, 0);
> 		if (missed) {
> 
> So that you don't have a race between checking rs->missed and setting
> it
> to zero.

-- 
Thanks,
             Dmitry
