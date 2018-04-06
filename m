Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022019-2-5222984603084148048
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
    1523022018; b=pZCUZXRQuenF3Kzp8SQK057ePX/AAnpibWDgNAShM12QzFx5ui
    XkT6jlqeFaZHo6uqzLrQUid0d55Mmyr1vSOAGouc3P8fJ+XTiJj38Zt5h8oRITJD
    nG0Tv5yRiLw36z9X6SHMga39/LCDve6fjdBVH0la5gXXEIEL7u0TT2MxA8quBBJr
    lzX5o4n39pAdvOzAwjKm46mS6iW64aIosENSdnzR+GONuN725Gq3iyLYhI1NcSoy
    1cuBF0KEQeFnXGLvOTTS0Z92fP62KjZt9ACuYsMNcf7nHJ93NgPf4pTLIY4RDRPh
    gAzC1lDvqgBq4XXD9gEGPj/dfEZxZ9wKF6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022018; bh=Y2Xem8SdhbOHw1O8lLc55XhOEWksMn
    TAZb/k8Pfou8E=; b=A/pObNMjpIbDIkh2onSoWXeUaaSrd82yDltkCcURPM1nXX
    NUf8p+leSFVwUUFB3xHPz58dGnTQh36fH8O7ro4kU3c1FnVVIhIOVftpLnQETEIp
    +Qxq6t7mw1n2q/O5PEEvAVSLwDAWzOlzoSjpBeCcnHnXFjV809ceRVnSPTTcnF+z
    cYyDuWAwgKvhAJRv8iwBNFZMwyW71WvSASWzY2Inzrq+07xlNK9vTb/dSQm8u85d
    q+JibfiVuDG1kRP7UqP2kmXogOaRQftvcbrhGlpsPXTcMQEzqwc+Oq0ixOH2etE9
    qz10hD2LSvz41iaVhcopwmWkyQSm7ubDhWo4YYkg==
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
X-CM-Envelope: MS4wfAx83D8LbjGbBRVuenZ3jeA/PWBB0uNoQILOj/gB6w+GdM+YNIRDOj17XxY5RmhALDYkz3XeqEgyXnd5FPWFRWDklLtGNJgqgxV4m069lK70vofOzpW2
    rRbByGqUaCz2iRb/iJ3kbGS2bazm3liej5CFxnwLl3QkvnikRCxuuUBOdCqVlfFCGC3rcpKzkt5HTnc3Pd8KNQDUoqU+V/2WHcgXJ5DZBoNHuIcJH4/WEkI6
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=J1Y8HTJGAAAA:8 a=1EsaE_6oAAAA:8
    a=ag1SF4gXAAAA:8 a=op9UsEP-19xe_-BtWwMA:9 a=Z1bj_NkVgQKNz4g7:21
    a=BbtYwH8rLlhfWEpu:21 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=3ZumFrijQQ-2J9H5h8ct:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756261AbeDFNkN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:40:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35394 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752501AbeDFNkL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:40:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 62/67] net: hns: Fix ethtool private flags
Date: Fri,  6 Apr 2018 15:24:32 +0200
Message-Id: <20180406084348.531497295@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
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
@@ -666,7 +666,7 @@ static void hns_gmac_get_strings(u32 str
 
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
@@ -876,7 +876,7 @@ void hns_rcb_get_stats(struct hnae_queue
  */
 int hns_rcb_get_ring_sset_count(int stringset)
 {
-	if (stringset == ETH_SS_STATS || stringset == ETH_SS_PRIV_FLAGS)
+	if (stringset == ETH_SS_STATS)
 		return HNS_RING_STATIC_REG_NUM;
 
 	return 0;
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -993,8 +993,10 @@ int hns_get_sset_count(struct net_device
 			cnt--;
 
 		return cnt;
-	} else {
+	} else if (stringset == ETH_SS_STATS) {
 		return (HNS_NET_STATS_CNT + ops->get_sset_count(h, stringset));
+	} else {
+		return -EOPNOTSUPP;
 	}
 }
 
