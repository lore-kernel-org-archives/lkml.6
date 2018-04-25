Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524652298; cv=none;
        d=google.com; s=arc-20160816;
        b=HbPKRtg7ivzyngQXj4pgRHNxD73f3EtrTC+iHhFR6OfLv30WUnOS+j54tWKlTXvFyu
         Ot/67xjLUxe+HjFc8W/3KSW8OvUil5MXPLE6SffFLdvDSNj2GqFyfajY368OMGoXT/QS
         1NaCXskZR/ifwjFx1++kjA5pHAzFAkIQCbOR1cg2I2jJTq7ylF33JbEY+lxr21pYCZRg
         HT1cjrL2X2Y3awr+0Mi4SeXti3i9j9tpZMDGxpJVk+SgVcJAS8T9J51zAISE0H5sm5Iu
         apyGy3BCHi4AQuIkkxjsKCJApZoi9xImC3UZRAVLM3cgLIl6QdCrMrE6G8BQ+RgXo981
         LB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=yXkA1eiteUqvs3GVtnsRYE09Op7n9+No+KDc3RV3qK8=;
        b=UPGSViadH8/lPMmNkMAgg01ozbEAd2GFrNWv353ke1Mfax5pCJFWvYWE/jv339EGRF
         is1sYV60IfYfJxeH5HPieDgfuwP71kICEwjquSCVLeS9hSvB8kTpxyln7osF3J+H23Oo
         XELeU37u5Uu6O7FK9CGRAN8K5eXk+8b0yOlviTiBsocwdcpiOKTeQKZ221JO/2Xw9Jh3
         sSjV/42MScPAJKIa/k9fcVAZTEC1uUfClSQaXlthJn8EgsKyRzH4usictAgvF4+7nZ15
         F8tzGBDdKK2XMq+vjLMrVnyiKolkLSYmOHkubbMxtxrSbHif5Ez+SnhJTMWZHNlB9B8k
         U9ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bHNK/Gn4;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bHNK/Gn4;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZq1gSSllGUsTEeQyBMl+7wSuEFSxGRv0QVISTuij1ZzVEQy2HCHMuklgJ2Xs+Ip2VmT45D11w==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 12:31:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425103129.GO4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180425084819.GA13295@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425084819.GA13295@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598713809132883301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 10:48:19AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 24, 2018 at 06:34:51PM +0200, Johan Hovold wrote:
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers).
> 
> YEAH!!!!
> 
> Thanks so much for doing this, great work!

Thanks!

> > This all seems to work well-enough (e.g. with gpsd), but please let me
> > know if I've overlooked something which would indeed require a TTY
> > interface instead.
> > 
> > As proof-of-concept I have implemented drivers for receivers based on
> > two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
> > hardware these have so far only been tested using mockup devices and a
> > USB-serial-based GPS device (using out-of-tree code). [ Let me know if
> > you've got any evalutation kits to spare. ]
> > 
> > Finally, note that documentation (including kerneldoc) remains to be
> > written, but hopefully this will not hinder review given that the
> > current interfaces are fairly self-describing.
> 
> Is this just a RFC, or a "here's a first cut at submitting this, review
> it please!" submission?  I'm glad to review if you think it's worth it
> at this point.

It's more than just an RFC, so thanks for starting to review it.

Johan
