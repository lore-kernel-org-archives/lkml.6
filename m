Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeCXOa2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 10:30:28 -0400
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:44064
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751907AbeCXOaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 10:30:25 -0400
From: "Chopra, Manish" <Manish.Chopra@cavium.com>
To: Sinan Kaya <okaya@codeaurora.org>, David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Topic: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Index: AQHTwgCo72nuJMDi+Ua15ArLZkW0/KPeAb2AgAAC9wCAAANrAIAAAlWAgAADgACAAAKlAIABW/8A
Date: Sat, 24 Mar 2018 14:30:17 +0000
Message-ID: <DM2PR07MB685FD0A0877865A41EE723889AF0@DM2PR07MB685.namprd07.prod.outlook.com>
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
 <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
 <20180323.130418.2223623186761161723.davem@davemloft.net>
 <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
In-Reply-To: <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Chopra@cavium.com;
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR07MB639;7:w+lU4cY5Cz7Ar7Xuxim2tDZz09iubaBd8UZDDpiUzGlUHGfHXbaezMBqwPo6UeoUMCZlwAbJ4d7aexkoH0bS8zvACo7bEmF6yQL/QODL3NzZEJ8x90z5QWurdpBUJjgsxJfYPpbMWi3zMITffJ7fAexOpoCq48zGOH+8AnaoKTi1NL6/8vPViPMVc64laTaMDCgrb1LAaffyNUdvozS661Y58wWY+22oFEJeRxiKD+RwWGLJFd+RoLRQq63NGDmS
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 358f69e4-7a95-4457-88ac-08d59193c42f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR07MB639;
x-ms-traffictypediagnostic: DM2PR07MB639:
x-microsoft-antispam-prvs: <DM2PR07MB639C266E0A87FE44434E19989AF0@DM2PR07MB639.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR07MB639;BCL:0;PCL:0;RULEID:;SRVR:DM2PR07MB639;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(366004)(396003)(39850400004)(31014005)(199004)(189003)(13464003)(105586002)(110136005)(229853002)(316002)(99286004)(93886005)(106356001)(86362001)(7696005)(81156014)(8676002)(81166006)(8936002)(5250100002)(76176011)(3846002)(25786009)(2900100001)(97736004)(2906002)(59450400001)(54906003)(6116002)(3280700002)(72206003)(4326008)(9686003)(478600001)(68736007)(33656002)(102836004)(26005)(55016002)(53936002)(186003)(446003)(6246003)(14454004)(66066001)(6436002)(74316002)(7736002)(6506007)(53546011)(5660300001)(3660700001)(305945005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR07MB639;H:DM2PR07MB685.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: t7Ji5ukMP9GCkciBwwk5hIn10HF+HbTaOk0QlJVnJfMAKDgPJTlA513Top721vKuaAxfwUGOL13Qb8SyOkFyU4Sc5ymNGwinUr6Uk2kJoI1Moqtetzy3L1zE6U/O+/bMaMCwco/LRIjRKg7jtS/8aAQGhpOCz5i2nUO6ZB8xX4SbD1yAasCZ59dS0yOvqMIB3FygH9iwAdnfl9bp58RNXOL3AOCwEZ506AkgVzkNxdba0lTUF2oHbq6cbrXmviqrd8rDqNR8cJ413t/g4HEfGsn3xmliXnAFfNnYSkPQRZf5dQZsKVplS1VjTWTfaY3lChP0xLlp56s2sluptQZzvw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358f69e4-7a95-4457-88ac-08d59193c42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 14:30:17.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR07MB639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2OEUYId001295

> -----Original Message-----
> From: Sinan Kaya [mailto:okaya@codeaurora.org]
> Sent: Friday, March 23, 2018 10:44 PM
> To: David Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org; timur@codeaurora.org; sulrich@codeaurora.org;
> linux-arm-msm@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Elior,
> Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-
> EngEverestLinuxL2@cavium.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on weakly-
> ordered archs
> 
> On 3/23/2018 1:04 PM, David Miller wrote:
> > From: Sinan Kaya <okaya@codeaurora.org>
> > Date: Fri, 23 Mar 2018 12:51:47 -0400
> >
> >> It could if txdata->tx_db was not a union. There is a data dependency
> >> between txdata->tx_db.data.prod and txdata->tx_db.raw.
> >>
> >> So, no reordering.
> >
> > I don't see it that way, the code requires that:
> >
> >  	txdata->tx_db.data.prod += nbd;
> >
> > is visible before the doorbell update.>
> > barrier() doesn't provide that.
> >
> > Neither does writel_relaxed().  However plain writel() does.
> 
> Correct for some architectures including ARM but not correct universally.
> 
> writel() just guarantees register read/writes before and after to be ordered
> when HW observes it.
> 
> writel() doesn't guarantee that the memory update is visible to the HW on all
> architectures.
> 
> If you need memory update visibility, that barrier() should have been a
> wmb()
> 
> A correct multi-arch pattern is
> 
> wmb()
> writel_relaxed()
> mmiowb()
> 

Sinan,  Since you have mentioned the use of mmiowb() here after writel_relaxed().
I believe this is not always correct for all types of IO mapped memory [Specially if IO memory is mapped using write combined (for ex. Ioremap_wc())].
We have a current issue on our NIC (qede) driver on x86 for which the patch is already been sent more than a week ago [Still awaiting to hear from David on that].
where mmiowb() seems to be useless since we use write combined mapped doorbell and mmiowb() just seems to be a compiler barrier() there.
So in order to flush write combined buffer we really need writel_relaxed() followed by a wmb() to synchronize writes among CPU cores.
I think  the correct pattern in such cases (for write combined IO) would have been like below - 

wmb();
writel_relaxed();
wmb(); -> To flush the writes actually.

Thanks.
