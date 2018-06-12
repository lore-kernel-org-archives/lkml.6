Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BFAFAC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A44C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iitpuNbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A44C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbeFLO1m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:27:42 -0400
Received: from mail-he1eur01on0079.outbound.protection.outlook.com ([104.47.0.79]:10447
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753448AbeFLO1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuRerVl9WlsHFx6kwjLN8Agmod7Cgvcu9gChalmmtmk=;
 b=iitpuNbFlZIys/F2EAeT6sVAL5jPOLjQk4ogIQwF89cofVhfgObSTBcgpEmbY5GWJkf5/MkeIjHLyB9klvM5drc8ioAKd0Mfgnf049KGBQlAr2zZTPSc5s1yX83HSi4oYmSNiVXwykUYbtlhmgXKhxSD++jwoiAQitNdybH7MCo=
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) by
 AM6PR04MB4261.eurprd04.prod.outlook.com (52.135.168.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 14:27:35 +0000
Received: from AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::db7:da35:1a5c:d7e7]) by AM6PR04MB4008.eurprd04.prod.outlook.com
 ([fe80::db7:da35:1a5c:d7e7%4]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 14:27:35 +0000
From:   Madalin-cristian Bucur <madalin.bucur@nxp.com>
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v3, 00/10] Support DPAA PTP clock and timestamping
Thread-Topic: [v3, 00/10] Support DPAA PTP clock and timestamping
Thread-Index: AQHT/kEN45XajT+VoUCyukvkQzFQXaRctlag
Date:   Tue, 12 Jun 2018 14:27:35 +0000
Message-ID: <AM6PR04MB400853DACF980BE0E117D9C6EC7F0@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4261;7:eHZyNRsZDYIMDOCWNieOPPmQQ6LUY7DE6shD5zfIfZ5Zsh8CJqJfw53/PyvBs3juGezQIiyk1IonOhPvM0IusTPtvLZ/l32px+h2lMD+BnmudYj1zk4PLrth1XDXkWMY4OZvAebr8lw6XX0eUsHV7/IcZFsasC8ZPj6mcWvUfUqHZNsAhoAy9iWlBYaTe7fcDrjNSQ+6U6fW+pP46kStPL46ZGqdrvwcadRX0/blgqaaP9GCmzm9oIZ5GD3yOW+7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4261;
x-ms-traffictypediagnostic: AM6PR04MB4261:
x-microsoft-antispam-prvs: <AM6PR04MB42615B6B7FBE560CF332732AEC7F0@AM6PR04MB4261.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4261;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4261;
x-forefront-prvs: 07013D7479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(53546011)(6506007)(53936002)(99286004)(110136005)(76176011)(9686003)(2900100001)(25786009)(3846002)(6116002)(33656002)(229853002)(81166006)(55016002)(4326008)(102836004)(6436002)(81156014)(7696005)(54906003)(6246003)(8676002)(316002)(26005)(39060400002)(86362001)(68736007)(2906002)(2501003)(3660700001)(14454004)(8936002)(5660300001)(478600001)(5250100002)(446003)(66066001)(476003)(105586002)(305945005)(11346002)(486006)(7736002)(74316002)(106356001)(3280700002)(97736004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4261;H:AM6PR04MB4008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QjpP7E9fVO+byj1iZhDVwYK5BWiaIChz7a9b+w57mgz2mVWVOobG78Pf/FnrUigaM29aE+1pKUKjOhaMrWCZ+X61tKFqtTAF5MKhrnk4ptSXW9OgxisSfRg/VfRIFaFgq3klHVXz2J8S0t1PLsqziRfGtSpdQR1BNfMZ3qsW7AK/cWE35OxCmoziAfHZyn7+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 953b19b1-1ea1-4705-ae89-08d5d070a463
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953b19b1-1ea1-4705-ae89-08d5d070a463
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 14:27:35.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Thursday, June 7, 2018 12:21 PM
> To: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Richard Cochran <richardcochran@gmail.com>;
> Rob Herring <robh+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> David S . Miller <davem@davemloft.net>
> Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Y.b. Lu
> <yangbo.lu@nxp.com>
> Subject: [v3, 00/10] Support DPAA PTP clock and timestamping
>=20
> This patchset is to support DPAA FMAN PTP clock and HW timestamping.
> It had been verified on both ARM platform and PPC platform.
> - The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
>   ptp_qoriq driver.
> - The patch #6 to patch #10 are to add HW timestamping support in
>   DPAA ethernet driver.
>=20
> Yangbo Lu (10):
>   fsl/fman: share the event interrupt
>   ptp: support DPAA FMan 1588 timer in ptp_qoriq
>   dt-binding: ptp_qoriq: add DPAA FMan support
>   powerpc/mpc85xx: move ptp timer out of fman in dts
>   arm64: dts: fsl: move ptp timer out of fman
>   fsl/fman: add set_tstamp interface
>   fsl/fman_port: support getting timestamp
>   fsl/fman: define frame description command UPD
>   dpaa_eth: add support for hardware timestamping
>   dpaa_eth: add the get_ts_info interface for ethtool
>=20
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-----
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++-
>  arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
>  arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   88
> ++++++++++++++++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
>  drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
>  drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
>  drivers/net/ethernet/freescale/fman/fman.h         |    1 +
>  drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
>  drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
>  drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
>  drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
>  drivers/net/ethernet/freescale/fman/fman_port.h    |    2 +
>  drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
>  drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
>  drivers/net/ethernet/freescale/fman/mac.c          |    3 +
>  drivers/net/ethernet/freescale/fman/mac.h          |    1 +
>  drivers/ptp/Kconfig                                |    2 +-
>  drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++--=
-----
>  include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
>  26 files changed, 361 insertions(+), 115 deletions(-)

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
