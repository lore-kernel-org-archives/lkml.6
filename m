Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524733927; cv=none;
        d=google.com; s=arc-20160816;
        b=KV1IyyXTkIVI2WepPuDhXuxOC2Ip+6XrgWGZxMDT8lpHrKYfSdm2iFoUm5O/4WXQBy
         LEdK7OZ5+pFWFIKOphX5DJcvjY+ICaxHI6YK3GKn4+BlF0o8MxU0BtYM81u7FEowLu1Y
         p3Xiu6wXXNZ89osvG0sJTiXyt2LqwqQXfYGqfLTP55q56igbX6dAopfacy15BMih9idf
         IGAlXJbg60U3f8C4L5oBAhbj4MaS4Qg7s4sdLRg3w89a37obgwv2sObE9j63hhKOYgC4
         nSnUVmPKod0Oq7lK7FmWqpeEL3bFVkbvXvdiQ+/J7NELZ+07br7SSac1GLoqp3uEWr/d
         /SBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=nx83bkNgMHK/0ICMzlDYX+pUdQeWEwBgMD4XX0Hx6Po=;
        b=fjeYw0wPrKpgnbgAPwF1nAWBeNFb05dfCOLd5LAVH6rEKkpevGuHerNsgc4fmO423D
         DE/qnq6dpGRTXXvJqfn7LLUXUeS2llw3gvCzaSAm3VhRM7gvuAeJ+uXylmLpDtDR18BL
         PfFN1GJwkydZJG7Q1Ewf1feKqwdv9vYW6L9WeGaj3LD4X5sfYfq5FDcI9VfA2r0di4mu
         mKSY8gPvKC1qaTwxZZ6CtSqBT/dGCaq0sfYwWTExOznuvH94eaHxKryPfFJfSkVfIc5Q
         sNYYNG0EQFQJRvsQd/wVRqM9wIFjXHCdZl1L7cDo+bHtmpWMXulDN3qZfkFlBCjHfDcU
         s38Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rz/GXKLR;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rz/GXKLR;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZqBn6GhsakRhMR1/WoH/BbwZ3IjlZo03DIiQwpPUgoyZt5/gBTuOO/B6Y/Ig9thRYiCSlQoWg==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Thu, 26 Apr 2018 11:12:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: gnss: add sirfstar binding
Message-ID: <20180426091200.GV4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-7-johan@kernel.org>
 <CAL_Jsq+nj9P5z=Ao=UbS-AKy+qeM98EFJiHmYgoniD_4N3Hr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+nj9P5z=Ao=UbS-AKy+qeM98EFJiHmYgoniD_4N3Hr4w@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647065272659964?=
X-GMAIL-MSGID: =?utf-8?q?1598799402939380912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 01:25:26PM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 11:34 AM, Johan Hovold <johan@kernel.org> wrote:
> > Add binding for SiRFstar-based GNSS receivers.
> >
> > Note that while four compatible-strings are initially added representing
> > devices which differ in which I/O interfaces they support, they
> > otherwise essentially share the same feature set.
> >
> > Pin and supply names (and some recommended timings) vary slightly, but
> > the binding recommends using a common set of names.
> >
> > Note that the wakeup gpio is not intended to be as a wakeup source, but
> > rather to detect the current power state of the device (active or
> > hibernate).
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  .../devicetree/bindings/gnss/sirfstar.txt     | 38 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.txt   |  3 ++
> >  2 files changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
> 
> One nit below, otherwise:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

> > @@ -390,6 +392,7 @@ vivante     Vivante Corporation
> >  vocore VoCore Studio
> >  voipac Voipac Technologies s.r.o.
> >  vot    Vision Optical Technology Co., Ltd.
> > +wi2wi  Wi2Wi
> 
> Wrong spot.

Duh. I had first misspelled this w2wi (which happens to be a different
company), and then forgot to move the entry when I corrected my mistake.

> >  wd     Western Digital Corp.
> >  wetek  WeTek Electronics, limited.
> >  wexler Wexler

Thanks,
Johan
