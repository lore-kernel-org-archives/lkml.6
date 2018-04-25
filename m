Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524654320; cv=none;
        d=google.com; s=arc-20160816;
        b=fGIqXIzJ61GOvMu/CNv6HsnalIYsx8boebANKRHp966kCFsbLr3ydl9YawLfm/iFEr
         eXnNATFWwNK2k6WOE23VqDrFgfRPNzK0HjkTaxnLt7aZpR6hWYc5di5bi6gWufILZGXD
         N4EKnLe6AE7sBt6NwwCOYLO01wnumBI/IbL7LsUnKYMGgi1HIS8MnSJNaX4qtGJFYHvb
         YAbfyGRVK4J1wwwOjUTiJlg44jRaXF4jZr9vXf+puXv0xXfy5ZV7qEq0sqPSwyUs5ece
         eBvHxoE2MtNm0MpXngEboILbGByID1HpXVo25W5df07X0tvfhhTL8T+h7d3wZshj+h7e
         n2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=YOjjDwukirNkiq95A0hYweot+KzU92s1CuPME+3pGok=;
        b=BOwjUSr7mAbuHsB05EgbqQrEKhrm75Orhdsyys5cHRs0l3SIFtgirpm80kg6NDpK0K
         slrz7ZWQlYgogxSy2m5v/kmuXXANnqbTItwt6WzVtJ5tGKCLMrClRpxmf8Uahd3yZ/tL
         b/0mLj+WFJqL3mKiu5hnggsHOhNMtOEQc8nEQ4gfDTWbEVaJNzig7R9BOULxrU/yk+v1
         seaxJbEvor7kohUvcQZcKZhIExk5CvkKOHjOnRRnG0H+6xf3ZaslZDKpzhCPWh1SMa2f
         OArk3z+/7TAZeSRh3NHzfD3OxHwuHmul/rJvCall3FDk6QhcC1u3ioHvVMdHhZ/+8OVP
         E1rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pFzUlvRF;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pFzUlvRF;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZqExIZD/DnQAzkMRTEgXsJRC2YGJH5oYc0/y+VG/QI3Zg3b6VEqfcubsi5TwVDrlHVFS8VTgQ==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 13:05:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] gnss: add generic serial driver
Message-ID: <20180425110511.GR4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424163458.11947-4-johan@kernel.org>
 <20180425090031.GD13295@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425090031.GD13295@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647063920484580?=
X-GMAIL-MSGID: =?utf-8?q?1598715928824607902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:00:31AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 24, 2018 at 06:34:54PM +0200, Johan Hovold wrote:
> > +static inline void *gnss_serial_get_drvdata(struct gnss_serial *gserial)
> > +{
> > +	return &gserial[1];
> > +}
> 
> Oh that's the best hack I have seen in a long time.  I need to remember
> that one for next time.
> 
> Anyway, in reading this driver, I don't think the module reference
> counting is being handled here, so you might want to add that to the
> gnss core to keep things from going south if modules are unloaded.

As I just mentioned in my reply to your comment about module references
in core, I think I got this covered through the hotplug support. Devices
can go away at anytime, including through a module unload.

Thanks,
Johan
