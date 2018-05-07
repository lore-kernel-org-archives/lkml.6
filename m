Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525686475; cv=none;
        d=google.com; s=arc-20160816;
        b=dg0mI5oYmVtb6+mZa5SEiRZ+h/HIQipOf3bqfOEsrkIsS6LkWZBaJnPcLau+Dbr7Rs
         OBupRHMlTsg+URvL9J9pjcA6UCEmkmTbP+X+Md2JUAwUaibaj2pUA0bD5Pnuoa9t9hbv
         vYnOREaKQUyhTaj18b5VeLuUJjTtoSn3qeHJyG0x/cyv5Do5Er4sKnAxF6A8yMapgzVd
         0o12i/V712Pt9e95Qhyz9Nz6+6y/66HNXjncm7A89/k8dRfzSDLX97/2mH6f3RZnaDPL
         2NY3ofaQ/taEhsiU2Pe7UQFEKow96MqQ0yONqT23QUo+MLxXOVxEuYOISy+o/XJM7cGw
         wDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=YEpJ/k9awYfWNoM/zq/xmqee+LRl6V3mAsONRCk96LQ=;
        b=b9XTJyR4HkX9z34+2Eva3nspToAVvNEs8DfGEyOhgFU4DrAEYGPVPMRu1W0ogetAIU
         rZ8qjD2FRb9hypPBJ4n9yFSolVHCmeQ/0cXyil3XjGKfZcn18wwlvMfDr5zkxydm+m5o
         6tWsEa0JqUOcImq1wRcAocHlZMIJ8Le8LXm+kisV4M8noDYIgpHNdrgFF1R0ox4loDcP
         DCy40B9PyACaOuVG9FHwt8FCjWzqjSEuzPGOY5pH3f/rTsbQZS699Rf7r4yA8S5tBZik
         spprFRAc2JINUZ/c+OADBUu/Gb2ARrxEG4On+xfzcS7qzddvmr1SqbLYGghsWP3c1uat
         8Jig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gY2VQhBW;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gY2VQhBW;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpS0Q3oAW0HhDp7bXhjaPSgTHLqyT2z8RKc6hCZ8NaYa8N6UYBUcsafEm5Mp6+LVXMrDV0rzg==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 7 May 2018 11:47:53 +0200
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507094753.GR2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-5-johan@kernel.org>
 <CAL_Jsq+mCp=geT8t_j+0fuTxAB7C9RYn6pESRpLc2GH273fM1Q@mail.gmail.com>
 <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599798222104847880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 11:35:21AM +0200, H. Nikolaus Schaller wrote:

> I have realized that the w2sg0004 is an exception (although a Sirf chip)
> that it does not provide a WAKEUP signal. And another significant
> difference is that we have to keep the serdev UART enabled even if there
> is no user-space client. Otherwise we are not able to detect unexpected
> activity. So we unfortunately can't move serdev open/close into the .open
> and .close ops but need to open it in probe.

As have also been discussed elsewhere in this thread it may be possible,
and it is definitely desirable, to only keep the port open when really
needed. But given the complexity of implementing this, starting with a
simpler and less power efficient method for sirf-chips without WAKEUP
may be acceptable.

> Therefore, it is in my opinion still better to have a separate driver for
> the w2sg0004 instead of hacking the support of this chip into your WAKEUP
> capable sirfstar driver. So I suggest that you make WAKEUP a required
> property.

I disagree. The sirf driver subsumes your particular wi2wi module and
configurations without WAKEUP are described by the datasheets for other
modules as well.

> We had faced a comparable decision last year with the ov9650 and ov9655 camera
> sensors which are almost the same. But not same enough to integrate both into
> a single driver.

But here we are talking about two configuration for the same chip (even
if your particular chip only supports one).

Johan
