Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239499-2-17926316749869466527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239499; b=jqd8vZ2JYSX2Z2J63uRqPzcRO/rQQEySip8XecpsKf9/sphm8W
    0AJbgjxNHZ/RDUMqqWZXMKxqJEHwNJEhg5cp5CVFh6E6maaZ9syEcv5USBGDOUGq
    PZ5eWvUkGqgwb32FGi02mDmX+Xmc8TXLYQA0WknikVrfXoE9ceWYUA/0T5s0LEUf
    T2iRT0T5TuXpx7lAVAk2Zh7yOXFIL+eN6QBD0B9FmYAEFyeVr17icHS3K/Zluidg
    2wsxMNGac3TCOaJU8c+JLxpaJnCv6zn72bR12W0/tUtONMM0E4xObXIrQ1SlhicJ
    D/hhk8dU2EY7ztN6y6d0erDj/uwaBp7vOlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239499; bh=4Ha9mUNbvf
    7nF1qR6k7vBYg7/+PYIm6l+yjplU1xiBk=; b=OUY6oxTnlRDAYFmj47uF8Zogtn
    jEbJqxm/QhM0BXOpbm6c0leGqJc/cjJz+PfmmLiGuvCF7I+U0C8a6F6dSvdgr9K2
    bIPXZ0gKyd7dedm9uQ1GoWvI7+RZu3xoG2SOwi6VLAhajyVBjy6B/e5FIr5twRJt
    gG7j5/SssY6IoX6Xrdc+8o8lxS27elg8hlw21qgQMiQChr2REnrpKl0RbvZi8JTD
    x3qvL+XI2BOA+BUxpiLJmaEk9QD7ZZ2t4z31JQVYY2CG0fkwVc2ghq08k8CGqRMW
    4euz68I0SAylCjgNVD0Ny0CVNbGBwC1AFExihhhAts9g2Joxg73Ex4K2nMWA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eZ47SW2L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eZ47SW2L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB6zpSBA7+odXbaKMF49YTveBVFsYddZWx9acSJ0HIkxgdpur5Fn9KbnpMM3xdxpywLUdl/kg+psh4v5v9S2UWaZQo07y/R6yTp2o0iyiIDzmGl13Pcx
    08ATgaaYGsLdtubPjQQnUuyB1x4hJjU9+ZtlcK7nyRqj6eZ1UGT6U2Dnz4CvCkHg/rXbJdAqSQwh8qbthdFYyIkoFwVpY4z8rhrkF65pMcvD1jDYB/3oIN9l
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=qR72OPCw4gzq-UOGwM4A:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeDIAcB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:32:01 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:32931
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756356AbeDIAb6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:31:58 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 183/293] iwlwifi: mvm: don't send fetch the
 TID from a non-QoS packet in TSO
Thread-Topic: [PATCH AUTOSEL for 4.9 183/293] iwlwifi: mvm: don't send fetch
 the TID from a non-QoS packet in TSO
Thread-Index: AQHTz5k8kUkEOcGS50e91JUYUOTU8w==
Date: Mon, 9 Apr 2018 00:25:17 +0000
Message-ID: <20180409002239.163177-183-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:5m0vaoMHPu9lZkxjKIbin5m6Q99FUfcNUDMOqPITAIOtYUCR7f8EtPwJjtpn8xMrd14luBsrolaGxSJccVn3aqnmvQvhUefpdLAQNb0nnh/C8HqcibWNz8JqOZA9q9qQjUByvHLzyuZ0mB64Kln+HvNxnXqeD6rii9SMgHclNc76pevEr9VXoIF2IL4KNrPr2x44TBiXvszztikVhn+1RVz487Ep2ASH95CkUwtBkFtSSi4ZDA+4T32yDF1XVriL;20:3R3krLbubpOsljHBA+Ur2F4yVuI00Cy7aEuotDPAJt3aGAvtYob9pyxu47dhlTf4NB1zJaqXsIowV4j226BYRZzKiv7cz3LZg//qm793P03Ru1n/HeS3cjDLQicombFtEMBK782IELRLdUC9rp2eXjhPpqxHCQKh97JGGluV5Go=
X-MS-Office365-Filtering-Correlation-Id: d6d0d358-ec55-49b3-a37f-08d59db14c59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112637AEAD4C12ADFE1A778AFBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(5250100002)(10290500003)(1076002)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eaMwbgiodUXckA2DYF3UpACbr6Hz/pxWfjG0z1WZ50mZ+a+A9FUqIDZ3D2Eq6/Cc9VMMQlMdCm5UNTx9Wgb+TmpUyl1+xc1CIGxdRFbmJbHtz59hlza4MQchWxvPtFtdirA6IpFIRbhOMrUgAtm4WnNRgB6qnUmMlOQWDpW2PESIG/PaO7IhiAp9BJfy6v7UzIPtmHjVDU8dWjLF9CPbmb+Ln+0pr3fo/Es0SYg78QmZ5oA8/W9bLfDeLqwp436R2Mtq/PNWUtUeDhtCRhTZwfW/4ZLEi1zR7J/7lVcGcXEogPT40oU11z5EpTgMCceQz4HzooPejZT8mP8iifOEIsJTAu26SVCQt+UyNwrzUovU13/H/uIAXZjZGZKDqVFsDFRd2L/YjvxjO8jOOqbKki9w+6ugodl8bTykTQFUV8E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d0d358-ec55-49b3-a37f-08d59db14c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:17.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 4f555e602b42826b3d79081c9ef8b8e8fe29fc49 ]

Getting the TID of a packet before we know it is a QoS data
packet isn't a good idea. Delay the TID retrieval until
we know the packet is a QoS data packet.

Fixes: bb81bb68f472 ("iwlwifi: mvm: add Tx A-MSDU inside A-MPDU")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tx.c
index 7465d4db136f..790952e48262 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -652,11 +652,6 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct =
sk_buff *skb,
 	snap_ip_tcp =3D 8 + skb_transport_header(skb) - skb_network_header(skb) +
 		tcp_hdrlen(skb);
=20
-	qc =3D ieee80211_get_qos_ctl(hdr);
-	tid =3D *qc & IEEE80211_QOS_CTL_TID_MASK;
-	if (WARN_ON_ONCE(tid >=3D IWL_MAX_TID_COUNT))
-		return -EINVAL;
-
 	dbg_max_amsdu_len =3D ACCESS_ONCE(mvm->max_amsdu_len);
=20
 	if (!sta->max_amsdu_len ||
@@ -667,6 +662,11 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct =
sk_buff *skb,
 		goto segment;
 	}
=20
+	qc =3D ieee80211_get_qos_ctl(hdr);
+	tid =3D *qc & IEEE80211_QOS_CTL_TID_MASK;
+	if (WARN_ON_ONCE(tid >=3D IWL_MAX_TID_COUNT))
+		return -EINVAL;
+
 	/*
 	 * Do not build AMSDU for IPv6 with extension headers.
 	 * ask stack to segment and checkum the generated MPDUs for us.
--=20
2.15.1
