Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493198-5-14204488729929370983
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
    t=1520493198; b=iYvuftKIvwtQqQP4VxqqHsGsbTtpzBPNnIntPl8zLY0KYqR
    T4yknw4ZSKU3LVcdB5pR4e4VPDEh43HL//LJG1P8Q4wu7bVpi/ej7RWxB5q3TkkJ
    Db9OFIin1Y6XGuUlGNdJ64TSM2OpeVy+aHK4ma1/pE50fvI1/K9FsUxOhaOwcdhA
    WFVk3y4TqJYzfnVlJMZvW5a4Yuv/yeQfUxBArVEqnEjPp/D9VH1RxYAlTsBNp12s
    oBslx9O2h5p2DC2ttCOHFtzFGc4oB6oXBRX00HqyyLyxk+HFm5FXZvb81e1FD56E
    x9kXl0Dq2E8LSvA7k+CkF3qebKwuyfMXNSGqWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493198; bh=QmuKJQ
    4uPuvB8JN6rSUc3duFC5kHyqvJSap6ury9A9Y=; b=kCA57vNGyT8rpvlXToW9On
    VhWUA8uDeaFbe87edncgnSsukE5zdRj3gqrqdLpugI1hGiWRigtixZl4Dri+/kUb
    Wy6XFo+DXDn23RJEJjN+b2YAuU+v8SWLPSFG6qv32wZgwQnPusLsiUebKEnZvTPI
    ZXIX5PVB0UP3comoTcbJOLdPfBCmn7zE6em+C7FwvJhTwny5zo44Dtrkht2DA5Y3
    qxWva0zlVbdETVMfyrKu/ibKocQZHwyXI17gPw2BtRloJuHpU5kpHsmv7fPJBo2i
    ueVzEgS3PE+vygCJKkgESGzb3uHI049BNme+fc+QYnUD3bYroYapNPWtBTEL2r9g
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A5fWn6NH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A5fWn6NH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933757AbeCHHNP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:13:15 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754741AbeCHE4E (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 03/78] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Topic: [PATCH AUTOSEL for 4.15 03/78] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Index: AQHTtpnBGy6laCELi0OvitDlReYGfQ==
Date: Thu, 8 Mar 2018 04:56:01 +0000
Message-ID: <20180308045525.7662-3-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Vivf4dLbpA3v6PpB0M2KuCf6OvEWDqR61HZSf7GtWIAz1AcpyrgPE14hOaSF+GyorPn/Bzo80kLxnoc/ge8qP2VKu/cb8d5YcDCk5+9mNvsw0moiLOHe3EfSkuZ4QazNpKoMs/8t3OgiXullSROlQa5Lxz4WX78pN7A1b8rpD7040e2GVBx8/BoGKzhRJNQRM84AeXNOH1TAVei1OEPtqEsC7n50L4ypm+gJSdVjmRAQJwrF7mIn52/cJ4qQG23n;20:/2Cw8tLikCFfvThR/K4sIi5ueKmTMgNTVf1szA7Dk8P/Xp1tjdre9xa+HTQ4m6jz7tK2F3oGw5mfaYgwbSVUwehGvZpSCU+oTl3UVQuUOlMGUSaWvmylr/kzHvIb4jW3hyDSi/Sa3BpnGw9CGYB+Bq/dUq+ulELzo1UnFeslVb8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57ec2daf-e8ca-4893-d942-08d584b0e422
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09022EB965A959081D2CE238FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: C+n6Ad0ikkJ/W096r46D06CoRkdDHn73EphX6L6PcM9S+9fptmjl6zB3McPdk+9W8R8gJ2i3w7S+O1QoVLoDZ7E8jPtf5ZwJ+FEHYLXjy0EKJsJ2u2Fl1+C+L1cLA6FdTysNVCbHwPoMGrEpOCt2IkS+6J/GemhdcIVGmdiZaSwgMJG9UTVjjX30r/SkgfhmAlsk1c0/4QIE1qPgYk21tWL/ZJZN+jH8T60qMGXXyH2fZy2wfWVIc0CMKLy0WpZq3S45d5NA0OdN3UJMH1Sgyu8F+RKlsjwgst8X3T3Kajttun0/yWoiVU7HueppmwG8NVKmesX5OogGC60wUkhGhg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ec2daf-e8ca-4893-d942-08d584b0e422
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:01.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit ba8f3597900291a93604643017fff66a14546015 ]

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bbd7db7384e6..05ec530b8a3a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -932,6 +932,9 @@ static int qca_setup(struct hci_uart *hu)
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret =3D=3D -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret =3D 0;
 	}
=20
 	/* Setup bdaddr */
--=20
2.14.1
