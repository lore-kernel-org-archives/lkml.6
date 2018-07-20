Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0244CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959DB2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gGku0lKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959DB2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeGTIGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:06:00 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:22784
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbeGTIGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSJ+uZ9/rdxDPPoy3BLp9iq5JTIeDaT5kWpFwLw5lkc=;
 b=gGku0lKGP5JFw1c5ZP8IgYhN3POXktZdU0KkzXLYLf3pTdoMcdPXzhqNicfh+wjPBX/5GQylSU8gUWgAFdEsJN3ZIbsBHG9M84aXHoyMezjzHx5qhaEn6JilooU0lT4Ar3cqgnT1mPnw4QkF9ICb7g8Fx/5NXgZQIKCCt/0QCSU=
Received: from AM0PR05MB4260.eurprd05.prod.outlook.com (52.134.91.25) by
 AM0PR05MB4371.eurprd05.prod.outlook.com (52.134.91.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 20 Jul 2018 07:19:07 +0000
Received: from AM0PR05MB4260.eurprd05.prod.outlook.com
 ([fe80::6182:6453:c4f4:d83b]) by AM0PR05MB4260.eurprd05.prod.outlook.com
 ([fe80::6182:6453:c4f4:d83b%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 07:19:07 +0000
From:   Meir Lichtinger <meirl@mellanox.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "Ofer Levi(SW)" <oferle@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>
Subject: RE: arch/arc/ allmodconfig
Thread-Topic: arch/arc/ allmodconfig
Thread-Index: AQHUHyKW1M3GsAcZr0iuL832AquqnKSXtOGg
Date:   Fri, 20 Jul 2018 07:19:07 +0000
Message-ID: <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-GB, en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=meirl@mellanox.com; 
x-originating-ip: [87.71.73.236]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB4371;7:1JpmzKJw7l5tJi/HVUEEtdJickEjebh0fgiM8W681pRKlTWAY/SKm22ZFhdWBtBB0fa7X7hn7UfXzffTYzx3HkAwbnOfc2Hw4BlZDEclE7YpYtDDeK7U50dF2c27gAUzWDmKqUKDGwFpkNjEK8plAKsvIiCGc7Xb7FoeY2f3HHEFJp/s+NWmHb2FXzHL/RCvMGgXsOYJ/ctyUC00WwvCskbubQSwniUzhImGoCyfOycovcJSknYVvPfjxoXnCWW9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc02908e-c98a-412a-dca4-08d5ee111505
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600067)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4371;
x-ms-traffictypediagnostic: AM0PR05MB4371:
x-microsoft-antispam-prvs: <AM0PR05MB43717DCF38AEDB60069030F9DA510@AM0PR05MB4371.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4371;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4371;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(13464003)(43544003)(189003)(199004)(55016002)(6506007)(14444005)(110136005)(2501003)(6246003)(478600001)(3846002)(6116002)(81156014)(256004)(74316002)(5660300001)(76176011)(8936002)(81166006)(102836004)(316002)(8676002)(106356001)(86362001)(305945005)(107886003)(2906002)(6636002)(7736002)(33656002)(97736004)(26005)(6436002)(229853002)(25786009)(446003)(186003)(68736007)(7696005)(2900100001)(105586002)(53546011)(5250100002)(11346002)(4326008)(9686003)(53936002)(486006)(476003)(14454004)(66066001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4371;H:AM0PR05MB4260.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EbSChfUMB+ovWpj7vPRkAUGeeToQDSqbGr+KjzPrREfKus+hqf1XLSJqSOM1cyqsBG2QSqtrrprfxLPYw1WfY/9efQpIXZDizHA/2g4ZJetVqfdzgFna12Nx5pnpcocJTHqqzz690DktctGEcxJTav4pHDGL7TfbDSH9OmTQ7Ka8wIW7Q/gA71gthiISE4T59aL9LvgSXrsQ6TLvK9zYLw/Qgzi6adxi/uvbqtuEsFWRwbQ2M383ucFNqw1wcOP4Q3uKYtZIv4fPgZ1VPzX41yMbywPX0pF7ZuDA924eXI2bVRKPSmY+MSQmSByDiqEky2o9Q/TaaMSMM2TDUH2iNkvQS4ssra8cHdXhqY9o2a0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc02908e-c98a-412a-dca4-08d5ee111505
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 07:19:07.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,
Ofer Levi is now the maintainer of arch/arc/plat-eznps

Ofer,
Please take care of the issue below

Thanks
=20

-----Original Message-----
From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com]=20
Sent: Thursday, July 19, 2018 19:22
To: Randy Dunlap <rdunlap@infradead.org>; LKML <linux-kernel@vger.kernel.or=
g>; Vineet Gupta <Vineet.Gupta1@synopsys.com>; linux-snps-arc@lists.infrade=
ad.org
Cc: Elad Kanfi <eladkan@mellanox.com>; Leon Romanovsky <leonro@mellanox.com=
>
Subject: Re: arch/arc/ allmodconfig

+CC some folks from Mellanox

On 07/18/2018 10:37 PM, Randy Dunlap wrote:
> Hi,
>
> When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax error =
here:
>
> ./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':
> ../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't k=
nown
>   struct nps_host_reg_aux_dpc dpc;
>                               ^~~
>
> There is no struct nps_host_reg_aux_dpc in the kernel tree.
>
> Can you do something about this, please?

Thx for the report Randy. I'm calling out Mellanox folks to see if they can=
 provide a fixup, else we will revert the corresponding change.

@Elad, upstream commit 3f9cd874dcc8705 "ARC: [plat-eznps] avoid toggling of=
 DPC register" added reference to struct nps_host_reg_aux_dpc but the defin=
ition is missing. Can you please provide a fixup as I have no idea of that =
platform specific struct.

@ Leon, reaching our to you, since it seems you removed Elad from MAINTAINE=
RS file, so I'm not sure if he is still at Mellanox.
The two folks I worked with on EZCHiip Linux port Noam Camus and Gilad have=
 left Mellanox.
If you or someone from Mellanox are interested in maintaining this platform=
, please update the arch/arc/plat-eznps section of MAINTAINERS file.


Thx,
-Vineet
