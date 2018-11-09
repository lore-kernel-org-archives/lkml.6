Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31215C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504820855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U73+pg6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKIPo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 10:44:27 -0500
Received: from mail-db5eur01on0058.outbound.protection.outlook.com ([104.47.2.58]:62976
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727485AbeKIPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 10:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nun9kO8nxnrQ/b5Rs6Je8L6MHrT8bS5DsuzR+3QRZKw=;
 b=U73+pg6K9a0m5j9idg5DYtthQcd6bWnQt6fLuAmI9cB4Pvm7ybFp7RoDT8yL0nVumhyhuOVbh1TJbrDOwO5AFTUht3cBq0qXJtT4rqQHV72Mt7BYimXULGwA+NnvrnByBQjBL+xrxILCuHC2iOWfQ6ntkkIbiXXasSmRGDHA64c=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3774.eurprd04.prod.outlook.com (52.134.15.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 9 Nov 2018 06:05:24 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::6570:f84e:f9d9:4ca3%6]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 06:05:24 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>, arm-soc <arm@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Thread-Topic: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO
Thread-Index: AQHUd8kl/5FfCJ+SikWjB0SaOZVRMg==
Date:   Fri, 9 Nov 2018 06:05:24 +0000
Message-ID: <VI1PR0402MB3485824A9FB3BC878E7B83D498C60@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3774;6:VqV5TPe5EJtbxwnPAS9F8JYp9aPaavNTaw7FasUrN2JBacek3us6mMtYSIuKDNyuBch0A8qGWi+6WiMmDu5ATQ2nk9k5/hfAQDsjKTzg0QYGJbismUbYERS+48KBs6NSom3z5i7AwmECDhhnGdIwMnedDmpSZoYgIk4BZsRbj3kclp3M8YeP2KLde+3E5W77HWBlhTEHKARUn9xjIcsSbrFTX8ciCNs5nz42M/7wu4cMU9LjTDNvoe0CftRj9M1G7rSh1pZMb5B3lL+NnFg18Y0BtiWj6DvOZA3SIeoikuPwsVm4MKbCRNQwRZHfjK70+4VW3YjMYQIb3dVQnxCdaVn+403wGyPZ3QeC6x/uUVKZfhbYSVdy3Vo4ZC1JKwJvHMLZB4HbekE6L8rE+7BhBmBUUVbw8pMT3aJuD+ZQUktqSNGnvBBAW41Xq4Vq4neml+57debGBcvzR07SvmpzvQ==;5:O+XubLYJ8TOGCuOILOeMu5qw5j9+3k5hzrUVgryerHyX7nt/qJKXw3OHif5Rbjq1A+bwnsGVXos89wT9LuFuzCk/HR7vDZWyLrmW+FW+l4/sEohmxgu1X1Q9KxPgMnkRFLsngkENZylzpq4zdf8msPDO8pKedOss/TB67sZ8SWk=;7:RnuOrRoacEhBDXXIZAtHBLlZi22W+vaW295NMj/GuDHDTt7egV+swoMFuMsI+bzHUz9IPT1Xc+mIJIIEY2YJoi5uhU98G1loYvjPixfkdA6Lt7RT2rmrqIwZdi76qdkGYEdmeDUB0ButWjxdr6swRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 98b0f9f3-e28c-4dd7-cc65-08d6460956e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3774;
x-ms-traffictypediagnostic: VI1PR0402MB3774:
x-microsoft-antispam-prvs: <VI1PR0402MB37748F350C9E99AB6970AAD298C60@VI1PR0402MB3774.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(191636701735510)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3774;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3774;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(71200400001)(71190400001)(7736002)(8936002)(68736007)(110136005)(54906003)(2900100001)(9686003)(4326008)(316002)(2906002)(305945005)(256004)(5660300001)(74316002)(76176011)(6246003)(97736004)(486006)(446003)(33656002)(6506007)(102836004)(53546011)(44832011)(229853002)(99286004)(7696005)(3846002)(6116002)(476003)(25786009)(26005)(14454004)(186003)(55016002)(8676002)(478600001)(53936002)(81166006)(81156014)(106356001)(105586002)(6436002)(66066001)(86362001)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3774;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uThdCLAHUfriB1Suso4ni76fDKcGEhakX3URfQPAbjuEseFkTX47m1ETsID5P0PVOmJkQ9zWHrenW6FoAg+2H/1nsXjYG8LWcUyc58+qnX5CzIgQqWowqdiJ0ODh45J9xlwWWl91gGrzMjIqVHkvLf+qAb0JH76WL8sxkYum2Rez44KYhaU3w1zpW4NaDSKKrkRHgr0wv2Nk+csLXfd62i7+v/U58nh7IspmDpKutvOTZmSS7PquTMwxY68O5QjYzAF+twGgOg8QcOSPA6DThXpJ1ODPqAi6k7OAqFSvV7d6Y3b3lHx590mjO7u/B4OEOWznE33X7P/OTJsbcHsKabM5kZILFj3nU5B48Pu9J1A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b0f9f3-e28c-4dd7-cc65-08d6460956e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 06:05:24.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2018 3:11 AM, Marc Gonzalez wrote:=0A=
> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")=0A=
> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,=0A=
> which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and=0A=
> CRYPTO_DEV_FSL_DPAA2_CAAM as modules.=0A=
> =0A=
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
