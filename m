Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AH8x224IlHhXkrgXVOjZZUYkWwy30Ld4RnmbUGdHG2SuBFH+fyg53GK4UtKxWQokocRQzCm498G9
ARC-Seal: i=1; a=rsa-sha256; t=1519646750; cv=none;
        d=google.com; s=arc-20160816;
        b=d5eLL0Szr0lbOplxONr6K9+0kkPUI8hVLMXX1R2kQ/kpa20SAlu9gP9x1pwmKPuUzM
         x82EiLdp0kNe6sgq6iIzt2+DLlhotPYdxjATByEVv/fNfLqP/mSvQ11t8d8vSn03CtkB
         0e4xHSyAz0bgQZRj3UBcnKNShs/jLWW6NCe56jFxRL+pjJwD5SVZ7+Gjh9sOLmPve+D5
         5XtMlZdDo7UAPny9cQkbo/vaL4z+l3fHCzfd7T/GoMlPWsaO9m5WGfuWhbz4fwLhye8Z
         ltnIV5wr6kGPNSVBqpZU+5Y+3rQ7+tOCIsx9ozrqqnIzBY824C+w8378mB4PsqoEjYrH
         6ByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Z8pp8UJXveblnSuQG9DRYUIVg1T8hYsbtsz172yu5xA=;
        b=JS/+qa0HTid7iNoWrJuiWy1qeo1otmfQhKRGi/mtT6Z5N8JvcIQ/1w8cINNWXFaoiE
         QpdDSznZEpqFuT8UJ+udF16GojZ2cZPUKhyfv4EoysAD+oZV8sTmuyXnpL+NlKVbxA12
         Y+3zaBw/MJ3HzVDl18aLwDVrng/98kM7aUBvfrxQG7Sg04AqeTe0s/ufFm5e7Vlh5QQf
         uyqZB6p40lOoWW2c7GlOqUzLa84AzZ3TX3pSpmt1yjUmHPeEOKxRTEiRwndIB3RZqSfo
         VFRQFW1HD+kaQz1Mh+qnHUZiqbBPIHv1sS/hTnbs2wYcqUXdRH+czN0t5bQRgQjOcMPz
         /gFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="23198994"
Date: Mon, 26 Feb 2018 14:05:34 +0200
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
Message-ID: <20180226120534.GO27191@lahna.fi.intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222131834.GA5527@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1593465111000678477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 02:18:34PM +0100, Lukas Wunner wrote:
> We do need runtime PM on hotplug ports to power off Thunderbolt
> controllers when nothing is plugged in.  That saves 1.5 W, so a
> noticeable amount of power.  I was going to respin the series one
> of these days, I think the best I can do is continue to forbid
> runtime PM on hotplug ports by default, but whitelist it for
> Thunderbolt and allow manually enabling it on other platforms via
> the command line.  That way, vendors are put in a position to
> validate their platforms for runtime PM of hotplug ports, and
> perhaps someday we can enable it for all platforms by default,
> but with a BIOS cut-off date.

AFAIK Windows started to enable runtime PM (RTD3) for native PCIe
hotplug ports with the latest release (I guess it's the RS3 release) but
only when there is a special ACPI _DSD property ("HotPlugSupportInD3")
associated with the root port. I think we can take advantage of that in
Linux as well and I already have a patch series to enable runtime PM for
such ports but I haven't been able to test it properly yet.
