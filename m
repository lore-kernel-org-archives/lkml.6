Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405325-2-9106896692827389041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405324; b=vNMGY2pfnSIqgcSNPwoQUaHHY0h2/fwE95C/XkF6yVTW8ChyUN
    0xwxjsk2qHDBL9Y3fen+NBfjabuLAVXBpe9Zu43nDTYiqDtG+kdClaAeKsZJRIvK
    W5elUv7BApGx4ARxedFfDlekOwupIK2Tn1nVet+yTBegLrYojlVF37kCGqCA6r7O
    /rZa9E5eGmqCbryYPHaP0GvScda0R1ivkntcXZBXzDavHs51tTfchJo4eMxJ4hkg
    71hRmvlgvU1hIGOw2W28gib76/fMRTUquDSVZibqGrM4Pib5D6bpVv7Sak0BIme+
    rdFdQEu9r9kW/qPmON3dPEffayRUm1Z/LXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405324; bh=m8NH4NBVvzzibZYZmtSylEpE3xZiGn
    otorW8ytpT4Ak=; b=vjl4puSaGpwUG+HpOihrtcC57MTVtHtG16eoAIc9hr+Xwu
    6wFdrEkE4YR0ZwfBTOsC1fybTKN7Fi5ziiJEDfEOQuRF82AVoeUrwUVGTT3lZziv
    5RUq81F7xyRHYTtizxrs13HnAdzgHuKGNtPEaUNo6ao+6EXSG3tzuQq24rD8HuvH
    76d5OrMa23SpxyrgwCPZKsPIg35t4S/kEAgrwCQDBhwUA+10KRz0kslhmi0ww3JW
    UwNIuqZe+O8IzI5+zU7FFc6BcQvxbXSSm/ts0bYZhnqTpX1R2Vrj/l9KLcO3k0Ie
    9XhSuIBivj1z21VNCeGwZwjUG2lNf6OpHLSrX7FA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfHUKlPpXenlF3oTBuXYhTrTovt9aTl+ixBUfXu9S3uwTt5wXumadaUHQG4QfOKBSCfEwpDwX85lArkgWfHhOdXYKr1jID0Ifx4iS9xbaxpLisXOd8pf/
    RpYL4GA54A2FQDkXTcE4H2TNaNdb2L5s+f6QJdznD+JByQLZliPSRW538DAVbVxM6oxxFT1zWPqeP3DQy/ZRD6SDHbAFD/pKdZBVjrXBIVc2/itASjUmis9G
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=B_WdvT1gQCqxchbH3WIA:9 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeDVNzS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:55:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeDVNzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:55:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ellie Reeves <ellierevves@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.16 020/196] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
Date: Sun, 22 Apr 2018 15:50:40 +0200
Message-Id: <20180422135105.174318964@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

commit c04ffa71ff491220cac28f55237c9aad379a8656 upstream.

Different modules maybe installed by the user on the eMMC connector
of the odroid-c2. While the red modules are working without an issue,
it seems some black modules (apparently Samsung based) are having
issue at 200MHz

While the tuning algorithm introduced in v4.14 enables high speed modes
on every other tested designs, it seems a problem remains for this
particular combination of board and eMMC module.

Lowering the maximum frequency of the eMMC on this board until we can
figure out a better solution.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Suggested-by: Ellie Reeves <ellierevves@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -310,7 +310,7 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	max-frequency = <200000000>;
+	max-frequency = <100000000>;
 	non-removable;
 	disable-wp;
 	cap-mmc-highspeed;
