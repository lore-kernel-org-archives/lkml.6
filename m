Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246146-2-8286356384767736089
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
    1523246146; b=KUchQDC4Ao/CN46iV+wlmNhoBpGDIExEMhdUxujILwJcQUzIjM
    u9N53cazcnw5ygKk9+KGMP28VkHJgqWgjkcJ7ualaIIUUTJEBHcJia+LlkGOBPCj
    OGTUndHia26MTqmJ1BdAWFtSKzatGw2bOgGylIu8dv1zmKWR4qEVknbFtQQDwmeq
    9q50OQutC6gHpKT5hskRbH2Ut4fSysJXOVPNE3pcd5J2WTWkQeIICaDJIA4oa0xR
    CcPlFwot3UkCcflsxsovXwQBTLw5DhoJqp8vffzf9RP6Sgdb2dBvf2rIt8x2k+Og
    NcEfgjukwPRnyuHWDLeLSNUHqhvFW64wxFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246146; bh=SDGiEXPASl
    q2LoAtHicbNog/9F4BxOwuME3v7gfF5I8=; b=jI7ztOMOE9OI45liP/nqc/xbiX
    glEClsMaFcTzkZxa7LEKJsIKufSdEDw9fh6TtjEeeKo77tUCIHMsJYK1C6SlZTHu
    xFg1EB/0FJ/QibwY84aQ1GqbF2+XMtiEAkAxNODCoPx9XLpezkLlAhbyF36fBDAk
    eU47IJUcDeygHwESNevVOP89shWlxac0YHE5gOXUWZ/QDznryI/KNLZQsq6BJKD/
    Hkmdd7Gj64ifwBVjh4AGXOj4aBqXdBwmePijZgLYqMvx142xmhG55jqj7M6wSpLk
    IZAWuUfKx80GnpLS1eM2sYcYSto4Ztf/F9nUNI6frOeMAvyjxguzudC1RAYQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NZJW68KI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NZJW68KI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfON6F1q59Ls8BNx43cqxEU5ORIXaDeVgTmuad5IovrYXMx6BRWdjKWOAxAIIr8UvD0niba3MY7Mlx3QuePe7cIlcCd8twMS/MxKPLRzD/vq1jkBuSQIk
    /9nVJz5kEDiwQ/3HNReiixLOOEklbRTaO3/iljQT3bZRLSE0zmQnB7czup4pvtSHJBloJU8WdGP6a4wIlygDwsyAU6miQgrPLc5iUNWPsqhtLDO4+jaTTTcq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=gx6koJuJAAAA:8 a=yMhMjlubAAAA:8
    a=vnP-Y30kCj38PRlCAtAA:9 a=wPNLvfGTeEIA:10 a=td0oL5riYOtXiimfbIXQ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDIDzb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:55:31 -0400
Received: from mail-by2nam01on0126.outbound.protection.outlook.com ([104.47.34.126]:59343
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753815AbeDIASv (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 089/189] Input: edt-ft5x06 - fix error
 handling for factory mode on non-M06
Thread-Topic: [PATCH AUTOSEL for 4.15 089/189] Input: edt-ft5x06 - fix error
 handling for factory mode on non-M06
Thread-Index: AQHTz5g1ZC1cOALDcECbXaqdIJXLeA==
Date: Mon, 9 Apr 2018 00:17:55 +0000
Message-ID: <20180409001637.162453-89-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:gGU6jAWbdJcFMHU4Tty+oR129X2YCgfSx3QqvLTEHQKd9+RwhQU3A0TG7EJjRqh8w7tXkcF05TfXGJ6tZy2R+N+8BBlYpcDtwn53zFI/FC44iVCLGnOUH5s5U7U5OTmrFvyi2D+y1xau9oPZPRCfRGezk8+spfNLzSvv3kWh/8QwwGXTGnrCxlKM1/i946UluVLvp4BB0vUOCMhz36is1QyLo5nTE5pskyzltIEwS4uc2d4e7Su1hv4744Jb/4SQ;20:eVlkGJleFcIWj0ebiMePYCb+OFDjATmPf58iEYNOSS6F/vQicenN+jVldHGW67zFpYF/FdDGHTNX2afrQPyvgNsu4IWTF55eQZbQzGhe7ZSbxsmzd/uP0VkRP9ak2l5dFUzlZSbeaStEmn005VS++RKc0rcEaq7fsRYSt8oBYm4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 14c2c5f8-2727-4523-7589-08d59daf73cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128C37C3EAFA0FBFAC70AC4FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(39060400002)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vcKXwPLhEOAJaDdcdYeC2nKZW4ppOieBUJ2umkpiSWLhpS7aazjV7NRwr4868fjpiS1bMsopGCZJqtK8caVF5FImWhO/ITSlDUmeNKQeM+k6S90xMSjr9yaDly0FabXygPswuGDbU6BTgM6LGmQiJVKhhhKCc2fnbZqWWkU0AWqXVOTiaOZruK8sJwlsg1vB7RHLxGGE6u1c6HHEowi6NhjZg8LI0p9kud1kMLDs3qMI3frwyP7mwTnSRDhCOzvoHxHnbK7iD9rfHzpYCCWsWZwS2Gn/wGbpDRwkBWDIbxuzyQVF/py7VFqkEArhfbT0hIrYkfZJhIfvAWShbgSBK7wQ5BplWBt4aWe4uELF1x+kVwYXhVi6EJpb4FwPRlqr7jfYWV8KcZYTHwNkWInG9mGMWcy/Lmbfb74U5RTF1FY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c2c5f8-2727-4523-7589-08d59daf73cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:55.7260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 4b3e910d7f430ab76dd37131bb75129878950163 ]

When attempting enter factory mode on firmware that does not support it,
we'd error out, but leave the device with interrupts disabled, and thus
touch not working. Fix it by moving the check before we disable
interrupts/allocate memory for debug buffers.

Fixes: fd335ab04b3f ("Input: edt-ft5x06 - add support for M09 firmware vers=
ion")
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchsc=
reen/edt-ft5x06.c
index c53a3d7239e7..1e18ca0d1b4e 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -511,6 +511,12 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_t=
s_data *tsdata)
 	int ret;
 	int error;
=20
+	if (tsdata->version !=3D EDT_M06) {
+		dev_err(&client->dev,
+			"No factory mode support for non-M06 devices\n");
+		return -EINVAL;
+	}
+
 	disable_irq(client->irq);
=20
 	if (!tsdata->raw_buffer) {
@@ -524,9 +530,6 @@ static int edt_ft5x06_factory_mode(struct edt_ft5x06_ts=
_data *tsdata)
 	}
=20
 	/* mode register is 0x3c when in the work mode */
-	if (tsdata->version !=3D EDT_M06)
-		goto m09_out;
-
 	error =3D edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
 	if (error) {
 		dev_err(&client->dev,
@@ -559,11 +562,6 @@ err_out:
 	enable_irq(client->irq);
=20
 	return error;
-
-m09_out:
-	dev_err(&client->dev, "No factory mode support for M09/M12/GENERIC_FT\n")=
;
-	return -EINVAL;
-
 }
=20
 static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
--=20
2.15.1
