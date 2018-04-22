Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48Mqk8Jne+M1/aUtnMOyvCFabk36XexKumTgvjwdCC0GbglZ+oDNlTv5wrzhaPmcQ4GDbd+
ARC-Seal: i=1; a=rsa-sha256; t=1524428774; cv=none;
        d=google.com; s=arc-20160816;
        b=WI14HAaMcHHdBKrihK5+Z0/pHENhIUiZjaFMAg9foHXCZhUI2/P8aLXXambIK+Yk/f
         GVNNljNLiyFKpaSppjVg5EAllXTJ7Rz7BMl2RF25uLVpRZ15jDUsafA9cIrlg7FbgE+U
         h8nWzx8uVv+LuzYO+JThisonUP5VsHr6yyovcLtoP6bXjDldkOXeYAkA3UPcNpY7IOtQ
         xgdn+Y93n9wDA4edRC1xsOOEZC53ia0a1ShfWIX2n2+vqj2SfZ4ZCeSTjvZ0WXeLvXRC
         Jp+KN3DR+/+tF0/oMHX2G77IpGS53n4yqghKQj6USMBhTgvhgyDaJ4VezQeryeoySfxC
         oNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=firKBt63lPxwYpTPi+JwDkKRKzWfV4HuTYbuQm1KMEA=;
        b=SxeudSY2bmNU04w1mrGVYQzx675QyjkXK2Ri8rPVLTO1YTWwAYtfiveer9xVvCdXKn
         jDiAyd2zYJi0tpsWTVoTAJcnnZ8XnKJzOEWI/2VftluMx+2nCn2N6aQrD9Q4Yy+MG0gp
         lx5nr72Ft5TEm6XpBp6uiavYKuGmKavNGCvppiHKD4cdIp5KG9OSVaLmu3fybFXSJLSd
         Y43sPSbCeCDsRIuHfSzmsZfYKB7rXk7Zb4eJB7CgvRoabeemXzY8FZTPAr92ZopORfu+
         LGKw6mJ3ndP3cyew3hJMt4mv6LRWmMw8zk/7wefFK9fO9hStwUYBGMBYwVfXtjEFZEPe
         7hQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sun, 22 Apr 2018 22:26:09 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	ckoenig.leichtzumerken@gmail.com, Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
Message-ID: <20180422202609.GX14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-6-andresx7@gmail.com>
 <20180421143206.GQ14440@wotan.suse.de>
 <20180421144911.GV14440@wotan.suse.de>
 <CAGXu5jKVv8R1yVcuCCPJb1YD9u8tiZyj86wdz043PKxKPZj4Lg@mail.gmail.com>
 <CA+55aFw4WxBDD3YA9Ksj=mxcYmAg7+bnjfuDVtBnzn+0w6mtbw@mail.gmail.com>
 <20180421173650.GW14440@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421173650.GW14440@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598479426216576376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 07:36:50PM +0200, Luis R. Rodriguez wrote:
> On Sat, Apr 21, 2018 at 08:32:00AM -0700, Linus Torvalds wrote:
> > they were nasty and illegible and pointless.
> 
> Clearly request_firmware_nowait2() is *not* much better... right? So it illustrates
> the problem I was hinting which we'd eventually cross...
> 
> > Using some single flag field for an extended function, and leaving the
> > existing functions alone so that you don't have to convert existing
> > users - that would have been fine. That's not what was tried and
> > rejected.
> 
> Actually it was tried, however the divide was perhaps *too broad* and split
> all possible *new* functionality into two calls, a sync and a async call.
> 
> A flag based mechanism *is* reasonable to me given I have been an advocate
> of such type of mechanism for a long while. It however is against what
> Greg requested -- to have a new call *per functionality*.
> 
> So feel free to advise... I really just want us to move on.

Andres,

Since we haven't heard back, and I don't want to leave you hanging here is what
I recommend:

Re-submit and ignore the new async call for now. Leave that or another series
later. Note that Hans also has another series which we want to merge soon too,
so I expect we can address this async call after Hans's work.

What I recommend for advancing the API to support future async calls is
first we make it clear the current flags are private, then see if we can
stuff them into struct fw_priv, and pass that data structure around internally
where possible instead of using really long set of arguments on tons of
internal functions. That's at least one commit alone.

Once that is done I'd add public API flags which reflect the existing
custom use cases, the first flag would be the warn (or quiet) flag for now. We
can then pass these public flags around internally to modify behaviour.
That may be another commit.

Instead of doing only two calls (one async and one syc) as I had done in prior
submissions, we'd continue the ongoing practice of a new call per functionality
as Greg has suggested, however the flags would enable to *slightly* modify
behaviour. So you can add a new flexible async call which accepts the public
flags argument.

So new functionality per API but slight modifications are expressed via the
new public flags.

If you're up to try all all these changes please feel free to do so, I just
expect more possible bikeshedding on it so don't expect this to go in right
away.

 Luis
