Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117376-2-13970817226823410196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117376; b=oMoFK3Vk0AvGUykMntuSXsT/k/v2SbNgat/m86I5rEp9auD
    CsqdyThHug+R70L9bOBQv7uh9N+jdi/G3i1dRfgXgrSOmgEdRfDJynRec5slH0HS
    SCOrhZ73c3kEHNkHM0muRX1hBQV0/cIGiiHl6p41Zy20/jHcNYSb1qUKP9mY6yU8
    HJIW7nvrwEYpY/ULNLwh3TB+ln8kE5rgwQTewdXQfxnJYInzQCCiV4p5qGNHOz4Z
    4l/mzc8V2LWPLW0MwSjyR+PWnt/uj60WSpCJIWRuXl16r40miJGhfqxSXu/1wKxi
    3Wbj8fetWISj/bF/AmoPjrSL/AtcxGdJ6KfxXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117376; bh=NOtaQI
    RxA+sS1BU2WirvDFkVfa/Qd8BP6BSMOaR/88Y=; b=WI9f8ZB/qncbvCixgADIO2
    tcMRgmQvzyuZutpXnqI1Fhoo0YbXJXgZ6QMmznQNG7USb5ZJ+RjDksKYxQyp5Kyo
    4ixisL8uMK8x7PflOGvp1GLkm8lzPbAdmZ8F5BL6lmvyUMb1E3aJ7nF7OBccFd1g
    wC4DekBM7EDOcPH87jryV+Hfbzo6hKTB7Hfhhn6n2r3y4AhG6h5WOxV3tvJJmUyo
    ssegrJ3qKj08nkCG4SSCV+2LJ/IgN8g/0gqNGLy6ruCJ/poqfHBkL5FdPiAhDRWy
    xr5NlfQxRgKLOK07wnY1ayIxrk+gExPn8Gu0kFVp9BTHjL1uLtfJ1NjwywwgA2oQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NUwJZ8Sg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NUwJZ8Sg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeCCWlp (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:45 -0500
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:12597
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932258AbeCCWln (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:43 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Phil Turnbull <phil.turnbull@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 31/63] fm10k: correctly check if interface is
 removed
Thread-Topic: [PATCH AUTOSEL for 3.18 31/63] fm10k: correctly check if
 interface is removed
Thread-Index: AQHTsz+mIhyOZiaqA0mHKw1TliASlA==
Date: Sat, 3 Mar 2018 22:33:28 +0000
Message-ID: <20180303223228.27323-31-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:OisVQDiqa8HQ0JmyboPuxNsVYHwxRckTd/e2G9xnW+QGrmJmut6Mv/kx1zKmR/CLjqRoTZNZGFBoY5uRWKYXSgoh12LACwO/cqivMljtxTizNh+R4ou9PFYFDlcx2vRrdz5HpAwj4rkRkzTdhW3rF4bYMRZ3aLEYGdCXnFLcq82plrNuqeOl9PtFI+jbhj4WW/vW5RcbNq/eBsDt1h8oJ5poGXKdmnrNPNoeZS+77P1nPQWzwxU2aU2DsZKSyrZH6nW7TOKYx5i7nrilqqEx64hD5Pt2EYS08HARMcYr+1BF6Fe5Sz7ykDRGUeVkLfi2XrNsZxumYH7sXfILGNEXiwebw5qp/Cullo3vlNoWg2CktCsBYlHJU9aAfqk0HvNe;5:aeRfXJGGNE2orCroDtHCRg4CNK8poT9GRtebPD5ndrlsvZOkacuT0GLEdLpfWWDsBlGKsvaJYqS7A95XOD0HSLNqPLNEj1dMywXIAZPeEEGamChRRvkDtXWCUR5x7s4MXaIoKYFa2hXFBy2LZtmFoHGiluOjoK06GOwtGK48nOw=;24:Z1ukL7wkwblRNSAsiY4p3jwbJ2LbDQRY9MfY0ZY9mymghm7aUEYsVNjIgG1DavBIJcxzU0sOXrvfFX34uffH/JUKMna9p7pwWxu5OvndN8A=;7:KaJeiShZnz+oBV4JVSlKdJqbFBQvRitCVf3E2hKWab+HsL9/7MwwVjJ8gQo6hU0GTaTsbzW2o4JC8U3zLXGUcyUbgR0BQnD28XHVlEmbQpeOI+Pwd+mtbgmOuCZweFXkCPV4sIYMBE+2p1cg+dAt643vZFIYhN1dC8cYOwWTuRdegbggAglXE8hOPScjqiMF8LnHfdS9cBRFcoq/JSC1mujb0D41/OASHoXm+Z7w0eeJowr1wu6SVk2jJW8rvX6e
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84ce35cb-f73c-4d40-a758-08d58157eef2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB060089E2BC5B46361104D3FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: m1sIHjWEBeuitem/tJodONgnuRqN5YPS9WrbHJsbJlM5mwWBBBe5H/NsfjOmG8Ieskur3u9QKNCAo0gsDqiSQ3wsKg6ENAYtihXx99n40W8jH4A4639m7SJChcgpN0oQq77sv+tAGj4Nj4lHiU4axOpuhqOWw99By2YRJy0hb00=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ce35cb-f73c-4d40-a758-08d58157eef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:28.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Turnbull <phil.turnbull@oracle.com>

[ Upstream commit 540fca35e38d15777b310f450f63f056e63039f5 ]

FM10K_REMOVED expects a hardware address, not a 'struct fm10k_hw'.

Fixes: 5cb8db4a4cbc ("fm10k: Add support for VF")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net=
/ethernet/intel/fm10k/fm10k_ethtool.c
index 2d04464e6aa3..125fdf40daa6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -840,7 +840,7 @@ static void fm10k_self_test(struct net_device *dev,
=20
 	memset(data, 0, sizeof(*data) * FM10K_TEST_LEN);
=20
-	if (FM10K_REMOVED(hw)) {
+	if (FM10K_REMOVED(hw->hw_addr)) {
 		netif_err(interface, drv, dev,
 			  "Interface removed - test blocked\n");
 		eth_test->flags |=3D ETH_TEST_FL_FAILED;
--=20
2.14.1
