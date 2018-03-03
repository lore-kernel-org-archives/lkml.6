Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122231-2-7306876868143825798
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
    t=1520122231; b=M+EmNmoSdEZJUR5g7+Y9n+kX186TNLEq8ihmUabtq/x4LP2
    zQ05FyOmhDC22GX0A62OZLJ7HSyOVoEZJJ+YguSq8QC3xfJxggovpLAItIOhBFi9
    l2D4+5xndNFpt4ODjcu5G5Jl9WY/KcMHhp3/LMcxD+lfXZCZG1JHaasq6Z/nrTg/
    ZuIPv3adg/nSJ9NEWauaMRC/EY8t3NAm8kDG8X6rDhIFAzBSplL1fqS6hkQ8zfI1
    1WtdMvTgDz18TfxuB2SI9Yz4lcqaylXuznP7Sf0aISTlj4D/F+bE0b0dn46ABlPq
    7Be82IGxuNzDj+QENCGY6hAW96lp5WH+S5UNkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520122231; bh=NAhB/NqYbOpzevgXmiQEIHKY/3
    SyCjcFaCRj7dTMztE=; b=OCHV/7t2/INRE44MZ2bUNx8MvT/hXZIzlKyfnuwiod
    Yt3e00sPLcB8KaoxuzZ0fOWTDnEpLmAY6V11O1OSKFxSlA2Eiu1yl7nZm5vYLxo6
    TmXY/x1Kt98nhfTuAv8K9NYLm1oR1m0Bvv0EisFfRcK+QneP3G5vHNrrDay7u2Do
    tfmi/agYKXezab/Xs28x2ONOrfIGN45TDcD2EIXdFWrdywVZix68QL2XbtO4Ep4K
    Yd5r9bfEcVsSpZ4aH+KxgMwCopo9YAhB7jWu93ZN1GZKvaP1fnujrAdCcxPWDZD7
    Um4skf9AFhKYcipE2u4DOjir+I+zvVGLxZj0xrffsjYg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z9d2JcV3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z9d2JcV3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeCDAKS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:10:18 -0500
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:51749
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932496AbeCCWa6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 001/219] Input: tsc2007 - check for presence
 and power down tsc2007 during probe
Thread-Topic: [PATCH AUTOSEL for 4.9 001/219] Input: tsc2007 - check for
 presence and power down tsc2007 during probe
Thread-Index: AQHTsz7g4tX9hmQJgE+KHFT7rRFHZA==
Date: Sat, 3 Mar 2018 22:27:55 +0000
Message-ID: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:Z6igCIsJfJMPxn1dJYte4kVR1BDcnmV23EBjU/PiFaiI+948on+OSD5a22QYU+qMcXEjqUWmDsDn6pWiSNneXzc9P4nh1UHED7j2x1u3ZuJLreUsFUtvokh5OHxCgJ+aQSFUasf/NixnF/tFycgzuWiv9pJ2E08t1y8rSYNnOcQyO4Y62KoQ23CLaQr41Bw94Siw5NyNi8cfVxXz6DBnNQIINSPSE5L3W8KXfJhY80adU/RSPKnq7cL5F/j0NbtLun03eusYtyfGCy5zVPHc7crfrruV7uoBONDWPA63BX5u6tn90D0/RWB6aPKgqpvL4sKxBcMj3rlfdx+FBgbGZEMK+eOiaP0hR2aIpdt4RYFY9zZmrarm4VN+dU/uHft8;5:RX5tPX4Vpn842vzpjXwHn617D8JdFYXxnDDr90Oln4cN5Mx4kxfQxwQQenS5S9Nme1SAVPtVTXPyfE8F453CeUCtaU9L9J68hfN/zzjQVq6oDJb6KR0A+QBIdcz0QaxmyCJAYH+F0rx9VqlWqHaMCaeT80pdFDL+vD2w+k4fAMs=;24:KaiB2uovkAcsWX3QFitaqO42oCLwYQnRR+6dgXgAvhnEYknTYPwnJ1/a6REkUGJLiQBGT5puSaUTyYiLfk2LjUTO2bPnO9suNDy3VgtWP3g=;7:7PuFbdTXm4GnNcYpIoe+TdE7o6+9bSxBWAhNAV8oYstXfBIv4Oqw58pFUBgUXDGs6UGQHNWc6U5l6XqgHNZ68WaRcIJqdgFgIxuYZ97tyiqUqbUX4v8Ii+zMSqblJ6JFruY9K6zks6homy3VyX7S94j2Z+sqJt+JALJojU6dTof5fCNlwi3+AnA6thw/c3kk220NmZtmBdoQLeUObMUqlJ5+av+/dbnVTf/e6H6JLmiTSmzwlr7ZTK3s0MPaGdf1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6fe5642-a21a-4855-0ca0-08d581566df1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970CBBD38D895793AC0266CFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jelXtXPgrm//amwcdIaomwms20pzcIHldOVbALPACMGww0H5bpEnuv5fHdlWVXxgIIlk85jRw3iclaZTOAMep/S7D5MACF3psTSc1eaLV2GuFw+sRHW8H6imrI77U9IueEBp4jxRbJ9ezZFtqMUizzcMz6FEqBYD9O2DuxXxYZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe5642-a21a-4855-0ca0-08d581566df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:55.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 934df23171e7c5b71d937104d4957891c39748ff ]

1. check if chip is really present and don't succeed if it isn't.
2. if it succeeds, power down the chip until accessed

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/tsc2007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscree=
n/tsc2007.c
index 5d0cd51c6f41..a4b7b4c3d27b 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -455,6 +455,14 @@ static int tsc2007_probe(struct i2c_client *client,
=20
 	tsc2007_stop(ts);
=20
+	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
+	err =3D tsc2007_xfer(ts, PWRDOWN);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to setup chip: %d\n", err);
+		return err;	/* usually, chip does not respond */
+	}
+
 	err =3D input_register_device(input_dev);
 	if (err) {
 		dev_err(&client->dev,
--=20
2.14.1
