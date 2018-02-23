Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519414202-2-5504228026962585456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414202; b=l84AMea0gxXVKwzBgHxf7SCsJWDzKO45g0fTcldSD2myQEr
    fCfcsEpd+NOwvHQC6Rm+sde6TKxTh/zkv1VQ7Yc6UZ3qsLTD58WA/YcIRvNYnFcb
    WOFzM+7zA0yZWyKzqGqugZ0GvIT7URnAc0tuJgQDk0UdyQ3S9fA8koGxTO3QvcBb
    N4WWci5YSc8VUM0vMrBwT6JQqM6d0JdJPdzvrxALWONDLI2pPdctLD2ZkYClLdFX
    omCE+cmX/SGQ5NGd1AKUZYu8KMIfDAAcSoJMESQXk26TQWjUXIdTbGPHEW2ZQz5W
    mJsbHlB7H3o3U8sJGIoFxZFfYOgOLvhy4ygvANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414202; bh=CVZBSW/L4UqgFMD5cbuhWG2tS3
    wP1f94jvEm24epknU=; b=KkxS8TcKp8474++8XzHP2MwNT7oqFDT779mVt813UI
    8fB+nWxX7qFq63YXWbr81WjDNyEIEIALey4ckuKV3+4mhSr8IleaA1ZtAbanI6Op
    ruu/1476yRZt6h1mZcDQxFRmruiYLK7aTlVqvK4PkD221rHmq3zECyl3/tGJYPVo
    TWT5BkcxDE/Ef3zTagiPijHbi9fV2ViG+jnGJnm9qaMft380OnaDp+dWd1Li8CYq
    Cf++KxwpFlKbUtdL1WBKpl7y//G0WSlhHFeMSQN28dg2cMMXY1LVDNwyn5xyA/ly
    F/bpElQ3tLKNfnbjkdFBFFO/oa5tp+dfb5ioLAriVvRQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeBWT3s (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:29:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935030AbeBWSvw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 059/159] usb: build drivers/usb/common/ when USB_SUPPORT is set
Date: Fri, 23 Feb 2018 19:26:07 +0100
Message-Id: <20180223170750.741294825@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>


[ Upstream commit c9d24f78268be444e803fb2bb138a2f598de9c23 ]

PHY drivers can use ULPI interfaces when CONFIG_USB (which is host side
support) is not enabled, so also build drivers/usb/ when CONFIG_USB_SUPPORT
is enabled so that drivers/usb/common/ is built.

ERROR: "ulpi_unregister_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_read" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/ti/phy-tusb1210.ko] undefined!
ERROR: "ulpi_unregister_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "__ulpi_register_driver" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!
ERROR: "ulpi_write" [drivers/phy/qualcomm/phy-qcom-usb-hs.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
+obj-$(CONFIG_USB_SUPPORT)	+= usb/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/
 obj-$(CONFIG_OF)		+= usb/
