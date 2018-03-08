Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934174AbeCHOb5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:31:57 -0500
Received: from mail-he1eur01on0117.outbound.protection.outlook.com ([104.47.0.117]:45370
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755559AbeCHOba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:31:30 -0500
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
Thread-Topic: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
Thread-Index: AQHTq+rZh4FxrXNPTEqh+gv+36lx2aPGd9uAgAAElYA=
Date: Thu, 8 Mar 2018 14:31:26 +0000
Message-ID: <1520519485.23006.6.camel@toradex.com>
References: <20180222143825.1517-1-marcel@ziswiler.com>
         <20180308141501.GH3529@ulmo>
In-Reply-To: <20180308141501.GH3529@ulmo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR05MB1426;7:83soXfbyvC80DEpInPEEv5OzrpNAMPrbQEGRbhYvapoU3NGQeFHi0g0GfsIuIMlRGSwuOk2oBGNihJBDZuvjDdVuRt5cqaEMasfYDvtCoNgeW69Rm7FcW6p1Gt9N6Y8SSMu+Zlz86O/Vyf7hbXWdQU0Pd8v6u4/sXLsT3Z6z06sZixmZ0ym4Eq1XJEti6aNOdZdoigVe+NT8CHP8JlbIrGLRPTr7SF+x4cy8BW8hABe88pXVRpCFx0gH7R9wiKRk
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 351797a3-d152-49d3-1af0-08d5850146b5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR05MB1426;
x-ms-traffictypediagnostic: AM3PR05MB1426:
x-microsoft-antispam-prvs: <AM3PR05MB14265F1A4DB3DD9FA34AD497FBDF0@AM3PR05MB1426.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR05MB1426;BCL:0;PCL:0;RULEID:;SRVR:AM3PR05MB1426;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(366004)(376002)(346002)(396003)(377424004)(189003)(199004)(59450400001)(2501003)(102836004)(5640700003)(7736002)(6436002)(2351001)(6916009)(5250100002)(3660700001)(2950100002)(103116003)(106356001)(5660300001)(68736007)(3280700002)(2906002)(478600001)(3846002)(14454004)(7416002)(6486002)(305945005)(53936002)(6506007)(26005)(97736004)(186003)(6116002)(6512007)(6246003)(81156014)(8936002)(81166006)(8676002)(99286004)(76176011)(66066001)(25786009)(1361003)(316002)(4326008)(105586002)(2900100001)(39060400002)(86362001)(36756003)(229853002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR05MB1426;H:AM3PR05MB1364.eurprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: q1LUNCak1cT+d4FKvSQmEa40M3i/VdWm3TG8M2tczVa+fwbIeg1gVbSYUjNO9sCDQgpFpSMyU7Q/PaYL7JmscVNLeqjPIwhVt/+QB+spKrALUliXBiNUzJ5tJrt8pCmkY7rSQtobwlbQirsBdKaaV3H4bsUdIpXDYjIDk17sLtRHJbQiyvIYgPAcvdVXZyGZ3YS3GA1Y2+f4k5so7IjZI1LbPc//J7pL4Z0qSj1EuQz3obtuzq3NbvBfEbCRn+0JyGTmyChtatCT1lk4FYkvo8xUzecEVh2M7GxyTUTrvNZkAZdcwvo0Wt2MsjJYlHMHVECQoliRc6h34k1sVLc1iQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5172D0DCC432A84FB5D47AB81AFAED9A@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351797a3-d152-49d3-1af0-08d5850146b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 14:31:26.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR05MB1426
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28EW2oD024864

On Thu, 2018-03-08 at 15:15 +0100, Thierry Reding wrote:
> On Thu, Feb 22, 2018 at 03:38:25PM +0100, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Since commit f8f8f1d04494 ("clk: Don't touch hardware when
> > reparenting
> > during registration") ULPI has been broken on Tegra20 leading to
> > the
> > following error message during boot:
> > 
> > [    1.974698] ulpi_phy_power_on: ulpi write failed
> > [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> > [    1.985434] tegra-ehci: probe of c5004000.usb failed with error
> > -110
> > 
> > Debugging through the changes and finally also consulting the TRM
> > revealed that rather than the CDEV2 clock off OSC requiring such
> > pin
> > muxing actually the PLL_P_OUT4 clock is in use. It looks like so
> > far it
> > just worked by chance of that one having been enabled which
> > Stephen's
> > commit now changed when reparenting sclk away from pll_p_out4
> > leaving
> > that one disabled. Fix this by properly assigning the PLL_P_OUT4
> > clock
> > as the ULPI PHY clock.
> > 
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Updated device tree binding documentation as well.
> > - CCing Dmitry as well.
> > 
> >  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt |
> > 4 +++-
> >  arch/arm/boot/dts/tegra20.dtsi                                   |
> > 2 +-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> Applied, though I've split this into two separate patches, one going
> into for-4.17/dt-bindings and the other going into for-4.17/arm/dt.

Thanks, Thierry!

BTW: Do you know what is happening with my T30 USB patch? Is there
anything I may do about it?

> Thanks,
> Thierry
