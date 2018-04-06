Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021818-2-18320402388080817133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021817; b=RMIvjgYayxVW50UeDva1CS7Yyv1BTTYRYAejWQlwGCGJtQRqFl
    2Cz+cBGIKgumnQdfKh38/0OBOdymbMk+lyE77xdMwTki2XHr4MuWkRuGaf795jmc
    rMYeomcyUrg9Q+tQsBlsQGqoD71QD2SJk4tNBsYaua/efSNaf+k7BT1BevSQzDrz
    FlcPzcPXNT3Mm7pjTfbuBLFPdrMUiP0IqXIkawHE3o5Q1xY7pYFyfj+1VQksGbzP
    kntiakICja8xg+FGgNi/RCy4fC3QSm7oZUE/ctoLEdIrcZrHAdnojNML8XzAksmU
    rOjSKdm/H+VtVO6WAooP/sHt2P9y0WuWI54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021817; bh=wVArdynoP9yFfuhAbJWa9BdakJRtPd
    GubgEN6XppNsc=; b=E3xyKnslKBjiuBcyguSQ4mIX2JCNNE95YRjzP1ramT6Y9g
    fM8k4/P/C76CL1EFN8UZZ/LNfaUupCmlvRAvIsewwnKmgpuaPsi7pVDjGzqkNsYn
    XoImect8ZzHu5e7ILdI9a2macYDqoCDhPjETiS9l/WXDaCeQOI+hzY+qBRYA6XFr
    QvYegb/NfZB10AGIiM6eN20eKxf+Dyc01KyVGoG2kgx7UkTQVUPkSt0iqu5eY0GV
    qZOyXNSHpknQJ0ZHTeoA4IKp5aVDb7PPe/a7MRketUngmgQBk1E7BikfKEl4LERo
    d+pwEVhX11SaWFoGwVEdiUC73zGdvewwMcbGYAow==
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
X-CM-Envelope: MS4wfHO2mx9RXjKYcBDqWKATXlSSIw0wWnkvhH+huuQKZl8zc7unmtjg4TuYYyh7RbDy7KBFRfgS0U1p/eo/I/KIw/POoNdnbiphUBkEzLActaM2AI73edfn
    Mo/gaB9m7V7GfPElEKKuCvu3jBIIJ7G4yKexCBq0T3ghLxkprUSlHS6wnRG5GibnAyg4ZtSiUEkVGM00Z8DVgJHMB2rPROxsKMgUNaOVGsEoAYyizIk0Zb8V
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=J1Y8HTJGAAAA:8 a=1EsaE_6oAAAA:8
    a=ag1SF4gXAAAA:8 a=op9UsEP-19xe_-BtWwMA:9 a=bAKenoHZynvtZf8c:21
    a=BbtYwH8rLlhfWEpu:21 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756036AbeDFNgx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:36:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755920AbeDFNgw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:36:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 095/102] net: hns: Fix ethtool private flags
Date: Fri,  6 Apr 2018 15:24:16 +0200
Message-Id: <20180406084344.802126735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
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

From: Matthias Brugger <matthias.bgg@gmail.com>

commit d61d263c8d82db7c4404a29ebc29674b1c0c05c9 upstream.

The driver implementation returns support for private flags, while
no private flags are present. When asked for the number of private
flags it returns the number of statistic flag names.

Fix this by returning EOPNOTSUPP for not implemented ethtool flags.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -671,7 +671,7 @@ static void hns_gmac_get_strings(u32 str
 
 static int hns_gmac_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ARRAY_SIZE(g_gmac_stats_string);
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -422,7 +422,7 @@ void hns_ppe_update_stats(struct hns_ppe
 
 int hns_ppe_get_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return ETH_PPE_STATIC_NUM;
 	return 0;
 }
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -798,7 +798,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1017,8 +1017,10 @@ int hns_get_sset_count(struct net_device
 			cnt--;
 
 		return cnt;
-	} else {
+	} else if (stringset == ETH_SS_STATS) {
 		return (HNS_NET_STATS_CNT + ops->get_sset_count(h, stringset));
+	} else {
+		return -EOPNOTSUPP;
 	}
 }
 
