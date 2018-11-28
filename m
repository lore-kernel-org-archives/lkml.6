Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2998EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC1D20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aZLWJ7QH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1D20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeK2CQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:16:54 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26266 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2CQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:16:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="23309708"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Nov 2018 08:14:54 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 28 Nov 2018 08:14:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YmLJUa0FNgw8ryZbFwiZAXowl7O4p7BW5N1sdKhnI=;
 b=aZLWJ7QHesFO1QcmH7aQxK+ZIi50B+tH63DMQJVywJnTU8RPTW311FJf7gUdq0hTpDoL+qxaFuqrMCs1KGIhT9Twy3V/AqaiJNR0QNTTktPmoIdthA+JcLoDOY4RS015NEBqsR5PfkHhZeyXGDdvHJmtFN36CbwMfxOulJ6v2Bg=
Received: from BYAPR11MB2855.namprd11.prod.outlook.com (52.135.228.141) by
 BYAPR11MB3461.namprd11.prod.outlook.com (20.177.187.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Wed, 28 Nov 2018 15:14:45 +0000
Received: from BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::b5b6:4f7b:993a:5c71]) by BYAPR11MB2855.namprd11.prod.outlook.com
 ([fe80::b5b6:4f7b:993a:5c71%5]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 15:14:45 +0000
From:   <Don.Brace@microchip.com>
To:     <gustavo@embeddedor.com>, <don.brace@microsemi.com>,
        <esc.storagedev@microsemi.com>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 15/41] scsi: hpsa: mark expected switch fall-throughs
Thread-Topic: [PATCH 15/41] scsi: hpsa: mark expected switch fall-throughs
Thread-Index: AQHUhtM0zomd77akgUWOzOmzTecBQKVlTFEg
Date:   Wed, 28 Nov 2018 15:14:45 +0000
Message-ID: <BYAPR11MB2855A40D2B3D808AF09B89CBE1D10@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <991ec154d1a1da019442e4fd025a39fa2ad2bebb.1543374820.git.gustavo@embeddedor.com>
In-Reply-To: <991ec154d1a1da019442e4fd025a39fa2ad2bebb.1543374820.git.gustavo@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Don.Brace@microchip.com; 
x-originating-ip: [216.54.225.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR11MB3461;6:twl9PiBIxW1hbY4tGjQcOjT/oVGEKg59S7tbh0CSsWGYcBxDS1hlPO0CjTvwXxS5btk1t6qLPDeUd+BvEIMt85Jgcq1r62ydSXDzpX0jSBrQeGbOokJ8N1ox+S8h1Z3oF/vxb8Zr758euUyw1wNP5rveGfr6fgcE76fqE7pRWx+rKgkkIeUAv5mOK9JkpQbylQ4eBlXckYPWK8hlgIJJoNPmjLV4Vl1/Feb0C1D4/HehnGCRuVVUkS5heHovXCRPg0cwgEqB4DXGootnZsNsKvd29NNfNzcIn1MgPb83+bqDsNuoGOFkiKJRTUVQqIDVez51S00nE9DwQqN/6Aqb5EwbuAmCBgjK5SNktquf9cgbFMicdRafpFvBAjtYhgvnBhiiy2jJgH18KKT1OSJtww+Qvcfi1t0NAJIUu5ICuNTDNsLcofN6U55LguJ8EaGLD5q/JtSAbqEU3f8o5C0NGQ==;5:RBScZ2N8D5CpZLtBBGbau5db/DJLpOLIdS+hTtKoQZ2v9Bl+PiYmJ5VKHS+2RB3uAYCBpWDLLUBgVSaIG9HM6vg00FcAsSkSBgLFWI6o5HLZa4EAAoZ5F6UKP0he8NQ+6xQR0QnK9Ya3EriTGfuhTliItaFSahSGQH2tKagj4R8=;7:Zr/Jj6VdZYSmIn7LQ8yrpt9plkOg/qD2h7URWmz+PJFWkoLqLGnjAauUe+J02NgiUPb/PQ4eYCPA2ROTEATPnW3INSa2rEn6D4ntJLrR5XWK6yrCNK4kKRdDaAwFXebOvN8Hqlk4AQO8hAdh5icAiQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d61bd744-5476-4298-9fe1-08d655443acd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR11MB3461;
x-ms-traffictypediagnostic: BYAPR11MB3461:
x-microsoft-antispam-prvs: <BYAPR11MB3461AC5402CBAC3BCBB0BC87E1D10@BYAPR11MB3461.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR11MB3461;BCL:0;PCL:0;RULEID:;SRVR:BYAPR11MB3461;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(13464003)(54906003)(6116002)(3846002)(76176011)(110136005)(2906002)(106356001)(53936002)(316002)(105586002)(68736007)(55016002)(256004)(9686003)(6246003)(478600001)(305945005)(186003)(72206003)(74316002)(26005)(4326008)(66066001)(7736002)(486006)(2501003)(25786009)(6506007)(97736004)(86362001)(53546011)(476003)(5660300001)(446003)(11346002)(81166006)(8676002)(81156014)(71200400001)(71190400001)(102836004)(14454004)(8936002)(99286004)(7696005)(33656002)(6436002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3461;H:BYAPR11MB2855.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o6qCDTtevmw2bGzhg7xKhLYZ4x5v1zQW09ykuYZgW4xpUTKD47XWphGHW9quyo2H0MFyeHYq/bdmQzuWKNTd6o1XjT3hnpIlnDbl+IK4a+xaKyI70gZYfhGXKl3H5ZQpkysBGCfiHBhY7QaEEFpn1ZBM65OVvw6I5pjLxeOvIRO9rDkqyGq7J66kopcb5hi7QBIdyFdc52//RxRcOJWKJfq4/owHjtPsFjPYQv5WXJm8knb96RSrkR3PV9NUPxseELccunXhPUVkVryfqFwSBB39h7xwDxb5n22+C6QJjE7j1KVsooG43MCDqU5on4h6DGkh3na7B9S4zkwwf3orIiE5YV2iOWyNsvcUdHbbSLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d61bd744-5476-4298-9fe1-08d655443acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 15:14:45.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3461
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com]=20
Sent: Tuesday, November 27, 2018 10:29 PM
To: Don Brace <don.brace@microsemi.com>; esc.storagedev@microsemi.com
Cc: James E.J. Bottomley <jejb@linux.ibm.com>; Martin K. Petersen <martin.p=
etersen@oracle.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Gustavo A. R. Silva <gustavo@embeddedor.com>
Subject: [PATCH 15/41] scsi: hpsa: mark expected switch fall-throughs

EXTERNAL EMAIL


In preparation to enabling -Wimplicit-fallthrough, mark switch cases where =
we are expecting to fall through.

Addresses-Coverity-ID: 1195463 ("Missing break in switch")
Addresses-Coverity-ID: 1195464 ("Missing break in switch")
Addresses-Coverity-ID: 1195465 ("Missing break in switch")
Addresses-Coverity-ID: 1195466 ("Missing break in switch")
Addresses-Coverity-ID: 1357338 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Don Brace <don.brace@microsemi.com>

