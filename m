Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85471C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEF621D69
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uv5FeoRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEF621D69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeHIPtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:49:41 -0400
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:46823
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730419AbeHIPtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5rQYCM0d18bPwByiibr7qVvc2viLhcmltu3Ck1g2So=;
 b=Uv5FeoRO6Kk6l2EaQBukvgusBxYz2yVebCSZeEcsT+CyQgx0rwBXpwCEThZgWtaXdXODz+WYnGSXIY2uwX72dfSYATN05byVbfxoWQEyGlhI3EQDRzPn4xXglY+Be4HjYxS7avEV29fTjNgwN5WhBWNi5WNPdRNYCmrJZYG5lwM=
Received: from BN7PR07MB4676.namprd07.prod.outlook.com (52.135.249.153) by
 BN7PR07MB5121.namprd07.prod.outlook.com (20.176.27.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Thu, 9 Aug 2018 13:24:44 +0000
Received: from BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208]) by BN7PR07MB4676.namprd07.prod.outlook.com
 ([fe80::e94b:eb6e:2766:3208%3]) with mapi id 15.20.1017.019; Thu, 9 Aug 2018
 13:24:44 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: [PATCH v3 0/2] scsi: ufs: Add UFS platform driver and bindings for
 Cadence UFS
Thread-Topic: [PATCH v3 0/2] scsi: ufs: Add UFS platform driver and bindings
 for Cadence UFS
Thread-Index: AQHUL+RWfRq2hKddDki9emkp+1y3bw==
Date:   Thu, 9 Aug 2018 13:24:44 +0000
Message-ID: <1EAD7741-4CEF-4E23-9A3F-918F07B52E35@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jank@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB5121;20:E/TTn6Bhq5mv1ggwEZ/aZGJgX8GLs7gXeEzS0gHczGtVFBi4CbL5Q3mn9IO4oP0gPvpPcNYYYj0OZ6wUc26yZgp9q5aYWC1DcZTzY44Wz+fVZP9zwPlksf1f0vanGYWEvmNv/Ofwfydbg6yPy+XgphhyDbCQ+EYyXL2+nbcUGtsUsW9GofAqDAuYbhFkfMQcqa3dhF3Wtrs4D5L/Mc97CDc+yDgFzdpPT+uZlhPXXCTZgTVZkJeRmvJAjoA9Ujx+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f4afa66-2608-4163-5da1-08d5fdfb78af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB5121;
x-ms-traffictypediagnostic: BN7PR07MB5121:
x-microsoft-antispam-prvs: <BN7PR07MB5121299C04A2BF89B11E1640D0250@BN7PR07MB5121.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB5121;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB5121;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(376002)(136003)(36092001)(199004)(189003)(68736007)(97736004)(26005)(2201001)(83716003)(5660300001)(14454004)(33656002)(102836004)(99286004)(256004)(6506007)(66066001)(7736002)(81156014)(478600001)(81166006)(305945005)(6512007)(6486002)(86362001)(8936002)(316002)(6436002)(186003)(39060400002)(53936002)(4326008)(486006)(8676002)(110136005)(54906003)(106356001)(2501003)(2906002)(25786009)(5250100002)(105586002)(2900100001)(476003)(3846002)(6116002)(82746002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB5121;H:BN7PR07MB4676.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /tmMv56mSAKJDbr52eKRe9jLHdckqjQjAV6ZsMgqEGo43OvBD8FuDOO3g/+VaLAOw7g090EgEgxj1sPyFv3ZebB9dT2VbbGkoij67IUAG9nH9Lf7C9aHHWhh6udTfiwLbpOQIwy8ZbV9Gr8bgIaHWYlI6Z4zemcjmT8nSVc9kOtJkvlr+qgkp+DJDMyKzC5Admhy7xS3OT1Ji2inWn/J6NPf1aZ3GhiQKb1vEikC/FKDOOoZ/xoNmeVQi4Cp0PJbt9TqgPAQ+4+uXV8R/ybp+e5ULNam0z5Ti/SaMCXaMjA+4Q+bylOV/sxnf2Ky63ClA5nFcSHCtwVy4d85g8eJegAjGWquHWIl0HSQZ7UrZ24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <600FC4CD23F98B49A639ADE73BC4D8A0@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4afa66-2608-4163-5da1-08d5fdfb78af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 13:24:44.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence UFS controller.
It was verified on Cadence Palladium emulation platform.

Changes since V2:
	Updated dt bindings documentation.

Changes since V1:
	Renamed the documentation file name to cdns,ufshc.txt.
	Updated interrupt and register mapping.
	Added license information.
	Added a missing PHY clock.

Jan Kotas (2):
  dt-bindings: ufs: Add bindings for Cadence UFS
  scsi: ufs: Add UFS platform driver for Cadence UFS

 .../devicetree/bindings/ufs/cdns,ufshc.txt         |  31 +++++
 drivers/scsi/ufs/Kconfig                           |   8 ++
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/cdns-pltfrm.c                     | 147 +++++++++++++++++=
++++
 4 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 drivers/scsi/ufs/cdns-pltfrm.c

--=20
2.15.0


