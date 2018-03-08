Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486543-2-1830532946737320824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486542; b=Uf9jzSyGoGlTQSecVfDtRUkacmPaZB0889zdq+pW2j3+WgP
    aSWC48HM70gFQOtGL5hg5wgZ2hh2QUDLG+NFAEX2tueuiVzl34q4x4h3JQPJkVDv
    HIj43VMu/kLEtrd9xPNVY9HQncrkgRZR3KZZqcch19oFMRvNvBtHCO9nWkgKAxgQ
    OhQcDMl81ve7BwoKs0DpRcmYwQu8LOSN2ZUzZqdj/3arfSWVCvGEaU9IjXjnpG50
    1Xbopx5muy+aPjrQxmWVKk9AQ4zhku8VzafzRJSLIRjSVel4K/8KiWq6BTyAzDaM
    cbTzMuLLnaeLajRLVFmXZ64hgYbter6OiDcDvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486542; bh=hfzRoK
    5DqD+ja3EOraHFaWDWfDmG4x/4Y5zSyenHtDs=; b=AOSuT+o4bDqixGYObSEHsm
    NHwo9VuLJO8XdtpYot7wYu7WWOKweQEAi2hA8GbSCcjl+D862qM0JBfiMVyTpkGo
    f7VcqJzb+YKkbmSVz9GzstZhgAYZ/iSUxdE7COzO768gJtJt7Dvx143nZD18XWQN
    Q6arYcRqoS0u+9pQ/R5rprRnFz0gZDQTO+yNSiVVKEaMj75Uxkzdio6N21ELebG9
    uRuPen96gaYPSPrvg/JzyRnmgEVCRh3yDo5MO13AOOOV/V4g/+Pj+DQOi/mMjUYN
    4EI//jfDae0tT+XQPhuCLJJ1TfkOx2nq0UvCj9wJPC+MEkd9EDsPajkiVimdVdGQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EtFl6GoT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EtFl6GoT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966116AbeCHFWF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:22:05 -0500
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:48480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966683AbeCHFIF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Santeri Toivonen <santeri.toivonen@vatsul.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 08/53] platform/x86: asus-nb-wmi: Add wapf4
 quirk for the X302UA
Thread-Topic: [PATCH AUTOSEL for 3.18 08/53] platform/x86: asus-nb-wmi: Add
 wapf4 quirk for the X302UA
Thread-Index: AQHTtprAYNnZC/oLvk2JBIKMWMAhdw==
Date: Thu, 8 Mar 2018 05:03:09 +0000
Message-ID: <20180308050230.8876-8-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:V47ImZYcTObrPD9PRrksqQU3/cY34ctSL1eSX63JVxTd3zrmGn/mTlR4+35VLvgvjdWuwTJOnNPkruVff7DwD8GQXtTYvV5kVSE9BvenKPa1zfYUfSSPwi96zBGH719aPrnwyzr1EswkQII61BzXNTFvPPIjCwrjMGGshS8lqQX5YgaKHrHxmMzB2aCzmO7Mk2GvJ46jz6MRfENbXhaDs7VveD3Ny5XI0hB1VU4hXxBhhxHrQEO3gnC99Zh8YVGS;20:NqpuBr/g4MFUH6pWASIu965UUymAI+rjR0b/ggLtNjVcBCcKua1mOooWnTX82nzzpH+wraQvhAMdWxoHDtcJM4xzqhuSK0cVW143VRnzKkAPuQ/AmMVn8QBHLT0y4jpgKkWxH2RgLWSBopdzaAnLDoqegT1Gt+suF3TyUc50SDw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb0ff801-8917-443e-d616-08d584b29287
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB087147552B9E6B46D2819785FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jXMyFfVfBsCUJk9J16bj8VyIR5Ni9gpT4Xe8Eqg8B6gsibJi6/Dcz230n1NAj1+zFpqQjJ6RpBDES7rwLRn6q2JkYgQn0HbJEHliUDXJKny+xgeDx09FONIHZFskcTi8XtaXIZp2G/oa6aNTzXWF8s9trU/YbNEGShfhm+tRFR6jrv47d6ENEnUGaqdLT+WCkGXD4UcZjtIiUJVbTBputuJG/LjHpMqOj3Rc5AVZcvmNhi32lHt1FMzN6jXDU2M6aoiFC9ZoMOF/3xIT1apFLVi2wTBlOmEl9y/YEbse3d2jL5VvfRoQn3gvDArvSrg8rfI8Xn8hzMOQQCU+xHEu8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0ff801-8917-443e-d616-08d584b29287
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:09.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Santeri Toivonen <santeri.toivonen@vatsul.com>

[ Upstream commit f35823619db8bbaa2afea8705f239c3cecb9d22f ]

Asus laptop X302UA starts up with Wi-Fi disabled,
without a way to enable it. Set wapf=3D4 to fix the problem.

Signed-off-by: Santeri Toivonen <santeri.toivonen@vatsul.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus=
-nb-wmi.c
index abdaed34c728..5ea4c5a72a66 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -99,6 +99,15 @@ static const struct dmi_system_id asus_quirks[] =3D {
 		 */
 		.driver_data =3D &quirk_asus_wapf4,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "ASUSTeK COMPUTER INC. X302UA",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X302UA"),
+		},
+		.driver_data =3D &quirk_asus_wapf4,
+	},
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "ASUSTeK COMPUTER INC. X401U",
--=20
2.14.1
