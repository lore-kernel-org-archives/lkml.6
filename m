Return-Path: <amitshah@gmx.net>
X-Google-Smtp-Source: AB8JxZoqympuZLFyhjvr3yq95yuihcuy4JcLOL0bG8MLyB2gNVwLpLgf3iwIwP+y86fNXhC7dJAb
ARC-Seal: i=1; a=rsa-sha256; t=1525318491; cv=none;
        d=google.com; s=arc-20160816;
        b=nMZvL0PTQUt67SY31IOqlrl/EoHzBHxg7H+A+xzOA4gU7B0o5rWNVPAIf7ReUn9i90
         XAndgIvW0Ac+TZ0kkIsXrWGNYn2tvbE40xAIYU/Y0pW2Y0EnZj9J7dIUkjaEXuY6+krj
         1jqoCp0VjINtvX0EFuT0/E/4/eqWMnuvsemZqvHdpPSaCHJRQOlhAWnlE05cKg2ivb+d
         6Ic/81tzxmq8V0IjtwNXpYG6EsFbG6/9XY57/3/r5mSU7/Y9yNRZKVsBTaUH3qZzn9GS
         WWCnyhYyBgjqKsUKs3QHj8eoAxxYrlcGlth/deOeU5nOTo8lIlfgmIj64U1x6jMROuba
         krZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=PMico0yNOIvYaqIgys2MeimJC+7vXuMvY3EbmEL8XGo=;
        b=A2tlPEzyrWmHVTKe1gl9Fs5xg8Vh5jcWKJQv349J4Tg0xWJf4kamVSd8MK7XkHDymB
         aAXfxg/XaGIOKPUIn+zWiRl2uKablLqYO44hb5t6cLnD/voAOaDKftjAnaEzfQVPWdMC
         ewRsqUHHhtrhDZdcsDmCxI4bARA9loeVAC8sx8MjwKdl29b9vutJ2XyCTzYu3yN3R9M+
         S0LpHqPqqz2cnh1JZBgRtosy1rWnntvEEZICQFd9rgdtyrC6YsSYzj2UnQVNtcHXWSYx
         cyAoQg0dlhB/Vrya1kgsvVqVaEZUQfJ5tVduBB1lycQSi3hcemVZs4Xf+rOuPSxd0R25
         UQQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=fail (google.com: domain of amitshah@gmx.net does not designate 217.70.183.196 as permitted sender) smtp.mailfrom=amitshah@gmx.net
Authentication-Results: mx.google.com;
       spf=fail (google.com: domain of amitshah@gmx.net does not designate 217.70.183.196 as permitted sender) smtp.mailfrom=amitshah@gmx.net
X-Originating-IP: 212.92.123.35
Date: Thu, 3 May 2018 05:34:47 +0200
From: Amit Shah <amitshah@gmx.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180503033447.GA16202@grmbl.mre>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424214104-mutt-send-email-mst@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290166308217501?=
X-GMAIL-MSGID: =?utf-8?q?1599412363206142180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > Turns out virtio console tries to take a buffer out of an active vq.
> > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > going over it I saw that error handling is also broken -
> > failure is easy to trigger if I force allocations to fail.
> > 
> > Lightly tested.
> 
> Amit - any feedback before I push these patches?

The changes look good spec-wise.

There are a bunch of tests in avocado-vt that test virtio-console
functionality.  Can you give those a try before pushing?


		Amit
-- 
http://amitshah.net/
