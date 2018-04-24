Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx4+1NBZAK0oXo4FxLP97iHc757d4j7M3paVeGfxBPkZ4VNbETNOtlRuQxCAi6B9tBzbuCQfY
ARC-Seal: i=1; a=rsa-sha256; t=1524585922; cv=none;
        d=google.com; s=arc-20160816;
        b=D32TN3nKk+a7yRHkKOMlFQbk5zHXAx6zMIlXFjkNAz5fHkGLdyQnxSniqY8bosoIQj
         J8CJFOjYnUtaZlWVuz5sF3nJZXHROVBJ+/OK0wPjTD5EdvhSSfihriA+A/TSwNW5Wbh4
         1Kasnj7MkIvbH64ENOXlUoLlv2sSyGb2snv/HfLpJex/UxnMMlhYuv/igSCL4JhGpVSR
         dXFqxMd/wumBVQZIU4YoSjfFb0b6gbcyTDfiBbCIBq+cB9xCxcvpR+oSCJZreOyJxcgj
         nbJDkXwjocW+BbwgQx6sIvw+HzERK90ikKdfAgwK77NcW2csOzPJ+eO1YMEaF3HlqzfU
         FGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=rISRMxh8RHCVF4kKqjAiq7QnY9lgmybe9cv5WV6gfHM=;
        b=aqA7k5d2y8HD1+ls7n0np3a7iRGIM01MqifpCB2fxr7MSd9RtVJ1gbxOUfQCBwUUH3
         Fl1Sw921Z5Xn9PLPKzY4dL3b9uOy/RCNzU1jIzFgI9ZUMKb+kCCWAVI1d7CnYdPgGmX5
         07oA/vSe0xb7fjvUDCpZiAagdSUhyx0G/Sc0cKA1BT2EswwxUO169F6fs2R7Lvx9mppS
         XlQGmHm/N/VykwF3dfCX0G/uj3gzeXhQ3yiNh9mJJ9fPEnhz7+pVdzKBUkWCvBDotamV
         o283qWzUwhYyM5+5d2E2y+aHBvQ99IAboVROkep9o4EZmUUwBm55d2sBtODXP5akwuy4
         plgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 24 Apr 2018 18:06:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Alexey Dobriyan <adobriyan@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: simplify procfs code for seq_file instances
Message-ID: <20180424160652.GA28483@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2> <20180424142304.GE26136@lst.de> <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178416995714531?=
X-GMAIL-MSGID: =?utf-8?q?1598644208123224361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 08:19:16AM -0700, Andrew Morton wrote:
> > > I want to ask if it is time to start using poorman function overloading
> > > with _b_c_e(). There are millions of allocation functions for example,
> > > all slightly difference, and people will add more. Seeing /proc interfaces
> > > doubled like this is painful.
> > 
> > Function overloading is totally unacceptable.
> > 
> > And I very much disagree with a tradeoff that keeps 5000 lines of 
> > code vs a few new helpers.
> 
> OK, the curiosity and suspense are killing me.  What the heck is
> "function overloading with _b_c_e()"?

The way I understood Alexey was to use have a proc_create macro
that can take different ops types.  Although the short cut for
__builtin_types_compatible_p would be _b_t_c or similar, so maybe
I misunderstood him.
