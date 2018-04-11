Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473716-2-2065768965999481873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473715; b=rchixr1OES5qC4KQWPmuwdLGsT3k0d167Ugi5Dw23ytPyImoNF
    bqG0U8+cFO+FEP/F5SGWx+fUt8hDL9pxHlIIll27Y/L0bVQw44MkCWa0cBY/amQG
    eUWKkxRyTY6lgX7EjAWo7A/buA827jr4oq4YrVFABq1Gq/wTmL3+lAh0xTBtT9vg
    XeSmoggfw2We0MH/MApjmvYAF/PIbwCxmgASO9cesh/4EjJcxo9CGeE8uDaxy8Ke
    Vql25N0uDpXHlenB803hoarvFjkyjZ75uqiGdiPzH8NWUCczNp73QcLCxwFh2HSD
    FCKonm7ktGHro/OaZlLDIh7bOhh6w7ppF9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473715; bh=sRzzXHZ07VGrTMTPcoZMEj6HD85oJs
    OC9RvbWjrYfLk=; b=Qn55kuqMwwoB0ifOMgS5ze5+hnphsML0GjJ1e3rFS8uSpC
    wcbHxsXqe/XdvH6tsGS2eHFy3rya8DipUFwUn8Og/kypzCUDG5Q+9g5dVwtdjf34
    Am3GQ8eHguYmcOLiFjK/oDeUZceS/nb4zUjOqG6ZiR9GApgwhXqdobRJbRiw0vHo
    GoLPGuwa1S2ab4njqOsjah96FWh9E6zVDwIiYxJSlCmE4fmW6i1uocWXHqsCa8EL
    hI/f8B0D0zlJm/L2hRb2NDdpUgWZXc0werV6QD6vuSSeUS5Rx4PRm+zVKPBaHl4V
    GfxkRtbJxpXeOlTSaZNKDiWsFjKRO2ciJCh3aE0w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCKBfY19KLjZqDIanSk3q/lk7TT77WxDk77GsduCmuxs4sC5YU679KosNWBgVc7OQTDg9/XE3LSlDRgAPYHDi4lZR2QKvcIlFe1Zqpz53bjH1xtTMXUJ
    HW6nYmIkOK7uHCJP3/KpAaFFT1hdsuRsTWtq4DZIZhqGMyHL5BDViLWEhB2nKQBvyUSHkaCRZIckeDQmI2exLzhnDKDgBIn4alVYp7dvc8ctbb7akvbaYm1d
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=B8s8FRZQZouqPVZreGMA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755022AbeDKTIV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:08:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935339AbeDKTHA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:07:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 289/310] vlan: also check phy_driver ts_info for vlans real device
Date: Wed, 11 Apr 2018 20:37:08 +0200
Message-Id: <20180411183635.035791479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit ec1d8ccb07deaf30fd0508af6755364ac47dc08d ]

Just like function ethtool_get_ts_info(), we should also consider the
phy_driver ts_info call back. For example, driver dp83640.

Fixes: 37dd9255b2f6 ("vlan: Pass ethtool get_ts_info queries to real device.")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/8021q/vlan_dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -29,6 +29,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 #include <net/arp.h>
 #include <net/switchdev.h>
 
@@ -658,8 +659,11 @@ static int vlan_ethtool_get_ts_info(stru
 {
 	const struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	const struct ethtool_ops *ops = vlan->real_dev->ethtool_ops;
+	struct phy_device *phydev = vlan->real_dev->phydev;
 
-	if (ops->get_ts_info) {
+	if (phydev && phydev->drv && phydev->drv->ts_info) {
+		 return phydev->drv->ts_info(phydev, info);
+	} else if (ops->get_ts_info) {
 		return ops->get_ts_info(vlan->real_dev, info);
 	} else {
 		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
