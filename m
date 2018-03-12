Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-111126-1520852855-2-5700450316618885549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520852855; b=OqKowGdBlEP4AYw4Hsv1N2uXGLtCRbdx58l0XtPYVF9mjYP
    fUyJD7v+SVRwg2HX9DJC7CvMus9UImh+InRiXZRrZfSxK/7kalwig2xNcleVekEJ
    qYpR3fysQvO68ug+JKz2LmR/Um6yDQIC6jiMXR3431Xsz70+FSP5SAJ3iCDxFgXL
    J4BgZbvdddv05nAnWu2i4kik0XJajKXiVCUm973Gwvv8uhU8ZdQ68fgWBeLlGjBa
    lURfJlYYV5Qjuf1Y4Kx7GTbtnXPF6TX4VlZW1U/jNyxmsCJZYosHjiMnpDUpvv61
    59R22ZBpUYGAKzo1u+lp4wVUZ61qQBr104jE2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520852855; bh=TyCSAzhmMIHCGOxy3dbK9BnCDY
    J+XcXzOytsDYwyrT8=; b=PKaNScGDPu5GUoy5kUutythSmd9TNXofFzEJw7Euns
    rZNwIoy3H5zhocrrJaDpWlJhQVbDp26AB+H6QcewK8vLf1TdKnPOD96Ye5xsreqF
    XZNhBoGkDXZ2B1E2L4TtqrVi26sgXwaEgTHGVJyMWBytw04dBgeJJAGanpOcXmn4
    +gcjIJ5gw9A3Xc8Fmy29kqMFMZVs9Owtw/TF2hEGVnJgNqnP5GVbC1LR/EDSTcH6
    WMEw8NI28MePUA4HZ+E4K872s2VW8AD3+ltBEqxXH1zXcmaRMjcnIFU5qzmSV/XE
    99fR2jxrrtTUuSi67AaIbuk8aGVIRMfKShMEYwkR2qpw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=md4Xj0Ic x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=md4Xj0Ic x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbeCLLHV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 07:07:21 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52377 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbeCLLHU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 07:07:20 -0400
X-ME-Sender: <xms:aF-mWgJ70E6waP9E1evlup9VIrUccz_2_j4nPain-WVNXPpXv5PijA>
Date: Mon, 12 Mar 2018 12:07:22 +0100
From: Greg KH <greg@kroah.com>
To: ShuFan Lee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        shufan_lee@richtek.com, cy_huang@richtek.com, jun.li@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Fixes: 8f9439022648("staging: typec: modify parameter of
 tcpci_irq")
Message-ID: <20180312110722.GB10444@kroah.com>
References: <1520848002-3801-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520848002-3801-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:46:42PM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>

Your subject is odd, that line should be below, in the signed-off-by:
area, not as the subject of the patch :(

Can you fix this up and resend?

thanks,

greg k-h
