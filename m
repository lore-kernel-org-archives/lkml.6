Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519127965-2-14925168291328337669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127965; b=n83I9ZOqp7T6PN3K309QmQkido43LvlZUCRzEzAee0N7boM
    OLXopossxDP+LX6G3SF6BUmppqa8IIoE9BV35Z1nTvbC3pwhNg96NpTOYFTb303i
    XC8JfEyQbKxKlxCWc/oXkLpzPpsO+mAlZWOQ8B3b9ctqdD5pQCS2axYfEEhcF8xe
    c1ntmIpc/+qRFrBDsBlXucikbQf4/ydYn3AwiFllERogD0ouYbjW5Y1nJVyC5qKy
    aFpRrqzST/nwSD6YRFjYKd7/zT6bdZKNARP0VDuOV72Iz2HV41u7wXWIFR8rKR2x
    T5fuCwJTsXOsPfzIOLcpQxQKtzHZJgzFw/IDVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127965;
    bh=QNi6uYgmw17G5ip6yN1oQr7lrjCcCrq5VlMXLNDR3KM=; b=rETIsDNMGT5i
    d5YrkfubeRYF6drHF44fAW4dSaJaW9Uqo5SWt+GQjHPgxliXQu0080JdPUJnkvVP
    udF+H9MLJ8jvxCwsgLO64SNVAElAwGr6ELUzRJbpKuy7BDVSH1oYzuBKbIa3fN8J
    MYzclatLcJwMEHXEteRZc+TOVez3FqifZjMzK/7bVPv8hLYH+eker5U+w5DWii7u
    uTHgYkAwYQiC45C9Qe4AfqB3W9bjFZ8RqpiInCCmtDsgUDjG8cPb1Qp0q47yoRmy
    JVbxPG3zGq9PGjI6ZhFg4gh9t6c7PZ/KojblyI7QGA6nz1ZYcAqptPHnv8MhYwt2
    XSMxu9FhAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeBTL7V (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:59:21 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeBTL7R (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 06:59:17 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [4.4-stable 09/22] ARM: tegra: select USB_ULPI from EHCI rather than platform
Date: Tue, 20 Feb 2018 12:54:56 +0100
Message-Id: <20180220115527.1806578-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:7D0TeIPX5OLqmzyHlX+uwHrVdJL9ssUxR2cptD2mrHgWChlYHIg
 X/JTqBNWcvWSVoYvzKjv3ZnXvCKQuC/7HUnlEUwJXvwxsiov0l3YbheeR7YZxpOzv2Zs+Nd
 9v701RxajRMB+M+kZ5DC2XbNwSfPwK0djWML0/rxEcwApG9vWORoDH1yxHQBCFvK9vGWXXZ
 d90iX84kuuJYg3f+8Ts4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ogrXIHjj5U4=:TwSh3iqr323jpMVKD5SrhZ
 p84EceD6Tx8SnA+l48M4/iscAxFB6SBNNaYVD4z1oAmstTagLNx7KTReIiRQQj/PqUzixCSZj
 t7aKB96DFGcKn9EQyC7xJbcjU3vKtLx5xFuKtK4X9WaSgrcmmddAKSZitS2voZSvaLz6Su80V
 NwAoPR14Dby1frZxX8ysqZaBU5vL5/jlCXzWgehzbfAGybeXVCv+sIxfxjVJIg6pnOkAkB78F
 diT1kmAu0IhYvt2d6QqYqYdwEuR2iRhMkdCYA/si4tnJYHPPKHATmiwZebqbBKFqf8Ki/MYVI
 p+Cr1oTg6snfjKdh32kI/cYM2QnviKO7cN1Q7xeaQm+hrgrlByJFQYuQgOzMy4JIGxqhpfEJx
 wD7FesEg64d7KEsHy/aJHDtIlyn9XI3qWkVK+yxjGWixQ7eAAM5m1g5WjNYuTpMt2wqTlFYt3
 3aAAxzgz2Lez+5MUTAO5dGmDxLTJRqDWXZlCF7JVdTRrzJ2DXtAG4xmMgrnHIFicV7qtVsvpt
 bprIrJDWgyIQz3DQpjpPCaNIe/KOdD6ukF80umLtEa96NHze/EdLbS7hIHOB6GWQH0Uqf/7pq
 Scq8YogZ2EZvgCwdmKk7G1+1wKcYOdBL1GFtwp6eGjrXv3XmugqqVnysAOpoJoS2ykHK8zZeZ
 MMWXEaeBXWQAcftuRI+m6D1xpu4iN4pUF5uCeD1gagZ/GJJGtmkos74+GrHqZu7BRG3YOXSRo
 25mFJz7Sepj64FSs8rUEO3+if2yw3UkJkDkwGA==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit a262e87ff354f12447bb6268bd63edf7ba1c20e0 upstream.

For historic reasons, the tegra platform selects USB_ULPI from architecture
code, but that hasn't really made sense for a long time, as the only
user of that code is the Tegra EHCI driver that has its own Kconfig
symbol.

This removes the 'select' statements from mach-tegra and drivers/soc/tegra
and adds them with the device driver that actually needs them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
[arnd: rebased to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/Kconfig  | 2 --
 arch/arm64/Kconfig.platforms | 2 --
 drivers/usb/host/Kconfig     | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa4c5f8b1be..2d43357d4a0a 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -12,8 +12,6 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  This enables support for NVIDIA Tegra based systems.
 
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4043c35962cc..5edb50772c11 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -90,8 +90,6 @@ config ARCH_TEGRA_132_SOC
 	bool "NVIDIA Tegra132 SoC"
 	depends on ARCH_TEGRA
 	select PINCTRL_TEGRA124
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
 	help
 	  Enable support for NVIDIA Tegra132 SoC, based on the Denver
 	  ARMv8 CPU.  The Tegra132 SoC is similar to the Tegra124 SoC,
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3bb08870148f..95e72d75e0a0 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -220,6 +220,8 @@ config USB_EHCI_TEGRA
        depends on ARCH_TEGRA
        select USB_EHCI_ROOT_HUB_TT
        select USB_PHY
+	select USB_ULPI
+	select USB_ULPI_VIEWPORT
        help
          This driver enables support for the internal USB Host Controllers
          found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
-- 
2.9.0

