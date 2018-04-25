Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524656023-2-13608388772238847733
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
    1524656022; b=LOJGl4A/RPr/E94paMxmPlAUZFdY7x5LQd03E7iDjW3wHbK/O0
    wq0guaHBxcADRjRdw60n/bDe1qqZwUsUD0VL554hUfMnWyPixiYx8q4Fmfy0Ceke
    aDM9b/g2Vzd5RjIODiDgIT9/tiKqEcD/MLmZfm1pyIwDzrG9LwLrLc39kIZ2AJCb
    CSNTuizB9Xnl8ymtRkpmMU4LR4tUcE2ZVELIuwnuzmORO6dw0o5EazbNS/QG4Dx7
    v9+J/IjuO09EZLwhdEalV12xCM2kMIVueW8KTrT90naKZVFvT8izmIK5m9KhH+pd
    j7WKctBi4MeLsqnUN/d5Z2HlBQBudVfWHWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656022; bh=EL1zzEd0mN8xie/5q6uCWpytocL1nc
    jCrTBnEkImnHU=; b=dbPWY+/UyvdasASLjUywln2W5JWdw2Qgw3AlbdtipB67I6
    b6BwbasK5Txf9ESVRlw3Rm0Q/MTgVcPSqQyfiG3RlKa48l4CkAjyhVsIYE/BSnE8
    zliARYH/CHJ8lmfSIAgHpjekPKvS35453sx1/U2ktbhJSYv3LBqzb2jOT+zMY231
    ZoVOlzFLMfbAF5vraiZi6cjWJ3IvpppU3JgQpvOQy8ClNt+5k2uw0NANALnKO54q
    Qfwc26aHCr1M0YO8Q2D1/1qYKTrLehnz8gt5oT0D5DHHjl3q7dhSofsgf9JGcf7P
    fefe57Kgq5Jqn60XByUjD0RzH+I/V7tBrw3tVarQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfIO/R8SH6mLz297aC0uzHa/6H/nfCpF0DhafnDtHqxN4ctmhaAPNo18CNiMRjzmluMsi8q6QrWzNkq//s2Jy10508H6FojECrXOXIteTvUBDm/JbaYgn
    kZlxvJ59ISjxBHYA/DsZKnHjqkxa26wrgFq5zq4ZrCQ1E+/xEeZFMBP4Mg9tOVUZW0n6xbs1Or+EAVkhqzttx7AYlujzdba3jJgWRPIJkitxjy9gi4eg9mTZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=_ua-DJzVAAAA:8 a=2KMo9-giAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8
    a=C7x2lP5x8ud22Opvj2UA:9 a=QEXdDO2ut3YA:10 a=Rns7OpQVW6Hshu8udh8j:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeDYLd2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:33:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeDYKhN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 013/183] usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
Date: Wed, 25 Apr 2018 12:33:53 +0200
Message-Id: <20180425103243.147303287@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1780,6 +1780,7 @@ musb_vbus_show(struct device *dev, struc
 	int		vbus;
 	u8		devctl;
 
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
@@ -1793,6 +1794,7 @@ musb_vbus_show(struct device *dev, struc
 			vbus = 0;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+	pm_runtime_put_sync(dev);
 
 	return sprintf(buf, "Vbus %s, timeout %lu msec\n",
 			vbus ? "on" : "off", val);
