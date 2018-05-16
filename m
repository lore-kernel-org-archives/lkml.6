Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4013241-1526457465-2-9648864451581830249
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526457464; b=aSgYR1lVLXPbEtJ7D+rWZRKn19xBSm/PF+I8dVoD2xbmWLDccR
    8bB8+zXxMAAUEAb/zPy3bxCwybWdwa0s/pzlFK3eiJMx7f/V5zuWpNQ4IpfhaIMS
    1nHRJYFCUzDSTXNrF7qneBVYA+t2qM7EDv+OaD26UetaKa3VA0qwEo0gz24bSooE
    6WI6e8oN8Orv3fdTKs5D83DITcsOjkmIyyJtnOsQ6qBG1v3VXSnM5cyWslUPCos8
    LDl+vvHQIXGPSeCe6lHkT+6QHx27RtvTR6C7pLPr/oF2ei++imoEcUQuNnYywddV
    nGAeWeNXqAo/LAwNF4ftsnhFEjPfX7XuvUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526457464; bh=2A36MSL7Z0LD/jj40QdFzie6iagG6c
    rJvcLAv+laMrM=; b=Qoy23BrfyVAUq5CSLKLGn/he80bgU2QLvtD1rKWCU7XP6x
    q20LUS4lba2wZvpE6tRiwWxKiWT31tppgoutXKKsxszS14txeLbjKKYqMH6pAspQ
    yREKBY5u63vkyDeRCdCW/hj/Or7whB7aluPNKjc5uHdk7DP+UrhRZ9n4xkTImODa
    mphhQvhXhSGxOOlYH4vJCxR5kx2x5uvQfwQGfXxAFLzhmp1SapJFbmHvinUjw9Dj
    l9I85sMKGF5Ysa+W4Wg5jR168jU83zh0qhcx7NrGuxOsLGlHZP84Uwzz9lmDYuOO
    4rIcgKzHrOgfN0tNixywebpIyAIVtVK1mfAQBnAg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=kGFtQTgO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=kGFtQTgO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfCJXp3A/ACy9XIh9v5TbpTs+XDBKZ+GI4a3ucndf7ouobVzxHfozzOqA+Rd2cNXWI1d0PM1qkmhJh5pV7lkksH0VlinYLCFaBI/x7aCyNUrFAz9nTrXG
    jyc83SpHr4o6BQ4zNgaceF8KLozXL6lN/4tSSUFjmasSXZVDfjVZkCBsuVyO1WwpHCpm441sSpOmwtY8O4C7rbGYmyGx+SdrRi5box9XvgJh7gKqt7rBpA8v
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8 a=ag1SF4gXAAAA:8
    a=L_keCoNQEjXAZ1i_S-kA:9 a=wvGnI8YJnYRmxQnp:21 a=LX3t84-NsYVI7J2B:21
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=M-Yerj1wOn-OpK7r_3ei:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeEPH5l (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 03:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbeEPH5k (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 03:57:40 -0400
Date: Wed, 16 May 2018 09:57:21 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.14 49/62] Bluetooth: btusb: Only check
 needs_reset_resume DMI table for QCA rome chipsets
Message-ID: <20180516075721.GB3536@kroah.com>
References: <20180514064819.213872386@linuxfoundation.org>
 <20180515170657.GA40373@rodete-desktop-imager.corp.google.com>
 <20180515194236.GA22374@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515194236.GA22374@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 12:42:36PM -0700, Guenter Roeck wrote:
> On Tue, May 15, 2018 at 10:07:02AM -0700, Brian Norris wrote:
> > + Guenter
> > 
> > On Mon, May 14, 2018 at 08:49:05AM +0200, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > FYI, this backport is wrong. See below.
> > 
> > > ------------------
> > > 
> > > From: Hans de Goede <hdegoede@redhat.com>
> > > 
> > > commit fc54910280eb38bde923cdf0898e74687d8e6989 upstream.
> > > 
> > > Jeremy Cline correctly points out in rhbz#1514836 that a device where the
> > > QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
> > > with a different wifi/bt chipset in some configurations.
> > > 
> > > If that is the case then we are needlessly penalizing those other chipsets
> > > with a reset-resume quirk, typically causing 0.4W extra power use because
> > > this disables runtime-pm.
> > > 
> > > This commit moves the DMI table check to a btusb_check_needs_reset_resume()
> > > helper (so that we can easily also call it for other chipsets) and calls
> > > this new helper only for QCA_ROME chipsets for now.
> > > 
> > > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> > > Cc: stable@vger.kernel.org
> > > Cc: Jeremy Cline <jcline@redhat.com>
> > > Suggested-by: Jeremy Cline <jcline@redhat.com>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/bluetooth/btusb.c |   10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -2902,6 +2902,12 @@ static int btusb_config_oob_wake(struct
> > >  }
> > >  #endif
> > >  
> > > +static void btusb_check_needs_reset_resume(struct usb_interface *intf)
> > > +{
> > > +	if (dmi_check_system(btusb_needs_reset_resume_table))
> > > +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> > > +}
> > > +
> > >  static int btusb_probe(struct usb_interface *intf,
> > >  		       const struct usb_device_id *id)
> > >  {
> > > @@ -3037,9 +3043,6 @@ static int btusb_probe(struct usb_interf
> > >  	hdev->send   = btusb_send_frame;
> > >  	hdev->notify = btusb_notify;
> > >  
> > > -	if (dmi_check_system(btusb_needs_reset_resume_table))
> > > -		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> > > -
> > >  #ifdef CONFIG_PM
> > >  	err = btusb_config_oob_wake(hdev);
> > >  	if (err)
> > > @@ -3177,6 +3180,7 @@ static int btusb_probe(struct usb_interf
> > >  			hdev->setup = btusb_setup_csr;
> > >  
> > >  		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> > > +		btusb_check_needs_reset_resume(intf);
> > 
> > The original code puts this under the BTUSB_QCA_ROME section, but this
> > is getting placed under the BTUSB_CSR section.
> > 
> Turns out 4.16.y has the same problem. Maybe git got confused because
> mainline also has
> 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> in the BTUSB_QCA_ROME section. This is missing in 4.14.y and 4.16.y.

Ah, thanks for catching this, I'll go fix this up.  Looks like patch got
confused by the use of set_bit() here and fuzzed it into this location
instead.

greg k-h
