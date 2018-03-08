Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520489999-2-5991449581612169251
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
    t=1520489999; b=o5Llcf75PGeNykx3vdnZPRrV2BsO8Q45uj5n8HEx+x/0hmL
    VbrVMtsxtwKcq97DenkXujuV+20rIZFAEQn7w+UVZIIZtTK2t6gSTQhZszgFLPaw
    T/Oi/+RRrLYASRx0/NRDGMv5PzX43c4ahobJygYCxN5Zgv9G/n3ve+9NZInoMt8F
    7e9tHCLZM7oUbr+3Lo2dvinhRiIOvIJ2uxxksNg1XKErejBcIPRxZRfmGIih/H6M
    lnvqVEuuhOgWti2wBpkk2RdUDlkRCIq0qMpzm8kHVqiFF0LlKrvB1RFMP/jb1GY9
    D70aNHKLWUue02oSWVzP4APuFSPx1soevEi00PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489999; bh=ctOIma
    F4eK1TGOC/j2h9OMaEeQwcBPmhmoczpMpx28k=; b=WOQupJLO81ugm7R2m6Z4lB
    t972wlNItjZiPedMHwN5RbbOgpamhT5P/qBW6O0+TJnvH+8MraX4IxTQjpuguS50
    tUDrjETQyFp2oOo0FllWSjDgGC6iUJceJjRxZw/pF3tqEe2YeIKY1SeS8CFm4LSZ
    BpxKBCwlfzVQf4L5opZGFOrtQgSmbxmt/AKMzPfM+6X4vk/9P1aWqJ1hVsqtbEC3
    pKkNo0lMuWgvcfrkEiUcfR1kaxjgkC7s6izmOqhufVBYaVWkZ0AGVX2RoBamE9pc
    fpAtRNvIUdiinLlsVEbS8LMBeWdN21Q7Uez92IKUtaUTPhb2cBzqe4htM9W5PAHw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bwac0Srw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Bwac0Srw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965585AbeCHFA6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:58 -0500
Received: from mail-bl2nam02on0102.outbound.protection.outlook.com ([104.47.38.102]:47872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965209AbeCHFA4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 043/190] spi: dw: Disable clock after
 unregistering the host
Thread-Topic: [PATCH AUTOSEL for 4.9 043/190] spi: dw: Disable clock after
 unregistering the host
Thread-Index: AQHTtpoyBFUuW9KZ+Um4NdTQBEUIhg==
Date: Thu, 8 Mar 2018 04:59:10 +0000
Message-ID: <20180308045810.8041-43-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:meeDSvsUjV94MNhHBUKhx5ZykmYBGHufg98lwKPP+FITpm2bhiME76pI/aIzwis20Z1g++O2kGaZZImhcqPLmz1bWg2goPs+096gWFsv/3vg73KzYn3nVWFErv26G+4eLRkyEQ6NottGZiQoScx1VO+DZzXrf4M3d6n6ZWO9J6tq3AJN+NwdiDsBRkFeXkODTqGDl/Ya4VE9/Tvr3akzUKc/cLDv4h6VjelrZ/yJHc1gmN72XN+XfTeAG61g93UF;20:s7Ihvl0kVS44BujPy2PKVgQd3hQdYUYuZ4JSEFBmryK2LHOecCESWHL24KGK1f1YCD734OgmjRi07kcQ5h5MTNsR57v2Jbdwk6xdkaNphrIZXK32WvzpgpEmwiKtBmsLU7lTrwSb6+MpteuBHjnL565rwTgJAyCIM4qz2BdMDTE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b8ccd35-d140-4692-bdb6-08d584b18add
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112F442F5F0D3C764C1D52AFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 81cJjszUW4Yi9akcfaSuMdXJDfsFsuNdliWPGJwWclou9Q1DTxDJX17JtkKEINquLRDGTjiAnT4RjjjN0Y/qK2oEZns9Wc/oFjlwptykZVctrbmcUuuFVO0gOvxnFbvTcSNjsdR5TQ+gVV3SGIpX8iRlnWLcptmiSoTcQnQNtemc91FYwS9QZWNvfEWOsqYNBYtoNhGGsfpo0cTM0H4vE8Bu1tgPhmg9nphx8RLzJQSrcTjyf5ZUD/Ws3fc8wPwtHhofxOhQD9pMiPPkEdu0f5pqM2wkO9kSdR3QJdx6Ix8VDVM8sSiFmcsH1i+cda8v1BlNPQuEloLoamEmTwj1eA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8ccd35-d140-4692-bdb6-08d584b18add
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:10.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marek Vasut <marex@denx.de>

[ Upstream commit 400c18e3dc86e04ef5afec9b86a8586ca629b9e9 ]

The dw_mmio driver disables the block clock before unregistering
the host. The code unregistering the host may access the SPI block
registers. If register access happens with block clock disabled,
this may lead to a bus hang. Disable the clock after unregistering
the host to prevent such situation.

This bug was observed on Altera Cyclone V SoC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/spi/spi-dw-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 447497e9124c..d25cc4037e23 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -115,8 +115,8 @@ static int dw_spi_mmio_remove(struct platform_device *p=
dev)
 {
 	struct dw_spi_mmio *dwsmmio =3D platform_get_drvdata(pdev);
=20
-	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->clk);
=20
 	return 0;
 }
--=20
2.14.1
