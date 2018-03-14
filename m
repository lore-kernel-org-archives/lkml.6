Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AG47ELsStRax7ZGc4/x0UzC9pSlCbGL4fn6UA95Zml6UiP4HyLL8PCStqwukJ2PMIRo2G+IjjiOo
ARC-Seal: i=1; a=rsa-sha256; t=1521030480; cv=none;
        d=google.com; s=arc-20160816;
        b=SL8GfOYrrnmC5i5zB7JZYPijvJeCpjb1jVvNLihjeyc/rRXzRKs4SGYl7c35bv5a5m
         wZZWes+vAmIN3fkbeRwENwt8V6pikum+inn9AttHfhOW637YWgIKrf+CS+pWhxPU6Akv
         q0asMgjscFQiep5cV2+kPL+GRs2awI88yHKvFXQSugj6j9t0TT/Uhi1qZlwguAlCFCGJ
         Kg4SySL7tght79AKbkPJNKDRDcEIiEi8DxecSJHh+l+MNkQ3ExULwuiDkwDzjgV/dEQh
         tbr1wNUT2x0ZlqFPY3fCq9p6vBd2XAISKlri+5flCpuz0Uj9HIAPlA/j8N9Y2azVVKts
         /fNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zxwe7WHPzjuJMJ3+uTifg5MRSw5odsXVJimTlL6s4Wo=;
        b=efo+aYMuoL1ejOswUQYz8m4ZTgGaXR1hciFlK743CwWpSQC+e8yeQqaws/TTFo/8Bl
         NRh6IDWJk66nSgyEtH3lgZt+EpgwhAZkB5ZTJkoXt/RtPgkesi67QlVGV9TWle24MaPy
         YztI3UOPez8NJIe3FIqmPJGK8fwaptyZ+7EckQzz6RVms8dhMznxNZjGzNLjOjtPQQ65
         /GHx44yL8XB7gjFD7wxqmVX5I/nFoPZtKAaaAjjiEQBPSOc+yFZr8FI4CiaLAnNuD6bY
         JRTU+ZuyGNpkMZc65BNM9VzxlFWJpbNy1MKSqoPBM2uLPuV3PUfYid5ko74OURcvjAfp
         eNpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Wed, 14 Mar 2018 13:27:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Figa <tfiga@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Sricharan R <sricharan@codeaurora.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Archit Taneja <architt@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two
 devices
Message-ID: <20180314122759.GB19651@wunner.de>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <2217404.A2W3Iek6du@aspire.rjw.lan>
 <CAAFQd5CQXY0Efv+2MC1kTVW5q4eZjJ=gwVaR-LA=3agnSSHzUw@mail.gmail.com>
 <2705105.V6KYPvoJqj@aspire.rjw.lan>
 <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eae0bc-7921-e598-9c01-63498400c85b@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594916057471366787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:14:15PM +0000, Robin Murphy wrote:
> >>On Wed, Mar 14, 2018 at 8:12 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>>On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> >>>>On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> >>>>>>On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>>>The lists managing the device-links can be traversed to
> >>>>>>>find the link between two devices. The device_link_add() APIs
> >>>>>>>does traverse these lists to check if there's already a link
> >>>>>>>setup between the two devices.
> >>>>>>>So, add a new APIs, device_link_find(), to find an existing
> >>>>>>>device link between two devices - suppliers and consumers.
> >>>>>>
> >>>>>>I'm wondering if this API would be useful for anything else that the
> >>>>>>problem we're trying to solve with deleting links without storing them
> >>>>>>anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> >>>>>>better alternative?
> >>>>>
> >>>>>Yea, that sounds simpler i think. Will add this API instead of
> >>>>>find_link(). Thanks.
> >>>>
> >>>>Perhaps let's wait for a moment to see if there are other opinions. :)
> >>>>
> >>>>Rafael, Lucas, any thoughts?
> >>>
> >>>It is not clear to me what the device_link_del_dev(consumer, supplier)
> >>>would do.
> 
> Not quite - the issue here is that we have one supplier with an arbitrarily
> large number of consumers, and would prefer that supplier not to have to
> spend a whole bunch of memory to store all the struct device_link pointers
> for the sole reason of having something to give to device_link_del() at the
> end, given that the device links code is already keeping track of everything
> internally anyway.

Makes sense to me.  How about an additional flag which autoremoves the
link on provider unbind?

Thanks,

Lukas
