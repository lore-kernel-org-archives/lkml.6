Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490901-2-1375559335796920563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490900; b=f9+EuDPfEDVQqA8PiJ7cG7Jv764RD0vfIrp7aHnSsFE362y
    5LniqjAA5iiPsAFwgYfqqQXcfSjRI4zZWuedXNkqoFvSDdpOtOwVrjykSlbCZBXY
    j9nK1ngY6hUqE+83yaHeyhvSDgeDMmE688ymlPRIfr2wHDEc0c7Ly8uBX+sI1iVv
    z/dCaj62S5nrpoETUxafjEoNlgrPOIAvtyhevELmmeStEaZ345Mqf2uDACfNORVq
    v1+xhYgIFmsSKISjzQWdnpeFX/TfoO3wzT9PR4l9FUoBDNYRNPIscPZQ+8ZDmmEs
    K6yjurEPUTRu0iBm3Uwdd/gz1jNeCoeXXFNoeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490900; bh=aOPGA/
    k3N6QRYZnNX+pyYIs4Py1Y/IYPJCD5UtX51yY=; b=OCVhPGXG9FW0do2plY1eiL
    Npj5OpmZTNjfWq7D20NUonHW8f38I2WIwvgWjKoG4S9Q6Mb0UvHJmuV7qftElEWa
    tetlMZambUPi9APdxKKFiJ7FQiRrO3Bq7El2mzWIkk4gk2zmmzwY/bY5JEL99Gru
    3mdn47aXSq5IHCVnP+lhL3pBu4mLz+c+8jtJ/nIgN5xVkBXW5q1tXnfiiMhm3hHX
    JHG1XDwV7z6IOnKDIJn5FVRc9MMSZwk1HD17GPOckUwPlDQs847yWVVzNWywgBcj
    ne/8Bmr2UNAwkrRCtspBheykhEDnSP8CSR3hX+cFQaHhhxmNR35MqpI+aBUpEM0A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gmYbzVId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gmYbzVId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbeCHGeX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:34:23 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965516AbeCHE75 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 005/190] iwlwifi: mvm: fix RX SKB header size
 and align it properly
Thread-Topic: [PATCH AUTOSEL for 4.9 005/190] iwlwifi: mvm: fix RX SKB header
 size and align it properly
Thread-Index: AQHTtpokofXTHlSCwE2gnPBTOSq9iw==
Date: Thu, 8 Mar 2018 04:58:48 +0000
Message-ID: <20180308045810.8041-5-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:/ZG/IOQoVXmaYDE664UPnm4VOoh0/BO9rFa1fC5ig39bbK8pxSrRvRPfW9TpoNDxNVQ6yleVkgRQ/gBGmWfUkRSzxNA74k82+UPXTK4pDvtl9LI8gVqz7SxPAav1BUwLb6CzgksQ6ejX8nnBRihNM3+G95wNoOC4mkdiUExeBrzijJJS7U9H1QYOfJqJGV5Mkhnwi9UQOuwKeGRzySuQJkusByllhzb10H5iup8GQHjp14rgoicf+eRdCQqIqh3H;20:tD04L5IUDEfEg3EJtjs4pPKQAHipOsEt63qsYZm1RcvmDKsJrYNYn+m09KdCRf7dHkyYnACewgqnGzyR0Nqfkch6sSKN1b4IUyxcDYGkR0vVNWmROPnglV28rTn7/nZfXzbJUNpe17lfgtDkelUjp4hi9dkgmd5oKt3FjT1EYaQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bd991e3-ff87-409e-31d5-08d584b16df3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09206976DC2DD24186E90D29FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 3YboBllNkGXTZAeEsDJ2bih8cL0blzMe4TeEJsizyfQpQ2dt4i5gZKtPs9U6pbqx1VS0JLD4GwAsqOXA8H8MBICannWKjK9tOioIKh1HcAxnyUjwtD2+ZzjgVcvOEKfBYVBKVhg0L+bBGWi+jvINWgHqYoKUWO/ACJj+dKJ0ikUU4VK8okPzTnNrTyThOZLufW0+PbployuoyOwlNvKz+YGAWNOu275J86a5WX8W+PKxdtCK6fbdNbZV93/M/Pl6lAlTfreOzrR27fdSIcsGSk/GQLO2HWw1/n+TJDeb7pkozrc/S/7yoQ1kuPzeqSOI9BX75aoh2gESFkUkkSsvZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd991e3-ff87-409e-31d5-08d584b16df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:48.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
