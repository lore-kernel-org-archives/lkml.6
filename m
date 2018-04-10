Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeDJOXS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:23:18 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:65375 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753145AbeDJOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:23:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,432,1517842800";
   d="scan'208";a="277783082"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Topic: [PATCH] gpio: dwapb: Add support for 32 interrupts
Thread-Index: AQHTxqA8Q/Tp1OQLo0C0CX9dPZ3BD6P44lCAgAC3EuCAAIXioA==
Date: Tue, 10 Apr 2018 14:23:07 +0000
Message-ID: <TY1PR01MB17691846E8DFA86DA831B8B9F5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
 <20180409192013.5rytwgoixtyraow3@rob-hp-laptop>
 <TY1PR01MB1769EC6963CFB3D720D1B9EEF5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769EC6963CFB3D720D1B9EEF5BE0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0365;7:G6wPXoxzHwLbti4szNmEu158jwV9lWHfaqgcvim+yqqInjamg9mlyvxlP7SPfZEL7FFsR4EHz7Wa0maSTHh0CaXDygwu4ZOpnvaFEChzdgP8mPrknjg5aqYhyAeeGiQ20VuoiS4GO/Ff0nCKmBMjUXkYtk82jTjdQGnbkFwSBz3y4DCakvx8ZWUMd3793Ii9095lspxxUuLqc0i4gX3oA73lMjOE7Mwpt8fkYvhnp5kDRvpz5gyfcf7FdZIEus11;20:q2YSwwvEt0yuakfpJHa18tIWYJiiVn7rsyq8Do0xJqEZlKv0A4C+5qZKzImv91g3cQDmSpHJcR8R48oJuQtS9Fh1f6F+lHgYyHZQarPKzmnKSDrBaLBhhaZTpIdtoqioY+LTR8LXCHV6LCR00lmnWKrq/JnPJEnaeN3sMR/T9Qc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76bc1508-e95d-4b9c-4d5d-08d59eee94d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0365;
x-ms-traffictypediagnostic: TY1PR01MB0365:
x-microsoft-antispam-prvs: <TY1PR01MB0365A603AEBF4750FC35A123F5BE0@TY1PR01MB0365.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR01MB0365;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0365;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(3846002)(4326008)(3660700001)(2940100002)(76176011)(39060400002)(3280700002)(68736007)(106356001)(5250100002)(55016002)(14454004)(6116002)(7696005)(99286004)(9686003)(6246003)(2906002)(5660300001)(33656002)(105586002)(66066001)(53936002)(229853002)(478600001)(26005)(6436002)(2900100001)(7736002)(25786009)(74316002)(305945005)(186003)(486006)(316002)(53546011)(476003)(54906003)(97736004)(102836004)(446003)(11346002)(6916009)(8676002)(81166006)(86362001)(8936002)(6506007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0365;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Vvz4Kld4JTsqV9hcrWHUKRTrg4ykPzlNhi6ixVi6nNeYVvX6JHxlImN/ZdWtLeV8vzGk1NGUpXlavaTpi71v6IKOcUsnzDZI7uDNRkqXOLtB9kDg4QK+1RoyQgZK6v5e50V61OXvAjj1u9MzUCbpfvkMDWD/Dnq+S03S1+eAfHxi9JYPzwIaVso3aL1NVtxz3V//+SHu8lvwaNzzjF9e4l4OAIchidaILQRqN1W0uFtzr8LGkEH0epfkS3tVPKRgqihjEyW0ttcli99YzgiuzI1JStD/7a6GQ/hcEBQektNrfLsApxxVkhRDfIG8RwBlS3JraRzLU23of0JsMaOehSkzyyfzVgniYu4n5/Z1gc5sonb3xqeloyKqmyIdAwLO/N6p3it5+fjPZdUV2W5bIqOXiCYBefyTLa22DFp4sYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bc1508-e95d-4b9c-4d5d-08d59eee94d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 14:23:07.6901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0365
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AENMai032738

Hi Rob,

On 10 April 2018 07:24 Phil Edworthy wrote:
> On 09 April 2018 20:20 Rob Herring wrote:
> > On Wed, Mar 28, 2018 at 03:22:30PM +0100, Phil Edworthy wrote:
[...]
> > > +- interrupt-mask : a 32-bit bit mask that specifies which interrupts
> > > +in the list
> > > +  of interrupts is valid, bit is 1 for a valid irq.
> >
> > This is not a standard property and would need a vendor prefix. However,
> I'd
> > prefer you just skip any not connected interrupts with an invalid interrupt
> > number. Then the GPIO number is the index into "interrupts".
> Makes sense, I'll rework it to do this.
Err, what would an invalid interrupt number be?
If I use -1, I get a DT parsing error and 0 is certainly valid. If the number is
larger than the valid interrupt range I get errors during probe.

Thanks
Phil
