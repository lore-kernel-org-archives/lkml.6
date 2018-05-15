Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZo+OwS1zDDHR7IZ15MmuIBINSEshlqvI9peDNhfKB+5Unj93qXb5gxlJymJwAbxwHQ5Zopd
ARC-Seal: i=1; a=rsa-sha256; t=1526392132; cv=none;
        d=google.com; s=arc-20160816;
        b=w95C11i8TW6Rf5hVOUENvO/PvC2F78IwKbgnXNdZKuZId5S3UBmPrRPqv+p4X85tIq
         EhOi26dTJ5A5vxv7vJCBNKip/ywErHNxpV8iWMjZdRjtrtVrjtY5ggwtne7u/E5Eey4O
         Tqodf5V9Q9TJpQVVsMKv/khRDJ1qV2G3glvhl7OuxwgrYNRxvM4/z+ZO8pqsxsYbQIOl
         RnXj4QIztw9yXO/YXXRG2fRq7Ycby+QpyiN7BztycFxs2XRPNKTTcTYrq+VGHaMPDqm7
         MZ4OAyPVFCcdGr86H1c7aySDdaoegrsuJCvduyJbrLscjt+s6jnhHqq+jWaGoEDx5Efs
         8pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=6s3QmqG6Foye5yWqgO7SsraKGTYbQ2vksPQpQCMrgLQ=;
        b=VHJq3txNhjm43AwYMgC+8modZm5dTq+VqoQ452MXwFuM22Dw38eG3h7P6M8h3t8o9E
         ZAaI0WvvaqRzRrP8gc/JuB7YNrRvRVRpK9CCE0SFqN36u/KKP/jDi0EwGIhZwVxtE/+T
         qtDGom5xWJ7cpIFnLnXSLu0ro87eN3ViH0+SuiBFqfQjxSdkh3l2n8Su38wROXUr/Yv/
         RBMUyCBkLOqWgW3lmn4ywakArq3yf6Tdg13bN5ghx+MXIskMOL0iglVvoVwScQJpjitz
         ijE3DoBAw9wrHObHa3bNejLJwK904Q8wFQTLjbimnJC6z7jm49C/UXpu6dS5GgCygSLK
         ZMnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=pfh0r3p3;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=pfh0r3p3;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Tue, 15 May 2018 14:48:31 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-ID: <20180515134831.GG16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
 <20180515081519.22751a39c49e63224da3acac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515081519.22751a39c49e63224da3acac@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600538156473654120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 08:15:19AM -0500, Kim Phillips wrote:
> On Tue, 15 May 2018 08:59:02 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
> > > This patch is provided in the context of allowing the Coresight driver
> > > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> > > to bus_find_device() in of_coresight_get_endpoint_device() when
> > > searching for a configurable endpoint device.  This patch allows
> > > Coresight to reference amba_bustype when built as a module.
> > 
> > Sounds like you are fixing a bug, don't your want this to go for
> > stable and then also add a fixes tag?
> 
> How do you consider this a bug fix?  What commit would the fixes tag
> reference?  The introduction of the amba bus?  Not only aren't busses
> required to export their bus_type, but that commit predates git.

I do not consider it a bug fix (see my reply to Ulf) and I certainly
do not think it should qualify for backporting to *stable* kernels.

While the impact on stable kernels of just this patch should be low,
that's not really the point: one of the requirements for stable kernels
is that patches should be _real_ bug fixes - stuff that affects people
using the kernel.

That is not the case in this instance - there is no problem with any
of the existing kernels with not having this symbol exported.

The only problem which we're aware of is with Coresight, and only then
when your patches to allow Coresight to be modular are merged.  That's
a new feature, and this new feature now requires a symbol that was not
previously required to be exported to now be exported.

So, the need for this export comes from your new feature, not from a
bug report that is affecting people.  As long as your new feature is
not backported (does it even qualify for backporting to stable kernels?)
then there is no problem with any existing stable kernel, and so there
is no requirement for it to be backported.

Hence, there's no need to Cc stable, and no need for a fixes tag.  It's
not a fix, it's a feature enhancement to permit modular code to use
bus_find_device() with this bus type which wasn't previously required.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
