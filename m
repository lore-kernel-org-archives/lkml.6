Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A33C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F83025AC6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1xis0CIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F83025AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755595AbeFYNr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:47:58 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:24309
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755015AbeFYNr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQMsvNKDC7+pY0nVD49OXQxlzMw2k/iC3Z8P0aXAmGU=;
 b=1xis0CIcy37+MvApankltvflB/stuSQlDzmtalvmJmVHddnYYmq5JYdCfFNyyFHU6/lnviGzt6yRWeV2iAlL5DBG92O+LVzO1XQHEoT6boodOVbeJbln5N3AhRAoiv+JiDwV04WZ9RJkyFPHzomxCLS6we2MqckadVUmj48JYVM=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4860.namprd02.prod.outlook.com (20.176.111.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Mon, 25 Jun 2018 13:47:53 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 13:47:52 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Simek <michals@xilinx.com>,
        netdev <netdev@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
Thread-Topic: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded
 name
Thread-Index: AQHUBvS6CT4gPmJtvkmLLZPHjMPu66RoHVUAgAAQ/wCACNehgA==
Date:   Mon, 25 Jun 2018 13:47:52 +0000
Message-ID: <DM6PR02MB436155458BFAB5575207B2C4C74A0@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
         <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
         <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
 <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
In-Reply-To: <3013aae1803c096645887864d1b161efbfba7c77.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4860;7:vBUcQ43ThBLvPiE7oPsuK4tiWsJ7q8gljDufXyYEwKlajI9oHRPqzzrYhKE0Ulv8aOm0sZsBASBHojkz78EcNwE7Epslotdmn/2hHw+JRZVdH8CsrFLr7x459nU7DRVV3Aw0eg8nHlFrK8ctHAetZUD65IuIFGdrNsYkGLMJETqtIqmKNQ6X8/GAOeoBn9g0cjRb2LSv6ub8S1u1Na8AmEGvopm9el9+pDcWsP6bWkZ6kYuWvblZm1qDT6khXQnD
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(39380400002)(189003)(199004)(13464003)(11346002)(39060400002)(6246003)(446003)(25786009)(4326008)(53936002)(476003)(5660300001)(97736004)(66066001)(93886005)(486006)(316002)(2906002)(3280700002)(7696005)(76176011)(99286004)(186003)(3660700001)(26005)(55236004)(305945005)(102836004)(229853002)(110136005)(6506007)(59450400001)(86362001)(14454004)(6116002)(3846002)(53546011)(2900100001)(478600001)(33656002)(74316002)(5250100002)(9686003)(55016002)(8676002)(7736002)(68736007)(105586002)(54906003)(8936002)(106356001)(6436002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4860;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 2e71fa10-9381-41fc-ce48-08d5daa23f69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4860;
x-ms-traffictypediagnostic: DM6PR02MB4860:
x-microsoft-antispam-prvs: <DM6PR02MB48603543CFC6A29E3A4ED343C74A0@DM6PR02MB4860.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4860;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4860;
x-forefront-prvs: 0714841678
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0pm7b527UlwAKAraSJW3f59ZnlEpPcVtWGXApXoSJE4E4z2XMhvT3OJtLIsYNgvirJyNz4WYpE6cmkHOONAwShUt2Ed6oq8SxUoV7P8MU/wNn1lvkM6VcOfeuDdrG4KaM6oswAmTb1qbI6DQ/2yq15SE0jg3arU/iIVQK2OgmsQZrcu2cADHDaJK5XIqypH3DoZVW8hCujzf3+w587JJHjNw1eYaDe2smP60hoS4gLqQSVXGDQrHuN0JD6CVVSJYI63detFE414TfVCKAm3a5ehRctVXOc6plxFleqnqeninE685xqt+i/immoseJcchZBZFndbF6UvPD0mnkMhZaTbUGYJ/dY1eVmCLenlrTcs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e71fa10-9381-41fc-ce48-08d5daa23f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 13:47:52.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Wednesday, June 20, 2018 4:08 AM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>; Radhey Shyam
> Pandey <radheys@xilinx.com>
> Cc: David S. Miller <davem@davemloft.net>; Andrew Lunn
> <andrew@lunn.ch>; Michal Simek <michals@xilinx.com>; netdev
> <netdev@vger.kernel.org>; linux-arm Mailing List <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded
> name
>=20
> On Wed, 2018-06-20 at 00:36 +0300, Andy Shevchenko wrote:
> > On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
> > <radhey.shyam.pandey@xilinx.com> wrote:
> > > Switch hardcoded function name with a reference to __func__ making
> > > the code more maintainable. Address below checkpatch warning:
> > >
> > > WARNING: Prefer using '"%s...", __func__' to using
> 'xemaclite_mdio_read',
> > > this function's name, in a string
> > > +               "xemaclite_mdio_read(phy_id=3D%i, reg=3D%x) =3D=3D %x=
\n",
> > >
> > > WARNING: Prefer using '"%s...", __func__' to using
> 'xemaclite_mdio_write',
> > > this function's name, in a string
> > > +               "xemaclite_mdio_write(phy_id=3D%i, reg=3D%x, val=3D%x=
)\n",
> > >
> >
> > For dev_dbg() the __func__ should be completely dropped away.
>=20
> Not really the same.
>=20
> dev_dbg without CONFIG_DYNAMIC_DEBUG does not have
> the ability to prefix __func__.
Yes.  If it's acceptable,  prefer to use __func__  to support all=20
configurations

>=20

