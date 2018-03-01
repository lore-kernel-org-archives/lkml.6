Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELugIm29R0PVI2PV+OOxUIeLkDHSRAm3Mk4RRGpkciKEsFmtmuEBNue+J6EuGpWB7FDtHBZA
ARC-Seal: i=1; a=rsa-sha256; t=1519925605; cv=none;
        d=google.com; s=arc-20160816;
        b=nf6PUHl9egalIdCWkyRxPvv2zENPt9uX5PYMN00hbyQ7j9jOCYg0UBr6t8WKIylIZp
         UpBSrRCwB2fVgyAewNmBPfiAkVievjHFbLg4HZyF/+pn9y/XC4VtpIcPKhEotVXk0jb7
         QtJWbqHghbxtA2msU0rrVymZdb+H1xgcFTxOEmL9cYdygj+V5mmj/uuVbnsc5ON/A2/n
         7r45sqQj2GMTLQ0jHqOE6Cz0ZgakW8Zf0FjFZ5UXxn/g0vDE69wcH4DM6m+g64dROI3O
         pubnf0pNvu59Cx8Mj6sIbCj7FNXzyB+Ra4UC44O8A/UOV/WgWxhvdPFGrBfnrmHFD+FW
         K1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=FPd7SG3tN/q5GhJPsp5IxxV39SShIBdlEbEndhzrmVA=;
        b=nMmVkVln8C49G7S7kZbMBlpeC70g9XceZOte+lVyyKLM2NW0eKDQpa+zGJU+YW3XoU
         pKTMjb1HONe9oKNjBn/+5X9RAoO5a9qC9/4S5r/2mpiclk8baiV0hiqRrV4qjbBUtNjr
         qk+oYPX1oF5PNyz7p6lp4+BcklB5VyTWvdfeN6PIDfRuu20bOhLzLcUOnrOIl4IU/ycT
         iQjo12Md16cOQ7KhgiaBbY1HLC99TYTsIG2Q6aHY2OXCEm1k9EZ7utIykd+brRVv0ku0
         k7SHc/NvhrdZHEVheTv3mxop3haivfkj90i4/XP2t6F8CxBwLaNo8gWbLfJ0YOiS2/bF
         Efsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Thu, 1 Mar 2018 17:33:22 +0000
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
Message-ID: <20180301173322.GW14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
 <20180228013237.GH14069@wotan.suse.de>
 <20180228090723.GA11438@localhost>
 <20180228182603.GI14069@wotan.suse.de>
 <20180301000057.GA3426@localhost>
 <20180301003816.GR14069@wotan.suse.de>
 <20180301021956.GA12202@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301021956.GA12202@localhost>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593757511942625934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 06:25:16PM -0800, Josh Triplett wrote:
> On Thu, Mar 01, 2018 at 12:38:16AM +0000, Luis R. Rodriguez wrote:
> > On Wed, Feb 28, 2018 at 04:00:58PM -0800, Josh Triplett wrote:
> > > On Wed, Feb 28, 2018 at 06:26:03PM +0000, Luis R. Rodriguez wrote:
> > > > So for folks who enable CONFIG_FW_LOADER=y, they'd now be forced to gain an
> > > > extra 13436 bytes broken down as follows:
> > > 
> > > Ah, I see.
> > > 
> > > If you have CONFIG_FW_LOADER and not CONFIG_FW_LOADER_USER_HELPER, then
> > > you only have the in-kernel firmware loading mechanism?
> > 
> > Right, we don't have the old fallback mechanism (which BTW used to be
> > the default way back in the hayday).
> > 
> > > Given the
> > > *substantial* size difference between the two, it seems useful to have
> > > that option.
> > 
> > That's what I wanted to get to, is 13436 bytes *substantial* enough to
> > merit a kernel configuration option? It seems like that is the case.
> 
> By at least an order of magnitude, yes.

OK, then now we have a worthy reasonable description to amend into the kconfig
option too. And since its now revisited, I guess we can live with it for a good
while.

> > > What would it gain to combine the two?
> > 
> > Well Android enables CONFIG_FW_LOADER_USER_HELPER, and if they do, I was trying
> > to think if there really was any point in having CONFIG_FW_LOADER_USER_HELPER
> > as an option. Who would enable CONFIG_FW_LOADER but not
> > CONFIG_FW_LOADER_USER_HELPER?
> 
> An embedded system with a fixed set of hardware that needs exclusively a
> fixed set of firmware files known at system build time.

Fair enough, this should help also in the description.

> > The less hairball of mess of kconfig options the better to test. Even
> > though this series has reduced being able to consolidating being
> > able to make a kernel now which lets us test all configurations in
> > one build.
> > 
> > Who would save some 13436 bytes in the real world?
> 
> *raises hand*

Thanks for the feedback.

  Luis
