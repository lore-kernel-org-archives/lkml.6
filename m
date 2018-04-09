Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240302-2-12385595760685918802
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
    1523240301; b=TkQEsjdM6yC5dZoopLcUYKwtzjDZT3cHNqQnPznPEVyQf4C2hD
    3jvEdY8DBdnMk9PFL30HOF9f98hvF4uQ3+rzDxCBRXzt8lD45yPk9rcq2lUPK9Rq
    I0v9pECJ+Gr3637+rsZklO9i3AhgZNvbQvqxqhYY3jAsq411rPNpRopo3IEs5+ZA
    FZcGH0RworIL6kWFMff69EmF9+v6d1cXvXtVzmLTgH2c0YHIYMGxrwZbqVjTeuLc
    S2itg/JgqXWxqk0Wq+BAb3S19ECW5NpcNQ3UElsk/JnWQh5oKWb3sVI7pfzZkz5/
    3DAWJFvYKcp2RF48Ij4jCSr3e7yAGiU2/OrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240301; bh=GmkkIZED7+
    Txhd+pNgzj8/1OQWSNTc0z1hNIU6/Mmzs=; b=kLpd0OqXJtIuE0SlcpCF/JjPQ0
    isP9KPmw1vg3CA3qb4fgMJAafMWlW2BcLc6MY3c3IxWhFpKk0y4FzLW7JKO43o9H
    g6dg/ZcVzvIqCLsX1iYtylmdLsW++vy4UmmP3DOUJheAQqmg+NMHkiP1/mkFb11f
    kEeSFAgcQ8zCB2P8kRwBVaSZlq/1mfuK4KzPP9ERXPdjrghTPO/5i0cg3R3Umy7q
    l+P7N/eg70I5Pan1YdoDi/Pm9dAJmXUtU22RUXPzjI86mSpgVPGxNHzbjPF3BUGO
    lV+XYjNlI90dWG9oAiq1osNi7OvM+cCd+a5F6o4QcmVCpTsVO/qXomyIWbeQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N1VxivUQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N1VxivUQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDJqilTWpSpGnA06e1S1s9skzqZDKm0oPleGXqr3HWiSsX4y4ZLynJDvzfWk/3NLhgElTPixHGOVoN4JBlwtZbvf3ZoeSq0cMA8S7w+B+cUt40YkwDK6
    3pX5laxk5S+to24pdDWoG6Xhq1tkWi0kjqUy4yU0OfeD9lV1gQRsGOEzdNBAyO9KjmfW7tiQLmjPsivaW8QdRRe6FcOBLq2MDjCKFDR7uQc/VYJu6RqJeG//
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=swAopTDVAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=beXlt2xKAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=Th06MsY-qsxrhzEtfzUA:9
    a=DxkN093LGtrrzYm1:21 a=78r42caZwrqE7TnV:21 a=wPNLvfGTeEIA:10
    a=7aPqbiTMDNvH6kBvy-t8:22 a=AjGcO6oz07-iQ99wixmX:22 a=gcY2M4Ci8LIz02MwfSIM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757915AbeDICRl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:17:41 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755636AbeDIAa0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrew Duggan <aduggan@synaptics.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 131/293] Input: synaptics-rmi4 - only read the
 F54 query registers which are used
Thread-Topic: [PATCH AUTOSEL for 4.9 131/293] Input: synaptics-rmi4 - only
 read the F54 query registers which are used
Thread-Index: AQHTz5kj/6FgNmfi202waZj38s+tug==
Date: Mon, 9 Apr 2018 00:24:35 +0000
Message-ID: <20180409002239.163177-131-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:WLg2orJLMrX/5yUdMjI4pfzzx3YwGz+/nP3HVlBnfIdSQMMC+F4BdDKwQIJYwfBHXHsutlojrYKNtB1kg+mbhzpWsgZMzLUk77LdykIvGFBt2CfP5ixBr7vrCaaXWWmPJq+qL5864eI75cX5om6So2de7GewMjxMkEB/hEKRioxFVvxU5xYOSMR3pG5DfcEJr3FYGm2IxE0uvxCxi/AAYNZ/i1A1HOVDtvD7V6pc74FiPxop9lC9axNlUnzEc9FB;20:NDZ7YRcfFjpXrLVVCcJz8skIC5gtTd/O7hAx+xLUUtnW0KxMkrmze/xv2k78qH4lRw375BvK6/2fzzHBG34th6ffHE7y+0CG9Z14ppzuUtqnlSAfdQu2UR8Ufsw6Lfm5TAJEVFzi3Nt3ITfJq+8pS+49RsYGYp0QHGIX3e47ShM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 727e1f45-8bc8-4d81-0761-08d59db113db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032EDE3871AF880879BD654FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(39060400002)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(966005)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(6306002)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4lWreWEdvx5bTu6WXctF07s4RK4d4Mol6LkpCf+d1zGVtE776mE8BfAHkzWF+2QzxiOTVuaHjB7YQw5PqV4Hra779zrmZR76byX3IvCZD67hq8wmsHyKf3IhyBPaDreiJC7FUd7AuYkoDEdQqOiYuW98iqK86l+rYAhzc4x/c+Zwtq1xzWeGNWKo+26zUSHt9iZlefOe6FVpjwmmt7WiEcvf3vbE/0zsxLTrDzdyiesM7t5+b/mlB2LSdEjKt6FaTQRjvgpEqGpQMzrXuJqbnSRaEYtWeWgA1wm5ftKE3XAg/62vsEAVlcSBt23MV5aq1Vmf44MPrsBg1TwP2+fRBLVMVwh2rkuBryEEcKmPbjGGWcpL8FMDBxVWGrf1aMhP1PA95NT9CPQd/s+WStnyh2PLobQtSbU7OeLKaTgnlAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727e1f45-8bc8-4d81-0761-08d59db113db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:35.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrew Duggan <aduggan@synaptics.com>

[ Upstream commit 9768935264c4f0e4afd788a185d8e8d89c28e41d ]

The F54 driver is currently only using the first 6 bytes of F54 so there is
no need to read all 27 bytes. Some Dell systems (Dell XP13 9333 and
similar) have an issue with the touchpad or I2C bus when reading reports
larger then 16 bytes. Reads larger then 16 bytes are reported in two HID
reports. Something about the back to back reports seems to cause the next
read to report incorrect data. This results in F30 failing to load and the
click button failing to work.

Previous issues with the I2C controller or touchpad were addressed in:
commit 5b65c2a02966 ("HID: rmi: check sanity of the incoming report")

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D195949
Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Nick Dyer <nick@shmanahar.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/rmi4/rmi_f54.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 2e934aef3d2a..813bef40aab6 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -31,9 +31,6 @@
 #define F54_GET_REPORT          1
 #define F54_FORCE_CAL           2
=20
-/* Fixed sizes of reports */
-#define F54_QUERY_LEN			27
-
 /* F54 capabilities */
 #define F54_CAP_BASELINE	(1 << 2)
 #define F54_CAP_IMAGE8		(1 << 3)
@@ -95,7 +92,6 @@ struct rmi_f54_reports {
 struct f54_data {
 	struct rmi_function *fn;
=20
-	u8 qry[F54_QUERY_LEN];
 	u8 num_rx_electrodes;
 	u8 num_tx_electrodes;
 	u8 capabilities;
@@ -626,22 +622,23 @@ static int rmi_f54_detect(struct rmi_function *fn)
 {
 	int error;
 	struct f54_data *f54;
+	u8 buf[6];
=20
 	f54 =3D dev_get_drvdata(&fn->dev);
=20
 	error =3D rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
-			       &f54->qry, sizeof(f54->qry));
+			       buf, sizeof(buf));
 	if (error) {
 		dev_err(&fn->dev, "%s: Failed to query F54 properties\n",
 			__func__);
 		return error;
 	}
=20
-	f54->num_rx_electrodes =3D f54->qry[0];
-	f54->num_tx_electrodes =3D f54->qry[1];
-	f54->capabilities =3D f54->qry[2];
-	f54->clock_rate =3D f54->qry[3] | (f54->qry[4] << 8);
-	f54->family =3D f54->qry[5];
+	f54->num_rx_electrodes =3D buf[0];
+	f54->num_tx_electrodes =3D buf[1];
+	f54->capabilities =3D buf[2];
+	f54->clock_rate =3D buf[3] | (buf[4] << 8);
+	f54->family =3D buf[5];
=20
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "F54 num_rx_electrodes: %d\n",
 		f54->num_rx_electrodes);
--=20
2.15.1
