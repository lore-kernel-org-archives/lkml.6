Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492407-2-13978108503661462324
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
    t=1520492406; b=fNTAORXfLoynQf6E1Ud9y2YPpGRlwoTid10IecQQbYcPqgc
    RngX1OeF75IP7+BOmti4OTCE8IWhvGy13ZLr17h3Ho25fGo7anQuJdSwxyIDJhZj
    pXcAf/zYHVyjl41wA3LPoPE3v6HZc4I3dCExo8+NBY2R84ZKa5rRA31jWgHfSTk4
    AZNmQZZTJoySYRSh6jegH1ymXVkspkkfxAyUFEevjYFW0faeoWuMZynkjCgQzqrf
    oCgVHy2Q4LTpyr6Q8L65Hfc0baiZPZGahBqMhvKKCxhWK4Q+07SXjvYSdR7+/2QG
    ohsV7rDAoVpZ+IDTD1uRNjFMt4t387ZVaHzzbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492406; bh=OnIfcZ
    HYUwzu+6bgEaeeTN5PQ1u4RCUKI3N34Q/nQuE=; b=Wml/EXeQIZ6dDzL9jRqDDv
    j7QvnMXmdwZeUS1OeCAfdJNeAgUkgk0IdR+rIR3KI2WHXZQkd02/fLbfPKIHVpqj
    wKuOxfI0xPAS6/uCfWmPlGdMFXlsqgusXFyXvRAfhVkvqMRDTpftCDSDSWMYh9xA
    22crO8NxnQn4YyqqYjz+MGREKZ3M5ZD033n/NGhwp6P7n81v4X4dkiQuWFjUVwwb
    duphUqEoMFJfLW0B2G+gb4wjIn7drs5togkCvHnququoBIpv1E/wUuMByj+5RTIN
    lmEUuCVq6AXBo5vXD0wLHzOShAUi+mk5LUP8WjlOF9wwCPHF+oykUXFx7OpTya2Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aEwwg0SS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aEwwg0SS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935066AbeCHHAE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:00:04 -0500
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:4352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934989AbeCHE5U (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 54/78] PCI: endpoint: Fix
 find_first_zero_bit() usage
Thread-Topic: [PATCH AUTOSEL for 4.15 54/78] PCI: endpoint: Fix
 find_first_zero_bit() usage
Thread-Index: AQHTtpnP7U6UGCo0xUiB0vYuxl4fkg==
Date: Thu, 8 Mar 2018 04:56:25 +0000
Message-ID: <20180308045525.7662-54-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:kSAMLQ6aIZAljWvaqzBOWfqcovBy1r6fT2M5o9v+u0BkxnQBoG6fUmP73HS3443vgwPiOl+Q2EvJLm7fk8id1yVHTdFL4PtfnbtWJhZLkV2SKL9u+i1yxEm5JZ1tTqW1dxfjdmaEOoljIM9lpSv7F+KRWLYpLz5/ECXxaiL2psOqMAUIqFObqG3YSuJgaRs/1+jvAtQbwrd32vjSogjpN8REuJligW9L5cbHzXAU22/cpH7WK32xXmcUr3W0sZBK;20:tKfCiS3BuUs21aYNZFVF4tMBIveqybL2b9ljpuy/MeIiNKzfnSUmxjnzUDtEAe/D+WEvBgbDGiKzcMgn6vsDs+GmoDhLP1p6uuRDqlC8iV6GX/JJ4ZVBMNWeg78pUAOr0ZZxA4z9Gm3VqtqhsMGCWwJ0V9REW5KC8ZM2q9Jiato=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5ca26fd-aca9-45af-3a77-08d584b10f7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032E003AB78669BC763EF66FBDF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(97736004)(36756003)(8936002)(105586002)(2950100002)(2501003)(6666003)(186003)(8676002)(5250100002)(86362001)(2900100001)(3846002)(5660300001)(6116002)(10090500001)(2906002)(7736002)(22452003)(81156014)(26005)(6506007)(1076002)(102836004)(59450400001)(81166006)(305945005)(3280700002)(72206003)(110136005)(86612001)(54906003)(99286004)(10290500003)(316002)(107886003)(4326008)(25786009)(68736007)(6486002)(6436002)(6512007)(53936002)(76176011)(66066001)(3660700001)(478600001)(14454004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LLIb2a6rNEeHsiHLEoWehbbAS/L/kDLBTaGbYywOhcgWiOIvGi4B+ZeAYBvaRU3Uugm5+k/sU69Y1GyTTX9uHzx1C5W3kAcpsj6UCYfLC1ejZg7VFrZdHcn+YSnJ/SMhgNAXpkqIMXZ77GSJ6p6rhG7WQe5126PrPUmj4gGPPw7uYfM7oOvPQ/Eos0YfvqkNMudBISj2gr2oTm8mKxFBSqcUd/EIl89nQi/6hu+zUTTdi+b/ZURuDOG86KQ5+D4yp7uaRlpkqknTSDQl9OnBD4oeZ2fDc+winkwurTa78rSDT8gCSixbrqLjyZsspyAb4+vY1MSxoTjftNU3LCcMkg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ca26fd-aca9-45af-3a77-08d584b10f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:25.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 4f74386c1ced..5508cd32afcd 100644
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
