Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405478-2-9386121450085900523
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
    1524405477; b=fgVmBaJwticNjEm4QtwV+Umj3iL67e97azib+mOWMDPrO0DKue
    NrthGbHmt5n29SliFgakYzkFEaIcR+lnICb1ZDnEqDyLXL2aUsxtM77MbQpkPMQA
    28ScFivjWOlT98OPIagUMhjP2ac9jy3MGPWUnA3TywlUSH9kY27QUEv3Xbjs+Ba9
    5p2EezrOtMVacwAD/LxALdFxEB51NS0c1VUhe5coCc4q+6UPTcFD1cutR++SHW5j
    +MUR9D39AWaYFGHhPenBXkxgv3yUJNfsEFra8qXXoy0B7QWSQvNfcUw/kxpZJ67x
    wFKnabbBJ5br4bSXGA4S520lTAPYhzBUC7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405477; bh=Dk2n9829aY/ZduMsVa3mhlcokTfjSA
    MKX13BvUvFsYs=; b=WGbc8ZN6y8cAJtrvnw8YK4JslSN2d3+fqCTiqbnpvEa3Cm
    sHF9FupWNEGSrgcIYt06mZ7BQ2j0AUD9CMOysGNGjWqq8muPI1AuRHyyVLMXf5v9
    yS37ZFM5O8qGK5LEO0f4fANQ0dPwtcVC3Bm3BmBM4MP82UXe8/klgqBGwwMC4zWV
    VzCsrD4YxetqKbU/qSpmP/qXpYLihjKtACCLoo0zmGz2iEa0c8Too02///hSD7R8
    A2Y9aHbtirnohEqhf0SZBh9qT0grZGcHtdYALq51MlT5qMVRGG6nL0bz1gMmtcsE
    jwiDsGRu3qu19tQFJOhmiZMfKHCK0O4Fp+4FlDdw==
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
X-CM-Envelope: MS4wfDCb8zfDIuDZ46stPnC2b8ru+aNw6ZKmshNjs2N6HBGARzhaf3J/LjWEkTA51/r3by/mtqhbVrBWtkBIRF6EdX2CdJuFQt1KVDk9RxnT3yJuEPnvxI5g
    uPI1X80K7Wvw4mCihmJCUpV44iRrefq7s+Vc7fCYO8jx+C6YWoBy59ZRZ7vo/mANdpZlwdP8wWNW6KYUiokFEGDHDLTOxJ1/MNb2d4cWXofWhuU3nx1MLDlG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=ThD-YMbD28sxt9sY-_0A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeDVN5y (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:57:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeDVN5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:57:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.16 078/196] thunderbolt: Handle connecting device in place of host properly
Date: Sun, 22 Apr 2018 15:51:38 +0200
Message-Id: <20180422135108.274849570@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 79fae987518a3aa6c3c7b2e3ad5fe1e4080c12bc upstream.

If the system is suspended and user disconnects cable to another host
and connects it to a Thunderbolt device instead we get a warning from
driver core about adding duplicate sysfs attribute and adding the new
device fails.

Handle this properly so that we first remove the existing XDomain
connection before adding new devices.

Fixes: d1ff70241a27 ("thunderbolt: Add support for XDomain discovery protocol")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/icm.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -383,6 +383,15 @@ static void remove_switch(struct tb_swit
 	tb_switch_remove(sw);
 }
 
+static void remove_xdomain(struct tb_xdomain *xd)
+{
+	struct tb_switch *sw;
+
+	sw = tb_to_switch(xd->dev.parent);
+	tb_port_at(xd->route, sw)->xdomain = NULL;
+	tb_xdomain_remove(xd);
+}
+
 static void
 icm_fr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
@@ -391,6 +400,7 @@ icm_fr_device_connected(struct tb *tb, c
 	struct tb_switch *sw, *parent_sw;
 	struct icm *icm = tb_priv(tb);
 	bool authorized = false;
+	struct tb_xdomain *xd;
 	u8 link, depth;
 	u64 route;
 	int ret;
@@ -467,6 +477,13 @@ icm_fr_device_connected(struct tb *tb, c
 		tb_switch_put(sw);
 	}
 
+	/* Remove existing XDomain connection if found */
+	xd = tb_xdomain_find_by_link_depth(tb, link, depth);
+	if (xd) {
+		remove_xdomain(xd);
+		tb_xdomain_put(xd);
+	}
+
 	parent_sw = tb_switch_find_by_link_depth(tb, link, depth - 1);
 	if (!parent_sw) {
 		tb_err(tb, "failed to find parent switch for %u.%u\n",
@@ -529,15 +546,6 @@ icm_fr_device_disconnected(struct tb *tb
 	tb_switch_put(sw);
 }
 
-static void remove_xdomain(struct tb_xdomain *xd)
-{
-	struct tb_switch *sw;
-
-	sw = tb_to_switch(xd->dev.parent);
-	tb_port_at(xd->route, sw)->xdomain = NULL;
-	tb_xdomain_remove(xd);
-}
-
 static void
 icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 {
