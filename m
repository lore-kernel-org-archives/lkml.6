Return-Path: <josh@joshtriplett.org>
X-Google-Smtp-Source: AH8x227UZgNmZrdJNOZ7IRyOU/xMM+Znelcw+jadnZNkZ6mn22kBt6UzfhN57jp5NO9RE4iHefkL
ARC-Seal: i=1; a=rsa-sha256; t=1519862472; cv=none;
        d=google.com; s=arc-20160816;
        b=Yy4zs+kgIMGc58LkDKAO35JWG0eRgvo84PPIcZzyEQ2RCHYsd7ewwWILkgqcZes+XN
         LBN7hO2OgVnPxQMDTxPItqFQXFsdFqL88sfO6hJSNmY6m6vr4FkOkocwGKjWnJQjUp1c
         y88MBVXTY65h8kBf2+WX7y9r+gpxba6g3lKhpz22+ksjp3UZLDjUuYJaIA6Hjn6BV0u1
         68VDIWPXJLl8cSIEI29Up6roVAe/7Tj+BA2+oTbKB/fQai+6iS5/bdfXcxUvRErhCkh+
         J5sWY37mSRd2iYUqymw0Sr5fEc9GItBkD5eSFT9YOdQokr7tO1rpZHuou+Ysea/P6a2u
         q1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=y0RqrcqVjVjOGg7jxjugYpw4/HPGMfFfN6N9CBtlvtA=;
        b=vUKbWzrx9MRA7W3JfO3q6KCCPjumQFExTbxZmNrVrTCpaN/BkpjcMKybutQ8KHqK6+
         pkjUOJ+2hV4v3A1KVZOPW/j67R+kLY7Pe5iy4mhcXGSyllUg3zvbtiO5f6OERL5sbnh1
         OgUTepa2Yiyn/cP/FJ1m85+1h31aFDEOkBTI3sJ51ThxNxATqvjZfBsWEmVY2YijTK+f
         13rJpNaPUuyKsaQ6c5HY7Xfx3b9D0itxE7PKK5RzinsJd/+Xf8OA/J+0eJVrJ1/th3Il
         zvAKYTvtwUYsjJb8z2K08blzriGSJKa2Z+xPL4GRrx3sex7tqBH6dUZB9mDt88t0KiM5
         khVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::197 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::197 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
X-Originating-IP: 50.39.166.153
Date: Wed, 28 Feb 2018 16:00:58 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>,
	stephen.boyd@linaro.org, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] test_firmware: test three firmware kernel
 configs using a proc knob
Message-ID: <20180301000057.GA3426@localhost>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
 <20180228090723.GA11438@localhost>
 <20180228182603.GI14069@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228182603.GI14069@wotan.suse.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593691312263162116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 06:26:03PM +0000, Luis R. Rodriguez wrote:
> On Wed, Feb 28, 2018 at 01:07:23AM -0800, Josh Triplett wrote:
> > On Wed, Feb 28, 2018 at 01:32:37AM +0000, Luis R. Rodriguez wrote:
> > > On Tue, Feb 27, 2018 at 03:18:15PM -0800, Kees Cook wrote:
> > > > On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > > > Since we now have knobs to twiddle what used to be set on kernel
> > > > > configurations we can build one base kernel configuration and modify
> > > > > behaviour to mimic such kernel configurations to test them.
> > > > >
> > > > > Provided you build a kernel with:
> > > > >
> > > > > CONFIG_TEST_FIRMWARE=y
> > > > > CONFIG_FW_LOADER=y
> > > > > CONFIG_FW_LOADER_USER_HELPER=y
> > > > > CONFIG_IKCONFIG=y
> > > > > CONFIG_IKCONFIG_PROC=y
> > > > >
> > > > > We should now be able test all possible kernel configurations
> > > > > when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
> > > > > the built-in functionality of the built-in firmware.
> > > > >
> > > > > If you're on an old kernel and either don't have /proc/config.gz
> > > > > (CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
> > > > > we cannot run these dynamic tests, so just run both scripts just
> > > > > as we used to before making blunt assumptions about your setup
> > > > > and requirements exactly as we did before.
> > > > >
> > > > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > > > 
> > > > Cool. Nice to have it all in one test build now. :)
> > > 
> > > Now what about we start discussing one kernel config only for the future?  The
> > > impact would be the size of the fallback mechanism. That should be a bit clear
> > > in terms of size impact after this series.
> > > 
> > > Wonder what Josh thinks as he help with tinyconfig. We could target v4.18 if
> > > its sensible.
> > 
> > Having any of these unconditionally compiled in seems likely to be a
> > significant impact, both directly and because of what else it would
> > implicitly prevent compiling out or removing. And the firmware loader,
> > for instance, is something that many kernels or hardware will not need
> > at all.
> 
> Oh sorry, I did not mean always enabling the firmware loader, that would add
> an extra 828 bytes, and 14264 bytes if the fallback mechanism is enabled as
> well.
> 
> I meant having only CONFIG_FW_LOADER=y, and removing
> CONFIG_FW_LOADER_USER_HELPER so that we just always compile it in if we have
> CONFIG_FW_LOADER=y, so a penalty of 13436 bytes for those who enabled the
> firmware loader but hadn't before enabled the fallback mechanism.
> 
> I'll note CONFIG_FW_LOADER_USER_HELPER is actually known to be enabled by most
> distributions these days. We have an extra CONFIG_FW_LOADER_USER_HELPER_FALLBACK
> but this is now just a toggle of a boolean, and actually Android is known to
> enable it mostly, not other Linux distributions. Since Android enables
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK we know they also enable the fallback
> mechanism with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> 
> So for folks who enable CONFIG_FW_LOADER=y, they'd now be forced to gain an
> extra 13436 bytes broken down as follows:

Ah, I see.

If you have CONFIG_FW_LOADER and not CONFIG_FW_LOADER_USER_HELPER, then
you only have the in-kernel firmware loading mechanism? Given the
*substantial* size difference between the two, it seems useful to have
that option. What would it gain to combine the two?
