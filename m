Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497716-1518797182-2-8761853403514160777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518797181; b=Imo19rz4Vn1VvijaPkOZ8inizhJgGaBx3NXhBmpR6vLHqzy
    HFnQla+lVnDb4hpTSUYFDMhbjDbGOxFEi4hGIijSuwqwk2InqV3OzQpG5XkbzhN3
    gvZQXzcTelcw1l6ha9viuqzUsRwEx3w2w2sfBXxagXuhKoCVEM5bhn5sqhvWhdA2
    dIkF8fb6MlbfMSTIED5wcFv1D0H0D4VYO36b8i4sZYMYmNpZAsEVvkygqA7Byw/T
    0avjLjz8KG+QluM57bJs2W+hNoAqt1IDNARP+5GNpokUqJ6t2iksv2chSRFuy9MF
    xCJyzGQSXl4XHhwuOr7R0ulQpKx96PrOzvInJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518797181; bh=taxLW7Yx71qsBdiMC8ahUYY8op
    uWW3jJ2UafcSH7efE=; b=SdyrbipPi3f4DEFYwD8b7RkZ5EYHErqQipVCimTDDg
    SwvfQWgwexLWk/DAjSVGSC998b7tldfmjclihIMbkHZHsIYsilTWyGVpqtn2XFup
    JHVeie2kC5sWBRmitiz9i6hcJ6wz6WtD/YF+dz6jki4+wq4hvMTob/n8CAhzn897
    SNF0qUIOfsZ5C8uaKGQSyklz871+4djGk/1Qwo+ki8gkYy01uEPwrdWWVPZiAgVo
    NHiuR8LFT39giyG6TvDp9RmxaFvOg01cSe6M+45h5q12+3uO6KCzcq0Meor6iKyr
    webc/9DwuCfOhbwdQFTjJA0vopc7Xb09ePwUnKhCrjkA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbeBPQGS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 11:06:18 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:34937 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeBPQGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 11:06:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tobias Regnery <tobias.regnery@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [4.14 only backport] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
Date: Fri, 16 Feb 2018 17:05:35 +0100
Message-Id: <20180216160556.1634805-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:oS85TbQgBSE1cnm5h+VkdE8M6sgsOp2DD98NKXRkAsphTvg789j
 E9Mr5oQ/5ABK3doJv+dLCqGAMjiRqbCxO0cgTuWRRfDl8zwvpGZY3aq3EEShIftTCpK+coO
 HA5ohQOifxfxR1bcxxj6Uguiwl4rrgWcNk/Qv4TcTuC5kNiANhOtRcGbNwzP6zt5YNchbR1
 A7VFU8vRkUpg2YDTH62wA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3xWgtkG3LVc=:NtPGYXF7mJtDk9HqHMDs1Z
 EuM8ycn505gJfT4R5ftJY3ub/f6NUzPD98dDh9nu8z6bOKRWPL/a7NqNDWiEAqOcepHf5cIKj
 OVEbS3wH3spm36Frf9n48esZ8YL10qZc18mP93jrgEfD4gJCPBm2aXO3v5DKW/IsZjrspPovc
 ze0ehcNgbLT63vc/WWeCuuIazRUEEGD94Z2XFwzhxxiTOiGHrNkDyfPRk0lCf+s2ftQnr2Lz4
 AxzIo7KjXseJ3g+RhVFUcVlWl6v9iitxZCocb3gbaOIKpaqch8sSbV/t2kyaf2BhZWanlVur1
 ScKlhfQ3wIQe+Yayy157JsD3RVYzyrp2aOb0600p8vDX/Ksr6szUtU0o2/eeUExXTWrd45Qkm
 ehFA4amO0fHOUr2NQYj4mtTf4sehzdhGaI2tR+UiEc0CzI29zMZIdJU19W8RRz1v2pFkJbVFp
 1y5mxuUXkzUdkHnCpTqr7LXQyLcGsMyXc6zbBnYmxZXw0sznPubpgx5hnhMqLYQ9ZLVva9wFv
 88mSElBfuZY5aOkhfws6Q8r5+Wxyg4DQF/cIbqFujaGwJ5tqF1R7fUldg3lHQiV89sAAEKFyc
 Cn2uCghusBfvUMwoOVf9bwxH9iw+he6hLoUV2ItGUl0QX4+ygWli/Exc6yj9c38mFqyl/SzbM
 8fFJKHaWT11yccJNJUovh7/kkGGqquuz1F8fEuEM6L9Ia7rxuC7C2rlCdFKHKEMu6IfJGiwnA
 VgjiGEsnQrRyq2SxN2x33n2awBYLqA05p9eQ3g==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 05e89fb576f580ac95e7a5d00bdb34830b09671a upstream.

It is no longer possible to build BT_HCIUART into the kernel
when SERIAL_DEV_BUS is a loadable module, even if none of the
SERIAL_DEV_BUS based implementations are selected:

drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'

This adds a dependency to avoid the broken configuration.

Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 98a60db8e5d1..b33c8d6eb8c7 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -66,6 +66,7 @@ config BT_HCIBTSDIO
 
 config BT_HCIUART
 	tristate "HCI UART driver"
+	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
@@ -80,7 +81,6 @@ config BT_HCIUART
 config BT_HCIUART_SERDEV
 	bool
 	depends on SERIAL_DEV_BUS && BT_HCIUART
-	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
 	default y
 
 config BT_HCIUART_H4
-- 
2.9.0
