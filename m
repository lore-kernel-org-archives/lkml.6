Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7F02083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="utGeHuvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7F02083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeJANsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:48:18 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:29280
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728677AbeJANsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peMDkdfLbJQmoksqLokTIDXaC9gaNinOojBRs7q4kiY=;
 b=utGeHuvPB9tRleY6dKDvzqPaGll8mVda9ncIsMAGlmIuSJ48ofL0k+8ynN0W0b7eMmEDcpxFZnFPh0zku7GPXl0+Lqd40XxlzJdnN5rjFwKBHSqCXcFowMUFF18dEatNafE5At6M0/whWnH4kXbbowmC1Kv88D+qeFpk8y1OCOg=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4006.eurprd04.prod.outlook.com (52.135.160.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Mon, 1 Oct 2018 07:11:57 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::2806:3ebb:e234:4123%2]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 07:11:57 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dpaa_eth: Remove useless declaration
Thread-Topic: [PATCH] dpaa_eth: Remove useless declaration
Thread-Index: AQHUWTy3q+wACAoAcUm3g4sJsB5jCqUJ+PRw
Date:   Mon, 1 Oct 2018 07:11:57 +0000
Message-ID: <AM6PR04MB4008E17B1D850FDB118382C7ECEF0@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20181001041029.2334-1-natechancellor@gmail.com>
In-Reply-To: <20181001041029.2334-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4006;6:K9eja7Ma5HC16btDxO+t3TZoDcyjQ0qrbWfOydwRmQF2JOaamFscd9z52cp3PefNAfRRLjc13Nc42XGGT96TiTNNx9QpVR5ltEf7bGOGzLW+e7UEAa+0Pwi3OJoNwp7Lfhc6dRMkS5w5lS2iGNtQd3s9yzuKPnnxesoTsifbuG0jr2jy87QywKwSKX+JkQJdpKsF2oxNeaH/f4mSAfu1GJ8u57fHqr4G+CLG/WcA71605ik1u/gLYZRQCyZjF2eOtTtWsP/lOyrAfHzRPWnPcwlHdBrSbuF4+Zo8LVebR5n0GvjFTA+P5tEml5AcePBHwqexsfPtGxo8lwSWUYYWqeFnQNWVv6P/9ll55VmwhDxIoVeN0srtIxs8eX/jxsbJmF39P7Kkj/ubXmfyk9jHV4Bz7meHIY1v2buILDdaRWxtB83x8gbphPRM1pl9LZjOyg6r907qfDF1JLN4CMsiRw==;5:2AbrmCvPpYLhKmiq+Jg2LBV2w/aunW7niv17mP7sDbVTiT6dlkWZ08yOhKieBfVDqQQEh7E/RGTFbgW/CilbC8TMKOd/6vN0L04Yuv1+dWGGTxcEUaJ9MDx01unGGMq7Ge8ME89YMB0TXfvKamJsE7VV+qUnrLOqFP6cUHu3lvc=;7:okGNWDwjCWR3QOXegKAvZI3cXioobLMb2ayTwH1XikDZ0M8tOgwg5gDXJbGxIJDRxJXwOoM3yyiTfXpjhxx3Hj27tcsUBA0u4Bh9GX5oaWxTm3kmY+Qqkf8EtV2+P89xQ4HAG3YUyT5QJ3HtrtaN3/8XPFCaz/ShXmJEfeouiePRy+kRSy0PqYpdW1I7hwh2+xeOWyDS19boq9km8OJFZnFOQZ0x/3kZyaVhdS1zYXWR3ql/WaehcMHKItQcHxzW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8750d1d0-07d1-4398-cb6f-08d6276d2cab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4006;
x-ms-traffictypediagnostic: AM6PR04MB4006:
x-microsoft-antispam-prvs: <AM6PR04MB4006D443D7C369E82C24E6D0ECEF0@AM6PR04MB4006.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM6PR04MB4006;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4006;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(13464003)(86362001)(102836004)(6116002)(3846002)(26005)(76176011)(316002)(6506007)(7736002)(7696005)(53546011)(229853002)(14454004)(6436002)(2906002)(105586002)(106356001)(5250100002)(99286004)(33656002)(53936002)(39060400002)(476003)(256004)(486006)(55016002)(478600001)(97736004)(74316002)(446003)(11346002)(68736007)(5660300001)(9686003)(4326008)(14444005)(71190400001)(66066001)(71200400001)(34290500001)(81156014)(25786009)(186003)(6246003)(2900100001)(81166006)(8676002)(575784001)(54906003)(110136005)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4006;H:AM6PR04MB4008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xd6YD2HX7HAQ8Qn9ujkUc1hk+8wjlTVWTa630D0xfIfu8CNXZkMO/+L3sGYGDNRmPIVUlo1cnFfC1UVea3TbCCo7S6vUftE2Vi43LI7nKBAbyGknfox5H39sIOj4vvKo0CtRB4e7CejbYoTSNgfZlb05YdkWWskvOoHpkfidU4d3bew3gIAQpK99JZUipHlpsTpjbZOldWmuk9SWuMvwM2STlXqanDHH6rDtD/jRoNimJxa5ivsFj8AiSaE8QA6wQ1X/bMXJqnlClQkDn4CHBn32QjWSx7gNdA4ceU3wBGF+JzzXiCRMkf0nLKH7mdDFHubJ+wZdMK21OWK4Pn2b4xgfyDTvR3pAAMuzSRL0eas=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8750d1d0-07d1-4398-cb6f-08d6276d2cab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 07:11:57.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nathan Chancellor [mailto:natechancellor@gmail.com]
> Sent: Monday, October 1, 2018 7:10 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>; David S. Miller
> <davem@davemloft.net>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Nathan
> Chancellor <natechancellor@gmail.com>
> Subject: [PATCH] dpaa_eth: Remove useless declaration
>=20
> Clang warns:
>=20
> drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2734:34: warning:
> tentative array definition assumed to have one element
> static const struct of_device_id dpaa_match[];
>                                  ^
> 1 warning generated.
>=20
> Turns out that since this driver was introduced in commit 9ad1a3749333
> ("dpaa_eth: add support for DPAA Ethernet"), this declaration has been
> unused. Remove it to silence the warning.
>=20
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index 84843de25c7b..6e0f47f2c8a3 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2731,8 +2731,6 @@ static int dpaa_ingress_cgr_init(struct dpaa_priv
> *priv)
>  	return err;
>  }
>=20
> -static const struct of_device_id dpaa_match[];
> -
>  static inline u16 dpaa_get_headroom(struct dpaa_buffer_layout *bl)
>  {
>  	u16 headroom;
> --
> 2.19.0

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>

Thank you
