Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4185186-1522844564-2-4479319423130329535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522844563; b=v3sg7npc5rHB7Vy3e0gkNmYlLsjpjTqnlyEGlBuXWR7PvsAZQ7
    l3ssENOKIHM/Mt7hcEm3s6m5RFlEwRrJC2ArzdGfPg1MjZz25uAVlZA9YRQ0iw0O
    jSpQwlKF9fmcP/N5OwnDQK+WbDQ89EErLKAR60XIvhY+Vv4ufudk7XviAn9/zHk+
    7uLVGVheHy3sQwOZPo+3d3Ca3xrZDOcslhBP6StAwG1EUnV5CqawoEhtRNIdOIRu
    Tm0xm6C1dEYTvEg5MJ8GeG3NzqKNoMx2xLTYRD/KqvSyv3augKk2Cib4W/R4iXct
    Zn49cuzQxzGjRoNvxsCt6M069dDLiPGN5eiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522844563; bh=fQ9U/GuMRXJPOcU6d/4VBItmb2OEvu
    +qzmuo6CHhum0=; b=HsRKoji0W7d7wmJppeZ25u0oZAGYAIRQ39Jz1Y4R1/oFEm
    27IblqgQe5YpSs9AglRm+jksu74Nz73/1L1OYCcSecll8hyqzIMJQw2rYRI267WD
    GEzm4JBrrN6h5na/tLyVdsaB+5aYtR80R/ZUp4BjX7r0iUP3cEWfHI41utW0/vZ7
    x49DKsaa7a3kUzUXwEWgz6YJiDHjKWC9TsB49ozUku/fu/1IzSuC0D5zfVjMCB7T
    APLnU0ZrYb9RrZ8iTncOxh+yItZVgdUO+ozaxtpsbN+jYMZpQwK1AxG7Xo3eJaYz
    gTLGmJBIPZOKRbEgRf9sSyTzsjqI1agEGJ6s9YVA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGa22biqoXEQj626ZA6QlrPXW3UrDhv06X3Nm7D4nBZFcRrDG9KnRt+dggaW+z/vxH9Fw7kS2M8ZgXm8I1BIrNs6GzJiwTwIyNOJ/cYOO6N8rIyY2WEb
    J05DWatg0ga5/956nleMRCS6yV+rDmdEu53lQ5ffCoqXDC0diaOxOf4nrr0N7OrTV7HaDfLavrXIzaslgU9ZM+8dBMYYsWnkk07YK1MY1yCZN1hiStWiCUpP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=3DJk4ypkVB3yUxPikFcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDDMWZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 08:22:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeDDMWX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 08:22:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: select USB_COMMON for usb role switch config
Date: Wed,  4 Apr 2018 14:21:53 +0200
Message-Id: <20180404122211.3309577-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:eLycvauCzdub3/12xFAtyMkBXdZ7y/i7Wb9jFwfQ7d3rY1wwQzm
 o2akWzo4Q9LnoGQMpZKZiVVP+pMaXbMDLWxShzpLJUyAuWJHp2Ip6V06N0oZQoPC5Qt1JOA
 XppkUqs7Zcx+4E+zScYzycbpUvF9PX5gXCnMFNWw35utB6BL0bBoXHMsOkx5+7Ttq3BE9Gh
 IexzJQeKwPkPkfKl+3Dzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:il4lm52IWlU=:WGO1VG/8c1LppcMWeBmddM
 zhH1YOAGxc73AzEpqued1z/ERhkUF6c8upoaHgb9xOMCbR2Db3gWLMCWb91vMbCgW5SgzFbSK
 +Zd1Z44ojZN0iAeAoeyoh46xZ6Icc7KOaABkuwE/A/zRv0yQCGodTJ4mRMG7P7imArtZaCc79
 j701FHK18hSF1ZGthSwS5qEilEYC2S+Bq/IlZeO+SAIWUG11DkANdFK+2WGFmz1BRgmwTBHPT
 ibrRTY0k/Hx7gptTTtcvtaOi0IaP2HdkMZD6mp6mWvB0xAFz1l90AfVEcOcwHRd0zH2rowMpc
 TDYREAcjPbuLy5ShygVXjDkiiCOALgOCk1V9aP2dT6eywUjhJSsBdqxA4TpaBIKMfeoEcEJ3y
 t10wKC/gRvu0d9MJakXs6DopZYwmfq/dC6HfSjJYq05rs7QeiG4Vm2E1nZC6js6sw8ijcbmIM
 MH/PPWxLJpWB+hr1t/YvLm04OU9WPHGuQEjK9kjs+qkRWIooB8ZoTsiW0eP+alNVl1TlWhfT7
 EJhBB60yXiMjxd9PbpQMYgMvJBGvOG1O1JjSyt5AjMMyuVRIfbB74GRpDNiIxXkicwGqzuwMn
 22Qpeev455Gv58rGRetHSGeu7pdh+foLYH20PHayCimJLkhxDtp8R0PegGj4+7T9gzF1enKLI
 Jn+f8ud+tTmRsw1NQyU8krs8FJonXYHVOS/swJB9HF2WgPMOQIeipP1zGi+IaRxnKIy9276lX
 MXpaG/zQ5TAbawqkVFC3jvddYbSFYk0JDgO0zw==
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The new axp288 extcon driver has no dependency on USB itself but
calls the usb role switch helper functions. This causes a link error
when USB_COMMON is disabled, as that subdirectory never gets entered:

drivers/extcon/extcon-axp288.o: In function `axp288_usb_role_work':
extcon-axp288.c:(.text+0x47b): undefined reference to `usb_role_switch_set_role'
extcon-axp288.c:(.text+0x498): undefined reference to `usb_role_switch_get_role'
drivers/extcon/extcon-axp288.o: In function `axp288_extcon_probe':
extcon-axp288.c:(.text+0x675): undefined reference to `usb_role_switch_get'
extcon-axp288.c:(.text+0x6d1): undefined reference to `usb_role_switch_put'
drivers/extcon/extcon-axp288.o: In function `axp288_put_role_sw':
extcon-axp288.c:(.text+0x1c): undefined reference to `usb_role_switch_put'

There are multiple ways of fixing this, I chose to 'select USB_COMMON',
since that is how we solved the same problem for other helpers like
USB_LED_TRIG or PHY drivers.

Fixes: d54f063cdbe4 ("extcon: axp288: Set USB role where necessary")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 75f7fb151f71..987fc5ba6321 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -207,5 +207,6 @@ config USB_ULPI_BUS
 
 config USB_ROLE_SWITCH
 	tristate
+	select USB_COMMON
 
 endif # USB_SUPPORT
-- 
2.9.0

