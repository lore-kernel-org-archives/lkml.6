Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-478194-1519058367-2-15467249141598912377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519058366; b=MDDQsF+5u0lywWf9kPIQqTMR8r1B/c7Ij2RJ3hAXmt+G8v6
    Gbi93Sv7o8c6YcECZUYruBsdGTb4PPF7i43M50FOhdgM1GymOt3AV3H4Lf6rXV/S
    ZrdMSqhm77f9mykVmxAGV1ZmPUWzh4AaXKrT3994U0n6y+1iX0OOOjotNivdwgOD
    fufDKY6Sv2pnCWq8xDqg9s2w+mCX6TJR7ojsrpKAh37gugrDVjZOW91mQGJuCeAn
    oO6w3Q72v1+NWDQ/N2MFj+uCJvIFUkQBeCFRi7UcMwRDP3znYYIqc2/Jh92CckoX
    nbVqANn9PpAjJ5A1lo8snzugwCrxwnw5R0vrrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519058366; bh=qNRSro6+cnFUKG5fWZ7gWDHaQg
    6w5VG+FQrF2HbLMxk=; b=RvwrB2xLUhIP78PCHtPptst5xNBlur353NR4GCr0dW
    rpCNRZSUL3WOHKyiGoli/Nhy3RP3BC3jowbpeCVAIe1NGHKTYqHyk1zFTw38Nr03
    SmMijzwsTY75XpDbCyL8VLgI41+Dl+zE4zVKXHHslkU87AcKJ2DqS+A+t4X/BzC/
    CBGIqmzMs3Bc2fR6H8KI2u/fM1Wr/dCVpSJ9QLLVzosMRuf0XuHBpY0tNa/9nXDe
    er13C8ezWB8WAF76Rj0AMkJDapVExR3jonC0gnzXNQxWZfAhi89ntO+nm74sePAI
    K1Hm4+Yz+k8jcHhmyVR5+7jYya2AVPIOiKuJJMBcpNow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeBSQi5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 11:38:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeBSQi5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 11:38:57 -0500
Date: Mon, 19 Feb 2018 17:38:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <richard.leitner@skidata.com>
Cc: Richard Leitner <dev@g0hl1n.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        linux@roeck-us.net, mathias.nyman@linux.intel.com,
        johan@kernel.org, felipe.balbi@linux.intel.com,
        ekorenevsky@gmail.com, peter.chen@nxp.com, drake@endlessm.com,
        joe@perches.com
Subject: Re: [PATCH] usb: core: introduce per-port over-current counters
Message-ID: <20180219163856.GA6171@kroah.com>
References: <20180219120107.20434-1-dev@g0hl1n.net>
 <20180219155914.GA23577@kroah.com>
 <5771d9c2-1efe-35f6-f8e4-58e929e0d72c@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5771d9c2-1efe-35f6-f8e4-58e929e0d72c@skidata.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 05:05:34PM +0100, Richard Leitner wrote:
> 
> On 02/19/2018 04:59 PM, Greg KH wrote:
> > On Mon, Feb 19, 2018 at 01:01:07PM +0100, Richard Leitner wrote:
> >> From: Richard Leitner <richard.leitner@skidata.com>
> >>
> >> For some userspace applications information on the number of
> >> over-current conditions at specific USB hub ports is relevant. Therefore
> >> introduce a oc_counter in the usb port struct which is exported via
> >> sysfs.
> >>
> >> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> >> ---
> >> Tested on an i.MX6DL based board.
> >> ---
> >>  drivers/usb/core/hub.c  |  4 +++-
> >>  drivers/usb/core/hub.h  |  1 +
> >>  drivers/usb/core/port.c | 10 ++++++++++
> >>  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > When you add/remove/modify a sysfs attribute, you always have to
> > document in Documentation/ABI/
> 
> Ok. Thank you. Seems I missed that, Sorry!
> 
> >>
> >> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> >> index c5c1f6cf3228..448fba1e1827 100644
> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
> >>  
> >>  	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
> >>  		u16 status = 0, unused;
> >> +		port_dev->oc_count++;
> >>  
> >> -		dev_dbg(&port_dev->dev, "over-current change\n");
> >> +		dev_dbg(&port_dev->dev, "over-current change #%u\n",
> >> +			port_dev->oc_count);
> >>  		usb_clear_port_feature(hdev, port1,
> >>  				USB_PORT_FEAT_C_OVER_CURRENT);
> >>  		msleep(100);	/* Cool down */
> >> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> >> index 2a700ccc868c..b5cf567bf9e2 100644
> >> --- a/drivers/usb/core/hub.h
> >> +++ b/drivers/usb/core/hub.h
> >> @@ -100,6 +100,7 @@ struct usb_port {
> >>  	unsigned int is_superspeed:1;
> >>  	unsigned int usb3_lpm_u1_permit:1;
> >>  	unsigned int usb3_lpm_u2_permit:1;
> >> +	unsigned int oc_count;
> >>  };
> >>  
> >>  #define to_usb_port(_dev) \
> >> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> >> index 1a01e9ad3804..0bfe410eb8a7 100644
> >> --- a/drivers/usb/core/port.c
> >> +++ b/drivers/usb/core/port.c
> >> @@ -41,6 +41,15 @@ static ssize_t connect_type_show(struct device *dev,
> >>  }
> >>  static DEVICE_ATTR_RO(connect_type);
> >>  
> >> +static ssize_t oc_count_show(struct device *dev, struct device_attribute *attr,
> >> +			     char *buf)
> >> +{
> >> +	struct usb_port *port_dev = to_usb_port(dev);
> >> +
> >> +	return sprintf(buf, "%u\n", port_dev->oc_count);
> >> +}
> >> +static DEVICE_ATTR_RO(oc_count);
> > 
> > I don't see what userspace can do with this number, as there's not much
> > it can do with it.
> 
> I've answered this question to Felipe already:

<snip>

It's not described in the patch changelog, which is where it is required
:)

thanks,

greg k-h
