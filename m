Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526976859; cv=none;
        d=google.com; s=arc-20160816;
        b=vkAtO6Js+hYYUwaZIBP/20g7jNcDUIwyANhzHhU8XIwmq33Ypkpk25XoFcl/MN4iBF
         kFi2adhkdVoaR9xXZMFLeoIrYI6KPGVJyKqtKKDnbXrsDdUEvm2LF0UOYzT/AfnVCaSk
         A1SzdF5Mu4c0X19jHY7mKUg35C4Jq8oCwkLAE4sj8XONuwrEoGd+P3Ch30w2TUkDKaXj
         eZ4WMS7WChdueYxTlUmcLjakl69VGinaQLGGLVqP2urzlseIuDM6/VkYC1swEsbF/LAe
         67UWg7ygzPot6boueQc5GUIPVt+d7OdfBwRCPpFKOSaqfTv0UNWRT8Q1Ic/2LpzW/zMx
         FUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=2iSjvTx7x4+qqgjmfrAZ0fIZXXjeUroLXtgO1RneeI0=;
        b=DeNI4b4+zy/ak/n+Dw7AJj9BEuELb1mWYl/8Tb+dLVa7QlnPV+FMIZ4NZqlBvNEDD9
         wn30lxsFb/mKBahTkwipQ18zFICSMmAA8RM6mQ5/rdx56+rFz7AsJYrCzkxzArE8JR3b
         s4n0Ds/Ti/v8g2I2IXR0IISPf3C5Qh+kTM2G/ZYxLsr66Gn5cbzTqWwtATBvrlAmDbE8
         AR1nzzdiXmnB2dRTgG77dPWgs1EslRwV+hNh2DoqTNF354ZXLW12lxa3UTBts8dr/hmk
         HQbiJfzq1VCi/ZIgaxiqR+QH98FC5lTmz8Fv3To/blChbSbIOyyVZ8aPcRwaSpsGwQnk
         uQVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a/tOQYdF;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a/tOQYdF;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqSDxQigf+EZvSdI3aS4bPWOJ6B84R0z5k9o0BPDcHiiHY6zKM7qVGQcjj5ni5O5oQqPDytJA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 22 May 2018 10:14:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] tty: add missing const to termios hw-change helper
Message-ID: <20180522081411.GS30172@localhost>
References: <20180521110844.30728-1-johan@kernel.org>
 <20180521164130.GF17976@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521164130.GF17976@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601071710898587784?=
X-GMAIL-MSGID: =?utf-8?q?1601151287907951346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 06:41:30PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 21, 2018 at 01:08:44PM +0200, Johan Hovold wrote:
> > Add missing const qualifiers to the termios hw-change helper parameters,
> > which is used by few USB serial drivers. This specifically allows the
> > pl2303 driver to use const arguments in one of its helper as well.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > Greg, are you fine with me taking this one through my tree, or do prefer
> > I split out the pl2303 bits?
> > 
> > Note that this helper is only used by a few USB serial drivers and that
> > the pl2303 bits depend on a new patch targeted for -next.
> 
> Your tree is fine:
> 
> 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I made this patch a prerequisite of the pl2303 change so that I could
use const there from the start instead (i.e. I dropped the pl2303 chunk
from this one).

Now applied.

Thanks,
Johan
