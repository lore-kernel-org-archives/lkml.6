Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526413364-2-5994717457279238569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526413363; b=E2vQU9VMRBYunjMNM0p1Azv9ncn0sfqcB6xhnOSN8heUhZ3TN9
    NTxv0BHJOStVzaftTbLRdPzHZUfetUZcilzm2rU3kR/Oub8jXXuhj/ThKOWCSVjT
    n6NQUNeA9nErpUpEnR4GdlnpDZGbF1FYtX5yA6Y+nATgHYkkHSTuaDJIgbPU7b1O
    jEzz9mgu/i6LXzmBJetfrDKdbcq/tOkvPFwLx9UlZ47x3l/G2B6t5Q22EveluhWV
    vgPrpZC7cFE0KjDIWKDuiiy13cJQLdAbwViNvEMVNQhy4SgYCwLceoqRldKr4bEZ
    iarbJsxByMb4YqmzV0jWV8n8whgTQfYcRjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526413363; bh=GDusF5EcK35hxKvfCBYdN3kpcjoXyH
    m820mwTCGhZPU=; b=N0Jm1sPEDlfs5jXh4GbkaMz17/s1wN7Zw8LQCsGN755TVD
    Hl01ILP9u283M8R4c24TNeFF/PK7YcjhRU7taWSt5XtK4yWgOrYz6GAtEbZbcexL
    gUFL/A0AlCDXrtNusbHlHJTlfjFFg0V1S5OHVMJnhXzsNRVSb7FBXrzfNd2DfaI/
    DCJ3gDDUXzLJg3AnRKCLGx77KV11/PrAY+jA/kAZYtawwNNe8tkW7jLzjXFwf7J1
    C9ReEUVA9lE1U21ES/WmC+QCDgdLvSwE+YWJH1aSJI13jPtR+dL191zuCp/zWfsi
    QsnXB3/rwmkHax2Tct65I2P62ut8ySJFbZqwCeRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=dcag3owm
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=dcag3owm
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF37RMFOqNtBr6X7Bz+dbLG0kX4Y1FnxwL+UnYI91/PTdmLeVcanx0sp9okn8Vd94646kdWOxTkRhYad/RlXXYRBKaZB2IN6/hBSkhzkgpbG74fT4f3t
    BslEI1TCKP1eO+29Xh492dpaASo8vZjuOSurSo3eZHux5RRxN09D2XCGJUH2NUgLFZAx9lvy97HbHwmS8ICvgmGxfVmzhKrowZho9H/4nzmfgPBKez1HTMsf
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=Dei6p5SHAAAA:8 a=ag1SF4gXAAAA:8 a=86XthmDyYNB93M_mtbMA:9
    a=QPwQGkOaLEjdYWv1:21 a=lqmQ27QvYBi8Gdu2:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEOTmj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:42:39 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:59079 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEOTmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 15:42:39 -0400
Date: Tue, 15 May 2018 12:42:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.14 49/62] Bluetooth: btusb: Only check
 needs_reset_resume DMI table for QCA rome chipsets
Message-ID: <20180515194236.GA22374@roeck-us.net>
References: <20180514064819.213872386@linuxfoundation.org>
 <20180515170657.GA40373@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515170657.GA40373@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 10:07:02AM -0700, Brian Norris wrote:
> + Guenter
> 
> On Mon, May 14, 2018 at 08:49:05AM +0200, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> FYI, this backport is wrong. See below.
> 
> > ------------------
> > 
> > From: Hans de Goede <hdegoede@redhat.com>
> > 
> > commit fc54910280eb38bde923cdf0898e74687d8e6989 upstream.
> > 
> > Jeremy Cline correctly points out in rhbz#1514836 that a device where the
> > QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
> > with a different wifi/bt chipset in some configurations.
> > 
> > If that is the case then we are needlessly penalizing those other chipsets
> > with a reset-resume quirk, typically causing 0.4W extra power use because
> > this disables runtime-pm.
> > 
> > This commit moves the DMI table check to a btusb_check_needs_reset_resume()
> > helper (so that we can easily also call it for other chipsets) and calls
> > this new helper only for QCA_ROME chipsets for now.
> > 
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> > Cc: stable@vger.kernel.org
> > Cc: Jeremy Cline <jcline@redhat.com>
> > Suggested-by: Jeremy Cline <jcline@redhat.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/bluetooth/btusb.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2902,6 +2902,12 @@ static int btusb_config_oob_wake(struct
> >  }
> >  #endif
> >  
> > +static void btusb_check_needs_reset_resume(struct usb_interface *intf)
> > +{
> > +	if (dmi_check_system(btusb_needs_reset_resume_table))
> > +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> > +}
> > +
> >  static int btusb_probe(struct usb_interface *intf,
> >  		       const struct usb_device_id *id)
> >  {
> > @@ -3037,9 +3043,6 @@ static int btusb_probe(struct usb_interf
> >  	hdev->send   = btusb_send_frame;
> >  	hdev->notify = btusb_notify;
> >  
> > -	if (dmi_check_system(btusb_needs_reset_resume_table))
> > -		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> > -
> >  #ifdef CONFIG_PM
> >  	err = btusb_config_oob_wake(hdev);
> >  	if (err)
> > @@ -3177,6 +3180,7 @@ static int btusb_probe(struct usb_interf
> >  			hdev->setup = btusb_setup_csr;
> >  
> >  		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> > +		btusb_check_needs_reset_resume(intf);
> 
> The original code puts this under the BTUSB_QCA_ROME section, but this
> is getting placed under the BTUSB_CSR section.
> 
Turns out 4.16.y has the same problem. Maybe git got confused because
mainline also has
	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
in the BTUSB_QCA_ROME section. This is missing in 4.14.y and 4.16.y.

Guenter
