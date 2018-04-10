Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeDJPAk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:00:40 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:25807 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754043AbeDJPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:00:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,432,1517842800";
   d="scan'208";a="276380222"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Rob Herring <robh@kernel.org>, Hoan Tran <hotran@apm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6P44lCAgAC3EuCAAIXioIAABBGAgAAIbAA=
Date: Tue, 10 Apr 2018 15:00:31 +0000
Message-ID: <TY1PR01MB17693D030D9B4BEC6D4C58BFF5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <20180409192013.5rytwgoixtyraow3@rob-hp-laptop>
 <TY1PR01MB1769EC6963CFB3D720D1B9EEF5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB17691846E8DFA86DA831B8B9F5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdUjYT466uPAHSoAWwQL2KaRUfM1njwpBkHwSK9fbGZTag@mail.gmail.com>
In-Reply-To: <CAMuHMdUjYT466uPAHSoAWwQL2KaRUfM1njwpBkHwSK9fbGZTag@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1852;7:7Z65Sh2ZHWoOjoe1Wf22TE3QIaxQoCkDEUVZKGi6ODe+CZ64FUQaxBJg69353GRUEkW/NR78t50HNBXl7KSE1vuiJ8IvkXvvHvXa7edIzJJKf2bOdsfja4pHhHJZo1cXjW2dc69fWWRa3xsdFGhi4bM7/HgZ2EAtA5ozTefWQFsUluaQ8erVjQYAW+R6IeN0UQstsA4Guz1nB2poJ3/21HguiC0MaoKKzfFKlp2ESGyIytBeeR4qPC+hsy0v0pPG;20:vMYZA42HZRl7KbFqLWIoHmyjJNtad3o0WxUuw8ZM0n+2u+KzGzlnkSlOAZ9qmQsqHLgZUkuzpMVy8luWs55BNrYN1b4CP/4MVJ8GUV0MUFl2dYGaJu1ZPxcIMAGybrqES+SFsx+9hGEqprYcoH0xdNeMCvDvuGikIQRk6qTl8A4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 344f0328-642a-4694-5133-08d59ef3ce67
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1852;
x-ms-traffictypediagnostic: TY1PR01MB1852:
x-microsoft-antispam-prvs: <TY1PR01MB18529F8BAFAEF7C1A4DA6AC1F5BE0@TY1PR01MB1852.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:TY1PR01MB1852;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1852;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(396003)(39860400002)(376002)(39380400002)(189003)(51914003)(199004)(6506007)(7696005)(7416002)(25786009)(4326008)(81156014)(3846002)(6116002)(26005)(186003)(53546011)(81166006)(39060400002)(478600001)(53936002)(6246003)(8936002)(316002)(446003)(486006)(8676002)(76176011)(54906003)(102836004)(11346002)(86362001)(476003)(93886005)(99286004)(14454004)(229853002)(6916009)(5660300001)(5250100002)(33656002)(68736007)(3660700001)(66066001)(3280700002)(74316002)(305945005)(106356001)(105586002)(2906002)(2900100001)(55016002)(97736004)(9686003)(6436002)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1852;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: X5A4j0GaXEFKQQybZq9IoyuZE6XDZB/vC7tGKYFRQs0jhHHoJNFGr8d0vxRLjCaB49qCCnoNQVBJwKpsMoDMuCWfDRp1nwIko6P7DQGy+L2yjxaH+6VPSE6eIb+geLlqzMi4H0pIsOZQIfN180MEwxKhX/AnE96eoBwzDtZKQGMMqnYyZTMJL7oDSRmw72yLJjCTnVXs57RnQFSDr7mRWgvXQ+pIwv0w0UarycI2X6RCmSI2starRkZB/cRU3BraZkDEbuzSikKEMUh61Vr1HWHxCteS8hF0+6uljwsZ4YaLjHiK5YElKa4N2rJlUnR7K/c1BoLKDD3boJtclPKtMf2W3g0zyyoHlj3zv3xZ+dYZp5iqdk8CI5ALKhC851tjquvUG2OYrTptNQ1Gxdnt78vYUI/6riTfylpSm5Q+KuY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344f0328-642a-4694-5133-08d59ef3ce67
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 15:00:31.8349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1852
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3AF1ZhR004113

Hi Geert,

On 10 April 2018 15:29 Geert Uytterhoeven wrote:
> On Tue, Apr 10, 2018 at 4:23 PM, Phil Edworthy wrote:
> > On 10 April 2018 07:24 Phil Edworthy wrote:
> >> On 09 April 2018 20:20 Rob Herring wrote:
> >> > On Wed, Mar 28, 2018 at 03:22:30PM +0100, Phil Edworthy wrote:
> > [...]
> >> > > +- interrupt-mask : a 32-bit bit mask that specifies which
> >> > > +interrupts in the list
> >> > > +  of interrupts is valid, bit is 1 for a valid irq.
> >> >
> >> > This is not a standard property and would need a vendor prefix.
> >> > However,
> >> I'd
> >> > prefer you just skip any not connected interrupts with an invalid
> >> > interrupt number. Then the GPIO number is the index into "interrupts".
> >> Makes sense, I'll rework it to do this.
> > Err, what would an invalid interrupt number be?
> > If I use -1, I get a DT parsing error and 0 is certainly valid. If the
> > number is larger than the valid interrupt range I get errors during probe.
> 
> Perhaps using interrupts-extended instead of interrupts?
> 
> E.g.
> 
>     interrupts-extended = <&intc1 5 1>, <0>, <&intc2 1 0>;

Thanks for the pointer, I'll have a look.
Phil
