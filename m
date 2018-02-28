Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519838090-2-10444202797371816104
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838089; b=Dg23wdA3xu1Do4zfE6Z/0wRMXyU11l1pCfmqsA2VSCWPipz
    /MRojoBtdXGiYi9RyFHegJ2qBUAk7CAKxoAM1duVH6+UWORaDGjtfrIHqMP8A94t
    Jzjd1PbGNJ+51maXMr/0jn8BpVqZB+YJVpbyDQJ/32qhY83TGCuANfXnl29ktdUb
    ZF47RGY1Y7Ge9ikY0IGxf9bvKS8dOmt2lPSAxxaHI4DqllUJFOdjBOBHIFZmPXm9
    LKhIzMuRjcc2UVnebf9vt2hVtp2wqCLY/EO9qLSHSLSh3Ti74H/GphUHwcoPkcPC
    sSINPOX4aLcGe5ydybio3DesUn6ojIbT07Fha0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838089; bh=+z/jt2lQBQ/SJ9gPEyX
    8ZJhTdYGuOsCBXZEMjNT4850=; b=m0SjdTb0hzREtHsMUN/FfxKidNvU2Pyf6hG
    aKxwMS8QaoMDrCYTcmw5U+gqd0cMAbpVj8am0etY6piWIGKlqxtkZswSsoV7ARJj
    42KFiuFIORWdNr/rrxc4O6Rvgm47tfSVZ7d2mn+pXqPZ0FDAvynqYvEmSi5fp3sf
    ivAzTweabpCeprtXBNkauOUFqE+efvVZAezDrMhUrwB8c89FGkWESeCf+30yJxE/
    8mB/EHL5djgtgJucZqzJKUeXssqTEWmgQzN9WihgPqFd+9OO8FtI0nIe0Rkm6Mi8
    vUmsYModAheyKbDLaW+hJ8VypgfChIc+SWerYUXVXTwLnpRfysQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeB1ROg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:14:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34267 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932362AbeB1Psh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:48:37 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Gregory CLEMENT" <gregory.clement@free-electrons.com>,
        "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>,
        "Andrew Lunn" <andrew@lunn.ch>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.884090596@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 173/254] ARM: dts: kirkwood: fix pin-muxing of MPP7
 on OpenBlocks A7
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

commit 56aeb07c914a616ab84357d34f8414a69b140cdf upstream.

MPP7 is currently muxed as "gpio", but this function doesn't exist for
MPP7, only "gpo" is available. This causes the following error:

kirkwood-pinctrl f1010000.pin-controller: unsupported function gpio on pin mpp7
pinctrl core: failed to register map default (6): invalid type given
kirkwood-pinctrl f1010000.pin-controller: error claiming hogs: -22
kirkwood-pinctrl f1010000.pin-controller: could not claim hogs: -22
kirkwood-pinctrl f1010000.pin-controller: unable to register pinctrl driver
kirkwood-pinctrl: probe of f1010000.pin-controller failed with error -22

So the pinctrl driver is not probed, all device drivers (including the
UART driver) do a -EPROBE_DEFER, and therefore the system doesn't
really boot (well, it boots, but with no UART, and no devices that
require pin-muxing).

Back when the Device Tree file for this board was introduced, the
definition was already wrong. The pinctrl driver also always described
as "gpo" this function for MPP7. However, between Linux 4.10 and 4.11,
a hog pin failing to be muxed was turned from a simple warning to a
hard error that caused the entire pinctrl driver probe to bail
out. This is probably the result of commit 6118714275f0a ("pinctrl:
core: Fix pinctrl_register_and_init() with pinctrl_enable()").

This commit fixes the Device Tree to use the proper "gpo" function for
MPP7, which fixes the boot of OpenBlocks A7, which was broken since
Linux 4.11.

Fixes: f24b56cbcd9d ("ARM: kirkwood: add support for OpenBlocks A7 platform")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -53,7 +53,8 @@
 		};
 
 		pinctrl: pin-controller@10000 {
-			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header>;
+			pinctrl-0 = <&pmx_dip_switches &pmx_gpio_header
+				     &pmx_gpio_header_gpo>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -85,11 +86,16 @@
 			 * ground.
 			 */
 			pmx_gpio_header: pmx-gpio-header {
-				marvell,pins = "mpp17", "mpp7", "mpp29", "mpp28",
+				marvell,pins = "mpp17", "mpp29", "mpp28",
 					       "mpp35", "mpp34", "mpp40";
 				marvell,function = "gpio";
 			};
 
+			pmx_gpio_header_gpo: pxm-gpio-header-gpo {
+				marvell,pins = "mpp7";
+				marvell,function = "gpo";
+			};
+
 			pmx_gpio_init: pmx-init {
 				marvell,pins = "mpp38";
 				marvell,function = "gpio";
