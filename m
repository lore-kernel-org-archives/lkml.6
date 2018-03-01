Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x225XaL88Oe7Fg9iSGth30Zei+R7gtG/VuHbNNLdSh8YEY8i3mY2lb35XpXfTCyIIxl8uDu5K
ARC-Seal: i=1; a=rsa-sha256; t=1519864700; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkHiRiBzNsMQ7Wr/jMH3C3YUunT+6T/vm9zuz3dheXJYUlf9IXeBtryAi/wFAOYS+d
         aBqu4joyXoDBOMmBYDGf1ZK9jiWs7wgthaIrJAqumumGBS6t84LoPOR7hmUrDvukTvdL
         kfIuoyET691wfbprBNpx5xXRLpCAsrVKxL1DYROh4QmxKB7DXbL9IeSjmurz/HdTvKS3
         +9VoQrjZSjdfaVfCVGLIejaKCeIxqZaC2MNuYl8mKj34M2GthvpbW0QmImoX4VIx5MZ0
         E7L5JxabMDsfXxZrdTcX68OVKH/D+vmI4l855naHm2KRY/XhMEYun9nTFN+ZrLQOg0zj
         Ov0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=cBP7LG6BUvs+nmQYRXBEI+P1B+pkmazkxBE/CnyXN00=;
        b=QGrz0fzb1YKyljUSzJzqcOUdG2dsBNvB36O71GyxAgR2Ei0BRTqrnZw2e66fhAyUM9
         ziCXIFoJF16PN+WOLhEIjjA+m8hQWxjwA+yiODIsAEjNuJlbJyA4m0kuSMWpQPtl2EEs
         jK6VNy+YlxCcNeAqRcYds6O52NzVfJLmKobTzHipppCMnh0qfK5Ni20xbEcKLkwgZ5E0
         +HoqKxy8t5KFocoizKtOd4Zab9kEu5stk9vHxKt6S70AWxqH8bBNidVcRRbxr4TJZg+J
         V7IbBwlIwWHYv5E5JKm0qzjDs5t7nfuyrrA3BSRBr4mIhyUKf5etVWH3M7jNBgkO2nxA
         cMxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Thu, 1 Mar 2018 00:38:16 +0000
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
Message-ID: <20180301003816.GR14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
 <20180228090723.GA11438@localhost>
 <20180228182603.GI14069@wotan.suse.de>
 <20180301000057.GA3426@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301000057.GA3426@localhost>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593693648291652441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:00:58PM -0800, Josh Triplett wrote:
> On Wed, Feb 28, 2018 at 06:26:03PM +0000, Luis R. Rodriguez wrote:
> > So for folks who enable CONFIG_FW_LOADER=y, they'd now be forced to gain an
> > extra 13436 bytes broken down as follows:
> 
> Ah, I see.
> 
> If you have CONFIG_FW_LOADER and not CONFIG_FW_LOADER_USER_HELPER, then
> you only have the in-kernel firmware loading mechanism?

Right, we don't have the old fallback mechanism (which BTW used to be
the default way back in the hayday).

> Given the
> *substantial* size difference between the two, it seems useful to have
> that option.

That's what I wanted to get to, is 13436 bytes is*substantial* enough to
merit a kernel configuration option? It seems like that is the case.

> What would it gain to combine the two?

Well Android enables CONFIG_FW_LOADER_USER_HELPER, and if they do, I was trying
to think if there really was any point in having CONFIG_FW_LOADER_USER_HELPER
as an option. Who would enable CONFIG_FW_LOADER but not
CONFIG_FW_LOADER_USER_HELPER?

You see other than
CONFIG_FW_LOADER_USER_HELPER
we also have
CONFIG_FW_LOADER_USER_HELPER_FALLBACK
and Android defaults that to y too.

It used to be that CONFIG_FW_LOADER_USER_HELPER_FALLBACK was a mess to
understand in code, and this series has reduced it to simple bool now.

I started wondering if trimming kconfig options may be worth it. Sadly
I don't think we can remove CONFIG_FW_LOADER_USER_HELPER_FALLBACK, and
we'll have to just deal with it mapping to switching a sysctl option.

But I figured it was a good time to also reconsider also if we even had
any need for CONFIG_FW_LOADER_USER_HELPER.

The less hairball of mess of kconfig options the better to test. Even
though this series has reduced being able to consolidating being
able to make a kernel now which lets us test all configurations in
one build.

Who would save some 13436 bytes in the real world?

  Luis
