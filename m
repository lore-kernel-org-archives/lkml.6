Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AH8x227sgB9UJmP2o6QRrw41k2xpMwObXSOI6hkqL6M8AZ8TpU0pxnb5AGQNgNuZOsfxelzUdpLo
ARC-Seal: i=1; a=rsa-sha256; t=1518787954; cv=none;
        d=google.com; s=arc-20160816;
        b=oJGxGQ7ve8aadggJ17SVyTxAh1TI+HvzHd5UMCBQhXulmwZ+0ArPFI2G7855VNgFr6
         RF6iPYewd4oeYrGz/wTIkR3xSU8tHpCmXEUjqHxOC2EddWxZV9mXPORoExR4RwKoxG/a
         Pm4xee/3EaKYzbo5qZhJYOeHycPnp7WNpreOw79snE3HtilZ7JmIZUeTwBcq++uif0n9
         jlaVmpanYL9sqw06u4tw2LQjMikFWvJo2X0aLIUPt3/3U5tWcNjDk6tyCiDlsaKdEJV5
         2p3xqG6JCoPm8oaCbWKjCV+jDTODaBuZ8IwTU6Zca6kVNXZIw2kD5wY4NBmpI4Cg3R/I
         IIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=epJBPPm8VRM+azirhQMFWPPh9/QK5ujhuZLLtaO/4xw=;
        b=tVmro4Ng9SJnQEKjhYdxrwvRvUGz01ZV75wOa68h+clCKlxRIYpLqKsSemw5o9/qZj
         REkvCkW2a5oB4LxtrdcxzODy4Qt5786jiHoj3P3K583x0uMF/TYHTRIHlwpWjyL25+R4
         sUDploSQjBefySaH57uASb8vL0q4QWyM7A4yavlUejXOMureTz4/XvpToHHFOmrF8oKD
         3M3U19oZVHKHGkKiMpN0d9ltlCbzgjJpeZVq0nIUVAF2J/Dg/AvmANrC+3yQSjpoEkF3
         wQYSbn57aMHSTYlSt1ncodT8WXbYNuPiJ5GnSMXG6GhO3hlPmFFMRO3Ww/FyHLyckWWU
         fR1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31366383"
Date: Fri, 16 Feb 2018 15:32:28 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 08/12] xhci: Add Intel extended cap / otg phy mux handling
Message-ID: <20180216133228.GN1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-9-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554252355342442?=
X-GMAIL-MSGID: =?utf-8?q?1592564597466741497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:47AM +0100, Hans de Goede wrote:
> The xHCI controller on various Intel SoCs has an extended cap mmio-range
> which contains registers to control the muxing to the xHCI (host mode)
> or the dwc3 (device mode) and vbus-detection for the otg usb-phy.
> 
> Having a role-sw driver included in the xhci code (under drivers/usb/host)
> is not desirable. So this commit adds a simple handler for this extended
> capability, which creates a platform device with the caps mmio region as
> resource, this allows us to write a separate platform role-sw driver for
> the role-switch.
> 
> Note this commit adds a call to the new xhci_ext_cap_init() function
> to xhci_pci_probe(), it is added here because xhci_ext_cap_init() must
> be called only once. If in the future we also want to handle ext-caps
> on non pci xHCI HCDs from xhci_ext_cap_init() a call to it should also
> be added to other bus probe paths.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
