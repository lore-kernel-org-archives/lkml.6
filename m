Return-Path: <josh@joshtriplett.org>
X-Google-Smtp-Source: AG47ELvolINXVyTPR417cjdJTwzbQIXrsO8yM9xe6nNhihOQepeqo33trX9fOiCOSoxzdUe2AFIl
ARC-Seal: i=1; a=rsa-sha256; t=1519871128; cv=none;
        d=google.com; s=arc-20160816;
        b=cmxetl0L5kGKKhgyC1P4glA+kemG1y7z/pwS7pjqV1xj7mo7SxBR87ieExrl333paM
         2DhvwWkEEGawupSRiSoigtXcZ3do1TcPZC7MPUe03SELEr4wuqHDVWt9HRsPgIsmPQKm
         1SyWiOuzqECUcAzgD2GmMwYc8kCepPhX3gswf+htakPkkilh4de6omxKY97YbyXSLo3m
         qqK31ZRn696aOTBnycgcdGCoT9ATqJVMG1MX5RrNJLvjBUe9yAMpp7PYgEAQLw56V6AS
         cLtMLGEQAl2ais1obuywNZM8v/P3CGkcJaQNiC6+knmq2lmTGCs7Fv3dLZ1ZUEBWpghp
         U+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RkrMH9EPPy88tHOwwt2ptwe2rWF1ZCZ69KIg7VHC8Uo=;
        b=ww9bHmqVmfTWEwatj0TBDPVVz7BisqtJKni9LbIazqQiI3OhV88vf00BMv+HkMxuYJ
         h6SdydPymPfeoJtW2t2E7P7iXK3aYIdE4fNI6GXkXzZpHqX9AuMkpUzzqG1FTn3ARrQS
         ySaSLy6zPnQhS0t7kOFu03DkUxQJjo9APY4zi6d/dcRQSrQ9RfAqttY5qOV1J9NIIGT1
         MdfRSul6uTQrNIUmHnUPXaBKwjCN3wh9Dnyjo8RF9JfChw78ruiLqav3BBrVw6wX2tEJ
         Bas5XiNvdAV83spWBJGCYynBFVz3Dd8a7jjU0eguQYIFtT46LwY3ga+p9q0AzbXOw8PX
         C0kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::195 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2001:4b98:c:538::195 is neither permitted nor denied by best guess record for domain of josh@joshtriplett.org) smtp.mailfrom=josh@joshtriplett.org
X-Originating-IP: 50.39.166.153
Date: Wed, 28 Feb 2018 18:25:16 -0800
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
Message-ID: <20180301021956.GA12202@localhost>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
 <20180228090723.GA11438@localhost>
 <20180228182603.GI14069@wotan.suse.de>
 <20180301000057.GA3426@localhost>
 <20180301003816.GR14069@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301003816.GR14069@wotan.suse.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593700388989000305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 12:38:16AM +0000, Luis R. Rodriguez wrote:
> On Wed, Feb 28, 2018 at 04:00:58PM -0800, Josh Triplett wrote:
> > On Wed, Feb 28, 2018 at 06:26:03PM +0000, Luis R. Rodriguez wrote:
> > > So for folks who enable CONFIG_FW_LOADER=y, they'd now be forced to gain an
> > > extra 13436 bytes broken down as follows:
> > 
> > Ah, I see.
> > 
> > If you have CONFIG_FW_LOADER and not CONFIG_FW_LOADER_USER_HELPER, then
> > you only have the in-kernel firmware loading mechanism?
> 
> Right, we don't have the old fallback mechanism (which BTW used to be
> the default way back in the hayday).
> 
> > Given the
> > *substantial* size difference between the two, it seems useful to have
> > that option.
> 
> That's what I wanted to get to, is 13436 bytes is*substantial* enough to
> merit a kernel configuration option? It seems like that is the case.

By at least an order of magnitude, yes.

> > What would it gain to combine the two?
> 
> Well Android enables CONFIG_FW_LOADER_USER_HELPER, and if they do, I was trying
> to think if there really was any point in having CONFIG_FW_LOADER_USER_HELPER
> as an option. Who would enable CONFIG_FW_LOADER but not
> CONFIG_FW_LOADER_USER_HELPER?

An embedded system with a fixed set of hardware that needs exclusively a
fixed set of firmware files known at system build time.

> The less hairball of mess of kconfig options the better to test. Even
> though this series has reduced being able to consolidating being
> able to make a kernel now which lets us test all configurations in
> one build.
> 
> Who would save some 13436 bytes in the real world?

*raises hand*
