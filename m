Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeDKKR6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:17:58 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:57140 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750801AbeDKKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:17:55 -0400
X-IronPort-AV: E=Sophos;i="5.48,435,1517842800";
   d="scan'208";a="276476128"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michel Pollet" <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6PpTkCAgAigajCACX+IUA==
Date: Wed, 11 Apr 2018 10:17:51 +0000
Message-ID: <OSBPR01MB1766927B331E6011CE7AEDDCF5BD0@OSBPR01MB1766.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1703;7:bgVcHpv55AU8vLNwNh+h4RbZLFLg4dF971X+idWF9nbD1itDfS2cDhBFjVIhoegHYk+ryhk5861LneTpy+YsE6/AUMPUZHmNlP113Oj2NCfShvDF24FMHAwi3i1dznK6n8Qf18a2zfKjE6Eay/Mj14AtTfqaIJsuUHeUVQxHLE4Gbt5Ax5BNCoX2MZeOf+homrT72XwXD0i3G8C0yjX2vuZnXLS2soHCTdCeIE+VLfLwugDwMYIxkwbep4dnY4RQ;20:DSaUZ/+SMnLtHh+D0WRgvQ0y3GbSnHJ6up48KgAKJGYvPm/RxlGsau3+wsrDVf1AW7jv1ALeb8H6nToqVhEFyXOYzrRmTuKAk4bl+1dMboh0x1QAL/n/o23doik1iNiTU4THeny6ODzkYrHGPCsQxGDvmWi1/9xwveouSxqOidY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1703;
x-ms-traffictypediagnostic: OSBPR01MB1703:
x-microsoft-antispam-prvs: <OSBPR01MB170356B87913FCB3BD7D4182F5BD0@OSBPR01MB1703.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:OSBPR01MB1703;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1703;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(39380400002)(346002)(199004)(189003)(6246003)(39060400002)(53936002)(5660300001)(6436002)(229853002)(97736004)(66066001)(53546011)(446003)(6506007)(54906003)(486006)(76176011)(476003)(102836004)(99286004)(316002)(86362001)(186003)(5250100002)(26005)(81156014)(3660700001)(8936002)(8676002)(81166006)(33656002)(3280700002)(25786009)(7696005)(106356001)(14454004)(68736007)(2906002)(55016002)(478600001)(74316002)(7736002)(9686003)(3846002)(105586002)(2900100001)(6116002)(305945005)(4326008)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1703;H:OSBPR01MB1766.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: VPSXWOrkxynZala2yHQVnidFZdIQ1Psmw+S3a/NwPMOK51YDxu4lqb2adzE6lJFtey/VaayzuRcBoE3+Ydo6tRNcAWcuv934EFYwv2kw/KrV1VCfLj/saQJXJPvVISEFwlkseZyLm5K4TsdIG17pjXvFeDLVaDwRyFN0PstbOg+bQxYvtNuxJoZO0UCtwJ2kjvikDBKHN1c27HTW3aiJvhcyiuRaoXkUjwplMTDE3xZ2b1YZdSL4sE5/tr2Lk5vTkKA+Htmp5yAH8hRXn0K4L3C8znObSpnlTlFW2lWd3MA6T9aWaOpsKkqINbvEFkfG9I1NFxHCXS5VgvoTYDsMF2LWpbLRptVedupL1DsW4SNELJA2/tZ84RxoOmA5hMd1lblZuVHa2OVU2qOCfZt1epB7VjePjFpz8xWJoV5+1T4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2cbdd981-4c26-4f27-5159-08d59f957ba2
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbdd981-4c26-4f27-5159-08d59f957ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 10:17:51.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3BAI5Gg009524

Hi Andy,

On 05 April 2018 10:43, Phil Edworthy wrote:
> On 30 March 2018 22:26 Andy Shevchenko wrote:
> > On Wed, Mar 28, 2018 at 5:22 PM, Phil Edworthy wrote:
> > > The DesignWare GPIO IP can be configured for either 1 or 32
> > > interrupts,
> >
> > 1 to 32, or just a choice between two?
> Just a choice of 1 or 32.
Sorry, I was wrong about this... the manual does not say 1 or 32. It says:
"Port A can be configured to generate multiple interrupt signals or
a single combined interrupt flag. When set to 1, the component generates a
single combined interrupt flag."

There is no other text describing this option, but I believe all GPIOs on
port A will have an interrupt. In our case we have 32 GPIOs on port A
and 32 interrupts connected to them.

Thanks
Phil
