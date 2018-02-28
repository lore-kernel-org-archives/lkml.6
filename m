Return-Path: <josh@joshtriplett.org>
X-Google-Smtp-Source: AH8x226qsw2gnBtrqoN0/pJH1pehMkCzxMXqQ5OQ/abgWG01/wTX11WljvbHiapDqFDfReJaXwis
ARC-Seal: i=1; a=rsa-sha256; t=1519808859; cv=none;
        d=google.com; s=arc-20160816;
        b=kbq53svjKnQ8nP0DPNP0x7vNPYY6W93qJQc4M2+cGO7Vwb56pIp465iP9So1w+6dy+
         EvDbWBVebhKIN3kNJe1EszjDhX7+0ZavoyWP+DdSePvVhSWukOX0oFbSEErT4ppSgNGI
         hUewfsN8xD+7aNgn2OHTGmS6uoTB9rIrO7DTBfR9OG8/hNdeyvJr02PbBpviH/Jwq7ww
         RN5nnv3DsbF5qBUky68MRb/XzSCA89+E6uUeN261tqEpfGcZ8WDgzVfiDwra5gSuJLeA
         9C6zGGPTyXhr/xPjWOUNUR7tGrAYRSqxMbbl9XYCRt0oe1YYTkL2KGjoxtv4xqXW5+f6
         2ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Xw4Gvxr7SgG+ZBwqRE03MFTsCUpV40+bG5vkR3jwUmE=;
        b=rsM7ZC/XQmSctEk4v7F5uosY2Y+vLgBSuCTxexwHD2IFysAUYIxxI+e5GNyrBJZ8UE
         p7r86WfUZ1bTMo9CiGmMtENqeKNNe8KCSnKaHt5J6QtHKh1yV05y6fO8FqdumnRyE5+T
         0ov4E2/behifJvfW2mBh5HUPZOlq4C89Z2RY+FRhpZ4GGffntIynQIonyaJolfeK7wNk
         WpEWMEUveg2+1++6TClmP6MtvY17a4pl0LKkH4WTxegVoM/neWEKiKikEygYtNYXQwAQ
         6GOBLcfoV21tJEmMqet5f85mSs1v3f27HD+52TpPWSfChq5swvYpP1W0E3nZhYSijCOD
         B4Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::194 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::194 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
X-Originating-IP: 24.113.124.118
Date: Wed, 28 Feb 2018 01:07:23 -0800
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
Message-ID: <20180228090723.GA11438@localhost>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228013237.GH14069@wotan.suse.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593635094978324128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 01:32:37AM +0000, Luis R. Rodriguez wrote:
> On Tue, Feb 27, 2018 at 03:18:15PM -0800, Kees Cook wrote:
> > On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > Since we now have knobs to twiddle what used to be set on kernel
> > > configurations we can build one base kernel configuration and modify
> > > behaviour to mimic such kernel configurations to test them.
> > >
> > > Provided you build a kernel with:
> > >
> > > CONFIG_TEST_FIRMWARE=y
> > > CONFIG_FW_LOADER=y
> > > CONFIG_FW_LOADER_USER_HELPER=y
> > > CONFIG_IKCONFIG=y
> > > CONFIG_IKCONFIG_PROC=y
> > >
> > > We should now be able test all possible kernel configurations
> > > when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
> > > the built-in functionality of the built-in firmware.
> > >
> > > If you're on an old kernel and either don't have /proc/config.gz
> > > (CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
> > > we cannot run these dynamic tests, so just run both scripts just
> > > as we used to before making blunt assumptions about your setup
> > > and requirements exactly as we did before.
> > >
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > 
> > Cool. Nice to have it all in one test build now. :)
> 
> Now what about we start discussing one kernel config only for the future?  The
> impact would be the size of the fallback mechanism. That should be a bit clear
> in terms of size impact after this series.
> 
> Wonder what Josh thinks as he help with tinyconfig. We could target v4.18 if
> its sensible.

Having any of these unconditionally compiled in seems likely to be a
significant impact, both directly and because of what else it would
implicitly prevent compiling out or removing. And the firmware loader,
for instance, is something that many kernels or hardware will not need
at all.
