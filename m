Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220077-1518788766-2-10644939397690766476
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788766; b=mAOM68UCL/EDoPKquHcuBPM+zraGns0XX1JM0pFcRgaqMgb
    C9pDMEgf2h2/eHbn4pIzTrc6IOnkll5KA4UDC8FHshzx9GoRopYBTL1C+7G4Qcbk
    bfVqUWs7g3HicLUQRrE4ZN6ewhShvwZrdb0Y+WrY61/k7awKMGRSztSYqdmEohUG
    Zk+BNRWGsW9aUUyb22YpJEGuMywLPpfJL9eErYDllyS/6QlQrvUURmn2q/TDHgIE
    2HzgL9LF+nuDhsZsJq3U3TN8xt20ViBDx9Fb1qmcd6QHHPiHfR0fwNmkNBB1IJNu
    5R3HSlMHbkUzo3G4AkTTFWU8aQBotOvRsWjPZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518788766; bh=EQIoThy1feuzYa8tJUVXyX9tvr
    0l21UpkiJtyP7ik/w=; b=Wp8AVlt+5NVy2k72wLtbzej16TFnoTxmtLdwF6+ICf
    rzR37IR0hbZdbzUKbZIz0hwM2wb6HyIcpgpIP/Vqh6+Re6ppheVHIulbX0w0xy79
    No/Vums9gRfxOTlyI3oGgxbY0QnIDGu6lSZpYNRx7gR3ukdzyatlC/5cxUTYJiTf
    YIwiZY/KNxLASZY5p2Y/L/+2xZJjHQuOA3JHRvkHYiUjNEoLfeUWtjoPAVxFXOY7
    h/V2+zniQdBmZLrTvz79nWrNzBUOMrZkk0ETnQc+urE4dMZHA6nx8njMFVhS/XDr
    kcFpVOB1r1bnzP/rSp4mTVmqEaZzGz4oFB+A5pxPm6lw==
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
        id S1032065AbeBPNpw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:45:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:65282 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031757AbeBPNpv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:45:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31368838"
Date: Fri, 16 Feb 2018 15:45:45 +0200
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
Subject: Re: [PATCH 12/12] extcon: axp288: Set USB role where necessary
Message-ID: <20180216134545.GR1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-13-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-13-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:51AM +0100, Hans de Goede wrote:
> The AXP288 BC1.2 charger detection / extcon code may seem like a strange
> place to add code to control the USB role-switch on devices with an AXP288,
> but there are 2 reasons to do this inside the axp288 extcon code:
> 
> 1) On many devices the USB role is controlled by ACPI AML code, but the AML
>    code only switches between the host and none roles, because of Windows
>    not really using device mode. To make device mode work we need to toggle
>    between the none/device roles based on VBus presence, and the axp288
>    extcon gets interrupts on VBus insertion / removal.
> 
> 2) In order for our BC1.2 charger detection to work properly the role
>    mux must be properly set to device mode before we do the detection.
> 
> Also note the Kconfig help-text / obsolete depends on USB_PHY which are
> remnants from older never upstreamed code also controlling the mux from
> the axp288 extcon code.
> 
> This commit also adds code to get notifications from the INT3496 extcon
> device, which is used on some devices to notify the kernel about id-pin
> changes instead of them being handled through AML code.
> 
> This fixes:
> -Device mode not working on most CHT devices with an AXP288
> -Host mode not working on devices with an INT3496 ACPI device
> -Charger-type misdetection (always SDP) on devices with an INT3496 when the
>  USB role (always) gets initialized as host
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

After addressing Andy's comments:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
