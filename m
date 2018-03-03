Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120246-2-8587135861353411249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120246; b=MAtsN5JrmaKuORr8wp+uA02urKZ9jMvgPrCJFBf9/3/KWvH
    stlcfj52dw7kbuNG/wXf7vorJ+Ju1i8eqb9s0j+mAliduDzE2AFmyW21BnK9GoRU
    4EHYgT5jglf6/h9CU3whXTvpPxwU+UnFnWffaMqxJ1SROec/L05svekWfX0DcCnu
    MZ8eVL5Y1NR/s1/CK38/KRxNQP0DTBsnZbAmxi4KvfGTTUcqiw/raqT55/Xd+c+0
    VZQc6ct6gAPt8DsUqXFiuCBXw8Ywg4ZRWis4MALmgPMsUfJylYezReB8/Xm2PTBn
    oAbyJRDzqaFuZ1poC1x3Ahlt2BWwnVDnyN0qskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120246; bh=aOPGA/
    k3N6QRYZnNX+pyYIs4Py1Y/IYPJCD5UtX51yY=; b=B4TUoTr6+QKhIkXgARxj4M
    zaR8h/mdcqQpN0+MlHoXyWnw+HLS3cfpJ4ez/DCdaPSKiIdX8EBGnGEUe3H+LS7l
    ZW7Rrtf2ce+Zp41LDFEjIl4w3PhjVyNKimSolTK5u6PVV8dTjh0b+FB6u23Pr1rE
    hs1GZEKmtbOvYxHbEd9gBRGC5ewcCEitddOhX/rudnnIOJf931hPHoxhamAlAq1W
    H2KiNzpZpZYeVyiMnwiqO6bUyjwCycMQBOzdM/d6SD6OU9zCgitZaAUaARYuL/w4
    8g9z4XEdL7iTpK5gYOke4lRkuDznYsu+/9e5FaMOIVpXJLxJSg8tL5GJDM5zGCOA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LCKeWOhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LCKeWOhK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933752AbeCCXhU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:37:20 -0500
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:45030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934370AbeCCWfP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 149/219] iwlwifi: mvm: fix RX SKB header size
 and align it properly
Thread-Topic: [PATCH AUTOSEL for 4.9 149/219] iwlwifi: mvm: fix RX SKB header
 size and align it properly
Thread-Index: AQHTsz8Uy3azo/4vT0CwOmtbyrYHog==
Date: Sat, 3 Mar 2018 22:29:23 +0000
Message-ID: <20180303222716.26640-149-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:bclBD683uHlRcoxGcDS76mnW9SpR27W1ykrltJBKAOtF5lBg356EARGpoJUYnFl7plzdLDOs+yY8OSK9j+2SoZ7wH6pB+fjlTn9U8At9kechCZ/tzz6iUIvD0f9isdVGArBKzQIW5TazDqrhQN8eZXfQE7UV27tKNycSpyn2jlgqHGq48f9t1kzL3cPOmB/WyufMn/LwT+a4chZuVHC3Kbimgi7k3yVAO2tjZnGkiTEjBh2FllBHclwMj3c3Db9pcunVrCvOmc7LpnqNjOu7wsbz3UJXqZnuYMdMcuOgTsHQTuxkh2sdKPZpRqRE3e24uW3nHCxxqEAiC+3FQ6Yg17LYugtaPwEqSzAEiNUSUYA=;5:30vUhKqYiT7+C7lQf6JgWEUCHh14MQlmg3AFSbZcAie3Ai5RqOosUC2Zi4tcS6RgNGODFmbDs4keKuNhEZtPtBJExG8Xa8oUsvWyoce1FCr7Lk3Z/j//2qHsYyKasBeJqJB7EdvPbb06FbJRCln/+thUGhPEM9jdAY02KQBMBoA=;24:EDONsEcxL/S04vMSWFq+uBH590KQjuZe7JGjWoOiGabEQmUjaiyUn3dZwFs+8j4JC37CMPqoyV6nQI4oHTeIAOlVmuP7lDBnz4rsilN7BXA=;7:q+jolLQLOZEFngsDZxD7ds+3cpz9rNAqmvvy7A/N3vvW2VOChwIh5oEco0SxYT5CVXO6QEpdb6QS3XKbRkC0a1KoNa1phukPAvslzxdmAtaYXLFQgEAQmmwXU+7ScFcLiZ2QhAnCLtHFuiHxE48uaNIQSacffWBTgrBL/gnxcnkkqflNb32v9Vg86v5P3mW7j3SspyL6k3qAV5TaMKP76CpoMwB0LW9NlmVTGIfwuwrKWbuDpyk47p5vRts+iJC1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 356c30cd-df27-4c35-c236-08d5815702ed
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924E704FE362F2BB15C07C2FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c30cd-df27-4c35-c236-08d5815702ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:23.1351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5cddd05c9cbe420436799716d009bc0372ef8268 ]

When receiving a frame, we currently pull in sizeof(*hdr) plus
some extra (crypto/snap), which is too much, most headers aren't
actually sizeof(*hdr) since that takes into account the 4-address
format but doesn't take into account QoS. As a result, a typical
frame will have 4 bytes of the payload in the SKB header already.

Fix this by calculating the correct header length, and now that
we have that, align the end of the SKB header to a multiple of 4
so that the IP header will be aligned properly when pulled in.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/rx.c
index 0e60e38b2acf..b78e60eb600f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -104,7 +104,20 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl=
_mvm *mvm,
 					    u8 crypt_len,
 					    struct iwl_rx_cmd_buffer *rxb)
 {
-	unsigned int hdrlen, fraglen;
+	unsigned int hdrlen =3D ieee80211_hdrlen(hdr->frame_control);
+	unsigned int fraglen;
+
+	/*
+	 * The 'hdrlen' (plus the 8 bytes for the SNAP and the crypt_len,
+	 * but those are all multiples of 4 long) all goes away, but we
+	 * want the *end* of it, which is going to be the start of the IP
+	 * header, to be aligned when it gets pulled in.
+	 * The beginning of the skb->data is aligned on at least a 4-byte
+	 * boundary after allocation. Everything here is aligned at least
+	 * on a 2-byte boundary so we can just take hdrlen & 3 and pad by
+	 * the result.
+	 */
+	skb_reserve(skb, hdrlen & 3);
=20
 	/* If frame is small enough to fit in skb->head, pull it completely.
 	 * If not, only pull ieee80211_hdr (including crypto if present, and
@@ -118,8 +131,7 @@ static void iwl_mvm_pass_packet_to_mac80211(struct iwl_=
mvm *mvm,
 	 * If the latter changes (there are efforts in the standards group
 	 * to do so) we should revisit this and ieee80211_data_to_8023().
 	 */
-	hdrlen =3D (len <=3D skb_tailroom(skb)) ? len :
-					      sizeof(*hdr) + crypt_len + 8;
+	hdrlen =3D (len <=3D skb_tailroom(skb)) ? len : hdrlen + crypt_len + 8;
=20
 	memcpy(skb_put(skb, hdrlen), hdr, hdrlen);
 	fraglen =3D len - hdrlen;
--=20
2.14.1
