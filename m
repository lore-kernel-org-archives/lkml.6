Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x225K64NfS8AqLrJOdeU3GflfRURUukqx5rpigZv49x5dKdHwkwPcWNkFwlKxDqq10bReVwLe
ARC-Seal: i=1; a=rsa-sha256; t=1519781559; cv=none;
        d=google.com; s=arc-20160816;
        b=ZdYniZMBe/kcQ+nLQySAyT54OsGCNjHpgzHBeI6E6VBNBwD9853b4KDbabygu+6u9z
         0v4FnfDP/2oD8hhyE7/LILKLI695+OBgunXztm2BfYDzC9MIw51S/9De1v7EuZeyNYZh
         VnX6mhttXsQK9VIaS425clWYxspJPo46Z05HqDs3MJCHBD8eLB8urKnnONv5Zlxk+aLj
         BYEWN5xI+ljJ7AvN9JNHuJ1yuHcRd8Cyq13gCybkBsNECoHU1dc2f0v5zZfpr9xysXD6
         EuHcfTibfC9Mp0MrRzCMkVmXV/Z2E+sF0/JwHzyn9JwBthLBSYErjxDilZ8ug2Z1inoR
         z7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=bL1Jv+thxMmi+gXKvXGk9a6SajfUenYXSZ3e+AEaF5g=;
        b=GPE05QoK2HgWcQYz6vvhBzc0jv4P3ZCPCaOwdcTY6BIrKdfkm1MgObY7WC/zfnD+AP
         wgjf9lTC/mxGXCZ54EteNu+cnlJiz4UkGBN0kUZvuMv+XORogYxliUj/4xobjKkSDKXX
         IFstm7V8CqDK5JiRU3Rsx0Ij+wZFN3jYzSUN5iPvNuk2qa8/wBXpQ0jn8LtIcisPOb7O
         cCE2DG3Ls3QlxVT3UZK4jjtdkNaxbWgP71Pm5GOicJzWf6/K/YGlhOjJpOBTp3Q+oVgY
         Pyw6d+L8tv/S+5VUeq8AVrUSHSSc4c2S1e197vlKaHSD2S172zreAiy989uf+TEzroqT
         Fv8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 01:32:37 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Josh Triplett <josh@joshtriplett.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20180228013237.GH14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-12-mcgrof@kernel.org>
 <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ66nDeZ87M9epgamn+9KUnASjPVWYVL+9kwbC2rBO23Q@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248724184221948?=
X-GMAIL-MSGID: =?utf-8?q?1593606467804369686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:18:15PM -0800, Kees Cook wrote:
> On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > Since we now have knobs to twiddle what used to be set on kernel
> > configurations we can build one base kernel configuration and modify
> > behaviour to mimic such kernel configurations to test them.
> >
> > Provided you build a kernel with:
> >
> > CONFIG_TEST_FIRMWARE=y
> > CONFIG_FW_LOADER=y
> > CONFIG_FW_LOADER_USER_HELPER=y
> > CONFIG_IKCONFIG=y
> > CONFIG_IKCONFIG_PROC=y
> >
> > We should now be able test all possible kernel configurations
> > when FW_LOADER=y. Note that when FW_LOADER=m we just don't provide
> > the built-in functionality of the built-in firmware.
> >
> > If you're on an old kernel and either don't have /proc/config.gz
> > (CONFIG_IKCONFIG_PROC) or haven't enabled CONFIG_FW_LOADER_USER_HELPER
> > we cannot run these dynamic tests, so just run both scripts just
> > as we used to before making blunt assumptions about your setup
> > and requirements exactly as we did before.
> >
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> Cool. Nice to have it all in one test build now. :)

Now what about we start discussing one kernel config only for the future?  The
impact would be the size of the fallback mechanism. That should be a bit clear
in terms of size impact after this series.

Wonder what Josh thinks as he help with tinyconfig. We could target v4.18 if
its sensible.

> Acked-by: Kees Cook <keescook@chromium.org>

  Luis
