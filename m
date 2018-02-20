Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519127952-2-14251601748184177824
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127951; b=X57/EonkTAdCaua9ocSLCA7Y5v+KbDho17m8xOGHZ1BnDkf
    /hFVmKjCyFG+adm5fsN4WfxX0HBL+LB1z8SSxcKH6ltpg9n1VMB56C9IQSDIPHDy
    IrhBlwG4oiemlLQJhi/U8+gPDFB36CKBqDwwWjrqnKbcqavfVqs8kAIBSLk24FvX
    zOTVrZ+IYMQwG+JVtu4oTSUlwH5A+dUx4HLaAlcgJyMIcqNtLAEKUZqk91A/SjC/
    9Z/Fr/qxwjcwLd4yhpkbiBWoq0O+t4sjiiU3H0V3mS2Ar67IQN7gC3OKOHo/gxQt
    JqwglpQEmBbnbqcWx1I0303LN6nO+TR6Mq6ZkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127951;
    bh=NJpLM2intY1Vs+vRx7qqXZsYvbqX6zZ/N19Kx12V7Nc=; b=GhbUs+1I4qXa
    VFzfC4fDrKb3mGEe5m3pr70KT50633L77Kquavm5EFfPOJH76I+bloG3zJ7OcWz7
    7VGKAwc1z5J0mMs63eehZREodpLobXuK0QJ1em6ligrBnyBDTuv8AhB49c+ni9qD
    C3vkOVRrVBrXJpdOJIiEUX3VaKlmiHkHECiPWRxxXTrkWuap4litlxi9X0T0BMDc
    ja5a+tH9IEgW8hYenhtflqrm3nuxVnNlGhSPvRmVXqJWkRYei11yImv27SqfMjcp
    xKZjOByS+XRt622/eSveBmLoTRpnlRgYNYLhHkCc10nBXBvIvDoUaa8CDo8tC5lb
    FcWRE6jA/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbeBTL6I (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:58:08 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbeBTL6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 06:58:05 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Subject: [4.4-stable 02/22] Revert "power: bq27xxx_battery: Remove unneeded dependency in Kconfig"
Date: Tue, 20 Feb 2018 12:54:49 +0100
Message-Id: <20180220115527.1806578-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:fllPO80jCZ+F54OUmU7MR6OWSYE1PbE5z1RJMQBnV4lbPB5twQl
 soTb9z8qXgDSs6fAxJHniVtjjmDhSr74hM9i/apWqNxbAi0k/s1/kOUq6gCGrxM4eRpyiS9
 TGUZJNVFzEmBTwQpWQbyAhDnxtEqFnPtvPm75RoUttb90XXTdufel1+/zuoUXh/fNsjAqW8
 fjWv8IBKIP+up8CdKlt/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZtlU2u5vjFo=:0dHbBF3twp7uwfZYaobd2W
 5QO50GSdiFMjvwx5Ok5pPrGewi+6UuCcquwoYDlB+fu3Bvun7oeMT9vyo1l3VCkzrlZQ44xD2
 D/K+T1Dyk/aOGbQM20mcCuQ/RP/CMkazJD8hv920nRVll0aiGKo6Wj/B9Bq1reDUOngG24wWK
 XtFZdWI9UOrR5/CJLeK0sVMe6by0GXBNz5s/QSKGzTrw6MSFAgpQ32Du5HPfD+MEFcTkNQVa7
 oXJitSShE13QSQ0OUmCtN4SWXyj4N66w7q8XEQ6dPXuLpVdSClQQ4/UOoYeZKy4WgBqK04TtX
 piclhSikUzL6QfFsHWzwZGmwNvtshX0h57yvMQYXZOYEkQEZMSvE+MjuUxet9rI6Kpup4P52N
 6Hf14BZ9taIIFVxSYFfgBcb0WcbAla7YYk0LrkjTHjrI1uLx/t0aCYRqTcP1PszBAyHt80nCr
 4U0/TXEg8erygbgoCyzZ8qEYpldYRkrnru6sTIreGAtTING24PHDE3LoI6J9DCi3y3ck02y4C
 OA0XBzyEB5N8IGaP5ZMe51XHcnpYgpUrfH3bY2+9zQ8fKncuD5eHJWCKTuwn433/KkuyBbD8l
 k0DFJrXz9EdhLUVkdIzqa2tdTs6+u22ueioiIFoGND3enfbxPb8i4qQ3SeKRCn1qbB+gMtwbU
 A5fjK0K+sCYqp5ojkQpUbEL1IrgNFME1TCFZ1T3ALnKF4ExTRxq8juE5sXuN0T8qyf6ZbtLmc
 vqOVFj29RafvuOe5oeegA00308jEiPdvzp+E2w==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This reverts commit 6bd03ce3c12a22d86f59070f1da15aaa2bde8a51, it was applied
in error and cuased this link failure

drivers/built-in.o: In function `bq27xxx_battery_i2c_read':
core.c:(.text+0xa6da8): undefined reference to `i2c_transfer'
drivers/built-in.o: In function `bq27xxx_battery_init':
core.c:(.init.text+0x68e0): undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `bq27xxx_battery_exit':
core.c:(.exit.text+0xc6c): undefined reference to `i2c_del_driver'

Later upstream kernels fixed this with a larger rework in commit
703df6c09795 ("power: bq27xxx_battery: Reorganize I2C into a module"),
but we cannot backport that to 4.4.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 237d7aa73e8c..9f53fb74ae6f 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -159,6 +159,7 @@ config BATTERY_SBS
 
 config BATTERY_BQ27XXX
 	tristate "BQ27xxx battery driver"
+	depends on I2C || I2C=n
 	help
 	  Say Y here to enable support for batteries with BQ27xxx (I2C/HDQ) chips.
 
-- 
2.9.0
