Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeC3HCS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:02:18 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:17224
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750764AbeC3HCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:02:16 -0400
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
CC: Allan Nielsen <Allan.Nielsen@microsemi.com>, Po Liu <po.liu@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Thread-Topic: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch
 support
Thread-Index: AQHTwuMtn1U9kei0Pk2jCu/kDM4elqPoX/vw
Date: Fri, 30 Mar 2018 07:02:12 +0000
Message-ID: <AM3PR04MB0743F2211B206D25B7D0A514E6A10@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
In-Reply-To: <20180323201117.8416-6-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1249;7:M2LLRKcQppaFbvr5VZxu6csxZsfXG4bAxED/QN3d8WFmu+lleuy/5vwTeRuX7s8kGAVucsctMO020+cpuNrx9Y/JXkXgG2tOMiDvWaz6FRZep5kce8Bhhfvs6BbIfx9LLgMWE2RHC1TjJdGKqtSm3k4LQaic9Fxzya85byxbZ7gOnDHdTii3yqWh99tT2t3tmzbnDNhkgm6lJEiymo0yAePyEnINqSjUNwobtORU4paZFRqi/xUuzoIu0Uv1OcG9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ec980eb-11a6-43ca-0269-08d5960c29d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1249;
x-ms-traffictypediagnostic: AM3PR04MB1249:
x-microsoft-antispam-prvs: <AM3PR04MB1249C30B2B19CF8B740B69DAE6A10@AM3PR04MB1249.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1249;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1249;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(346002)(376002)(39380400002)(199004)(189003)(33656002)(9686003)(54906003)(8656006)(68736007)(99286004)(105586002)(25786009)(7736002)(4326008)(305945005)(3280700002)(14454004)(81156014)(53936002)(5250100002)(229853002)(2906002)(8936002)(55016002)(81166006)(106356001)(6436002)(3660700001)(8676002)(2900100001)(110136005)(86362001)(5660300001)(76176011)(186003)(66066001)(26005)(446003)(11346002)(6246003)(476003)(486005)(316002)(486005)(102836004)(97736004)(6506007)(74316002)(6116002)(7416002)(478600001)(7696005)(39060400002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1249;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C3u7qZeykBBZ2piUhURyp5h417+fep3IdpJicuaXh8XVDOvQXf9M6+rPo2rFhbtADnRIVYYtp5GRPest2yAkW9uC685nsFq0DSEUGHz83t4HlPUJv8pusVP+55PjOnWkrZ3kfh/fde3VQLYoWpGNZEKv0ycbXzML4R5gXstkZ17tfdLd6njOd6sAJcpKSpIryXymsOtRIQ08edS3cgKg9T4eyAnHokEqZQAS4Iq9KpGTF2kjPx6ompiweO36GU1zorhvnBi032sNfN80A3vID3JKB2xl2re+RBM7NOWcQiOiBIVIutW6mTLSkD7ofbggqUdJ3lZGaKp4Xc03slfT27ps//UZI9WFVxa6+bUoSj2bMXszIWQePW2AB9wUvDkc7R/Is5pySbxWtpmKNPASi0dYhUL9wzZ4lxkO4mFtBXM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec980eb-11a6-43ca-0269-08d5960c29d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 07:02:12.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2U72NeV009954

Hello Alexandre,

> +
> +	register_netdevice_notifier(&ocelot_netdevice_nb);
> +
> +	dev_info(&pdev->dev, "Ocelot switch probed\n");
> +
> +	return 0;
> +
> +err_probe_ports:
> +	return err;
> +}
> +
> +static int mscc_ocelot_remove(struct platform_device *pdev)
> +{
> +	unregister_netevent_notifier(&ocelot_netdevice_nb);

This should be replaced with a call to unregister_netdevice_notifier(). And also makes
the inclusion of net/netevent.h not necessary.

Best regards,
Razvan
