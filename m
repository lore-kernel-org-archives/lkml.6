Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524837809-2-18337316844074673398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837808; b=k/8iUeWgg5M2343DoW1VORryX05VL/Cqbe4RcxNb6JGijxK0qC
    lFX3P9kHtM9mayECbNTZDMbA43hT+FmW1rLjiGM8t5ATwzkchYqynFfYEPRVOtrv
    l4Ux9SBUYpnmC3oMexW/wSIX70lSJdjfmXNGSQtC6F/n7F6IZ5hQASVCvR3Pajef
    Tz9EDtQHXtz93n/4+NEgXeZV57ZPXUXky/mEzvbMmJVe3Pe0O1Oie5+SiyEMpvAN
    FcWJ0OW2hMWzddeuR4N8Xqno/eQMoHYFd74ctyU5+d8mAalMC5q4vujpnxviS/9h
    /7Xf7YouUqYqWtLKfjA8Ygbb1GEOAD+1rwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837808; bh=MJqeyvQkJae5OahANaNLEXKNNjC3+e
    QFXNvCjOFpDn4=; b=fMUCg+/TsMeAT6RQnkMRDudmTL4khbWmCDRJrcE+GZDPfF
    86cGhmxfoH+m90lvn8BdF9wTBq1QNEbMhQQyRkQRtgt4jwpVMUX/iXaI5mV4Vz0H
    xsWPZyGpE2UR2R+qS751lyKsIDLwNUzlQK2RS9S2fkdr4Os8masDWaJjwDgrYOVV
    tT7Ck2gR+VqfywPhnt+Ea9hh8XR/RWpSqVP4xyTWjU9zd3INeOlrPckRWRqvA9yN
    1RB/hRvtRF2eLtqDqcRkrTh+ohwZnYBcO+BDYSrLvAl/jk47WUxW+4oi8cdqa8fk
    uZNvprLR3pDO/+U+EdQttkYt3sZJeJjbqsXlc4UQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLR6B9KRd0/NWHbZUY/TmvbMZR3c3RKjk5OHlpQZtGGtEttWRsi6Yu1V51T6TT/MJhCb3GC9Uj5PRigLuF90ayZ89qQTVQnuve5CQavj131AhwkTCq9E
    fey4mX9hOagWPuJcwkEQp1lR5FH++YCHUjgq3Q8u7sBbyZlGWhQD3TBZgmgjcdeL9riH7vYsrp6xkTN3nzCnl17SFZgmaiRCnw8BBysN3OfJJcXtM0UKAwyG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_ua-DJzVAAAA:8 a=2KMo9-giAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8
    a=C7x2lP5x8ud22Opvj2UA:9 a=QEXdDO2ut3YA:10 a=Rns7OpQVW6Hshu8udh8j:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933494AbeD0ODQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933446AbeD0ODN (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5AA218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 09/74] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Fri, 27 Apr 2018 15:57:59 +0200
Message-Id: <20180427135710.281185192@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Merlijn Wajer <merlijn@wizzup.org>

commit df6b074dbe248d8c43a82131e8fd429e401841a5 upstream.

Without pm_runtime_{get,put}_sync calls in place, reading
vbus status via /sys causes the following error:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
pgd = b333e822
[fa0ab060] *pgd=48011452(bad)

[<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
[<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
[<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
[<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
[<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
[<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
[<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
[<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)

Solution was suggested by Tony Lindgren <tony@atomide.com>.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1774,6 +1774,7 @@ musb_vbus_show(struct device *dev, struc
 	int		vbus;
 	u8		devctl;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
@@ -1787,6 +1788,7 @@ musb_vbus_show(struct device *dev, struc
 			vbus = 0;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return sprintf(buf, "Vbus %s, timeout %lu msec\n",
 			vbus ? "on" : "off", val);
