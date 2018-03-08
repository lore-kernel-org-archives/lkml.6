Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491255-2-17218140371400056205
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
    t=1520491254; b=oHQOTxMfd7W8SyiIhKN6uqZcDkfOXhuHoS+mjq7XSDYeXNX
    sKAuPWtx3qcdGJTAqsqovVEeOihnMad2anRFXQxjRR5ZOZvpgBdZSlRA3JliRCuA
    RmznQ07tx+tyLBj65dCC+eFKYl3BABqy0Dc8okbCbs3U/u/arHdw9bt2JyKcZX9g
    S0ez4oMStuTyPz/CTk2z3jaernMRyPbTrNXnieE4jqAXa5ztsD2qiZlbiWMjlhr1
    hXN0cwAX0IOYYsk4B44K9rUt3msXLa5pGWMqGGfLUzsAvC2EJ24rwGkCpLxqexBW
    8n3/3yR0tFEcpm4Xcamga8eSORr0fqhlVzgwX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491254; bh=wy1dj2
    uCW4bMNggyVlCxM8KuvBCUUZQOm/qxDp1Uio0=; b=auZDFuhh2IeEOh7CfONu3h
    VZwFN7s1aP5Ew1Qyq8PyjFkYTjZZWt9gFOrNQ9wX0YtDw8bXcvKiax9po6evfHS4
    TMyeC+AqlLQwQeL01erTjSGWR2oYDkHp8wo0gQ21TuPhbsiH2I1fju1wjpjta/Rv
    LXnaXc8EOa37rpAdGprnwfWFM+NOq9dtpuAJlydWapBHGIWDznw3Hsu0fgtPe8ZG
    sxQ3+pf9HqkxVp9yaHZzariVO/YCPMmOSypY4r2TkTWIQ+4e3uuvu8+iJgwFV4AQ
    qdp8eSGRiXB1bcIDjQZHiN4KVNarwEe+ZMuYlTJrNLiNYMsRsH1ipOErqVSZqJ4w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eRGAMVv2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eRGAMVv2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755364AbeCHGkk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:40:40 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965301AbeCHE7J (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 47/67] PCI: endpoint: Fix
 find_first_zero_bit() usage
Thread-Topic: [PATCH AUTOSEL for 4.14 47/67] PCI: endpoint: Fix
 find_first_zero_bit() usage
Thread-Index: AQHTtpoD4AsLVTHbzE2OVZKeiAncFg==
Date: Thu, 8 Mar 2018 04:57:52 +0000
Message-ID: <20180308045641.7814-47-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:IJ8o7ca/D4YaekeMh1xb8+zHVI8VAURyaYM58roWIc89BtK2FqDCZ5TJGRSKWI/jFYl9CDFM7Pomq/LLrbPm6oPo5Fx718Drq5OdqPP7jhHAPIrLqG2o5+o17xUZuxqd+VtjZVIhgGRpT8+Y1GAJuWXxy9DtkDbc6j2QEpFTOEPxD7HcUM/NV+zRPdmM+CG6qpsGN7en0PxVdv1EaoqkY78yr3OCx9obk5dhPGJ3Pa5oJmqQYym8ub4eTqqpyrKt;20:7WnyC5pBjdQeshrYaz+bSz79nTkPUZZpqDIBgnXkAAlRu0eb668021vUHrMDJDhr2nscSyZP+8JVUEAUIQOnD56LeO6i7Upzjz9vhttrSK17ugL40NLbXi3b7ffgIUGNc1GLIVfVEIWCFPbc96HeoucB1/3g22YAf8hEGoL4Bfk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 929a92dd-9e55-4bf5-1146-08d584b15255
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101514D50BF417FA404F2BE2FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: krkCR+L1FGsso4lILRAdYMsYQ/XS5QNxc83chbQ6P802maNTjFUO6bNTDyI1PbvfkedXhU5GjQ++JEKS66e6UsNHml6kWbfBeclE0Kuw2hgdeJlKpkqUsii747A6xfc0kGlzj2h9dV+CJApP5UkgacmgdmJnaTt0Sg4qrQp+iOftmB2M3jNq7nw6QKesg9Doh5UtOxEZDMzkDwdDPIGG+PV3tctkB9NrrL8JE4+S6hC1ZFRMvuXLqxThqc51ojFAZ0yvcCZe2iHDFQLNRpzjZ2dYEbhGoi/HF2O3ECNYSRIlAM7XHZN0fscHLnA9SkCzecrdPKtUSPxEjzz8cZmciA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929a92dd-9e55-4bf5-1146-08d584b15255
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:52.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

[ Upstream commit 35ad61921f495ee14915d185de79478c1737b4da ]

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
rather than sizeof() and add missing find_first_zero_bit() return
handling.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuri=
ng EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-e=
p-cfs.c
index 424fdd6ed1ca..16cec66b1d0b 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -109,7 +109,10 @@ static int pci_epc_epf_link(struct config_item *epc_it=
em,
 		goto err_add_epf;
=20
 	func_no =3D find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+				      BITS_PER_LONG);
+	if (func_no >=3D BITS_PER_LONG)
+		return -EINVAL;
+
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no =3D func_no;
=20
--=20
2.14.1
