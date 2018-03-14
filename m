Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AG47ELvVOUAsc1Y8vQE46Rzc0hTQzytPsDQ8XSawRjulXmHpJyfmXkEjG/ape4pEqsRdqJAK5jEk
ARC-Seal: i=1; a=rsa-sha256; t=1521030207; cv=none;
        d=google.com; s=arc-20160816;
        b=YuTNAn9EidtxMwBLGTGoyDAmIb3RVtNJbDPLghNObyZfLhGLABulGKbaNzRPz2yJM+
         v2eKw1+5/QeH7zVUtWB/ZLr7HeTzscyWArGniiHjZwrdxa7HxDluT869mNzdODKhwOJm
         MZ7UGXP76fwbYd7hsslj4mDlHJSQyjAJTOvFir0f9Z7kMVr9kDdwmyqp4jGQSOa7lrYk
         0apJdzCDJzFYdnxLrKcUNngTJNP+iYlT0OkRsavUNFfc2UhSlaHSLPqENeNASlVFkAQB
         QVIUzmL7BC97ASlTnN8+H2Oh2vkib5+aA4G/6gHYTRSLxkMUgkNYM4rOT2QkJqVTTw6c
         OhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=L8c/dMpmms8975xyJXkag4epgiZND1RVlFaKIMdzqeM=;
        b=BtpDvHtl4roUr1iiW+35PkypHhCMMvWW8ZX6xtglVl9+5whLaS4YvholCDS93fkOKW
         f3KwdjGde0RE6SX2Wmf4c/lE5wUdMlkLWDZHL0UDBSK76+/mhyuWLiu+ttBd7zOsMZpP
         151GnCob+DHKn+RqHzxxY/gIuzQqkgX8kVIoX0+7J5sXYkdRco/lNudGLSATc0OSiHCh
         EnG1uA/DEkF8wyBpHx0VtJgcPXLmeDMJ7tuSeEao8TrQR0p+e9voYO5ALRZZg/4cf+Jb
         RZKMhkpYoZqriC+fy8mOXfB14AWGsvqSsyKqfqx+EbPlk3s6VCJEfMTCWjiNprDB9yZg
         vaYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Wed, 14 Mar 2018 13:23:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomasz Figa <tfiga@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20180314122326.GA19651@wunner.de>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
 <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
 <2217404.A2W3Iek6du@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2217404.A2W3Iek6du@aspire.rjw.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594915771167446877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:12:05PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 13, 2018 12:23:34 PM CET Tomasz Figa wrote:
> > On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> > >> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >>> The lists managing the device-links can be traversed to
> > >>> find the link between two devices. The device_link_add() APIs
> > >>> does traverse these lists to check if there's already a link
> > >>> setup between the two devices.
> > >>> So, add a new APIs, device_link_find(), to find an existing
> > >>> device link between two devices - suppliers and consumers.
> > >>
> > >> I'm wondering if this API would be useful for anything else that the
> > >> problem we're trying to solve with deleting links without storing them
> > >> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
> > >> better alternative?
> > >
> > > Yea, that sounds simpler i think. Will add this API instead of
> > > find_link(). Thanks.
> > 
> > Perhaps let's wait for a moment to see if there are other opinions. :)
> > 
> > Rafael, Lucas, any thoughts?
> 
> It is not clear to me what the device_link_del_dev(consumer, supplier)
> would do.

The point appears to be that the pointer to the device_link need not be
stored somewhere for later deletion.  The newly added function would
check if a device link exists and delete it if so.

However I don't understand why storing the pointer would be a problem?
Also, would using DL_FLAG_AUTOREMOVE avoid the need for the additional
function?

Thanks,

Lukas
