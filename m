Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x227BSZ3AYRMYU2d4iMUEWzF5RR5LKZx/BtVeY0fNsfgbFgKoViihxpuWAMxTCqmph9JI6IdX
ARC-Seal: i=1; a=rsa-sha256; t=1519842365; cv=none;
        d=google.com; s=arc-20160816;
        b=AeXpiXxLxHfEcj6k8nIKyWWRpP3gA5xc1jqhCZvXyir+zXSF9YijTwAdfo8kCVDB9h
         /CvJR5EVV0Iqo2u8QDFm7ImallW0Jp3/cx2LpsmuYrG8jkQ+KSvhUa80MVPpnzx3ob7S
         zH8A4OgiMuMLzOWF+2Tdx6I+wR9JGpJJkkTKZWjMgr5lX6MOr7lik/BBFYMkFAOdU+aD
         R0l+gBMOhg4CSMtM6ZIwnToyrUK9BP6fwY+hIu6J+hrHTA3w0XFmKGq+H8DbKXUrA8Uq
         rFhHDPVsGpvlxgo265JXcktHSx10TAYj09b1Dk6JL+pVT15xj4FywHRwOIlLXsOXYUsX
         BUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xo2tPDROzHp2Bkr6qhqAwu7J9Z3FHWElPFpVq++8PU0=;
        b=ywWhbMobpkS4lKACt5G7kFJaoDZbt3rZ4vYmbT1UEAlGXqcgckplvWINor5iZy/sQV
         6KTz2FZU7uoMIQgtbk7Saenxv891/cR5HG0M2STA3UTOTbcJ96BxcNUVNlsnJRerz3bI
         L60egjRr1ooekG6XouaJpZ6VTp/VqtmPlI5/zYf6KoemPluEjKH0AcuGcJ7IyJh2mkJc
         ivb0LBseXb/zg5jLyHmVHdR2l3iOKAcnoxw+CRR3u12ug0IM1GoeqQOH0EXsUeoN9Oc9
         NFKKQ0UaJnoClriJAI3GhDcKLeGaAaX1MkLR7eyn7swaakJ7EeaFa4A0klmPXGnwmPKt
         Nfbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 18:26:03 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20180228182603.GI14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
 <20180228090723.GA11438@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228090723.GA11438@localhost>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593670228710803501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 01:07:23AM -0800, Josh Triplett wrote:
> On Wed, Feb 28, 2018 at 01:32:37AM +0000, Luis R. Rodriguez wrote:
> > On Tue, Feb 27, 2018 at 03:18:15PM -0800, Kees Cook wrote:
> > > On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > > Since we now have knobs to twiddle what used to be set on kernel
> > > > configurations we can build one base kernel configuration and modify
> > > > behaviour to mimic such kernel configurations to test them.
> > > >
> > > > Provided you build a kernel with:
> > > >
> > > > CONFIG_TEST_FIRMWARE=y
> > > > CONFIG_FW_LOADER=y
> > > > CONFIG_FW_LOADER_USER_HELPER=y
> > > > CONFIG_IKCONFIG=y
> > > > CONFIG_IKCONFIG_PROC=y
> > > >
> > > > We should now be able test all possible kernel configurations
> > > > when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
> > > > the built-in functionality of the built-in firmware.
> > > >
> > > > If you're on an old kernel and either don't have /proc/config.gz
> > > > (CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
> > > > we cannot run these dynamic tests, so just run both scripts just
> > > > as we used to before making blunt assumptions about your setup
> > > > and requirements exactly as we did before.
> > > >
> > > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > > 
> > > Cool. Nice to have it all in one test build now. :)
> > 
> > Now what about we start discussing one kernel config only for the future?  The
> > impact would be the size of the fallback mechanism. That should be a bit clear
> > in terms of size impact after this series.
> > 
> > Wonder what Josh thinks as he help with tinyconfig. We could target v4.18 if
> > its sensible.
> 
> Having any of these unconditionally compiled in seems likely to be a
> significant impact, both directly and because of what else it would
> implicitly prevent compiling out or removing. And the firmware loader,
> for instance, is something that many kernels or hardware will not need
> at all.

Oh sorry, I did not mean always enabling the firmware loader, that would add
an extra 828 bytes, and 14264 bytes if the fallback mechanism is enabled as
well.

I meant having only CONFIG_FW_LOADER=y, and removing
CONFIG_FW_LOADER_USER_HELPER so that we just always compile it in if we have
CONFIG_FW_LOADER=y, so a penalty of 13436 bytes for those who enabled the
firmware loader but hadn't before enabled the fallback mechanism.

I'll note CONFIG_FW_LOADER_USER_HELPER is actually known to be enabled by most
distributions these days. We have an extra CONFIG_FW_LOADER_USER_HELPER_FALLBACK
but this is now just a toggle of a boolean, and actually Android is known to
enable it mostly, not other Linux distributions. Since Android enables
CONFIG_FW_LOADER_USER_HELPER_FALLBACK we know they also enable the fallback
mechanism with CONFIG_FW_LOADER_USER_HELPER_FALLBACK.

So for folks who enable CONFIG_FW_LOADER=y, they'd now be forced to gain an
extra 13436 bytes broken down as follows:

-------------------------------------------------------------------------------------------
allnoconfig with no firmware loader (with procfs enabled):                      
$ size vmlinux                                                                  
   text    data     bss     dec     hex filename                                
1135188  272012 1219736 2626936  281578 vmlinux                                 
                                                                                
$ du -b vmlinux                                                                 
1745556 vmlinux                                                                 
-------------------------------------------------------------------------------------------
CONFIG_FW_LOADER=y                                                              
$ size vmlinux                                                                  
   text    data     bss     dec     hex filename                                
1137244  267984 1219716 2624944  280db0 vmlinux                                 
                                                                                
$ du -b vmlinux                                                                 
1746384 vmlinux                                                                 
-------------------------------------------------------------------------------------------
CONFIG_FW_LOADER=y                                                              
CONFIG_FW_LOADER_USER_HELPER=y                                                  
$ size vmlinux                                                                  
   text    data     bss     dec     hex filename                                
1140554  272464 1219716 2632734  282c1e vmlinux                                 
$ du -b vmlinux
1759820 vmlinux

  Luis
