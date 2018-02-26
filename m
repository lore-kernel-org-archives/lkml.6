Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AH8x2255rnNy1VZLAOdVTLVwSGYk3Bl18E6NkgqRtHFiSGd/Z1pyWmGcha7MdePyiPpcb3t/hvfZ
ARC-Seal: i=1; a=rsa-sha256; t=1519648524; cv=none;
        d=google.com; s=arc-20160816;
        b=r/hU33voIOMw7hpVQNcMg8zH7tUJLQRLcq0y9sZEEIqVe50dykX038oGCcYJQDTw2h
         yjNUexM04L8VBANYc2bc5AG8YQh2ZGJtxE2/An34NesPmLggKzbFkorrZmpLuyGu0BqN
         WOeTOn6UHTrWYqDb9dUVBLZjIc4dsu5N7wOLMcJGfFgXaVFdX6pUUApKtgElx+SpBbgx
         5sRD3IH6I/cOofCz236/FaqN/f8iEi6ObYC/jR30PtMvB2bOUdaavxoPbkns/SUHA6e5
         3o7TJFNMfbEpMpZGNPrMbcbxhv7E0ceO2Ub77ql/Y5q3fL7MpBcWRZA7wNtqMUoM/OrP
         f+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=iZD2r8RtaSkSubbU6LRxV6qrvWEhFgi3tLqLTUlle2A=;
        b=NQPm110AjW3u7qptzKL0oKXSnRbJrsshaOFum5PYS/Ai3ypKEPqR45pYg3OCr76EPy
         5n2/5xZ+8wP69dgdjBm5WKQ/H++NHprt3duVnHH/m5EulwLoeCsZHWiRceBbcUBpjPOe
         c8KmIJofdqEdS/Am2slgAQQSYzQRpYmj4rmH9aL49g1rbMKgQ4OGCIcUnDIQNEfxbJKk
         +Eo3XR2hTQ//OMljcG3NaA4tLcPZQquZMkmDZn84AMKUJrmAT9390wJftbFqGbFcLPbI
         Vi4d2ZtFk/5L5fRidsgBYoQtIJ95W4HW7H2PMYYcJD4QHMeIVks2LHTpWofRgorPrkC6
         JfRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="207025938"
Date: Mon, 26 Feb 2018 14:35:18 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
Message-ID: <20180226123518.GP27191@lahna.fi.intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de>
 <20180226120534.GO27191@lahna.fi.intel.com>
 <20180226122243.GA25450@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226122243.GA25450@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1593466970748978366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 01:22:43PM +0100, Lukas Wunner wrote:
> On Mon, Feb 26, 2018 at 02:05:34PM +0200, Mika Westerberg wrote:
> > On Thu, Feb 22, 2018 at 02:18:34PM +0100, Lukas Wunner wrote:
> > > We do need runtime PM on hotplug ports to power off Thunderbolt
> > > controllers when nothing is plugged in.  That saves 1.5 W, so a
> > > noticeable amount of power.  I was going to respin the series one
> > > of these days, I think the best I can do is continue to forbid
> > > runtime PM on hotplug ports by default, but whitelist it for
> > > Thunderbolt and allow manually enabling it on other platforms via
> > > the command line.  That way, vendors are put in a position to
> > > validate their platforms for runtime PM of hotplug ports, and
> > > perhaps someday we can enable it for all platforms by default,
> > > but with a BIOS cut-off date.
> > 
> > AFAIK Windows started to enable runtime PM (RTD3) for native PCIe
> > hotplug ports with the latest release (I guess it's the RS3 release) but
> > only when there is a special ACPI _DSD property ("HotPlugSupportInD3")
> > associated with the root port. I think we can take advantage of that in
> > Linux as well and I already have a patch series to enable runtime PM for
> > such ports but I haven't been able to test it properly yet.
> 
> Okay.  Well it would be trivial to whitelist those ports with
> device_property_present("HotPlugSupportInD3").  In how far are
> your patches identical with the patches I submitted last May?

My patches pretty much only touch the whitelist part not the other fixes
you made for pciehp in your series. We can add those on top of your
series or I can send them out separately.

> I've started reworking them for v2 but that would be a waste of
> time if you're working on this issue in parallel.

Please continue with your v2 :) I can provide testing assistance if you
need any.
