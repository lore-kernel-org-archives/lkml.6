Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2956902-1526404028-2-13702856327879450965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526404027; b=OOyF00F3yU18a8Aiwn5Ofr1ifXVv4hujCk4L+nKubDcFeIUsC0
    CRrE8kiK8vcMP8pBrGoOK78FChhBbvyk8WABhihEAcqD/DyH5gPuCZIGgbHbs6aM
    Ok0eFWGs7MWdOE0H/LDGtZPJW7NbDN1XxJF7cNhbnisEuEc4EdwSTnjVAUkej1jx
    EdqIJlBitK1W+awBDEQEDUAn5/9PR5AzK2v6SMVzGMz7Yh7hOynImvN+Sed0R2af
    awnbm34ZkxdPUfYtXTR2iJbrxYbg3CIBUJxfuOwOW5GY/nVhluBDYnt8VdGOaBY4
    rEw8DpYFXzm+07odjizILt+jBvcgUoMcBu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526404027; bh=fQHqD07tvhzy5Ww8i9953U1nZRS4u7
    b5SFidBvUqsGM=; b=Sa/g1NllPmayA7MUgOBlwDWh47RgH5TXB94nSNZ8peotyX
    aucZGLqmOxfnMpr0IfXsbXXzebZy/S2JaOL+xZSk4ORCSKp6zTJwvf/RtyY+kL5v
    EM2KHknuwpU7Ke423aQ+qpwwDofOyr/ZeGtArKdfz3RaILz0DDNOpMUG0ynZyUae
    y0wmhn3AO1PDrYr3G6adTu9mmzVUB4D7Ort5p0hC7Ga+dJdoEJ9Fe9NLvKU32qFE
    x+h90cKyP/KHKDZ7R8pK/3QhM0kkNpN+c5O54bEqHC8e63dDMpuEoliKmx4zRJdZ
    yxbKFreZk1SbgvMmFYdx3ZWQsutc66G9/8q1PX6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org
    header.i=@chromium.org header.b=Wt/HT1V2 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=QzUL1XhA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org
      header.i=@chromium.org header.b=Wt/HT1V2 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=QzUL1XhA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0IE6wlGZL0gtcq6whckzXkwgN7kkv2m0mVHgn90HkDnXC/NrvkRGb6gBJ6WVA0fiJhLdQ0hHiGSpwjmfvhyRsGU3fVC2BIG21WVIm3gOqDs2QMlIAd
    nUQxE50i5WvqVmU8CdYhQtE2bZKWql5WrnLdQzKOJIbtmX0kZvYAq4J417qzONSaX4KIkP/Ap2yPp0we3flPRJ6iZ5kz7HO0viqg8LVlkirF4XpwKS7uD0+v
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8
    a=ag1SF4gXAAAA:8 a=i_EsnebCxLSoe4krfr4A:9 a=WYJdJbBKxvnratJt:21
    a=MIPMLnxIhdgQdLcT:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754091AbeEORHG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 13:07:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36048 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEORHF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 13:07:05 -0400
X-Google-Smtp-Source: AB8JxZrG3PPGDyxhbzztbjQfPQQXzfn4jhDVi5MGA1NPtEbRzf2OyqJZUbGijjm8Cz1EI01nXTvoxg==
Date: Tue, 15 May 2018 10:07:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.14 49/62] Bluetooth: btusb: Only check
 needs_reset_resume DMI table for QCA rome chipsets
Message-ID: <20180515170657.GA40373@rodete-desktop-imager.corp.google.com>
References: <20180514064819.213872386@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514064819.213872386@linuxfoundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+ Guenter

On Mon, May 14, 2018 at 08:49:05AM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.

FYI, this backport is wrong. See below.

> ------------------
> 
> From: Hans de Goede <hdegoede@redhat.com>
> 
> commit fc54910280eb38bde923cdf0898e74687d8e6989 upstream.
> 
> Jeremy Cline correctly points out in rhbz#1514836 that a device where the
> QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
> with a different wifi/bt chipset in some configurations.
> 
> If that is the case then we are needlessly penalizing those other chipsets
> with a reset-resume quirk, typically causing 0.4W extra power use because
> this disables runtime-pm.
> 
> This commit moves the DMI table check to a btusb_check_needs_reset_resume()
> helper (so that we can easily also call it for other chipsets) and calls
> this new helper only for QCA_ROME chipsets for now.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Cc: stable@vger.kernel.org
> Cc: Jeremy Cline <jcline@redhat.com>
> Suggested-by: Jeremy Cline <jcline@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/bluetooth/btusb.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2902,6 +2902,12 @@ static int btusb_config_oob_wake(struct
>  }
>  #endif
>  
> +static void btusb_check_needs_reset_resume(struct usb_interface *intf)
> +{
> +	if (dmi_check_system(btusb_needs_reset_resume_table))
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> +}
> +
>  static int btusb_probe(struct usb_interface *intf,
>  		       const struct usb_device_id *id)
>  {
> @@ -3037,9 +3043,6 @@ static int btusb_probe(struct usb_interf
>  	hdev->send   = btusb_send_frame;
>  	hdev->notify = btusb_notify;
>  
> -	if (dmi_check_system(btusb_needs_reset_resume_table))
> -		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
> -
>  #ifdef CONFIG_PM
>  	err = btusb_config_oob_wake(hdev);
>  	if (err)
> @@ -3177,6 +3180,7 @@ static int btusb_probe(struct usb_interf
>  			hdev->setup = btusb_setup_csr;
>  
>  		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> +		btusb_check_needs_reset_resume(intf);

The original code puts this under the BTUSB_QCA_ROME section, but this
is getting placed under the BTUSB_CSR section.

Brian

>  	}
>  
>  	if (id->driver_info & BTUSB_SNIFFER) {
