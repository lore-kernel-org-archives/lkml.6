Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825185-1519131817-5-17625779852964401152
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519131817; b=CH5lf3Ae9KW5Ug7YT4aJk42A3cWOTDMFEsDksZtkfZ/HaJ1
    dEa1cz/DGssnRyMDhAOWPM4uz1tDdbwZv9gKnO1DeG6fDwn01LUIAcjGS1Yakznp
    QtvUeq7jzeCoUti+au4o1cZ9fntZTs1Souet+oVJT6QNWmIukeU/O/lZQDOmtjgg
    ruT+z6vJt8Kt5PDYcVzJDYrymsaZ8srZ7p3PDRsFJzp31/OhHXmfQUtDAxk48lVs
    u9PhKqrfPV+8y0ywTbTUKGNJY8BCvVVFFSDOWMcxGa8KhmaZyhvfIkz/KCcQvu9t
    0sHfXpEcKetAROJeEU2X6S6dUVthu9AcqYzXRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519131817; bh=LnPlv09ohxLap4WuleNioRKa6DyK6EpVHHO1Bh
    EBAqE=; b=BDAifuAq7UiFnHSPPcBl3b46rNKYf8RBDEp5Gq5DXzPFuBDkpLCoN0
    o2TJmb5sVB26WRJOo1iHmOSgSZ4DUOYS/S5m8z7Oh35M35Fx8eCic7owHDmeg5FF
    uNrR/G9T2wKNd0ogItEENZfwCAz5r2rgVJmw5aBANVdARTWyRwezt5i7hI0OmwbH
    gDEWZYpuTRyB5kk4a1T4PY8YzTRF47Q3vHAxkI5HEePiLDXOU/hxmLgCXFWUpcfa
    ElYmZ2kfCGKGN7ZkR0isZqRPJ5i7DkF41iwyva1Oe68SPLd4wTsvqNXbbKA1BzW6
    yMQSIezyNNOyYTjzHttu9ElfyhAV7k3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeBTNDU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 08:03:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:47267 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbeBTNDR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Feb 2018 08:03:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="19102587"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional external vbus supply
In-Reply-To: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
Date: Tue, 20 Feb 2018 15:02:41 +0200
Message-ID: <87h8qbq0em.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Amelie Delaunay <amelie.delaunay@st.com> writes:
> On some boards, especially when vbus supply requires large current,
> and the charge pump on the PHY isn't enough, an external vbus power switch
> may be used.
> Add support for this optional external vbus supply in ehci-platform.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>
> ---
> Changes in v2:
>  * Address Roger Quadros comments: move regulator_enable/disable from
> ehci_platform_power_on/off to ehci_platform_port_power.
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
>  drivers/usb/host/ehci-platform.c                   | 31 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> index 3efde12..fc480cd 100644
> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
> @@ -19,6 +19,7 @@ Optional properties:
>   - phys : phandle + phy specifier pair
>   - phy-names : "usb"
>   - resets : phandle + reset specifier pair
> + - vbus-supply : phandle of regulator supplying vbus
>  
>  Example (Sequoia 440EPx):
>      ehci@e0000300 {
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index b065a96..05be100 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -46,6 +47,7 @@ struct ehci_platform_priv {
>  	struct reset_control *rsts;
>  	struct phy **phys;
>  	int num_phys;
> +	struct regulator *vbus_supply;
>  	bool reset_on_resume;
>  };
>  
> @@ -76,6 +78,25 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> +static int ehci_platform_port_power(struct usb_hcd *hcd, int portnum,
> +				    bool enable)
> +{
> +	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
> +	int ret = 0;
> +
> +	if (priv->vbus_supply) {

you can reduce indentation here:

	if (!priv->vbus_supply)
        	return 0;

-- 
balbi
