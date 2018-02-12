Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AH8x226baAsWTrrXyjnj0dMrX9SwWEv/9/e3UA/5FQzpPx5YL/4ZzPC4NJaqv3GUKdcv1gbkWhE/
ARC-Seal: i=1; a=rsa-sha256; t=1518456022; cv=none;
        d=google.com; s=arc-20160816;
        b=OeXVRFmCg3apW4ux44ZMZArSzKt+s9IXXjC6ljScnA1TtGTsHBMWu3VuO0ddOPBcVx
         YSG0qq8qnaZPAbZ9vVtQ/Lwd9oJb6fn0h0W8Mt9VYBmKZiW2pzPJMPmONR6oe0RHnRhB
         5LFliHZy+UIxO3C9yTmdwLSeWSBB1dmFqpv6H3GYqkIGJMZwOFNOs9k2qJR2iWowg6Jx
         Nws+z5GA3jXof6ajIhBBojo80zZkRKhcIOnBhXtpu8rK30yWxBbxT5GYjjYDCIOxktLm
         MZZPsbTNpbhpQ0uwtZRSIvAdMocs7zSksUvA/PGrMTw6rgaaUz+KiIFpOtL6OJ9D6sDf
         gnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NMhSzjWpoKE9vIY691GMVNLVnwv2WPoQtW5F5wbgYZI=;
        b=bpcve3BRqMiTQXakcJCxFGAFzF8F6Kjk0amCYzh0brxhffIoWuI4BMFgK3+Ns0GRg1
         hjeqPjUEFRYgx3UTpKeXTJaxeQDtux9CqtVPpEIWq7MA2TKaBKnsjlxt0qu++L/RgW6t
         hvGKU4cEVOvAe2hjKJmJQ0gnNgIPeVo0kh/rptGG+EB+eBJZ5HchNPLldukbt5adif+E
         Z2H/OA9bMxa0lzf7syqd4vtMyMkmWa3IsM/jQOewKnNJtcPs/Tl9T4EByFNsC6ilwXev
         pZtTlTJwYYZXrFDafr3JB7DKuLZn6vafwdbNAyzVZZdSunEERQA+19AWv1G98Mc2t6P7
         yDbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Sk3GMuli;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ULS+WJUi;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=Sk3GMuli;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ULS+WJUi;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Mon, 12 Feb 2018 09:19:17 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: License documentation
Message-ID: <20180212171917.GA9396@bombadil.infradead.org>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
 <20180130151446.24698-6-igor.stoppa@huawei.com>
 <20180130100852.2213b94d@lwn.net>
 <56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
 <20180210033714.GA12711@bombadil.infradead.org>
 <20180212082849.1377f7e6@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212082849.1377f7e6@lwn.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592216541836755466?=
X-GMAIL-MSGID: =?utf-8?q?1592216541836755466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 08:28:49AM -0700, Jonathan Corbet wrote:
> On Fri, 9 Feb 2018 19:37:14 -0800
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > I've done this as the first line of my new documentation files:
> > 
> > .. SPDX-License-Identifier: CC-BY-SA-4.0
> > 
> > I think this is the CC license that's closest in spirit to the GPL without
> > the unintended consequences of the GPL when used on documentation.  The
> > GFDL seems to be out of favour these days.
> 
> I think that's a great license.  I still fear that it is not suitable for
> kernel documentation, though, especially when we produce documents that
> include significant text from the (GPL-licensed) kernel source.  The
> result is almost certainly not distributable, and I don't think that's a
> good thing.  The GPL is not perfect for documentation, but I don't think
> that we have a better alternative for in-kernel docs.

That's a reasonable concern.  I've read other reasonable concerns about
the unintended effects of using the GPL to produce a printed book (eg
can you print it in a proprietary font, do you have to provide an
electronic version of the text, and so on).  I fear these wise words
still ring true:

  But the real problem is that we as a community lack a copyleft license
  that works well for both code and text. About the only thing that even
  comes close to working is putting the documentation under the GPL as
  well, but the GPL is a poor fit for text. Nonetheless, it may be the
  best we have in cases where GPL-licensed code is to be incorporated
  into documentation.

I dare suggest another possibility: that we create a further exception to
the license that the kernel is distributed under.  Something along these
lines:

Documentation [1] extracted from files marked as GPL [2] may be
distributed under the terms of the CC-BY-SA-4.0 license.

[1] This includes text explicitly marked for extraction using the kernel-doc
tool.  It may include short example code sequences.  It does not include 
code that would normally be expected to be compiled.

[2] GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+

We'd want to run it by a lawyer, of course, to have them check for
unintended consequences.
