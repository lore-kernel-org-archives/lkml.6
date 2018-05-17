Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2600153-1526584559-2-5886030491157985534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526584558; b=IwRbT59hEtT9RcCLBkO/RwTZMjC+Dwpqm8uNw2K5L66TB9VyzH
    CIZF5WGVHA1EmnAwq0ejoTq2V8/xpnH44re08R1nOUacX0YKdgWGXNKqNjheM5Z1
    QsHrGMw8WgWyDsbjcdEVeP181X77hcvpVwi+NSPR5/F+QGiX7lYNzO4zD9TZ1I4W
    XNbxZSgypOsI0sJpjFDpKwMzY+1iToNoTdS0Ee9YH8TR6EVYxHskUP1xz/pLKqF/
    2G289w+M7rL1Bq5kVjmqp4n0sjAZs6ZaE5ljPvlgHeJ/M+v7Ssho4+X4pt8mlRKI
    7wfCHW/6NQA4Uv5ZjVuio/n49UPqn/dOS56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526584558; bh=+op+JhcZvnAKdO7158brgNElBJJr8F
    g4YqZfs8OdOZ0=; b=hSH4vWKNpYz0YagXonBLk8lkGY+Rpvwv9Zgf7WGTbyU9Ga
    7ZvSYX1R1jxwfvRUaV1jBIJ0ZrpL4tWQu4rgam4RLYpx/XKBtwGplpxHklxGS5Fg
    WtFKA9dlIFe1tOmg/pTTjKYdLHoS8KG1n2uqg1JLm6jv4i3Pg9qkH+Ku/VzqEz/c
    EQOqLjv5yt3Splv994p1ov9OaxVEztV4gR0D7pf8ZUOn2+f1jG4U3C/Pqpy3NVVT
    bX50TnUS4/wBOOOBTQSDuE0uvWLfep8xLQ+JH7vnCUnhnBHnXfDU8GtQz0c1qei+
    luEpcBN1x0RgieD689KaIXQlm9SS9pu74gpwPm5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=yj549xct x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=yj549xct x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK1NsiZBt1OcbmjCgXZxR27/wlPVg5qgD1vUkb1/JVVU9IFHU66m9dcVZRlEpH0/JU+/sqWiPIdxneA9JLZ7dkpE5fAE2jLEqi4RSL0XxOQ253WbJUo2
    IN8Me5pv2Mc/VGXmiKTQBt72Jxe700uCbPeeMLYplex+01kN9DcwsM4YfWWXaRM7wL53XZUGdTO3aoSnr1WBJT5Ec6yDuw6USKvWlZ+PjqxmN9m5icQizMu9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=_Wotqz80AAAA:8 a=dCB6-aEaEGGP_dzkFJkA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeEQTPz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 15:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeEQTPy (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 17 May 2018 15:15:54 -0400
Date: Thu, 17 May 2018 21:15:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci_sysfs: fix potential Spectre v1
Message-ID: <20180517191535.GB3799@kroah.com>
References: <20180516222200.GA14733@embeddedor.com>
 <20180517065117.GA12910@kroah.com>
 <ba00b923-3ff0-95db-2939-7da27d34fe6c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba00b923-3ff0-95db-2939-7da27d34fe6c@embeddedor.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 12:57:49PM -0500, Gustavo A. R. Silva wrote:
> Hi Greg,
> 
> On 05/17/2018 01:51 AM, Greg Kroah-Hartman wrote:
> > On Wed, May 16, 2018 at 05:22:00PM -0500, Gustavo A. R. Silva wrote:
> > > pdev_nr and rhport can be controlled by user-space, hence leading to
> > > a potential exploitation of the Spectre variant 1 vulnerability.
> > > 
> > > This issue was detected with the help of Smatch:
> > > drivers/usb/usbip/vhci_sysfs.c:238 detach_store() warn: potential
> > > spectre issue 'vhcis'
> > > drivers/usb/usbip/vhci_sysfs.c:328 attach_store() warn: potential
> > > spectre issue 'vhcis'
> > > drivers/usb/usbip/vhci_sysfs.c:338 attach_store() warn: potential
> > > spectre issue 'vhci->vhci_hcd_ss->vdev'
> > > drivers/usb/usbip/vhci_sysfs.c:340 attach_store() warn: potential
> > > spectre issue 'vhci->vhci_hcd_hs->vdev'
> > 
> > Nit, no need to line-wrap long error messages from tools :)
> > 
> 
> Got it.
> 
> > > Fix this by sanitizing pdev_nr and rhport before using them to index
> > > vhcis and vhci->vhci_hcd_ss->vdev respectively.
> > > 
> > > Notice that given that speculation windows are large, the policy is
> > > to kill the speculation on the first load and not worry if it can be
> > > completed with a dependent load/store [1].
> > > 
> > > [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> > > 
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   drivers/usb/usbip/vhci_sysfs.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> > > index 4880838..9045888 100644
> > > --- a/drivers/usb/usbip/vhci_sysfs.c
> > > +++ b/drivers/usb/usbip/vhci_sysfs.c
> > > @@ -10,6 +10,8 @@
> > >   #include <linux/platform_device.h>
> > >   #include <linux/slab.h>
> > > +#include <linux/nospec.h>
> > > +
> > >   #include "usbip_common.h"
> > >   #include "vhci.h"
> > > @@ -235,6 +237,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
> > >   	if (!valid_port(pdev_nr, rhport))
> > >   		return -EINVAL;
> > > +	pdev_nr = array_index_nospec(pdev_nr, vhci_num_controllers);
> > > +	rhport = array_index_nospec(rhport, VHCI_HC_PORTS);
> > 
> > Shouldn't we just do this in one place, in the valid_port() function?
> > 
> > That way it keeps the range checking logic in one place (now it is in 3
> > places in the function), which should make maintenance much simpler.
> > 
> 
> Yep, I thought about that, the thing is: what happens if the hardware is
> "trained" to predict that valid_port always evaluates to false, and then
> malicious values are stored in pdev_nr and nhport?
> 
> It seems to me that under this scenario we need to serialize instructions in
> this place.
> 
> What do you think?

I don't understand, it should not matter where you put the barrier.  Be
it a function call back or right after it, it does the same thing, it
stops speculation from crossing that barrier.

So it _should_ work either way, if I understand the issue correctly.

If not, what am I missing?

thanks,

greg k-h
