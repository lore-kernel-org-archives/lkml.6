Return-Path: <briannorris@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518546328; cv=none;
        d=google.com; s=arc-20160816;
        b=fl6PBkecLpFqgVPcCGkVYJOpoZxFwlxp/bm/64qZqRQRBIor5kaeVYmaziqzolomlr
         ipjJyADqdb4czf4im3F/vLM4/ya52b1xA9GOGYuErypifBj08SB/5NVjj9llk96YU2UD
         Zn7eVuWXlPH4qN/Y7qy7EJ8qDPZSwYf+o7R4ZdmQzD24ZPpPjPGimArVMxN/qXHXfJLl
         znjgaHrk8AQC8TttGvkyO5h/J/zAVQreiEx5G88YGxeVw4Xwf0qY6sXSmIcwIJnDeAAq
         fUzZQx56yhGSVeokz/Ehx61XoS+SehzHcHhJbPWgQJZxYa7cA3e4pulxm+nTCd6SM9Sy
         IxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=C5fJW0/ZT2cM0Z8gU/LojRJr81j7w4xJuSXx47HyZgc=;
        b=g4Ze5sNDL4Uu6Vs4wMt8KsKrDC3HLa/rdSwml+G7sKieiuXhQhHPbY2Qxk77Tx1mv8
         P/b057kBI/usEp1DeILh+lhdnRSHiI+6Ayg9+zLhrYw1XYKB+wKyHVBiKMM1+YDY590a
         kmvufgjS42TEFGjnNiCRb9M2hFw+oPJ5qZre/JFiX++/9obqheIuImHWgvjzyjr1WpmW
         MZUVbtPut7nJdSynrIBQtg5/zvnsYWVDRrrCDpIZfx9qyIZr4fEPUVOdLNBDN/gByYbt
         TU4P5nKt8M6sGR7wLSJgiEQBwm7AgfBS6y1LztE6v10jlntrk5tp+hXyXc5z9qvoutzw
         d20Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Z3MqZREf;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Z3MqZREf;
       spf=pass (google.com: domain of briannorris@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=briannorris@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x2249Vyf3+2FYVacralSs0E6P1XRGxHkOLqjRMzB6VcgwpU9PlIoQtoduRbRLEOcti2rr9OYOgg==
Date: Tue, 13 Feb 2018 10:25:22 -0800
From: Brian Norris <briannorris@chromium.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
	briannorris@google.com, dtor@google.com, dianders@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180213182521.GA51247@rodete-desktop-imager.corp.google.com>
References: <20180210110907.5504-1-jeffy.chen@rock-chips.com>
 <20180210110907.5504-2-jeffy.chen@rock-chips.com>
 <20180212221309.GA66974@ban.mtv.corp.google.com>
 <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059e2aa9-bf94-517d-a132-abe851ec69f7@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592012049405115473?=
X-GMAIL-MSGID: =?utf-8?q?1592311235539008145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Enric,

On Tue, Feb 13, 2018 at 11:40:44AM +0100, Enric Balletbo i Serra wrote:
> On 12/02/18 23:13, Brian Norris wrote:
> > On Sat, Feb 10, 2018 at 07:09:05PM +0800, Jeffy Chen wrote:
> >> Add support for specifying event actions to trigger wakeup when using
> >> the gpio-keys input device as a wakeup source.
> >>
> >> This would allow the device to configure when to wakeup the system. For
> >> example a gpio-keys input device for pen insert, may only want to wakeup
> >> the system when ejecting the pen.
> >>
> >> Suggested-by: Brian Norris <briannorris@chromium.org>
> >> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> >> ---
> >>
> >> Changes in v2:
> >> Specify wakeup event action instead of irq trigger type as Brian
> >> suggested.
[...]
> Not sure if you were aware but there is also some discussion related to this,
> maybe we can join the efforts?
> 
> v1: https://patchwork.kernel.org/patch/10208261/
> v2: https://patchwork.kernel.org/patch/10211147/

Thanks for the pointers. IIUC, that's talking about a different problem:
how to utilize a GPIO key in level-triggered mode. That touches similar
code, but it doesn't really have anything to do with configuring a
different wakeup trigger type.

The two patches would need to be reconciled, if they both are going to
be merged. But otherwise, I think they're perfectly fine to be separate.

Brian
