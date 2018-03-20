Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELshMjOs9z8rljs/ETGjDau+VbQQ7W+c6JkbKjJmokDrtDZYsTJERVGlEpHNJHHZJRR/us2X
ARC-Seal: i=1; a=rsa-sha256; t=1521575514; cv=none;
        d=google.com; s=arc-20160816;
        b=V2innkoXlJduSkLvmzqD1IveVXX67tAxkHStIDknBHgw4XtBVmyyeOGgg1QBoa6h+9
         T2YOfmSiIouqyNgJSVO253ufFT0rjyLjbfEDaJZ/UNTDeV1puhbRHT31k9/DyRO9QHK6
         Abr61OuWOKbKaIT377O/3gc4RMS/fE5BoOKYVjO1exfih5pWkpWnCVrjSWzSDtJE+fbc
         1TrWTpF0r434rSssgBuFAtbO5opprlUV1swUztnEauP2L1PRzcFklsOjtCvUlp0aSDww
         Yl+foy5wVS3hrLOd8qCUcnRmyza2A+3G3WlUCUi4blQSWWP2SHkgbJB27KAyJIK3RoJd
         PclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NwHpW4t66ug6/XeuTLhR/HDDNfTc4EHhsMYLcX3r8LU=;
        b=Y+kJsPzWZlajzfiBIWeum8d+o4Fau6Dl6RJ7Df9YEo2oQ+umjMWIOlMd0w9i8A23wm
         NjwRVRks2jFJ1hiElKsfArDZtkAw4lZi2SJVT1GqGjKKXckku4chBn/Q24GOjgW+2dUd
         QHdNuOu7RARiq2TNFV0K1tHe8MQo4ZmfgeQB8sqsZ7UE54c5zc79gDHAg7aN3+OvCpRC
         WWt5aQSNx8p9XjQ4RF0d0mBWc0g9nMQSzB89zAVfiX6ATabUa5V4lr5ZmJTAOJ6he9dK
         TweV2mfLCpuWs9ZyYP5HJeeCvHvjCBou+PkJfePYtHArALsLBr0bdSHK9e8c/lNamovf
         PcNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 20 Mar 2018 19:51:48 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Kosina <jikos@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	akpm@linux-foundation.org, cantabile.desu@gmail.com, kubakici@wp.pl,
	linux-wireless@vger.kernel.org, keescook@chromium.org,
	shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
	dhowells@redhat.com, pali.rohar@gmail.com,
	arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
	markivx@codeaurora.org, broonie@kernel.org,
	dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, oneukum@suse.com, ast@fb.com,
	andresx7@gmail.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 19/20] firmware: add request_firmware_cache() to help
 with cache on reboot
Message-ID: <20180320195148.GH4449@wotan.suse.de>
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <20180310141501.2214-20-mcgrof@kernel.org>
 <20180320083055.GA21640@kroah.com>
 <20180320173409.GD4449@wotan.suse.de>
 <20180320173801.GA25040@kroah.com>
 <20180320182409.GF4449@wotan.suse.de>
 <5dc49c7f-56f6-28df-38da-bfa998afbdbb@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc49c7f-56f6-28df-38da-bfa998afbdbb@linuxfoundation.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560438545867805?=
X-GMAIL-MSGID: =?utf-8?q?1595487566010669083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:54:44PM -0400, Konstantin Ryabitsev wrote:
> On 03/20/18 14:24, Luis R. Rodriguez wrote:
> > *Iff* this seems sensible, this would only mean kernel.org would have to start
> > accepting git notes long term, for those who optionally want to push them or
> > fetch them.
> 
> We don't disallow them. You just need to make sure you're fetching and
> pushing them, because they aren't by default. You can set this in your
> kernel.org origin section of .git/config:
> 
> [remote origin]
>   ...
>   fetch = +refs/notes/*:refs/notes/*
> 
> And then push them separately as "git push origin refs/notes/*".

Superb, thanks!

> Since frontends clone with --mirror, the notes will be available on all
> git.kernel.org nodes (e.g. see
> https://git.kernel.org/mricon/hook-test/c/a8d310d4c13)

Good to know thanks, and it looks good!

> If you do start using notes, I strongly suggest you pick a dedicated
> refspace for it instead of putting things into the default
> refs/notes/commits, e.g.:
> 
> git notes --ref crosstree [...]
> 
> This will create refs/notes/crosstree that has less of a chance to be
> clobbered by someone else's use of notes.

Indeed, the default is crap. I was suggesting perhaps having it also be
per branch, so:

git note --ref branch/iso-coccinelle/ add commit-id

If it was required sed I guess

git note --ref branch/sed/ add commit-id

And if we wanted a resolution handler which could manage the above for you:

git note --ref branch/merger-script add commit-id

Which could use the above two to run what is needed to mimic the commit.

  Luis
