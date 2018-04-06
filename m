Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeDFKU5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:20:57 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:45855 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751802AbeDFKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:20:54 -0400
X-IronPort-AV: E=Sophos;i="5.48,414,1517842800";
   d="scan'208";a="276021137"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6PpTkCAgAigajCAAZ9igIAAA/hg
Date: Fri, 6 Apr 2018 10:20:46 +0000
Message-ID: <TY1PR01MB17693CFDF889498956107783F5BA0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com>
 <TY1PR01MB1769064C77AE3E5ABA4993DAF5BB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdX34f1pDCVqNV43_qtzqZ-fruOcUsUN_Ysz4ihJwe-56A@mail.gmail.com>
In-Reply-To: <CAMuHMdX34f1pDCVqNV43_qtzqZ-fruOcUsUN_Ysz4ihJwe-56A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1101;7:+tI0i/GuPkDOHPPw9372Pt28rZgy265z9RnPlpv+3atLZpjn9ENaYw5IuyIFTM8NtytomXxJ1lf2BF5aB/mSuqShAEq0Crv+GP1kviwt9oZnyQWCmsSVOgxrX1dbzQZbstDXe/B4XMyoEfY4QSKoGOGISfVTAsvAbPbUpwxvn95UkgZJlj65pP/FFyNsqSC8NRraRRHDmpAXQVS64sbOldQgsGoa4vpdwX7aIdHwfv81juBAZXK/yYKJBo/JyOXI;20:OVQRrKJIQxVud6k7oPGV6mWIlF9y/bgvcSzPuTHiIsYHI8i/92I4sDK49WJYi95f3Wnvn1Uq3f3q2lRi3PrATgsrodQeT/PDiP+u6qdJ5T5T6ZMKpUQtAPG0fW+khvRT3WSZyxTiWU/KCDxrr4BpFOyAyPWTdhp272ZWJc81hfo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 75a320cd-f4ed-4083-63b0-08d59ba80fca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1101;
x-ms-traffictypediagnostic: TY1PR01MB1101:
x-microsoft-antispam-prvs: <TY1PR01MB1101573DF820F4603C3AD9A1F5BA0@TY1PR01MB1101.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:TY1PR01MB1101;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1101;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(476003)(55016002)(9686003)(446003)(2900100001)(6436002)(11346002)(7696005)(76176011)(6116002)(3846002)(486006)(68736007)(93886005)(3280700002)(5250100002)(25786009)(39060400002)(97736004)(33656002)(6916009)(4326008)(106356001)(7416002)(7736002)(6506007)(53546011)(86362001)(54906003)(105586002)(478600001)(8936002)(81166006)(81156014)(14454004)(5660300001)(3660700001)(74316002)(305945005)(6246003)(53936002)(8676002)(186003)(102836004)(66066001)(316002)(26005)(99286004)(229853002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1101;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: IjP7xveLrKgmKepQO9t3ixl37Q/gc8/KNAHj1I1z2fEFnl7YEipy4SH3unNr5UXkpy2RHNAMoz+7TdnQ6Tgr5PNYAJUGvkcw7HBMX85NlCYYji3rxKtwVe/3NcR0wIBAARGTsuSGDddQV4rTPa/+aYUcHT6uDjVyiY7tsHlQgn7mgUOBTBtGuGD/cZ8NoM4eM425xBvfXkZ5rL9TCXbNKV0mtmgdVlA/TnUvaHSfxp5W5sKfD/Rn3qUlP97CiJpOaq2XDWipFGJi+851r9+pbdXRb+AyMCRSDhW4cLYXj775h3W+EHHfEhZs0C2HrCoUPPb7pAmp4y+tTJH7LZV11ysnrVbesRtszgs+VUEZ5HTqVQ/RsNsDsI/k9JS8fWg6Sv4MdK28eAOlTCDZOcySC+jqAkIyYYVsDX60zevuGeE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a320cd-f4ed-4083-63b0-08d59ba80fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 10:20:46.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w36AL5Iu000979

Hi Geert,

On 06 April 2018 10:57 Geert Uytterhoeven wrote:
> On Thu, Apr 5, 2018 at 11:42 AM, Phil Edworthy wrote:
> > On 30 March 2018 22:26 Andy Shevchenko wrote:
> >> On Wed, Mar 28, 2018 at 5:22 PM, Phil Edworthy wrote:
> >> > The DesignWare GPIO IP can be configured for either 1 or 32
> >> > interrupts,
> >>
> >> 1 to 32, or just a choice between two?
> > Just a choice of 1 or 32.
> > Note that by 'configured' I am talking about the hardware being
> > configured in RTL prior to manufacturing a device. Once made, you cannot
> change it.
> > This configuration affects the number of output interrupt signals from
> > the GPIO Controller block that are connected to an interrupt controller.
> 
> Differentiating between different versions of an IP block using DT properties
> is usually a bad idea, for several reasons:
>   - What if you discover another difference later?
>   - You cannot add differentiating properties retroactively, because of
> backwards
>      compatibility with old DTBS.
> 
> Hence I think you should introduce a new compatible value instead.

This is not a different version of the IP, just a different configuration option.
Most IP blocks have a huge number of knobs that can be twiddled by the HW
people, such as cache size, UART fifo depth. I think this is no different.

Thanks
Phil
