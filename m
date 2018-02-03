Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682180-2-12702571327233597537
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682180; b=QoOe8U7gNT1LUNFXNYlK5B3chuLKubJjXcbFBwo5deSpMGs
    4WH+LKK4TqgbpEc9uSrycCAGcLOJPyVKZvnHKFEIvd34QPzvaioblLemG5iJ5P6m
    R43Vu8H6Xp2FTw+Z7AF9xbc+oqm5KAapjcai6yEyWz6R5csO9AmRixPEBqKqUL4B
    6ezEaOIjH4o7AL/UbCbBJ+ULmLGDGTbAbQZPz+fWhOcU4xundUhzfHMJd+xvZBoC
    /27QTUwBC2AO1MkfuGTWtfMBbb2xRmauyU7rcBTruzCBHy6sVmd660TAckfXQytF
    1gzbvvPqQiEHqZEc97ctAEOGbNU54yTd9s5QblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682180; bh=+I9EmQ
    bBo1rku7BYKTn/zh0Z4FAxUzxtclKtqNRbKD0=; b=lk4ti5FCugt1aX5bJOoy0n
    pKfVTT5X8uRc90pIlAdFWnUEg1HPyDRBCwLPS9QBoqnqcn2kpC/hDI7GzQoGevx/
    lx8P3GMUoS+8afh1J/FVfkN7u3SRw0TAGESq4DkMHWLAF+VICNVdW1JvNKselHv3
    4EINFv3R/Gdrcuj2OUChTyjN9VgCU6RmW651i9XVZHFWtem25ljhJ1zUD0dQf3Pq
    Scl2KRwlraoIl+cL+wpYJhOMAxF+88DMMDbZREy5XjmYDcPjdYxlZyMCq+OfIvTJ
    rSIQmSOhIY+YQQBCjLT/QUAuR2OJBWJaaurFNdrDtT3XAwcRaJVl73hLKK0lY77g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZm8zQEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZm8zQEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeBCSUM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:20:12 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:53600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753115AbeBCSGo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 43/52] mac80211: mesh: drop frames appearing
 to be from us
Thread-Topic: [PATCH AUTOSEL for 4.9 43/52] mac80211: mesh: drop frames
 appearing to be from us
Thread-Index: AQHTnRlcvo8LbK6L00qfgI4e9Um7xg==
Date: Sat, 3 Feb 2018 18:03:57 +0000
Message-ID: <20180203180303.8490-43-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;7:y/mlfOlCx2fP00FrW9sZ4RgyEJAnaqWoAPakcvXq8D0Vzv5f5D2I3TLaJSkV5MZu61u+IJmzEYLOvI6un1bkgxWu/ro4j3Jnx4I3bLNJfWJZwf0WYuMO8aK0+yvF/gBWSGufGLlwcMjM8hkdeXKWh3sx9H6EY7KJc0O4u0RA6+dPv6jit6w4qLpgrd0ZLtHLVVtNLopL3AXLR22EpBfxV1DxpCCYn/LlHmUy5ihsX01eVe9fotdH7/iGz2KhVY3f
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dcdba11-75ef-4678-536c-08d56b30a160
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012153B5B3925D7707E34FBFBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(52314003)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(22452003)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: V0MuNUlZ848BJCUK7Rig2/Tf/u0cX8b++KxV/uQEowXRz5WB5skRxPl60ZHbRbuwsRsG/KhtIILNv/0ebjZonQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcdba11-75ef-4678-536c-08d56b30a160
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:57.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 736a80bbfda709fb3631f5f62056f250a38e5804 ]

If there are multiple mesh stations with the same MAC address,
they will both get confused and start throwing warnings.

Obviously in this case nothing can actually work anyway, so just
drop frames that look like they're from ourselves early on.

Reported-by: Gui Iribarren <gui@altermundi.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 439e597fd374..404284a14d75 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3611,6 +3611,8 @@ static bool ieee80211_accept_frame(struct ieee80211_r=
x_data *rx)
 		}
 		return true;
 	case NL80211_IFTYPE_MESH_POINT:
+		if (ether_addr_equal(sdata->vif.addr, hdr->addr2))
+			return false;
 		if (multicast)
 			return true;
 		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
--=20
2.11.0
