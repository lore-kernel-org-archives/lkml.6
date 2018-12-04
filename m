Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303DD2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADCN68sX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303DD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLDJCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:02:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:02:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so15004121wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djTzPzGyrZiEHxmAlWU5eT5nDI4Ncu8dwRdabVKYnKA=;
        b=ADCN68sXDPMjSrE+pQtTfYPv59b7ZgDJ3gVY6Fsk5tWjz9Zc/fMcTi8U1Aw6DLt6vE
         P/uJHTchmSoDEPDPeu2PCYf+x7pzcBV+ZHsqUkK35U4hwnazvtSa7A1d7fL42myjBJOQ
         NvE07ChhbKANj1LAMCZ0S3exsLXZJ88FyCOHioLmXNKSH1/tJ7tMqFoZfcm/d+s7EuTU
         xihT49HpfmXYJr/97uZYgigrQDWMhVLInwlAxbWwr6dBUyQoClSH0/zBauNvHBUv48Nt
         nHA6Z8Ycrzqeb+6BNpTRskamNyBh/boSGCSGFA9v8VGkYaXuNZ1NVzsrtqxOtT6arLjr
         l6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=djTzPzGyrZiEHxmAlWU5eT5nDI4Ncu8dwRdabVKYnKA=;
        b=CQe8NaEDxBZ6cT2u+HaeHtvfSzuDqqJbscIepLE2LODTs+EtydYXMKc3u0yKVAshJq
         bm3j/QUi9C5/oeuSB8dsrjPmJxL2vWvfw13VR57WgWG/pbGvwxSBQUfU0JkRLNLX4mFc
         uXpJSIOJNFthoyxrSn0/uAfJMgwrupC431yMKxltmU8uF7Kinr+chGmdCnrz+xvuINI3
         zjQZZf4t1OjlkKFHDwWV2o22ksjUrTvxElVKiWZnns3joTqMDvtG3MNnPRgRFL9FFXpx
         yVRftlRazr3BA7O31Gs3I0vWn1Fx0UyQfUIqPMKH6r9dfrKSR1hM/kP8ny353BKz4Ctf
         E6pw==
X-Gm-Message-State: AA+aEWb0L/yZmjq7rQsPoAC3E+vlzXOk0w146qBOvykt16yF9nx2eRCP
        PArzBFny9if2j6QMb2Vg7Ic=
X-Google-Smtp-Source: AFSGD/V3EjZ/aPRg1UAgG0yAGuvqQwyA23Lf1TrN7GMR3KViEe5w3hqE6wEuiDz9HJO2KlbuudqrWA==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr17641464wrs.279.1543914151856;
        Tue, 04 Dec 2018 01:02:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b7sm12943741wrs.47.2018.12.04.01.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:02:31 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:02:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chanho Min <chanho.min@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux
 4.20-rc4)
Message-ID: <20181204090228.GC73770@gmail.com>
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com>
 <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com>
 <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203141737.GY31738@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Hocko <mhocko@kernel.org> wrote:

> > Do we actually have reports of this happening for people outside
> > Android?
> 
> Not that I am aware of.

I'd say outside of Android 99% of the use of hibernation is the fail-safe 
that distributions offer on laptops with very low battery levels: the 
emergency hibernation when there's almost no power left anymore.

Do these hibernation failure messages typically make it to persistent 
logs before the system uses power?

In practice if that is buggy the kernel won't hibernate and the laptop 
will run out of power and the user will conclude "ugh, I shouldn't have 
left my laptop turned on" - without looking into the logs and reporting, 
as they'll perceive it as a user failure not a system failure.

I certainly saw random Linux laptops fail to hibernate over the years and 
didn't report it, so if the distribution doesn't do the reporting 
automatically then chances are we'll never see it.

Thanks,

	Ingo
