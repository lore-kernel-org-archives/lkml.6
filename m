Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491212-2-17662028512483951432
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
    t=1520491211; b=GnJ3lp5zY+/fc7S3V5jOtL7PbX4CcEwTeZx/GDTV5bGr+H3
    GG/sro8+xQS96D/lHtooCIMM/zXcErrwleSyXWGyA6jF/SxGvWE3HaotTkILhMBM
    yMpnkt+AYRw7axCPrSt6pFKAOssa0LKkA40iYlxgaZj7Hoj2ti2q9XM/SWxS3Oyo
    1vU9OTLcXlQoi/jUG8jvVKllcdtxw7UU0f4MnQ/UoO8p9o6Z+DWXe8mOmYUnEuCs
    K8T2rqcxSfwOoeJ9A68z/SgtJbdhQzpef1Op4FVRpk81yirHV7Bg/DcBJLGr2z1v
    sYDoLfMdI1IfkziY8EM+768wIeLaPu9lkO8Fmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491211; bh=LslsYJ
    1g8cVmDjos65r5rKHvjsRX3Kgs7yx4DRrLDBU=; b=uHaP33oYNzYGcOnCyh+Tfm
    G2fKxIelpNBM9DInaPBuChHfuLzY2nu7/PNtbmwwhE20aFay3SOb0zU7GGMqMG59
    EytQzzPX6ls+VsrlOFOzWSiBezXoDaOgZIPWKl18t3s3Xp5h5cLGcw76zo/vF+sz
    YwaqyrcIkoEhRJgFN09kmBOUzUpuZ6kzEx3dHn7AsEd6K0ya4bttK2K39UDSj5My
    bLAra2cK9w2zQBGFVsovozWZ7HOA2zO6dOMogY06FyKJLhu6XTeHZ2bUd5c6IcB2
    7fYN0vBRBUHz3OfT2+1FsCSsvp530HG2kd4w7WH/8mDySTNOlhseO6nDZv6OdCvw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTQ6mNGa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZTQ6mNGa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755475AbeCHGkI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:40:08 -0500
Received: from mail-sn1nam01on0106.outbound.protection.outlook.com ([104.47.32.106]:14491
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965311AbeCHE7J (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 48/67] PCI: rcar: Handle
 rcar_pcie_parse_request_of_pci_ranges() failures
Thread-Topic: [PATCH AUTOSEL for 4.14 48/67] PCI: rcar: Handle
 rcar_pcie_parse_request_of_pci_ranges() failures
Thread-Index: AQHTtpoDyqETKx57kk6K9u5L3g1rfA==
Date: Thu, 8 Mar 2018 04:57:52 +0000
Message-ID: <20180308045641.7814-48-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:4v1UYP9s2/uxGD4PErhE6AwzOPVrxqnrJnLH3XBBM39+St2Kw2vB1QVWYtIEz5sajLfIJAu8kcePEVT9bTdlKFSOBPmE1gjT9GM9GuokfgohkAGhp4tapnyW/WETGhIpnVwH23nzSSCJuYcHMCJcveNS+6UbsiF82B08fAqL5w66o+H5N2h3qZpEZGlC0I8cACQJ34E2gu5+ZwVUF1ytMgy71qP29Pb68Naw8XRT/Bm8XEGcEV2dalD7abMzYpNP;20:pOtZ7YpZ81qYZ1Nes9xAanY/Oo2uG4/oHEofjVsk4NV9pUhcD3kkBKTodDh3TMZ2Oi79FS2kHBP+KvDWYLklmGdzn4YnpkVCkn5nGo95lopAVmLJ0Wy8la7TVelS3LIqMPhlsx+HG9vxZfc/02GIVPOEpGs0wuPp8H5WPCjMSMA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb715a45-5d2f-4207-e684-08d584b15289
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10151D1907F4BE5EF0558024FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AP8mPPrnMzaqkLH1lsr+RZPEDpksWapcCme6r6lG3kZztErTJ0xX3alSbpiX8+R/fniWMekS1xSH1Hjz15VwlM4GYordf0G4FoWck8Cgew4oKfg5F8KVAsHb+b+1RHwz+psvLn9kZIQhRxlkglvm/ZBTEEjVRaYaQOhplPPA9KzLbrEURizlKmFP1pdIE/t2U241x/TfGiuxjABz6H71r2l9MlwQxP4xT1/xeS+49wbpBmHSc3dw1Qy+Cyj5BKr8Wq7U0oTy46p33m/lunnHD4mC7aV+dJbR6eDZFO/usOz6FEkim/66IHmh0JyRkGfmLD5ENbYz9JgSYeiUqGJO0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb715a45-5d2f-4207-e684-08d584b15289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:52.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 83c75ddd816e979802bd244ad494139f28152921 ]

rcar_pcie_parse_request_of_pci_ranges() can fail and return an error
code, but this is not checked nor handled.

Fix this by adding the missing error handling.

Fixes: 5d2917d469faab72 ("PCI: rcar: Convert to DT resource parsing API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/host/pcie-rcar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index f09ff4789bb5..8f44a7d14bff 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1141,7 +1141,9 @@ static int rcar_pcie_probe(struct platform_device *pd=
ev)
=20
 	INIT_LIST_HEAD(&pcie->resources);
=20
-	rcar_pcie_parse_request_of_pci_ranges(pcie);
+	err =3D rcar_pcie_parse_request_of_pci_ranges(pcie);
+	if (err)
+		goto err_free_bridge;
=20
 	err =3D rcar_pcie_get_resources(pcie);
 	if (err < 0) {
@@ -1196,6 +1198,7 @@ static int rcar_pcie_probe(struct platform_device *pd=
ev)
=20
 err_free_resource_list:
 	pci_free_resource_list(&pcie->resources);
+err_free_bridge:
 	pci_free_host_bridge(bridge);
=20
 	return err;
--=20
2.14.1
