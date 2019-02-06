Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05561C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D3C2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4wvdLC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfBFIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:55:28 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35288 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfBFIz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:55:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id l142so4793924lfe.2;
        Wed, 06 Feb 2019 00:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GLDfZmSNM30C49L/laWm285X7f6T1jw10bM39mOPJME=;
        b=C4wvdLC1fmI+KGvcpvTVJadrrUlz0RywpXFZGxOukmMiNC+3Oth+kLskPWOsxxkO5u
         PEwuqgBAPhTTZENYVsPRkWsGgwJwiHJEomweI2h2fjuDAqRbIy58IK5HMh7trJSEEi7g
         gaXfP84zBuY05QIz1o8PwQGyqFECuB8EO1TTBSA2ONW5nH0Sgz258egtyr+fmkt6xsyw
         r3NM67skxhzjUH3G6KtDGy2Uxnik+Dfo3xDZG8xORZx/1HIKcCPnjXRcOCrqTJdtICXD
         Zv0ohyBj90tOvn+kpJ3GsbfrIOh/eq4GqqcJ5mFgwgDCjjdX6mFSWxuaZStrwbQkR+G9
         ps5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GLDfZmSNM30C49L/laWm285X7f6T1jw10bM39mOPJME=;
        b=DyHOBXga8yK6YxJo5SUNgnMeipl+G5VhWc6JP6zEz+7cv8eACP0EvkNrgYrT4BwSQ8
         XH2WUGQ87uIdTII+cNk+Rt6791yo8opdKxONf38c7FYGxJB/bejpKHOdeUfOmggp13bW
         5fXG6ykYFpDUR/WogH77A9UJNJEY40aPtL7D25ue8FEAyDX1LA5vaJEGqIw/Q2hbeqFd
         s0dtjCCWWnnX2ohKVwVK0lj5BeTk8N4vSjlGfQ9NnXc6bXm41Mglus3Lvwdrf8DhIeOp
         Md9hipK3wxNq98GfX6Jbua7wB9baoGEQ7U4hn2oUTr3vV/foVWk7hsnbznKMhau6TW0O
         IqlQ==
X-Gm-Message-State: AHQUAubAPKw8tyvrjiYukPSoiyB6iCzLdjL0Xu9L/20TNzVNCIS8b2YY
        rO3SzgfDoUBHH23kdb9eFBU=
X-Google-Smtp-Source: AHgI3IYm28s1u0T9q/r22k1/tOHBY+XczDxXPDkDRJg5OduD1z1jlv3R6tPSgj/BIww0mM2d5jxVsw==
X-Received: by 2002:a19:aace:: with SMTP id t197mr5763249lfe.7.1549443326294;
        Wed, 06 Feb 2019 00:55:26 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id x11sm4646252lfd.81.2019.02.06.00.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 00:55:25 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 511364606E4; Wed,  6 Feb 2019 11:55:25 +0300 (MSK)
Date:   Wed, 6 Feb 2019 11:55:25 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 05/32] timerfd/timens: Take into account ns clock offsets
Message-ID: <20190206085525.GC25251@uranus>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-6-dima@arista.com>
 <20190206085203.GB25251@uranus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206085203.GB25251@uranus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:52:03AM +0300, Cyrill Gorcunov wrote:
...
> >  
> > -	if ((flags & ~TFD_SETTIME_FLAGS) ||
> > -		 !itimerspec64_valid(new))
> > -		return -EINVAL;
> 
> Please don't defer this early test of a @flags value. Otherwise
> if @flags is invalid you continue fget/put/clock-to-host even
> if result will be dropped out then.

Just to clarify -- this could be done on top of the series to
not resend the whole bunch.
