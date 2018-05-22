Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeEVC3S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:29:18 -0400
Received: from mail-ve1eur01on0054.outbound.protection.outlook.com ([104.47.1.54]:7744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeEVC3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:29:14 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] gpio: mxc: add clock operation
Thread-Topic: [PATCH V2] gpio: mxc: add clock operation
Thread-Index: AQHT8WrcjYx7tNrcV0y/NY26BOdSk6Q7BhmAgAAAMEA=
Date: Tue, 22 May 2018 02:29:10 +0000
Message-ID: <AM3PR04MB13154C4D2EF4D42A16BF19E6F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526951717-12347-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BJy-jEKywyN515+5W-bmA01v7sWsgDj0=5wtBCqsHSYQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BJy-jEKywyN515+5W-bmA01v7sWsgDj0=5wtBCqsHSYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB257;7:1qgKAromWEjICleLWLXWaWmx7ixwfHv1fZyAAgd7a5p17CHRC47jNnxfz63UF08tPdBRiOh7GUG0a1dbahYSxRyWcjbGLnkqRQDQ528x7hbC3nsmZMe84m+GSpByiQtbfR/xeqK6s2z6LR3ZI+gWCSJtg4I93g+fPZhoezAII1FqoPv3hECoc6LwecYh/vQdiS8LZIeEMwf789aoisCIuoNC30iqwpAsgDsDQl+Nk3tSygU0PYqluUJjiq07QypG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB257;
x-ms-traffictypediagnostic: AM3PR04MB257:
x-microsoft-antispam-prvs: <AM3PR04MB2576D7C1C48CA9B28653C4CF5940@AM3PR04MB257.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB257;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB257;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(13464003)(76176011)(5660300001)(229853002)(186003)(26005)(2900100001)(102836004)(97736004)(5250100002)(316002)(6916009)(54906003)(6506007)(8936002)(86362001)(53546011)(74316002)(7696005)(2906002)(9686003)(8676002)(4326008)(66066001)(6246003)(486006)(3660700001)(55016002)(3280700002)(305945005)(99286004)(446003)(68736007)(6436002)(1411001)(39060400002)(7736002)(25786009)(33656002)(6116002)(476003)(106356001)(53936002)(478600001)(3846002)(81166006)(14454004)(11346002)(81156014)(44832011)(105586002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB257;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: R2neh8Fj3f1ZCfaUTWrxVANbm9gRGBx8GsoMN5inhziE44eIgezAGDSsckEYT17oNPCNzF0Xksw795oJ55XhD27w2bTaOJDceLKjtlexywNFkGeDvMGHM5X/ncfFqZiSlZj3ro4HOe+5D0TKH8RjbPj06p4RJZo133v10IYiVF7ewpT0ApvLWsxhByDP7/Zk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 29b26796-fe53-45f9-35eb-08d5bf8bccef
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b26796-fe53-45f9-35eb-08d5bf8bccef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 02:29:10.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4M2TOTO026648

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Tuesday, May 22, 2018 10:28 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; dl-linux-imx <linux-imx@nxp.com>;
> linux-gpio@vger.kernel.org; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V2] gpio: mxc: add clock operation
> 
> Hi Anson,
> 
> On Mon, May 21, 2018 at 10:15 PM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > Some i.MX SoCs have GPIO clock gates in CCM CCGR, such as i.MX6SLL,
> > need to enable clocks before accessing GPIO registers, add optional
> > clock operation for GPIO driver.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V1:
> >         add missing clk header;
> >         remove FSF addresses in copyright to avoid check patch ERROR.
> >  drivers/gpio/gpio-mxc.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c index
> > 11ec722..2026f94 100644
> > --- a/drivers/gpio/gpio-mxc.c
> > +++ b/drivers/gpio/gpio-mxc.c
> > @@ -14,12 +14,9 @@
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >   * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program; if not, write to the Free Software
> > - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> >   */
> 
> This is an unrelated change and should be part of a different patch.
> 
> A patch that converts this driver to use SPDX would get rid of the FSF address.

Thanks, I will rework it into 2 patches, using SPDX.

Anson.
