Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2767713-1518613058-2-6399430001564651422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518613056; b=jpBZeYTIw9Pp/AOCEebmumN2R+0IJsS273YOGhVYvCRp9dL
    YVbPhySq6ViRjBuHep7UadB266PlhJ21YZw7UdBFA9/nivU0uaRh6bEa423rEU1e
    kd6ZTjvM6LZJG787AlI/hTYyr0FNerYXtY5B+XKVsTb+Aob7DTdDVoQUssHSPOTf
    thOCoFgTSuzZuxO1Mn/4sXtEn3oYePzXZidXJkfDKKSk2KCij+q7OJeUjLCQTmLB
    DzowMqEODESZ6q5wJKlLz3tE/ynYF8wmRmaWsnEDGLOIfUOgyiBBM0IpRbSsM/QJ
    cwE7gZyfQswiOPC1NEfNb7NrrRcWUBO0jQmw/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518613056; bh=g5w9kAv0HFf630sMtj20zmpxNh
    NXCProVU6B4eunIhM=; b=f29wLDR4hyjMAmvZXuA6KTVl6AvmhvSBvSqF2H/qax
    mbHIRZf5dzT3nTLptOw8eoa0jMEKTvtq7cX46DcoNgBuls2XfnclSYdxCJX0vFlJ
    ZMT5y0WpFvOVapl+3brrjGOaet0VgQYphSJiZofOBKGnRTrYB5gelNPAeqXp2GDx
    ZeZj/tZigZp99+UXlFX9x+6Kzs62HYaL728fngwbrkJw/25wmhPygn5MLvmYpSLU
    T4m6G8SOiT3HGAII/iFgwTATe5qSmxOxB1ODV6+LsGL8bZlPwC9zeTy5xw49vEfG
    VyDl7hs8w5snxVwOxjpuzXGrWp3zVyTQqLHEY3U5pzgg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8+KTUk3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8+KTUk3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967751AbeBNM5U (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 07:57:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50137 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967589AbeBNM5S (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 07:57:18 -0500
X-ME-Sender: <xms:LjKEWj2V7ntnrduCw8NHOr49Z_JmurCcLo7tBX8cYcYg72y3jZ0Ijw>
Date: Wed, 14 Feb 2018 13:57:20 +0100
From: Greg KH <greg@kroah.com>
To: ShuFanLee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        cy_huang@richtek.com, shufan_lee@richtek.com
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
Message-ID: <20180214125720.GB30479@kroah.com>
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 08:45:34PM +0800, ShuFanLee wrote:
> From: ShuFanLee <shufan_lee@richtek.com>
> 
> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tcpci_irq.
> More operations can be extended in tcpci_data if needed.
> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> TCPC shall not start DRP toggling until subsequently the TCPM
> writes to the COMMAND register to start DRP toggling.
> DRP toggling flow is chagned as following:
>   - Write DRP = 0 & Rd/Rd
>   - Write DRP = 1
>   - Set LOOK4CONNECTION command
> 
> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
> ---
>  drivers/staging/typec/tcpci.c | 111 ++++++++++++++++++++++++++++++++++--------
>  drivers/staging/typec/tcpci.h |  13 +++++
>  2 files changed, 103 insertions(+), 21 deletions(-)

What changed from v1?

And I have to ask, are there no ' ' characters in your name?

thanks,

greg k-h
