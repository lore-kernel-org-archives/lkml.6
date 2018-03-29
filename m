Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeC2Qtz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:49:55 -0400
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:7288
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeC2Qtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:49:53 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Thread-Topic: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Thread-Index: AQHTxosQ1pBWmSR6xEK26yNat+laXKPloajwgABpnYCAAVpXIA==
Date: Thu, 29 Mar 2018 16:49:51 +0000
Message-ID: <CO2PR07MB97249009D56FA041EAD1146D8A20@CO2PR07MB972.namprd07.prod.outlook.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-8-niklas.cassel@axis.com>
 <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
 <20180328193717.GA97213@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180328193717.GA97213@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zZTNhNjQ1Yy0zMzcxLTExZTgtODZlMi1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcM2UzYTY0NWQtMzM3MS0xMWU4LTg2ZTItZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxNTMxIiB0PSIxMzE2NjgxNTgxMTM1MTI4MDIiIGg9InpIMzFOYnhleDZqVFBITjV1VU1oT0RaK3hXbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB2646;7:atrCZV3i44Rmr6EPRI9xnDtPCw27NCghrtYFq6wFD3rSYcO0vEgg4oEfG6DyIqglTxbcFmxOOtQ+2qhXoRn1I3lEiRJ4py9oUna4YpuTbJKftXK4p+O1LRlNwkJnN1IetZhMD+s5ItE/2IAIJ3xnryqwihW5udmV5VpPzS17hmo89JJ06yKkXxE9WCvHfEJoxH+FrXZ63T+ezKzaoo+IbJrQGqdjhp0NnZtK5hn2R/0UsxwtWB/13IhLtSRhsAtM;20:jAYSK3c3lT41cjygYwaGojOFqB9fXpLZvQ148QaH6/mYXbEv0Jc7xXM8nmyIJSM6jLlngSemBVaMJ2bUdW3pixWQ+TQo+zTmlzNJRokdamqcgbkvBHB0EtfPlhoxcaZAClLJMcwoPf7DhPRUTj7fEfl5YZr29I/ckwZeYMbidE1O4mTavIUN3Tkt8t4TpeBcht2R5zNH/hdHWJjvBSk9T5JUDWLi8r5QTQS0E22N6QplvDgCRWalv9ftDUyhmK97
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce24d663-fab7-4788-44ef-08d595951707
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB2646;
x-ms-traffictypediagnostic: CO2PR07MB2646:
x-microsoft-antispam-prvs: <CO2PR07MB2646E4E6442F92E2F46C02C2D8A20@CO2PR07MB2646.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CO2PR07MB2646;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB2646;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(346002)(39860400002)(376002)(396003)(36092001)(199004)(189003)(8936002)(66066001)(186003)(86362001)(6246003)(9686003)(106356001)(14454004)(11346002)(446003)(2906002)(53936002)(3660700001)(316002)(8676002)(25786009)(55016002)(478600001)(33656002)(76176011)(229853002)(59450400001)(4326008)(5660300001)(6116002)(3846002)(5250100002)(3280700002)(105586002)(7696005)(99286004)(97736004)(68736007)(81166006)(7736002)(305945005)(81156014)(6916009)(102836004)(26005)(6436002)(74316002)(476003)(2900100001)(54906003)(486005)(15760500003)(486005)(53546011)(6506007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB2646;H:CO2PR07MB972.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: eNhty9NOFZ+6HoXxvNZlSW7ia9NUwvJBCz5Tx6OC0YoNXExlh6t0InejAafnl6y8Cn/9zE89ZYFQGeAgvLnNDJ4Cb/z1lL/wDBv3OvkM7g29ZvGlkVjbxlaxu/9MLEFjyy+p4eOftG7BqLcBg82D2vvnFldpwxRPP3naO2erdQ3ExJ5/thJCAL8/vHR2XX3ZvbG5UuBazTiOiINWd12LBZ+UwpHKmqHriV5VZJbcTI5LzTFq0gO+wvSvYFOcdTrHiH54o0Dg0fAj3YTpAu+sdjPHueyo+vdA4YffH6gajwZgNi/M1Z3qLEuhAQPlnpgJxgnH1OUaAGmJHbHHGABnog==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce24d663-fab7-4788-44ef-08d595951707
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 16:49:51.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2646
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TGo3tB028285

On Wed, Mar 28, 2018 at 20:37, Bjorn Helgaas wrote:
> On Wed, Mar 28, 2018 at 01:24:10PM +0000, Alan Douglas wrote:
> > > On 28/03/2018 12:51, Niklas Cassel wrote:
> > > cdns_pcie_ep_set_bar() does some round-up of the BAR size, which
> > > means that a 64-bit BAR can be set-up, even when the flag
> > > PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.
> >
> > > If a 64-bit BAR was set-up, set the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64, so that the calling function can know
> what BAR width that was actually set-up.
> >
> > > I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag
> PCI_BASE_ADDRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to
> fix, since there might be a reason why > this flag is ignored.
> > Will investigate and fix this in future patch
> >
> > > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > > ---
> > >  drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > Change looks good to me.
> 
> It will be helpful to Lorenzo if you spell this out, e.g.,
> 
>   Acked-by: Alan Douglas <adouglas@cadence.com>
Acked-by: Alan Douglas <adouglas@cadence.com>
> 
> Also, it looks like we need a MAINTAINERS update to add drivers/pci/cadence/
> to the "PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
> filename patterns.
Lorenzo please let me know if I should create a patch for this, it sounds good to me.
