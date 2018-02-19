Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-177322-1519048495-2-133984629075624521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519048494; b=CQersDe6erbqyLYSHw7YiIor+MULcnneo0LOb13yt7raxvD
    EXNbyMAvd0bxjQBS88Q0ZmquxcQvJ0mjmhOshyaianQiw6BeOz+UIXstmY5IDilJ
    CrMHGxbD9+G8JzcwV+PbYR47q2fRg8t2ov/PiB+5oh6xP4N9RWD+xX35ilr1Dceh
    EIkJXC6uxEvfcxGHl93jMs50oo/qQs7GnzvjKcg/z6o2Mho1LI2AWG5KGcAI4jZ9
    1PHx0PtHM2Y2PBh0DOYxnwXzuZsImKCp1kS/nurCn+G+QfW/nXwmyyfndpCRq6Jv
    /tlxEHxzWUWRNMpavlU78NljOye06foRlIl+dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519048494; bh=5GvhXDWgQyDDNCw4bP0jo+UA1iUJpnQmDyiRHu
    ZdBXU=; b=bFtqFR0h0KpuZZn8bDae2oqB+Mtf+KSeZLRkW3075s1k8BoefBAoQH
    MC34hT5uUzy6LVAhl+lDC3WCGympGJ4GdJi4t30KhtZPjJgVRZ13NiwgrofZ+9tr
    oXvEEaZP0kim9lYVfMymfcP0CabdAGsOcLQRA7BX/sB+doXmedDNOrhrZDCzfXqM
    sXMFpq8+fz/dPZDFVZpQVuBg7xL14p6wEeI0eDWaEs9Xxoq13t1B6FPi5BaxVZv3
    lDrpQ61GLVz8857wpEFWmaVfe+S5Wxg3/3jFZctBjB6nFJouSl8jTz9o4G/cuBU9
    0ifZl1TghOOuUnV/uwqxD02tjGgtl+ow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeBSNyk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 08:54:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:42124 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeBSNyk (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Feb 2018 08:54:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,535,1511856000";
   d="scan'208";a="29115765"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Richard Leitner <dev@g0hl1n.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux@roeck-us.net, mathias.nyman@linux.intel.com,
        johan@kernel.org, ekorenevsky@gmail.com, peter.chen@nxp.com,
        drake@endlessm.com, joe@perches.com,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] usb: core: introduce per-port over-current counters
In-Reply-To: <20180219120107.20434-1-dev@g0hl1n.net>
References: <20180219120107.20434-1-dev@g0hl1n.net>
Date: Mon, 19 Feb 2018 15:53:59 +0200
Message-ID: <874lmdgk5k.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Richard Leitner <dev@g0hl1n.net> writes:

> From: Richard Leitner <richard.leitner@skidata.com>
>
> For some userspace applications information on the number of
> over-current conditions at specific USB hub ports is relevant. Therefore
> introduce a oc_counter in the usb port struct which is exported via
> sysfs.

relevant how? What can the application do with that knowledge?

> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
> Tested on an i.MX6DL based board.
> ---
>  drivers/usb/core/hub.c  |  4 +++-
>  drivers/usb/core/hub.h  |  1 +
>  drivers/usb/core/port.c | 10 ++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c5c1f6cf3228..448fba1e1827 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
>  
>  	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
>  		u16 status = 0, unused;
> +		port_dev->oc_count++;
>  
> -		dev_dbg(&port_dev->dev, "over-current change\n");
> +		dev_dbg(&port_dev->dev, "over-current change #%u\n",
> +			port_dev->oc_count);
>  		usb_clear_port_feature(hdev, port1,
>  				USB_PORT_FEAT_C_OVER_CURRENT);
>  		msleep(100);	/* Cool down */
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 2a700ccc868c..b5cf567bf9e2 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -100,6 +100,7 @@ struct usb_port {
>  	unsigned int is_superspeed:1;
>  	unsigned int usb3_lpm_u1_permit:1;
>  	unsigned int usb3_lpm_u2_permit:1;
> +	unsigned int oc_count;
>  };
>  
>  #define to_usb_port(_dev) \
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 1a01e9ad3804..0bfe410eb8a7 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(connect_type);
>  
> +static ssize_t oc_count_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	return sprintf(buf, "%u\n", port_dev->oc_count);
> +}
> +static DEVICE_ATTR_RO(oc_count);

I would actually spell this out human readable: over_current_count

-- 
balbi
