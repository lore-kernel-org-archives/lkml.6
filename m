Return-Path: <SRS0=BGWJ=HQ=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZqpNZON5hXkS17xX1wIeaIB10MTjYe9FdsT2BpaRPeOYs1QBYOP3vI0XRYuaUUeRo/p9okc
ARC-Seal: i=1; a=rsa-sha256; t=1524793621; cv=none;
        d=google.com; s=arc-20160816;
        b=JEenRmVOFMqqjTsfryIV0uwB3Wli5nAG1w5k9to4U/mS6GFeYudg4hTjbr7ZlRYRDJ
         cm1I0ONpkqCopqkR3ttuL8jBUoIzo/gmzDlhAzWHYCcnHCymWet3TWAibey9q5HUxAUv
         jV+vD5IAhavCRPVkEBAHtVaepcwn++XRpm2NWf7SxSaqVPe0Fua6Rwmrd3PoqrQgQ07O
         kf6l8goqYbrUy7sc22zq97jPXDGTY2iSpi2Z0iN0IPY/yH0umk73fK+r/EtIVZX0Envc
         CnT3Tpkbi0fQXPC2tyd8/TowPebT/i/c7b8jlf6V7BwZFn6Ck9redem4wnAzHx25eCKZ
         8k7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=HEy20rUCo0/cvvZIlvqZLaHeZkubAd8+H7OIn7uN8po=;
        b=vpcHWjqYBOiBR1jJUGkMmLdxUB/gmboKj+I2CZjNyDRqOkvMUnQ6E82NFZrUtbe2Nn
         odtVgQ5rYMAo4fZy/yhmgzd33zjpaQl6cw/42fc+HOOcy5XIkI3zaVaKxuOl9mfDU3tv
         aFNMzAp2F6iZ13vDS2WEcfp9aoKBT+DYt+NCsUvJgzwKVkkKkRNpwLfjbPL/+QaHh3NP
         cWsMNShiVhvXW0NEEh+KJjnyl1q0c9I56s5BLZWotXjn41ODGMkm0vf62WcPVOaQuRR5
         djUXI5mg9gMnYwRhj/PfN/zR8cmoLYg0QTtIsfMegCF1/KcAW9OK0BTfHC8dbptOJsAa
         7rKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=bgwj=hq=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=BGWJ=HQ=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=bgwj=hq=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=BGWJ=HQ=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF352184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 26 Apr 2018 21:46:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wei Wang <wvw@google.com>
Cc: gregkh@linuxfoundation.org, Wei Wang <wei.vince.wang@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kees
 Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Crt Mori <cmo@melexis.com>, Alexei
 Starovoitov <ast@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] do not call trace_printk on non-debug build
Message-ID: <20180426214657.612623a3@gandalf.local.home>
In-Reply-To: <CAGXk5yo-9E7xOibMSWzPKgiduLrjzBA2+i0nhPNKiFnfyL7mUA@mail.gmail.com>
References: <20180424180812.215900-1-wvw@google.com>
	<20180424145056.7c29ea18@gandalf.local.home>
	<CAGXk5yo44kAku+ZYx=8HzOgkEVC7ARNSER4MvWTCz-i51up=ew@mail.gmail.com>
	<20180424151416.397fbbde@gandalf.local.home>
	<CAGXk5yriz2CtCN-vkL0q7gdpV+f8+9GJH-FT+v3KBLb-fWoCZA@mail.gmail.com>
	<20180424152607.71fbee34@gandalf.local.home>
	<CAGXk5yo-9E7xOibMSWzPKgiduLrjzBA2+i0nhPNKiFnfyL7mUA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598651942651560845?=
X-GMAIL-MSGID: =?utf-8?q?1598861996049654165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 04:53:33 +0000
Wei Wang <wvw@google.com> wrote:

> On Tue, Apr 24, 2018 at 12:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > A lot of kernel developers use trace_printk() and I want to make it as
> > easy to use as possible. I don't want to add a config to enable it,
> > because that would be something that could be rather annoying.  
> 
> > Let's add it to checkpatch and see if that can draining the swamp of
> > abusers.  
> 
> 
> Currently I see f2fs trace is using this when having CONFIG_F2FS_IO_TRACE,
> so I am not sure how checkpatch would work. How about we add a BUILD_BUG
> surrounded by a config which would let us flag abuse easily on build time?

I don't want a config to have to be set for adding this. That would
really irritate myself, as I constantly take configs from others for
debugging purposes and then slam trace_printk() all over the place. It
would be annoying to have to remember to enable a config. And having a
config would also change the way the kernel gets built, and for
debugging the less variables the better.

But you are correct. I see lots of abusers with trace_printk(). I think
it's time for me to start removing them.

-- Steve
