Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492354-2-2705739550610425584
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
    t=1520492353; b=CRLRVXweg8io/KeUIvtpznxFLGjXWV4KsE8uIA9Civ5PvNA
    EKbVO66+Lq3Iwa8ITx2KXcV4jYaMmShVu9qaYNixhoJjmq0gUnd5XjRk/FY0WS7v
    Uw6+weuPQ3WXPxSvXB2NBd2Jyhh4nuK39mKDlv5+LidwQCuXp9GK5M+AAVoaczoU
    THTYFRB+9/olA2nUpO/jefBBK62QuUjScPUkoj8m0CI5dF5AszxPKptRdl5YgKXB
    egf3exb1jQm+16gyXOJnMEoyA5RdHhjc9H2r93UibSIIlq6GP7mLrEN88RXBxwZn
    XqofgSO/kdN5ngT2zEhx4I5pIl6YDBDW4NoRoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492353; bh=bBW0qX
    0AJhM8JIiKs/WpLgsjMW5bWB2usvOkJGZDXZI=; b=UrRXNJX1w90mB/O5HaBzz6
    bXSDhwrsucbUIIUDMkRd+ZO5S17RnD5SKhOEbrV8qlbtahhxoNs/5HmeHvRihvvA
    xXTz8Gtq7xEuXt9gSe76j9tA7tsdZbTw4r4LNWeuHE7Jul7YsnmUkeN9cn3szgJm
    TMi2BPHPta4ndxbx9xFFM67tqx77MkByMXx5WcEDQJ8aAKSZHs3/YJEw5tSBplet
    iS5OiigBoT8AzTlo5H/R2udTh3y7KkMnbNRdVHpOmjIeaaro6lRVwKPLw62u0o2c
    lDeg3+QFvgLIjvbTuWOPNTV+ltU+ZCoJspJ6/pKLFTfIAu1oPNJl7JvNeb383d4w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X9Vi3/OW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X9Vi3/OW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbeCHG7J (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:59:09 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:9666
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935016AbeCHE5X (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:23 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 57/78] clk: check ops pointer on clock
 register
Thread-Topic: [PATCH AUTOSEL for 4.15 57/78] clk: check ops pointer on clock
 register
Thread-Index: AQHTtpnQTrJ1Vkr7G0iBu3crD5F1UA==
Date: Thu, 8 Mar 2018 04:56:26 +0000
Message-ID: <20180308045525.7662-57-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:cDM3APL01bWvNBGFhHnCRsnr67P+VdF+pUurbeGsxF8aJsl349XQs/QXcuuRUoUjpggUcJSlW8fjcTGg1rSOGFMP15FHXUqzidlPEBR5hM9mT1/JI6DT9rbuZuZKlLmYyCCDwNcp5atq+i8DeYoDuH5rSQIwgh/82c00HoYThGf+mfYCOzckZpKtoE51QVorU0AeBpVbXrCJas37RRmvnDN1/X81vqVktPDihHDUiwDkfgPaR46loeUY8YYB8X/w;20:RMHoWBi32+cQkPljq7ZZTzq2be216TbfuyJJ0z7WJ0VxadyG+cXiGauX4GlqNr6UJSozjtiJzuJw4ixrV1HyMcnLMS1yPCTUqATr9QrR12/FTGatXlS2hXPhvAJuh4JEA572DaiTxspRgusgjrhLNfY7ylYLDcJYUOkz/C+dAaM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 475bb599-dbb8-4678-1290-08d584b11034
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032383A08EF40892CC9A96EFBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YdfBn8UdSiKqSs3/sN+NkYIvOMtMvw9o4SYKTAHzWxdnGca26k8919QvSbt9g/CkyBNSM3O9Uz9UGOGR2yomjOpSHbvEuVjdKawsi6YT9f6z90zVbcCtFbNWZ1T+YQL67KUNZnDYgttw2q6hF1sHBDDLgBqtihvuGKURccgiaG7AoBLhc0R9ACpD0Y0IdJAxAUfilECF8P/dNBZ3azE3CDGLdvF61Coiv+4fT+9/kRtjqHd4Is5cTlDWoNnMiMJFdmTurPa32GOSVVh2tt/AMHWFceDl7nAxGGxDXPbr/i+sQoryMuXJD/wDoxryZAZMmYAZdwFUWxp/JsxkITIJ1g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475bb599-dbb8-4678-1290-08d584b11034
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:26.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 29fd2a34ef8d863e48183bd473ba57c8d7839e25 ]

Nothing really prevents a provider from (trying to) register a clock
without providing the clock ops structure.

We do check the individual fields before using them, but not the
structure pointer itself. This may have the usual nasty consequences when
the pointer is dereferenced, most likely when checking one the field
during the initialization.

This is fixed by returning an error on clock register if the ops pointer
is NULL.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/20171219083329.24746-1-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b56c11f51baf..12180049a42a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2684,7 +2684,13 @@ struct clk *clk_register(struct device *dev, struct =
clk_hw *hw)
 		ret =3D -ENOMEM;
 		goto fail_name;
 	}
+
+	if (WARN_ON(!hw->init->ops)) {
+		ret =3D -EINVAL;
+		goto fail_ops;
+	}
 	core->ops =3D hw->init->ops;
+
 	if (dev && pm_runtime_enabled(dev))
 		core->dev =3D dev;
 	if (dev && dev->driver)
@@ -2746,6 +2752,7 @@ struct clk *clk_register(struct device *dev, struct c=
lk_hw *hw)
 		kfree_const(core->parent_names[i]);
 	kfree(core->parent_names);
 fail_parent_names:
+fail_ops:
 	kfree_const(core->name);
 fail_name:
 	kfree(core);
--=20
2.14.1
