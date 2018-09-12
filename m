Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC557C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B8F206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FN1UcNF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B8F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeILN6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:58:55 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:15218 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:58:55 -0400
X-IronPort-AV: E=Sophos;i="5.53,364,1531810800"; 
   d="scan'208";a="17001343"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Sep 2018 01:55:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Sep 2018 01:55:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pC+gsHGXxi3W2ZaKOCxBUtYpvJCeACOcaKvZvj992o=;
 b=FN1UcNF3gCpR5qAuM0ZQ45/ueCBdi6FJg0jAVtLd8pFwyNKqqlL6PNA+5O7iJ/4ozcmxJyoEuXt7jsIjdmg4B6ZUk/Rsffh+4zPuWxRjmJDdGpQUjBgcGq0CoVA10/8eQ20Xm1BIpKVIYnHt/+FkM+U+K/oZFEXgRu3ruwqFLpo=
Received: from DM2PR11MB0105.namprd11.prod.outlook.com (10.160.26.155) by
 DM2PR11MB0256.namprd11.prod.outlook.com (10.160.136.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Wed, 12 Sep 2018 08:55:19 +0000
Received: from DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::3438:f537:f7cc:363c]) by DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::3438:f537:f7cc:363c%6]) with mapi id 15.20.1101.020; Wed, 12 Sep 2018
 08:55:18 +0000
From:   <Wesley.Sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <corbet@lwn.net>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Wesley.Sheng@microchip.com>
Subject: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver and
 misc updates
Thread-Topic: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver
 and misc updates
Thread-Index: AdRKdRhBgeV9LqbDSayrtpBFveKPpAAAHpPQ
Date:   Wed, 12 Sep 2018 08:55:18 +0000
Message-ID: <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
References: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
In-Reply-To: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wesley.Sheng@microchip.com; 
x-originating-ip: [211.144.195.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR11MB0256;6:kgr9PcTB5UTBQJB/v+FfEwiQ8F+bBQqdQZo4OgLYjsaOvD/xtUWuUkr2EJuzBjKlvFBdI1NXENOodlbWWRw7v9uOIpmY2KZ5Ejpfv6Ax8WLumx5y8AVvUBN0OLpJ77sFEFhfPSlDSN1tzyTtmpaUOouH9k5P3Vu9UhobZRDZio2BlGgtpwOjYPUs0w5jVObdebFuQEg8zU5iXIiSWZ78xQ+9nRrlSTAqT7CuwDDalcFRKQsbgyZygLzUn6BL5byD7urGDCnH/+/rtsIvI1JZXJO2Ts1xY/cfSTNdWTbZUpaph91L3t+vt6W+GnvknG4GZUZi2QZBN3E8oBVi8pnKHISd6ni1hfk+oSwrLPbCFYMeAL5gZtrzVZeXCL2CRfDGQq+OeNxRdnRKktK4/lV9GYD+OPuzrl9hJjN0W4z21Agpx8aXUHyVDwhT5GSMhSVjc0CM9/aCXQh2BUC5Ft388A==;5:tvRhRh/5HCTCtU2RFIuHC0SM3wrUFTU0BBs15bb+n3+kLz0HdWKqTJFOXOI3fOaW1sKBGcyezi4849vJz6HYrTxFD7YoPFYmAKgiBPV8lbvAedZ23X1jAh/VBwtRMkUerPPMqbosCAyINC/ssX2yA/oGnJtWC6/wLvR8saZ4594=;7:1MbBwVQu+O0eiiJQIK1gdnYaIDixH3Y4EB3C4AxvKX3UMkE8NC5b2G9bX2gDD+EOe3rR5s6zlgoKdlbZbtrYIcn4gJ1HMwnQGC3jV8Sijst0SqRb3oRVosYFPthve1DhioFMywBJC7ovgt5/epHj8zzYI43WOAG8ywb/qxXhaP9KwdbG5/0nS7nsUoFNbZkhQk5QSBQFfCoB4E+RcZP3K8TEUnUECmw/kBYu1+6YtAliegDJEAchIAMNe74PTqey
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(366004)(346002)(39860400002)(199004)(189003)(6436002)(86362001)(81166006)(478600001)(8676002)(186003)(99286004)(7696005)(81156014)(102836004)(2906002)(8936002)(9686003)(14454004)(53936002)(2900100001)(446003)(11346002)(2201001)(6506007)(14444005)(72206003)(2501003)(256004)(5250100002)(55016002)(97736004)(26005)(486006)(476003)(110136005)(2940100002)(6116002)(54906003)(305945005)(7736002)(74316002)(1857600001)(76176011)(33656002)(66066001)(25786009)(316002)(107886003)(106356001)(93156006)(105586002)(4326008)(5660300001)(15650500001)(68736007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR11MB0256;H:DM2PR11MB0105.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b37555a3-84db-4bd8-b328-08d6188d76fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM2PR11MB0256;
x-ms-traffictypediagnostic: DM2PR11MB0256:
x-microsoft-antispam-prvs: <DM2PR11MB02569FF3B7B49DDFFAD5B6B8951B0@DM2PR11MB0256.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:DM2PR11MB0256;BCL:0;PCL:0;RULEID:;SRVR:DM2PR11MB0256;
x-forefront-prvs: 07935ACF08
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QY3Tpee/5JEOt8NxVg8D0BqORAFQJoKVpIxzYaMVvBXLZzYRJUq+ubNI3bj9daT7e3Dla93kOLcFqHW7VhIGim4MYyEEfXuNM29b6jkynlvYKdLu9BDPBWPn4W27kRGqi0cH6GI99xLW/1dfuswVlFgfQ5qAv3ani0e0fP860ts6uV6JEXHbU2rtJmrblN4xNnHWO28/vXV9UthEBtedef7R5KqBOAv8M9+UF4jmrbdcvpdsURqbSj10VLaj6aGQ3L1UC45jqBsgOJ2LKInKck42//nRa3IopWukSIspBCJHa2EBAGGObueTHG9dmVVK0ztF32lwP2Yldx0kSWbBUpWoflRGohGFIdIX+2jajVQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b37555a3-84db-4bd8-b328-08d6188d76fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 08:55:18.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR11MB0256
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wesley Sheng <Wesley.Sheng@microchip.com>

1.add pre-requisites for NTB driver
2.misc updates
  change ntb hardware driver name to ntb_hw_switchtec
  update the description of 2 partitions limit
  add reference to Linux Documentation/ntb.txt
  add use of term 'Command ID'
  add use of term 'Command Return Value'
  add a missing ')'

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>
---
 Documentation/switchtec.txt | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt inde=
x f788264..40e839d 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec man=
agement firmware is  through the Memory-mapped Remote Procedure Call (MRPC)=
 interface.
 Commands are submitted to the interface with a 4-byte command  identifier =
and up to 1KB of command specific data. The firmware will -respond with a 4=
 bytes return code and up to 1KB of command specific
+respond with a 4-byte return code and up to 1KB of command specific
 data. The interface only processes a single command at a time.
=20
=20
@@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint=
 in the system.
 The char device has the following semantics:
=20
 * A write must consist of at least 4 bytes and no more than 1028 bytes.
-  The first four bytes will be interpreted as the command to run and
-  the remainder will be used as the input data. A write will send the
+  The first 4 bytes will be interpreted as the Command ID and the =20
+ remainder will be used as the input data. A write will send the
   command to the firmware to begin processing.
=20
 * Each write must be followed by exactly one read. Any double write will @=
@ -45,9 +45,9 @@ The char device has the following semantics:
   produce an error.
=20
 * A read will block until the firmware completes the command and return
-  the four bytes of status plus up to 1024 bytes of output data. (The
-  length will be specified by the size parameter of the read call --
-  reading less than 4 bytes will produce an error.
+  the 4-byte Command Return Value plus up to 1024 bytes of output =20
+ data. (The length will be specified by the size parameter of the read =20
+ call -- reading less than 4 bytes will produce an error.)
=20
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
@@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
 Non-Transparent Bridge (NTB) Driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-An NTB driver is provided for the switchtec hardware in switchtec_ntb.
-Currently, it only supports switches configured with exactly 2 -partitions=
. It also requires the following configuration settings:
+An NTB hardware driver is provided for the switchtec hardware in=20
+ntb_hw_switchtec. Currently, it only supports switches configured with=20
+exactly 2 NT partitions and zero or more non-NT partitions. It also=20
+requires the following configuration settings:
=20
-* Both partitions must be able to access each other's GAS spaces.
+* Both NT partitions must be able to access each other's GAS spaces.
   Thus, the bits in the GAS Access Vector under Management Settings
   must be set to support this.
+* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
+  to be set)
+
+NT EP BAR 2 will be dynamically configured as a Direct Window, and the=20
+configuration file does not need to configure it explicitly.
+
+Please refer to Documentation/ntb.txt in Linux source tree for an=20
+overall understanding of the Linux NTB stack. ntb_hw_switchtec works as=20
+an NTB Hardware Driver in this stack.
