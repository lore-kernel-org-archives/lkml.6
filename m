Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87834213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dIrNN0GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87834213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeGLMGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:06:20 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:43904
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeGLMGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/P6kSOMtqa1L66c5A7xFxoP133pko7hoeKQGwkwgJM=;
 b=dIrNN0GGl7yDe3TTeezbudy23WawKZzxsIb9fJIOrplgsLioKU5nbS+QHHW7K6pCV41j8ZdMAFWLEb+JLL7yIJWrbLGx3QPmewJsJkF/pUPq7NvJfb49tWVYnq/XVrzQLYkN6ISkEKWYaghMBYD6PeRGvOzMO01rMqAKuK4LXCc=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB4244.namprd07.prod.outlook.com (52.135.242.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 11:57:02 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::dbc:2355:dd0a:fe48%4]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 11:57:02 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v2 0/2] scsi: ufs: Add UFS platform driver for Cadence UFS
Thread-Topic: [PATCH v2 0/2] scsi: ufs: Add UFS platform driver for Cadence
 UFS
Thread-Index: AQHUGddxk/LnVZwk0UKevuMJWJ8RZw==
Date:   Thu, 12 Jul 2018 11:57:02 +0000
Message-ID: <EDC29990-235B-4F52-AE46-2F9EA0603F64@cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4244;7:89852ic8Wji8l8JnOAu/af+KEYEmgZP7ajYCgi30IH8mFdRnmpsQfAzQJV+OATYyIXohDUp+QObq1r28psM6Vv+Wv1yQq01ilzOJTU/rD8XKGmMMaCrn7GayAGKg8i1LBdPgUfTqN3BpKoqWw7tH9tFAvVC8fLQS5tiZNSeHUuYRiRweLjjgskk7cbHhsXFx7g/Whh9j8Iz9xaWqK5kuA7IvkK3ECY7v84H/EYLG2FFNcYaydAe6yBy6wn1tD0Jb;20:ZtGdnYDZSHKh2ET4pTeFf6rb5npZGw2zyDPBifvnlXonrc7iocswL06ol/UDfO0WQ6fnNPW2dqftnjxoODYNWaNOMzHtoak2zJmrjF4O296qFSq8354w/JW2jmPvgGkav3JLxptkm2Fx2DR++SKP0+C1HW9mRuJyHN0cvGlUUyUQRwnuRmsO6E4WwobobFEMWlOPIsM7oe2e3T/tFJ6Us8P+YIQniVL16kD5fDmycLpyCk7xPjKddB64ijsHtJC5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d71f13b7-fbb2-4611-b389-08d5e7ee947e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4244;
x-ms-traffictypediagnostic: BN7PR07MB4244:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-microsoft-antispam-prvs: <BN7PR07MB4244AA16CC04DFFD6A148D79D0590@BN7PR07MB4244.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4244;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4244;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(36092001)(189003)(199004)(39060400002)(186003)(26005)(6512007)(6506007)(4326008)(6436002)(25786009)(6486002)(99286004)(110136005)(54906003)(2906002)(33656002)(97736004)(2201001)(316002)(66066001)(86362001)(5660300001)(3846002)(2501003)(256004)(5250100002)(105586002)(106356001)(36756003)(83716003)(82746002)(6116002)(7736002)(305945005)(8676002)(81156014)(8936002)(81166006)(478600001)(2900100001)(53936002)(102836004)(14454004)(2616005)(476003)(486006)(68736007)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4244;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /i3t9NzK7Q/y0WUkEt0UGYa8I0Ilp6DrWcTMOASzXbQY9sW38tIUZXzF1eCmnKw5zi0F6bMGJhzeiFifyzoOV3r9AumUt97T0Wmk7Hhf66Xp++tx0yJtA6Qvf3XC98k5raBfpWIvOBvlkHbP8FEWlFyhRbFa6k+CoU5L4YPhqKLrSM71O3UpN2FVZN3F6/PGny8DmPVOM/0e8Sax+LCvcOrOwuw1S2s3nEnVLyeZ5zbwaYC+4RqH9QMZoOZ+GlszigjYhqyELWSyxBEXQnt/RyvJq5U1UpNGjbpPWwKYGmU7YWvg0murph3DX/K84R3Zdn9GVXuDWCXfWuWp3ZtZ89wsm1jAUkBK3aRN1n579Ew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB3AB15AA3894E4CB26CB4E89F1D45C8@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71f13b7-fbb2-4611-b389-08d5e7ee947e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 11:57:02.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence UFS controller.
It was verified on Cadence Palladium emulation platform.

Changes since V1:
	Renamed the documentation file name to cdns,ufshc.txt.
	Updated interrupt and register mapping.
	Added license information.
	Added a missing PHY clock.

Jan Kotas (2):
  dt-bindings: ufs: Add UFS platform driver for Cadence UFS
  scsi: ufs: Add UFS platform driver for Cadence UFS

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |  31 +++++
 drivers/scsi/ufs/Kconfig                           |   8 ++
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/cdns-pltfrm.c                     | 149 +++++++++++++++++=
++++
 4 files changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c

--=20
1.9.0

