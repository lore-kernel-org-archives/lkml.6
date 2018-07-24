Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAB0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35A20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D6jK/g+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E35A20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeGXPpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:45:24 -0400
Received: from mail-db5eur01on0076.outbound.protection.outlook.com ([104.47.2.76]:6314
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388373AbeGXPpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYo0gKts61nZzEys4N/7whHaM5X6KbK7xRRBLb8Ph8s=;
 b=D6jK/g+XzabYmqe/DqZfzQ17PkY+GgZYJp8AdyBlUUq3iQFXM/lFA2EB8WfKJ59F9DI+/5DoSVITziB5ECEY76UsEbDV5aNcRV171orkRvJEtsu6spxnzvS69JWtrT6KLGS2DMOVZlPqEvAUOKRpKMc9Ft8DxJ0/UCfJGZnWCe4=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB0806.eurprd04.prod.outlook.com (10.242.253.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 14:38:33 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::84f9:3f8e:a8c7:1720%12]) with mapi id 15.20.0973.022; Tue, 24 Jul
 2018 14:38:33 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUI1mrGlFQJvKpDUqhG1SBjEJbiaSecNfg
Date:   Tue, 24 Jul 2018 14:38:33 +0000
Message-ID: <AM3PR04MB33800EB3509E6715AC49DC294550@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
 <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0806;6:vJMH1FMIYP6kAjx9dRK1NRodBEoCN2rpRlR9iCuFpLJ8a1KFpjjzhTq5lNPTXn+duBPXSqu+vyqBcsUexgoQ5Nd5o/VWH6QrDzylIKgq3khccCqWePI305vddE5b2vr23TPyHd65kD1bLmbWn6H6VyShUB2BPldIrlV1QZjpLQe9kWKHTRWRHrF9cG5q8eZZr93PgjpeBkagGA7kxmH0paY8TFHpQhZG98LgN4jkkchbl9wZ3+Ner8iNZ4pJmOsfCYi8fjB2wjjmyIt+nSYRaHwrh+SVkFdjxPY//hphjCBQqcgxdRCLNCrlk0eR+6kVAMVdby18k/RCYYK0BDxP/2nCgMaDUSafm3UPj7LzghjuiTvmy40OHx/S3MRUzn87HKrcAktaI8C76mFXsQnAw44kbeMH6Ort/LtiRG6N26t32d/Xc//yvkX9JaEWtBbCOQ/HNOmwnRcO710rsbfvpw==;5:ltdiFPGH77JfeuxkhtgkFLiiGCKmvLXfTv69VIskTraMHTtON9/E4IvXth7bs+hr1CNhkdBi63duSgg+bklOMAVpNMWpx2IHDYAJqn/kGwCfGCJcdMxU+0Kc7pqA47EgaWxZE4sQwFJhQqMHk4vwkHEKfPax0U6I+6TbmB1Rklw=;7:EO8MZndeqexK41F1Jz+Hjvy0aUpHbY2aKlC51r9Q9xSsvcs5elqAcmyLN1WXcU3KXgHNA97PySTdsHajqMXozXLFAVgDe8lSjCdONaCUMiwMfS5HtNihxG4fkIj7Ofthxgkj6Kr6JWzv+YMCIbMr/TaUVtOEPlxkCh79MVsGbb46zwP1JX/SeQMJWehLiCZ/mwsu+tXQjsoMD8SLezY1fn7WOaLQRPFzAHDbNgjJ1z802v79xou+Lbsa3LHVWWSu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1957d5df-3198-4955-87fc-08d5f1732223
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0806;
x-ms-traffictypediagnostic: AM3PR04MB0806:
x-microsoft-antispam-prvs: <AM3PR04MB0806316F76E9BAE5F42DCFB394550@AM3PR04MB0806.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0806;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0806;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(189003)(13464003)(199004)(476003)(81156014)(3846002)(305945005)(446003)(5660300001)(8936002)(66066001)(6116002)(11346002)(54906003)(2201001)(6436002)(486006)(8676002)(55016002)(110136005)(86362001)(68736007)(99286004)(9686003)(102836004)(81166006)(26005)(6246003)(53546011)(6506007)(14444005)(2906002)(106356001)(105586002)(2900100001)(316002)(7736002)(97736004)(5250100002)(53936002)(478600001)(4326008)(14454004)(7696005)(6636002)(76176011)(256004)(229853002)(33656002)(74316002)(2501003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0806;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OeoWxeITegzt392bG8DmcDW9Z8zqruUolJ+Hpv4DhZfg2ijdxFfUiZInEHDH2ffEGY++dUjyuuJpSWWHtn8X+uzSUoUpwUACX79JOfsYU37YMEGQ+hG59q4hJl/vmT/cL9GrSvJgmJudE4UL5hOoU3XLeQu8PyW0s6I8TvT1knp4RkiWMENptgOBQxMHDj4wS2rpROW6O8lGRcCFa7QR16rNuxqsrmWkR7jAPDe73FjZU7T4YAKs23VOWyOoXHdh79os2Q02+PhpShgKLP3nXLrmyYBGJB1auSe2RjDWunfNtO36hcO6lfYyJvrRytLR+zdBDtFl9Cr6aNvvBYuUX6PolULnIGpuI3WZupbZ6Go=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1957d5df-3198-4955-87fc-08d5f1732223
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:38:33.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0806
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Horia Geanta
> Sent: Tuesday, July 24, 2018 5:35 PM
> To: Roy Pledge <roy.pledge@nxp.com>; devel@driverdev.osuosl.org; linux-
> arm-kernel@lists.infradead.org; gregkh@linuxfoundation.org; Leo Li
> <leoyang.li@nxp.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; linux-kernel@vger.kernel.org;
> arnd@arndb.de; catalin.marinas@arm.com; robin.murphy@arm.com
> Subject: Re: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
> drivers/soc/fsl
>=20
> On 7/24/2018 5:21 PM, Roy Pledge wrote:
> > Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-
> mc/bus/dpio
> > directory to the drivers/soc/fsl directory.
> >
> > The DPIO driver enables access to the Queue and Buffer Managemer
> (QBMAN)
> > hardware of NXP DPAA2 devices. This is a prerequiste for moving the
> DPAA2
> > Ethernet device driver from the staging directory.
> >
> For the series:
> Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>

Also:
Reviewed-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
