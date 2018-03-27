Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522172376-2-10515777259769522602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172376; b=b3Vbd5nPYNuff3tEElRsjB7EXXLum/t3vXE+c8lzmxlTtqK
    ekYXIcVfLOBihBT41PtHmuVW9kvM4qgbBIuXhGxo+tTmYL5Ee8Ilx9KSwYLVwEve
    RGjFieWSQ9M+AFDegflMQ1+vSPMfOprTFC5Xa+HZgu+7eK93gPaWQ6ghoHLKW8o5
    jJTh+QWmJ4AmINMLn1VQfNJ59R0Ai8spwHwiks6DOeMYTw4Tg8iw507rf3YY/M0y
    x4PTlp61Cznq6alvdpbm3FfFztDzgZ5ItNxjpRqjcubVJ1IgURD4pcVUrt5wyQa1
    tvzk+Zy7drn0bNGw4UCg7kBnFdh9ix8jG4jiGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172376; bh=nTxy/8/lled+YyzTkEL2MFexE0
    4JXAZAYJigUP82Moo=; b=Ib25X0gRshbcLNNoGI7unzJlO1fsnahD3DbukZJETC
    v7D3e3g347xbolR0ekkgzmG+9PWOLns1P4rWBvZoHZyLY34XCrAd7ueLsZSxs7UU
    wdPR1dgtisKEryTCRuTaAfd02YzO1clMFdUGj9wcccmE8NaJUzSmiQY9B9C19iG7
    VhNxpD+LJxqs96eueGB2CMvRLsU/tYUBLihPFrfFsEICcQGWqjJRRYiKAEXkL6W2
    cloZPXLbmYgD85KOB8FAYE88RMnJhoR6ua1mFE8h5U2Nll1nSWNYjvVV7l4mTL5S
    40MJ2Hkx26J34xviu56oqB7LVJzQFi9dIHlcqo28d7lw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfFmrn2u40avrBDK2u/jx9Ch/71Zy673mPdZwvGEkUmCJB0Uj1e49T42pEBC0mwtFJaJBU1ogvejPaIUnecau5ictO7vX/DoDVLk7oi9E+KkVmSH0G13A
    jkCppd4eCdbnzTMsOEynlZ9PGj4ZgYJRUXX1Bk85dDV5ITn3PmaGI0mzmG2dUN1F/jJp8CKHpflgdE5K6W2/GAEt56ATOkr/SESEy/BewhkijF3DzbR7DGhV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=mK_AVkanAAAA:8 a=WPyIoOwQAAAA:8 a=Vxy2kpnnAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=Q9B-9VGzhpXwOC9T4iwA:9 a=QEXdDO2ut3YA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=mQL3ssppXrSh16SuiSjD:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754234AbeC0Qe1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeC0QeZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 004/101] MIPS: lantiq: Enable AHB Bus for USB
Date: Tue, 27 Mar 2018 18:26:36 +0200
Message-Id: <20180327162750.269452837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
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

From: Mathias Kresin <dev@kresin.me>

commit 3223a5a7d3a606dcb7d9190a788b9544a45441ee upstream.

On Danube and AR9 the USB core is connected though a AHB bus to the main
system cross bar, hence we need to enable the gating clock of the AHB
Bus as well to make the USB controller work.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18814/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -551,9 +551,9 @@ void __init ltq_soc_init(void)
 		clkdev_add_static(ltq_ar9_cpu_hz(), ltq_ar9_fpi_hz(),
 				ltq_ar9_fpi_hz(), CLOCK_250M);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203034.usb2-phy", "phy", 1, 0, PMU_USB1_P);
-		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1);
+		clkdev_add_pmu("1e106000.usb", "otg", 1, 0, PMU_USB1 | PMU_AHBM);
 		clkdev_add_pmu("1e180000.etop", "switch", 1, 0, PMU_SWITCH);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
@@ -562,7 +562,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0 | PMU_AHBM);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
