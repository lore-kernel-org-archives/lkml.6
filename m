Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeEVCfQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:35:16 -0400
Received: from mail-db5eur01on0134.outbound.protection.outlook.com ([104.47.2.134]:13120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752522AbeEVCfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:35:12 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] gpio: mxc: add clock operation
Thread-Topic: [PATCH V2] gpio: mxc: add clock operation
Thread-Index: AQHT8WrcjYx7tNrcV0y/NY26BOdSk6Q7BhmAgAAAMECAAAGWAIAAADbg
Date: Tue, 22 May 2018 02:35:08 +0000
Message-ID: <AM3PR04MB13157C664631DC28298B7B85F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1526951717-12347-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BJy-jEKywyN515+5W-bmA01v7sWsgDj0=5wtBCqsHSYQ@mail.gmail.com>
 <AM3PR04MB13154C4D2EF4D42A16BF19E6F5940@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Btvr7R7Ah_=LT6yDxRkJS=bi0bHVFN9ZHi=HiKeQP4sw@mail.gmail.com>
In-Reply-To: <CAOMZO5Btvr7R7Ah_=LT6yDxRkJS=bi0bHVFN9ZHi=HiKeQP4sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0759;7:5VYyFLe40IVDi7FtFzV+8oetnwX/zuj3Vy9gFr/Af4fch9K3ueZGyTj/mwdzC6ljhpMkffTJJKQ8X1l+7e7owUEyA9RQUIK470WAkRuB3aw37ctmk1crTTNOxVknM4TshQ+ddWrM9Cs4g/2VBx+GEuXabtch4wKBu6xygHfPTK1fsU6o4PIxhJXbqwpydov55nSzbXLZilZbEHzPR4DtIqYqMiCAXwfrcgaDj+lmMpGfVZAEP/XwTyVp5s8HHEvU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0759;
x-ms-traffictypediagnostic: AM3PR04MB0759:
x-microsoft-antispam-prvs: <AM3PR04MB075969BDC8D2F010BAFC4D77F5940@AM3PR04MB0759.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0759;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0759;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(377454003)(164054003)(51704005)(24454002)(13464003)(199002)(189002)(20776003)(69226001)(63696002)(74876001)(74706001)(54606006)(33656001)(77096001)(76786001)(76796001)(81542001)(54356001)(93136001)(92566001)(46102001)(1411001)(64706001)(76576001)(81342001)(92726001)(77982001)(59766001)(56816005)(80022001)(66066001)(76482001)(74316001)(90146001)(65816001)(87936001)(56776001)(54316002)(74366001)(44376005)(87266001)(54206007)(2656002)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM3PR04MB0759;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: j3ap/tBUEYEJL/u5QpZ/mZVVeWtMmjIRa3hG0Hxq66Vl5AF/EHchJI0/hGQiN44VLCxS/Aio3ph9jNDqcTh+HAiFwXH5V6O5uR6i0rolAHMQICoOGMRdxFG/AVKTCMiF9ghu9r/OGnVmT1zELr2c74IQXQjOoPukQUS6qZ0hfIa0Ffdl0rMAfBuOxkH8RsaQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1457ba2d-a569-4f9d-51f8-08d5bf8ca28d
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1457ba2d-a569-4f9d-51f8-08d5bf8ca28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 02:35:08.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0759
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4M2ZKvc026660



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam@gmail.com]
> Sent: Tuesday, May 22, 2018 10:34 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; dl-linux-imx <linux-imx@nxp.com>;
> linux-gpio@vger.kernel.org; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V2] gpio: mxc: add clock operation
> 
> Hi Anson,
> 
> On Mon, May 21, 2018 at 11:29 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > Thanks, I will rework it into 2 patches, using SPDX.
> 
> I have just sent a series that converts gpio-mxc and gpio-mxs to use SPDX
> identifier and put you on Cc.
> 
> You can base your change on top of mine.
> 
> Thanks
 
OK, thanks.
