Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863A620874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h73yUoEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbeLQSA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:00:58 -0500
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:60416
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeLQSA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nlH6GkFhf5rQsVvDnccH+xLpdy/za+wXLkBvXyXHXc=;
 b=h73yUoEj2mulV0UDZfPYj4nNF22tyCIn6mVwvPH0t/HBUAaheVyGJYaI4NHlH0755G5Rj73jItnNksSeSxljcqzBn1fs2htFYLWJGJh7gn/852NyjH73sDPK9swpxkwaJvmcGTUmPzFyVuEwb5b04SRgOU+Aw42lByXjbFoUgMk=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.5; Mon, 17 Dec 2018 18:00:30 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1471.004; Mon, 17 Dec 2018
 18:00:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Topic: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Index: AdSSumYR+EFelO/iSCugbWbDq9Br5wDcbnsAAAFGcVA=
Date:   Mon, 17 Dec 2018 18:00:29 +0000
Message-ID: <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181217091518.5004d4c7@xeon-e3>
In-Reply-To: <20181217091518.5004d4c7@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-17T18:00:26.7190705Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:2:3cb9:7d38:c591:f3ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0172;6:M00yviIgwrOP6DmE1UQ0Nx89Cya8Yl3/S7wsmOvGtzGB/gbDeLfn2viDsPRn8npL7de0+AndAH47yTveznIGCk5m5PiXju9hBo5tC9ejZ9nd5LFWn3Ov7P2w4B32BSztar8v21Ca1xHg8qYAuwMouKkt3BbRqrjD/90ZWgxkcXXcYksvKkRNjmmFgshTiaGWo9sKtcBgTxYCgrkFqI3J6MYcgMakjDlZZ+ViaDV0rXixwMFQtOVFhMmZ+OP9UqPTkPHux5zX31QNWU/iN/STuWpoZNHowWkLyjK7dW+Ar9k31ayVcq6Z69XsPcixP5Zh3SymqHJESGttGYAkTYb0kXw9jy/5uHN81rJftkq/D2gjBIyXuQR4NpOSBv8YB3D2SdrggJKUQyfhKHoSFZGfD4ARloqWkHzKjUQWrTzF2iMTxaMn2Rkv1/d+5nlbUxaaNHZgD1eOEL+YJPolBixGZw==;5:SrGo2gLND1XxC5vrbXlLym44RaYAfc0f/IXuz3Qsd6moSy5c3UOeEOfwJ82jwCYZpHV3zDwL/JA0UoI1MSp/4VlaoGMOtgwEv1XdyyX+jLkimD5P+rvynrQOyegXlgBKavjlDuJY2rYU1nE4x/LyazmpAfrkrOYA37YC3P49EtQ=;7:Bs8pmExwLq4paZlGdtXO4mRmNbo03+agu5S0A9biNxwPmcmnBL9i2rep1NVMHmpzsci8IQuGdUNlgYmEtOi7oSIF/pOW6I7kLJV1bneTtTMLodjM7Rbc6e7IfDVTm4koxwdSZUkEJfjyxcopR9kkew==
x-ms-office365-filtering-correlation-id: 44c3d597-f5e3-4743-6709-08d664498858
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0172C91708C59F9E7F692707BFBC0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(8220035)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501519)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0172;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0172;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(86362001)(76176011)(7736002)(446003)(7696005)(68736007)(256004)(10090500001)(25786009)(478600001)(10290500003)(53936002)(9686003)(97736004)(55016002)(86612001)(6506007)(11346002)(486006)(102836004)(14454004)(6246003)(8990500004)(476003)(4326008)(186003)(105586002)(106356001)(6116002)(2906002)(229853002)(81156014)(81166006)(8936002)(46003)(6436002)(6916009)(316002)(22452003)(54906003)(99286004)(33656002)(71200400001)(74316002)(71190400001)(5660300001)(305945005)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dJyFsVc+k/u3khNnZBI7BloPHdqM8hc3bubB8DbOtJioUdecPc7suTsv3MbXPOQaompwOjPA5velSBqPBu+gxbvwaQLym5WEFRWXt1xEccOKDE3LyJw19ZQo9gFJJJxZktdShGdElCKIjidacPawlFzZfYBkbb5hllsm9VooPp/HBasnz1J9fOnxH6+PMtdPyWQAvnxrhY67zBO9r1QfubSuAOMyrS+PF9C6usEt1xyD05245ZFIEMP9KhFwWMCOi26w3D7IJ91ue58kP+X3bDZjgpWlUBqo/XNOo+skeSY1J8/pVT+RmfpcB6+tIKqX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c3d597-f5e3-4743-6709-08d664498858
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 18:00:29.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Hemminger <stephen@networkplumber.org>
> On Thu, 13 Dec 2018 16:35:43 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
>=20
> > Before 98f4c651762c, we returned zeros for unopened channels.
> > With 98f4c651762c, we started to return random on-stack values.
> >
> > We'd better return -EINVAL instead.
>=20
> The concept looks fine, but maybe it would be simpler to move it into
> hv_ringbuffer_get_debuginfo and have it return an error code.
>=20
> Since so much of the code is repeated, I would probably make a
> macro which generates the code as well.
>=20
> Something like this:

Thanks, Stephen! Now the patch has been in char-misc's char-misc-linus
branch, so IMO we may as well leave it as is (considering the code here is
unlikely to be frqeuencly changed), and we have a smaller patch this way. :=
-)

But, yes, I agree with you that generally we should make a common
function to avoid duplicate code.

Thanks,
-- Dexuan
