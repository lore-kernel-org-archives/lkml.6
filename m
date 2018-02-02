Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3079078-1517595605-2-595949498079750814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517595604; b=BfKdUC8mHlPIaGvyxtvq/TWzLLYpKPHRf/WAuZFwtbV9R6g
    bbbvt/sN+iKrdf6FuyjbSdLvAn+Eku9xzDYn5XSkS8C89VGKxvWxyF7cBbQvuDI0
    UnMxUWMXRr7MuuGAAS253l8nlO0iY3X3WSAZoXrNsGnTDY+Lh0XIeDaR2BdCzQ71
    wpXZrijihy7DdTOpzAT98Q2ttBPzeHgiNtz0XJp3Id0Gte/JFX8DeS1AExjkjgCo
    1Yjc21f+5ucWRbzOxltoe87NjMfAs77Mt0nDuVJnKwTkiCW7HmAWUMrr/CU2HgTt
    IJ0dCxilkcSLLyINx9x5EiqhmT3vOXSYWJ88zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1517595604; bh=xGWpD
    LLhCtmgwsCFiifaOkpS2tUDaHZAatMPIZ+dD2M=; b=CdKfEEFtUZ4wmmdtXknHA
    pdobGnLoBUlckmDhdd2cXwl5PZwr0wuOk3lIwyi7DXq2Ap3ZvqapeGVbggSKzN+l
    PnFJTg6J0fTkQ6m78ECHtE6JbqKdZPF9iisqlvnZCDESkPYoymdlbPisxyqMhRpw
    5msj6fiauXuTzt9IgD6oKJgPahhi2QE0goziQ1cVm7FbpebiMYMW7dJF7loHmG1Z
    g6HURXKtdmQMGt78avhn02PfGM1ZreHaYkyBHVbduTg0sLNPsUXIhOYO2n62WguG
    Fv1UiXUnuTRO5cAAPPL2m/ZSWRMIEeu+/RLqVKvYL57D2uRVwO7odGVssF6WzNxk
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RJfOM5+G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JQpxIao3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RJfOM5+G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JQpxIao3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeBBST7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 13:19:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35831 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754427AbeBBST2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 13:19:28 -0500
X-Google-Smtp-Source: AH8x224CcKF+qDB1aagdCUCyYjEx4yo7wmAKL+8Gk1MAmm4nuiPjgfKExIzUKXfsjtUjpmBBFcmpqw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Add delay-init quirk for Corsair K70 RGB keyboards
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <1517586717-6209-1-git-send-email-jackstocker.93@gmail.com>
Date: Fri, 2 Feb 2018 20:19:23 +0200
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Sandeep Singh <sandeep.singh@amd.com>,
        dmitry <dmitry@daynix.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <596D3B57-74E7-4038-85CA-2F48F0130EFE@gmail.com>
References: <1517586717-6209-1-git-send-email-jackstocker.93@gmail.com>
To: JackStocker <jackstocker.93@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 2 Feb 2018, at 17:51, JackStocker <jackstocker.93@gmail.com> wrote:
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

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

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
> 	/* MIDI keyboard WORLDE MINI */
> 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
> 			USB_QUIRK_CONFIG_INTF_STRINGS },
> -- 
> 2.7.4
> 

