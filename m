Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1FDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C092150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JEkJv4cI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C092150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeISVX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:23:28 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com ([40.107.70.132]:31072
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732294AbeISVX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua5h77iSxuT2m8L0gKd69vHwFkEP03II+goaLfQlyTw=;
 b=JEkJv4cIKgPhaex37BMbRur39LN6DHTCd5FzhLehLA3xZCBSTk5uwAuDEjfae4KFCc5QGsmUoydxCze09uelPNoYOeFMYP9e0z6NW+6Gjce+o+V5DFcw+T8l0iWpZYB1i2WoofEDyJjsd5OAA6/pZOGBrDnXnBbcCk+3unffdwY=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.7; Wed, 19 Sep 2018 15:44:54 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.003; Wed, 19 Sep 2018
 15:44:54 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        Josh Poulson <jopoulso@microsoft.com>
Subject: RE: [PATCH] x86/hyperv: suppress "PCI: Fatal: No config space access
 function found"
Thread-Topic: [PATCH] x86/hyperv: suppress "PCI: Fatal: No config space access
 function found"
Thread-Index: AdRPnqLjk5RKpcSXRi2tGnIAPJn6lQAkNEyw
Date:   Wed, 19 Sep 2018 15:44:54 +0000
Message-ID: <CY4PR21MB0773AC52038EB086745D8368DC1C0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <KU1P153MB0166D977DC930996C4BF538ABF1D0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB0166D977DC930996C4BF538ABF1D0@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-18T22:29:47.8378282Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:qAkIfFNm4ksXVcGOUN2RDOcZYnl7PXhvUX3chNuORNfEeNLK0m0oKrM/N4kiMgP2nMpmWZ8HB6xL1lvE2mNg5kvlFfLC7e8GS+knJwrXqISqipFble7jUuFCf4ZZcvXntDU5jKoWFivjQuTYNqKrq1zst8Dm+Vy456ibCX1tcQJy7b5lTSD2HhgbOa3GqVxcsTlTRiYFRAizQ1FY2VbgQSL82QwFPW9mT7t3WVuUPk7dtUB6DmTQ2zmSQNEU9OWkvkmqppBdm5iNqg1bLnv+tAM1odoWTFVnNLaqa9h4lLidQddS3gXhu+Q4ueMCTD7/f4cMyyh87g3ZUAKgYXN3wT0JiH+B4XKjEG0QV8xndenPiYEiCJtGuF1B9gmZTOa+nYwO7FWd1NngorLjVCG/2qaTIxTIszIWJmMk1YjdJTLKigfFP+UXa/g/XMI4ma9XkUa9udFY8pq04WSxoQdXsQ==;5:XuFoaj41sP99gqLxvMpPG5FMia9vxlImkPhzqRGI0qtShRO9oavUYtqzBrVvhvZypfJ4g0PKQsfNJX8r2gjTeTpZe202bqRASmyeis7Y3+heO7nqh1kGY1Ik77+KyggVK5njlivFi7yqb6Elia78myNbDOL5BBpy0cxoFpu6IC4=;7:WQwIp/kTZDV2a/U7oLR0h2LXUZq5JJpxuXZSP+8RlARj1MCaSSyDFqBJXyfia2ai4i8eQJSCCjrfRu7dlywvDNh+Br817rXMj2dC7ZfzH5ajcx1Ba3ErkQo/ph/cgRy5SLD+LUaJa0htTH6gvmVKUYZ/KsmDc8ll5NNNI2IORbfqV/ZBUimmPlPseePH84ICz3BXh0k20Jk6g0sOT9m8ZGfV4HhmCFsKrI7gqjSs68xxS9B0+q7r/x9WAaUtxydM
x-ms-office365-filtering-correlation-id: cf9a225d-81df-40f6-0ebf-08d61e46d874
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0839A1D0CD139C0C108FB939DC1C0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(76176011)(86362001)(8936002)(99286004)(81156014)(7696005)(22452003)(81166006)(14454004)(53936002)(106356001)(26005)(6346003)(54906003)(110136005)(229853002)(316002)(102836004)(486006)(8676002)(97736004)(66066001)(1511001)(68736007)(3846002)(107886003)(6116002)(25786009)(6506007)(86612001)(4326008)(476003)(6246003)(10090500001)(7736002)(7416002)(5250100002)(74316002)(446003)(11346002)(305945005)(2501003)(256004)(14444005)(2906002)(5660300001)(33656002)(8990500004)(2900100001)(105586002)(6436002)(72206003)(9686003)(478600001)(10290500003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: iJccCZYgC6B+/oNZBi2jAbSAyomK1Gfw6GbGzUtZgu+ExWv/sVQZZP6ghgnOykeOS7zFdnoTvBoqMOPIaWLjrI3BRMKPig5f2QUGwZxh9rWFfUqD6PuZnJsAMnhVa+9o3aCIa+u1RV6C8zQslbZDbN3Ihv8+cSoQKOaJwOhU3N66iV6U42S3jYgv6otKfFUCDwsqpMJPLhYHBU83NnI2dYRP5x4rf6MbyAZcpbKqHMeHF9CUEEp8N+GvtiZzlS220+1yRnHE2LKNT14Ny1UtCz4R6m2+Uub0zmZkLaijtVkzC1LF74XSOCYHrUVLE8rg34Sw8YH2qsCAjoDqfNpVKbmbplXvbQxcHCX073W6nXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9a225d-81df-40f6-0ebf-08d61e46d874
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 15:44:54.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui   Sent: Tuesday, September 18, 2018 3:30 PM
>=20
> A Generatin-2 Linux VM on Hyper-V doesn't have the legacy PCI bus, and
> users always see the scary warning, which is actually harmless. The patch
> is made to suppress the warning.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
