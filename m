Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482303-2-1210185376443880380
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
    t=1521482303; b=JotESarLPtLwpubUsniDmktJ7TeVLGpJMizpiT8BV7DeO3k
    E/QEMSDhOyhZbXMvhZHxIamRr5feGMPxCMIrQoUD8gi3dzR8WRgVx+xdSYxCILZq
    saQNAtlB1iHeX/ONLh+gBfFBssQVnGVsGEb7He4F81MC1QMMmj4D4T+s8V1Xs/xB
    VVDCdFQWn/Rdr7JQxOVowF0jxWANR2NiaIDrOkaWymlh+VmsCbWI7z2nBXH+ytLc
    KgWTN9eWwcXzy3PYnUTNESYioafVjyp3DMn6kTxQ2BQs52WWhg3LuSz1zp8dxsEW
    wNqyWj61X0MC2dPPqYdXrTufsSV9+e1oofz0K8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482303; bh=p/+hBP
    livUVwA1jbmntnZkDM5WrRKJBWBgCjHJ7md0E=; b=WdXenFjooHLRI+Scs0yoNi
    KaJF5Fa46QgElYrAHRivYEGiDIdjXSCvlc93SdkeouKwF+j2GqG2j4bweBSMI67E
    lbtSMidI1q84jP43wa3Y+8f22+HUBfyPaoU/f2IfRtjDyDb4n8xJhb+OMO6gSNfq
    0aMEV6JDxLJsmmPqPorXyX5r0/PeDpih7EpKGSasYO2eMnIKlki+55w5OZrKDzf9
    7mCbh28LzmVUmrax8phghozMSaWYMMCbau/EvgxkIxcUyFRUIyqt9XGXHC7Tk2yF
    uEGLphm8RCmKmOttPkOYADCe7R1rwrzf09R2+9y8ZFDwUS5ms4rUgJpLwzZZVS4Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jCy9ZaIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvfeenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jCy9ZaIN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvfeenucevlhhushhtvghrufhiiigvpedvtd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968239AbeCSR5m (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:57:42 -0400
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:9760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964901AbeCSQEi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 212/281] cxl: Unlock on error in probe
Thread-Topic: [PATCH AUTOSEL for 4.9 212/281] cxl: Unlock on error in probe
Thread-Index: AQHTv5ufyiQn89hzgECEjUH2SFK+2Q==
Date: Mon, 19 Mar 2018 16:02:04 +0000
Message-ID: <20180319155742.13731-212-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:c7+EOjPMWTpyhST81YcIpsH9eLEmt42DftvpQj1RGttMh3kJAFx4yGD+f7UWnHpNQpfMj5rzKBQSDGEDB4agagbTvi2A12XWNx0qPJrnU8UQOfTzIOr+M2s0eKfhFsfqkT9UlGWVSOzU8UhaQfvV//NpqBkpX+0pO2Ak75B97YWDHjC3YtnDxHUgHBCpW2/MAxKxyjGNnj3MGRR9mEYiOaEFmoLZehwvIQjxlpyAnilpQbGg5cos6mE+rj48q88I;20:GCInsKm0im0dZSFSlEmg3JsrthUFWJQrbd0rxr2ZXJ6nvcrOcyoA9eHjc3w8bpFv5KuFLgCvejtVW30fsZJQJkXb8LE5e5LMq3oV+rlb4xYI5GaFPr6azc69aDTAPJBMHy2iUvuNSA2ieyomuJedH12iit1F5SQwKMWNvhNrr3s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c47da10b-d932-4924-fcc1-08d58db31bbe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1077E8B0D2855E22FC09FBB1FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Mr7AGQs/aC3RG//Jqg98JA9pPPrECZCjZThObJna8Imr4c3LnNqE9iOb+JfwTJjOKG8pa56m7BC+m2tJarBc5sLZGeYXnPdqLBOZXGVlgOTgg7K6L6mXI3JVlKSMJOROeAYgpVspnSpyeR7F1iYOZf4WBhuUXgRg/Cglb2654g2O5Xytix4KitrqEBtmUD6sYUTFYRl7XdTC6ltpjV319ULBsY2ec7U6SgHVTzqrF7LVXf1RG2BbzYa3sJEaVnSysNGjBINMdUc6MCbp0o6EUSUI10NEWjLVTY0yLdAUqC4ZVWRXTMV95CRwUA0kn20Ne+Zlbn0GJ8y9ng/BVaW67g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47da10b-d932-4924-fcc1-08d58db31bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:04.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 58d876fa7181f2f393190c1d32c056b5a9d34aa2 ]

We should unlock if get_cxl_adapter() fails.

Fixes: 594ff7d067ca ("cxl: Support to flash a new image on the adapter from=
 a guest")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/cxl/flash.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index c63d61e17d56..381a9a166f93 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -401,8 +401,10 @@ static int device_open(struct inode *inode, struct fil=
e *file)
 	if (down_interruptible(&sem) !=3D 0)
 		return -EPERM;
=20
-	if (!(adapter =3D get_cxl_adapter(adapter_num)))
-		return -ENODEV;
+	if (!(adapter =3D get_cxl_adapter(adapter_num))) {
+		rc =3D -ENODEV;
+		goto err_unlock;
+	}
=20
 	file->private_data =3D adapter;
 	continue_token =3D 0;
@@ -446,6 +448,8 @@ static int device_open(struct inode *inode, struct file=
 *file)
 		free_page((unsigned long) le);
 err:
 	put_device(&adapter->dev);
+err_unlock:
+	up(&sem);
=20
 	return rc;
 }
--=20
2.14.1
