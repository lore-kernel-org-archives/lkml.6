Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118622-5-15128037273590800353
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
    t=1520118622; b=H6zIliMWx8VuVxGZXjE7F8Ul+Q0fz+UVn+C772zUQnj7jtu
    Cu3KgVyImYJBQukWI2LZjhfFSWnM5I7ZyOeeX0joV2OtW2aEq08j+J2C7F3B75mR
    3pPm2O5RFIJAjgZasLelsY10KSRkhc6AOdbvsNI4VGLCODGiWk5lSXOeFswQtad4
    MbKBFkVTS9lKEK6bOztim75XT5dNs1xDAYaM1a+V1K39Z+7K1WfwqVR6kcGH19L8
    buXMu5Z2kvVwQzeeopPGM+MzNjDoJXMrr4RlB/wkeZrzol8kteomGu+m3Y0p/b/4
    9JmUCdlFpN0VYz9XZFtsTY/SgEDn//vDJqfNMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118622; bh=r7NjtJ
    Yf4EQJpHCl2OI29IQlZJWVfAEX3/cfqacTNy4=; b=fhD+iB2R6vf2JbjzAwqgsG
    j0ZQGl4txR7SIZzXgpnegJNQ41Pm1czVpS3XC7mgiBRQpRgN9+rfXerCh5SgwkHe
    MW5wcX6T7FWm+xCH8jFsTXtOaGqoB2pcC5zJ7V+Rez3ijLe8SgcZ4TbNwiNbZ6Kv
    +vIzSQzdN1/ilsiwNTidRefh78OLvJ+RETIMuHG1wDEI2FNp1Y/qqX8bWqcPfO6C
    CePYd/IE5RqKfTc5cie+0j4eXLrFDHIk9F5xzRmnXCmn/oBcaK3ywudLNMqnoUxL
    ZB6uk/O++hay0277RLLQxjNcngQq6BS8CNMjTkHtx43z+cJrtMqVY5nY60Epw/WA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZnw1x4O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KZnw1x4O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeCCXJm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:09:42 -0500
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:24173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935096AbeCCWj0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Phil Turnbull <phil.turnbull@oracle.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 058/115] fm10k: correctly check if interface
 is removed
Thread-Topic: [PATCH AUTOSEL for 4.4 058/115] fm10k: correctly check if
 interface is removed
Thread-Index: AQHTsz9bEuFPIuPdwUSEoaBB7sW2ag==
Date: Sat, 3 Mar 2018 22:31:22 +0000
Message-ID: <20180303223010.27106-58-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:Acr6hFnbSGs9+DIrK7XJ/yMAuF7Ui9QlVjwg1Invu96bBpl2tu3fdbYnPc7agbzfwilT6r144sDxorlFiwkPEdIc1rNIJQTgNvNXuH250WiOIk5lTDzZ0g7VZh9eeg5YtA/exBEkV7zw0X/NXyTghdNdafU7dpeM94HkVmbR4QaznXKbsGpMzoBZZn6uIqdox+rO70vBWa94DiPemkbfgeKDEvyJkYSr3IeojHOr2dLmtHOIpSfdApgiuGWt8/NgGDNLglWRD4gcDq0cp6COjWFsaJ13TUMjO3AtNABOAt2BeV3DTZeuvnr+OzC02dy8JlnVYYnpMjmRpDSesgsP43bcSYGBUeB/wWCLPX+d/e34p18YVeJlCLIMFVYBAkd2;5:H0eoYBvuoLGw0tGLDEbv0oWFL/jNm5dXLUKOGZtfqNts5MtF1Wj4a/ySXd+yZ7vrPsZcRbweX4SiWSTz/5uBqd3OyG3Vh6zhbDO/zSi3sgkkfTJ/sH+GGjh8PxLHSoplHb8JSffHU3LZmx6KjRJdqeiLuwt5IGwO0RRvJFSaijk=;24:RS7eAsrjjLU1rVCHEjXO3Olnc4wrvyMxVp16PTmXOV2WSXI2D36jtHjG2/1+WIMmXRb0ptovACxNBY+cY9TMgksLjKqo5oF8Uk9sjPgJjB8=;7:6AmScLEuOa0OHBmF1WtRBry98H1dE65tcKFr7aBiC7FOEvPqEdHcQ/ScdOcVn2xVghftaptgRGfP997yRZ/7p5OiDbwlHfuOX4OkKOB6kE4yXXr/5CB5i4URdbthmpUd0FS4LEc1wf0NKPvfXxxHu3v1dY6hZWNBwtf76k+yAwMOBkh/IStOwrmSlGJnPuuS5PtJW0KIB4PbuL2sCs08DMJ4jd6LPGS5OLfUBGeHTiausTOgpqnw6bKX3YJaKg+p
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4325b87-e258-44d8-19c8-08d581579b10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113162B073CCBBC67DAF423FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: sEG99iODBzqPsiLsNeVKlcrkRO5+5Rr93r/I3rKMCvsQFZuFz7lOdVTxHostR2/MxKicBOwjFavU7zMcONPSp518+MZ/X03DG5E4Oa8YVGW5NKQHs7Ms0ha7MI5shZKdn/sFBanCrmRYyrlrHo99oH3IYiOISRR0aFGHov2dqf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4325b87-e258-44d8-19c8-08d581579b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:22.5884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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
index 2ce0eba5e040..38431b49020f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -983,7 +983,7 @@ static void fm10k_self_test(struct net_device *dev,
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
