Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C94219C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 04:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+oNuhlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C94219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHFGur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 02:50:47 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:3941
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbeHFGur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 02:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdZMvEcttidMgJwDfUjzvBhvKJPpHdnJCzsbTXXWDnc=;
 b=Y+oNuhlhloYPvMnkXg3ZF3Q0xHlLFXONsrRj9FRT+/raUGXP729Rz/Kj5MuUWjrID8vXczXI3pxcyvwaia1KgtKs/D7FnsfqgsMuXqpX3cCdV5n9LTnfPJLeUL342SgiFyrdYuzzT2kOiz5bc4iq/YC0rar+lhB6lYDSbYl+eLI=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2327.eurprd04.prod.outlook.com (10.168.54.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 04:43:28 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b%6]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 04:43:28 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: build failure after merge of the net-next tree
Thread-Topic: linux-next: build failure after merge of the net-next tree
Thread-Index: AQHULSqpzxE2FXetq0SFzaJUv2BpL6SyJXvw
Date:   Mon, 6 Aug 2018 04:43:28 +0000
Message-ID: <DB6PR0401MB2536DA6B7603233D29307595F8200@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180806121026.7c4b956b@canb.auug.org.au>
In-Reply-To: <20180806121026.7c4b956b@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2327;6:nVgLo8CagwEeE8pHnh7ROelBFoblC39D/27UvO4ie3uB1+nU8dXGcCcxBY+svZBtYbkyvsMPYQx32KsOFomdE2Z6dtRIO6iv28YEMEzqAWyMoevesRTjz+6/SDSX7278Nslsa9sJRRfkrRsugZJ5i2yc6xUnDE0GWAKqoGmcmsnaajn9whGLfB7QZTN5NMnfBE5tfvd/EkzRFv2rkvAxAq3bFs3bLNSNeD3gxYYkKM3AZmvH1mXhc4hfqkx6x+mteSKl5LJInux7b0UAgp7ZgMEeXk1xVwBo9S0FO54fXzAhTuOnHCYtmRZnojTC7Bmd4MEYwQvi6VgZh73+NkSxp4BntYnCfq9iTwi/pRjJOwL4CuvXAiQns8kn/OCzmQbY0el+AkLcrqyyNYYin/Iy/mW9KNK0Vz30ZSTj6pwUxzRhoOhE5Xu6zVFBIoOLrJNoYHefOninJcXOFB3saAutFg==;5:GSwW6u3AEoMV7TBEsxi3EUsXLLGvHzTnEKhP9IfFsZr2wkSwTOM1q47JQrmd63A0OVcIbLBpfaYDjx/4O7R8O2W7KDqfruQOZ/Esv3Lfjx2BF7NLI4JYb6sLOI44ys3eXFknFF67+MrDFG4Oz13EJHNkkfTqUJQqsG5xg6lgFMk=;7:0m5720r7brvosuRyJadq5KHrLXR7/lPTrl5CUZ3IgtO07Dvi5tkFeII8g4bEh3a/2zAc0mrY4aQi++kCpdoflPOzZfFWo1NO4ovvyng0vhPx9Oy3SM4Y+LSZSCJdSpPwuaqE5ZNvMNKyUflx7cOVeWcIp+NgZDaRH1ObgYRip0qJICsdnSkQbLQXs/ahxTArggoMt6xzMGrGycgZLGap8kcnlUDIRgSOwtdUzUILaawKSt88RlzmUKdj8ZAK6YEC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6feabe7e-820d-44e1-fbac-08d5fb572780
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2327;
x-ms-traffictypediagnostic: DB6PR0401MB2327:
x-microsoft-antispam-prvs: <DB6PR0401MB232753D0D88720AB7564821CF8200@DB6PR0401MB2327.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2327;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2327;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(13464003)(199004)(189003)(53754006)(575784001)(86362001)(6436002)(486006)(229853002)(33656002)(66066001)(476003)(11346002)(446003)(99286004)(25786009)(316002)(54906003)(110136005)(4326008)(14444005)(256004)(55016002)(6306002)(9686003)(2906002)(2900100001)(53936002)(6246003)(3846002)(6116002)(5660300001)(478600001)(14454004)(97736004)(5250100002)(966005)(305945005)(7736002)(53546011)(6506007)(74316002)(102836004)(8936002)(8676002)(76176011)(26005)(186003)(105586002)(106356001)(68736007)(7696005)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2327;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DB8DgRKxwUWM+5S9NxTRzSC9ULVQHrQfqO/hmb794yxCU+KdiSZLeuRNpjxO3FI5sqTVdVufv2uaNPxaQDpZ7+zILrndYuK9p+SF4sKp4dqDZvIPXdUBRHrOjpwNQkJG1KL6nIXVBrJbbbaq5lY9p2IR9I3G6G6jFo7NP7XYbWI6Yz+FBsg2YxNkAc1wL10EBiEF/NlG7zig439ZCwxfvUSbLAFOc85XW1quXymVRblgk21cYwyUMpxoxD0G9uHmpC6C+ENeehgV/VSp9ew6dWklk/S5rTxoy5aOPIrOlyICbnjWFHBk40pNyLZrcOT705Ig7hCSmmZoi9J7YMUliETJ+5mJUNvZbtwzTjgZ/Rk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feabe7e-820d-44e1-fbac-08d5fb572780
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 04:43:28.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the trouble.
Just sent out the fix-up patch.
https://patchwork.ozlabs.org/patch/953695/

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Monday, August 6, 2018 10:10 AM
> To: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Ma=
iling
> List <linux-kernel@vger.kernel.org>; Y.b. Lu <yangbo.lu@nxp.com>
> Subject: linux-next: build failure after merge of the net-next tree
>=20
> Hi all,
>=20
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>=20
> drivers/ptp/ptp_qoriq.o: In function `qoriq_ptp_probe':
> ptp_qoriq.c:(.text+0xd0c): undefined reference to `__aeabi_uldivmod'
>=20
> Caused by commit
>=20
>   91305f281262 ("ptp_qoriq: support automatic configuration for ptp timer=
")
>=20
> I just reverted that commit for today.
>=20
> --
> Cheers,
> Stephen Rothwell
