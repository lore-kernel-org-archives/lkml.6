Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZo9aiW1Ep16EsMYIqI5sPLaWuN2rzPTgBSb/tC9zNZLbiXMn8CumayZ1khV4/9OpaSpQdOZ
ARC-Seal: i=1; a=rsa-sha256; t=1526462363; cv=none;
        d=google.com; s=arc-20160816;
        b=LXWos/ejkH+CQamm6UtYueRyoYzDWK1YU0b+YrGMEdlwikn+JUYmsmBpXhrzZ8Zn6M
         +e50A96v7LWJM6W8/wvYZEFzsObPYdZ33xxFFZ4zB7hnEiWySmbfD4g2kxjGX2m3rZ3S
         IQY9zNt8XtepHY13Pa6jb+9WAkl9VfLemAaLjKh81/pA9BEJHqYE9CoPVPHRQqNsXbzc
         DuOKYduNzlSzLmjSkyfz9+65KUBU5LdFhTEySVdlt0R20Qpdhb8Gj+ky052a2/TJYXAo
         wySBF+JJuiuQwqcTb5dUfJ5LXwWgZ5w13g9FNsS3dLNoZDgxZ7bWbNNUVpBP1Rkkm3br
         8qYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=AR+wV2Hd036pdA1DfSOdKzyaozCmRZWKscr0e+reO88=;
        b=tGjzGUubT/0i6xA8rSa8wxIjQwCAr0OJanFw9ZJeuBO+KAkZ5x0/2PXwGLqrZNDVW4
         IfbSqI7oNCzqOFa70IoFDTualJ/Lp4sQbNsYMiOzrIk1Km1X6Ti3qwq1kPEa2Pma65b1
         iA7jplJH1+2IuIQvBponkxbYJJN2FiU5of56/pcICRHOOaQtUFxtN+m+zZVuWMHTK19P
         ccHkPSE2xxA/1RUs18K+BeJyerUK40spYAklFdGaO3pEW3gwzY68o27SMwKZQc1guzWz
         /2nvw/kRKrl/7AH4GZmdNxeuvGEJoAcLolyyP7vZFyz18mmbrQsch8HzNhZCSWrJGnUA
         9X0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=hJTr+ura;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=hJTr+ura;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Wed, 16 May 2018 10:18:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-ID: <20180516091841.GH16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600611799498425061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 12:16:28PM +0300, Andy Shevchenko wrote:
> On Tue, May 8, 2018 at 10:06 PM, Kim Phillips <kim.phillips@arm.com> wrote:
> > This patch is provided in the context of allowing the Coresight driver
> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > to bus_find_device() in of_coresight_get_endpoint_device() when
> > searching for a configurable endpoint device.  This patch allows
> > Coresight to reference amba_bustype when built as a module.
> 
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
> >         .pm             = &amba_pm,
> >         .force_dma      = true,
> >  };
> > +EXPORT_SYMBOL_GPL(amba_bustype);
> 
> Oh,
> 
> What wrong with the approach let's say similar to PCI bus?
> 
> Whenever you have a struct device you may use two helpers:
> 
> dev_is_pci() -> is the device of PCI bus type?
> to_pci_dev() -> get's container of struct device for PCI bus case

How does that help with bus_find_device() which requires the bus_type
structure for the type of devices to be searched?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
