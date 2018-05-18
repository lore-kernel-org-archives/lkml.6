Return-Path: <lars.ellenberg@linbit.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526648161; cv=none;
        d=google.com; s=arc-20160816;
        b=Gz+RkpmTAhcbAs35WRlQ11w1cfzpzFgbAJURSbYZfSHzYVQiowrgNbLdyo1YFWA6sc
         zYE7wui3+b6h6rmYMWKnsLGuyZx+ItJGWdFGjJmuZ23qkZYEyX8vlDXwn7/AnAbH55/p
         cOf+GJwy9vS6FsWtOsBBlQPOwUyBGLZEjicooyVavQF1g2sGqKaeJ3Gah6mMd7ySERaB
         kkILtOQDK9+4+zKEbdipO6EpqjIrgXdWPE1oO9NfhcHG1393VihVVM9GYW7eXnT0Ksxi
         a2Xu9QuN1VxjXe926FbWgBnbw0pNYEZQxoBiAY68xEXRROCHZDCoYUtuJP86na4ils+H
         TrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=hS34oyTRSmMn3EMcFU/M2XED7Rv17GtmYccDQf9TGkk=;
        b=ColQQf2MhDgiE8joX3a2Rtq3d30W9VU5sjbDsVrBIkpiZyrKGK8rrXM83X5lPFgGdY
         yzKHxcEkSXP7w9WIy2qeb2w1xl+b4HjciYV3IAKe/9a8h4jPog7OolXpozrLBIKs/h09
         692aktJEv9D4prmXSEy7ODEZBUdR6Kcgi909biNrgEXu9oHHr1SyUaTZsljl5VKZKcd/
         Cp3aC91fJrC6Q6sgKAdDQxAXMSQvfrBruoIdJYwSypNk4VDUh22mcCX6UTrEa1Q8xxRw
         q+Y57UfFjT5kF15CTKD4RpdtzTCZTA1xxU/pZ6FzrA20j60Y6iA7WiVj6FcW9sFRwvXM
         5gzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linbit-com.20150623.gappssmtp.com header.s=20150623 header.b=dXb1ScQH;
       spf=pass (google.com: domain of lars.ellenberg@linbit.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=lars.ellenberg@linbit.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linbit-com.20150623.gappssmtp.com header.s=20150623 header.b=dXb1ScQH;
       spf=pass (google.com: domain of lars.ellenberg@linbit.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=lars.ellenberg@linbit.com
X-Google-Smtp-Source: AB8JxZqk/8k0s7RYlIcgAsA+GGnkI8q9fiGa4d6FXzjswbl4ttEb+Y24T4rwTFpNO/n8AGOKRFd3pw==
Date: Fri, 18 May 2018 14:55:54 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 28/42] drbd: switch to proc_create_single
Message-ID: <20180518125554.GA9238@soda.linbit>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-29-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516094346.20506-29-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600613468681721822?=
X-GMAIL-MSGID: =?utf-8?q?1600806623334182471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:32AM +0200, Christoph Hellwig wrote:
> And stop messing with try_module_get on THIS_MODULE, which doesn't make
> any sense here.

The idea was to increase module count on /proc/drbd access.

If someone holds /proc/drbd open, previously rmmod would
"succeed" in starting the unload, but then block on remove_proc_entry,
leading to a situation where the lsmod does not show drbd anymore,
but /proc/drbd being still there (but no longer accessible).

I'd rather have rmmod fail up front in this case.
And try_module_get() seemed most appropriate.

    Lars
