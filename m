Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3591012-1517751368-2-1671522904066304700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517751367; b=lCp/RO3WMJjHeIdQgWg1yKm4hGmapfwh41HbUCAeNgPAnTN
    f16i6aT03YGQhcEdjB8EzONOQsK0K79EbC6InlO16ai5pRvcM9XeIfznSeiqTsgI
    Nvd2s4WL5WSKDV9mG1D0qNMLLTqsg7qFUBBEDAlra+BBiNVU6ND0M2HRE3h3YpH5
    0F9lqIhIO+wNROzdVfkrT4HsJ06sXYE2Czh94pVWLvG84tzpdSS6m+sVxrxe1zMN
    lmaIvpkDik+1aY2IWXg5ICJ5qPeNj8lf+dGCh0YkBS7/rFKKkbzIRxYTQ14QlhGT
    wIXN9lLkpnUxq5BPzMSXq6dcY8O9RQaNrIpv21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1517751367; bh=jbo99
    wCtlJNMo9i6vufCCd08rMfeGWDCSwoZN174+KQ=; b=mC7X0sBt0deTY1LDKUR3O
    jPBiRpzyir7FcNmeWw75QKL2K4UYvNBqM/ZhOLervO0Jh44STj6Pc8Pec0LpoR4b
    zRTd4oBLQdYSbGJz5k1suWnsyHRUqeOjobsoBMXh54a6jjur7r0YB7SgE85a2brZ
    PKX27CDCbnfU/VPkzBJbsH8Q5i9HbEnEe7J5YKmeevUut4mGq2cjkcaSLMVzDwIq
    fMQXrs51M9mcD/k09HfRngZOSRvm//EM/kQMhOqkc/xhQw2IbOz/GKwYmRek+vau
    WhHpHRiEDm/cfsWmohQCKLb4R8dOP9aabxwPUM70sreDgFJOxek3TmfYUt0d6akB
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ym9qucew;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ym9qucew;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeBDNfx convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 4 Feb 2018 08:35:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDNfv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 4 Feb 2018 08:35:51 -0500
X-Google-Smtp-Source: AH8x2271zXZH3YQh6QB/XijZXjU5eekzG/7HTaHKNsqCxRM+vDR2boJTAgbjggeS2GyCnF/KmQBhHw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Add delay-init quirk for Corsair K70 RGB keyboards
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1517586717-6209-1-git-send-email-jackstocker.93@gmail.com>
Date: Sun, 4 Feb 2018 21:35:42 +0800
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Sandeep Singh <sandeep.singh@amd.com>,
        Dmitry Fleytman <dmitry@daynix.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <14038CE4-3754-426C-AC53-0AFE58D095A3@canonical.com>
References: <1517586717-6209-1-git-send-email-jackstocker.93@gmail.com>
To: JackStocker <jackstocker.93@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 2 Feb 2018, at 11:51 PM, JackStocker <jackstocker.93@gmail.com> wrote:
> 
> From: Jack Stocker <jackstocker.93@gmail.com>
> 
> Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
> Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
> start correctly at boot.
> 
> Device ids found here:
> usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
> usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-3: Product: Corsair K70 RGB Gaming Keyboard 
> 
> Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
> ---
> drivers/usb/core/quirks.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index a6aaf2f..9eb92dc 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -221,6 +221,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> 	/* Corsair Strafe RGB */
> 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
> 
> +	/* Corsair K70 RGB */
> +	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
> +

I think this change should move up, to make the table follows an ascending order.

> 	/* MIDI keyboard WORLDE MINI */
> 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
> 			USB_QUIRK_CONFIG_INTF_STRINGS },
> -- 
> 2.7.4
> 

