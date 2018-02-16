Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518788350-2-12101250705873781105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788349; b=iOfGxJh5ePEBjNATy71yWf7JkCjzWQ5bTE0mSz2ToQMoleX
    77/BzQFBCUZ0M2dyQdGVRFBDXS+OtKehdVM4L+vPOJHMrXZa6+BLlR/DkMu+wEGa
    7P0Skld40BypOdiTASUdEVEYQDWGUAoO/sv4xcrt++kQktOu2oXaEx7m/slxhYOc
    islckJhGVFdWVSKlsMiZU1CFVyyCY3NXuF2wIuzQPGIxcKHkt3YVgVd+e1oFEDgR
    zPs9DHxSPivl3NbrhQo3DXHuZDuzqtwehH/AT6pIEUXqZWE8V4wYuJQ62dA4Sutg
    R1NgdO1GkmrI3l+SRDXg4VQRCNrPxlfE2oCc5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518788349; bh=JORzEjluZsDELbnIh16WqGW/xI
    UJpxcTtHSMb4MCXcM=; b=wAd/vMolsHiuPbiiD6v9Urzl+PjF3N7A6ciMEa1+0w
    enYCEQMIJc15pFjDsS8opAMrD++jAMAYbUt1sVHBpKkjf3pf+fRgI+uWuKZTsjKf
    w5mjMawzt1P74MH9QQVU60M4aF3WRAWJAJpMrP8IEpyn6vWdpTcZsrtcYzYHpFJ/
    m6lC0KxCD3FBxu1iaraFV9MazYOcT108cEc6Uovt0EQe3H4cuMlDtJ61O+yp5Nkm
    XllvIlcwzpFhrMVZBqr+rfzTqLwjYVTyJ6hf/5tVwKdRkiyCod9ypv9xocI2YvVG
    LVPgMdWW9l+VXrgTtwqbaB5Q0uovlE+vWrfu0mppcpKQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031598AbeBPNi6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:38:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:20037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031458AbeBPNi4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:38:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31367574"
Date: Fri, 16 Feb 2018 15:38:50 +0200
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
Subject: Re: [PATCH 09/12] usb: roles: Add Intel XHCI USB role switch driver
Message-ID: <20180216133850.GO1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-10-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:48AM +0100, Hans de Goede wrote:
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 060643a1b5c8..7d1b8c82b208 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -65,3 +65,5 @@ obj-$(CONFIG_USB_COMMON)	+= common/
>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
>  
>  obj-$(CONFIG_TYPEC)		+= typec/
> +
> +obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles/
> diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
> new file mode 100644
> index 000000000000..e5c2bfaf8ba5
> --- /dev/null
> +++ b/drivers/usb/roles/Kconfig
> @@ -0,0 +1,14 @@
> +if USB_ROLE_SWITCH
> +
> +config USB_ROLES_INTEL_XHCI
> +	tristate "Intel XHCI USB Role Switch"
> +	depends on ACPI && X86 && EXTCON

Hold on... There is no dependency on extcon, or is there?


Thanks,

-- 
heikki
