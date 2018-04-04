Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDDLy2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:54:28 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:34499
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751244AbeDDLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:54:26 -0400
From: "Kalderon, Michal" <Michal.Kalderon@cavium.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Sinan Kaya <okaya@codeaurora.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Topic: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
Thread-Index: AQHTwfqdtrypC3mzl0CHfKiVN7XDyaPuY1aAgABUiCCAANHuAIABCDAA
Date: Wed, 4 Apr 2018 11:54:22 +0000
Message-ID: <CY1PR0701MB201281968E401A66825498DB88A40@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
 <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
 <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
 <20180403200348.GB21167@ziepe.ca>
In-Reply-To: <20180403200348.GB21167@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Kalderon@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB2105;7:xsifjaAVW1MVkhWvqLg4nnehTEsFgNjGtCo4bK9atXircXrOSwS6k4bdYkGGeInXoqMqTxyWRayUT8bsC/i0afFWD3q6LvsgbbrkLa5cUmhxcrn/A6/sgJDv9EzjApnidKt9yDH+/PMoAPKcrH/9AeYQeyRl/KT2noX01uQse8KbJr/tvLX76Iwu62/WUd8YE1Jlu3OUUJ+1QNnjhaOje3cZFn/FzjtbI1OII6FZTkXuG/HyzSxeU1JvtJCXqBEZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(39380400002)(189003)(199004)(11346002)(8676002)(5660300001)(59450400001)(26005)(97736004)(186003)(99286004)(106356001)(102836004)(476003)(3846002)(53546011)(6506007)(6916009)(76176011)(486006)(7696005)(2906002)(6116002)(6246003)(5250100002)(3660700001)(3280700002)(86362001)(446003)(4326008)(81156014)(229853002)(74316002)(305945005)(53936002)(105586002)(6436002)(66066001)(25786009)(81166006)(68736007)(9686003)(7736002)(33656002)(55016002)(8936002)(14454004)(72206003)(54906003)(93886005)(2900100001)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB2105;H:CY1PR0701MB2012.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 73d7d393-d50a-4415-7fbd-08d59a22ce94
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB2105;
x-ms-traffictypediagnostic: CY1PR0701MB2105:
x-microsoft-antispam-prvs: <CY1PR0701MB2105EB64C76C4B0438D0C6C588A40@CY1PR0701MB2105.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(100405760836317);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR0701MB2105;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB2105;
x-forefront-prvs: 0632519F33
x-microsoft-antispam-message-info: zqVa5WDbMvYXe7Kf7tT1SG+2Q4ciU/tNr0ZICVynJMjNA7T4l8AweCetAMVZNTocsE5s3Peu3hBqPQcq1IbaEiEyeW5oB63L9TfSv69PTN7TKTs9o2Ty8/dM2WfR/bDIxM4rPoSIrHUFv/NDMBCnf6lDtGuG0yZHB04oUmTwK3/OIAnno0snkt9piLC4jjLUyxaUK42at5vv5JR2CcKTa7HQxqU2lAcypXMlJcv/tAMIG/0MsPG5Uzwwp4bOAq1zpykN4jtZ3iZFhZfnKfCkouumLS/FprZnOR+bENPGdXfqWr8iZzkTSEEnRqws96ulYcTHTi4Qm7wfSRKhOKmL2ynuBZi9WsrGDy0dqFUyl0E24R2bm81xmWOPPZP7F9RpiJEbia8fJisi6Ehe+IHYrOYxxKbJHlDXBb8Jg4K2mYk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d7d393-d50a-4415-7fbd-08d59a22ce94
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 11:54:22.7572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB2105
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34BsZiH013819

> From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> Sent: Tuesday, April 03, 2018 11:04 PM
> 
> On Tue, Apr 03, 2018 at 07:42:28AM +0000, Kalderon, Michal wrote:
> > > From: Sinan Kaya [mailto:okaya@codeaurora.org]
> > > Sent: Tuesday, April 03, 2018 5:30 AM
> > > To: linux-rdma@vger.kernel.org; timur@codeaurora.org;
> > > sulrich@codeaurora.org
> > > Cc: linux-arm-msm@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > Kalderon, Michal <Michal.Kalderon@cavium.com>; Elior, Ariel
> > > <Ariel.Elior@cavium.com>; Doug Ledford <dledford@redhat.com>; Jason
> > > Gunthorpe <jgg@ziepe.ca>; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers
> > > on weakly-ordered archs #2
> > >
> > > On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> > > > @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq,
> > > > u32
> > > cons, u8 flags)
> > > >  	wmb();
> > > >  	cq->db.data.agg_flags = flags;
> > > >  	cq->db.data.value = cpu_to_le32(cons);
> > > > -	writeq(cq->db.raw, cq->db_addr);
> > > > +	writeq_relaxed(cq->db.raw, cq->db_addr);
> > >
> > > Given the direction to get rid of wmb() in front of writeX()
> > > functions, I have been reviewing this code. Under normal
> > > circumstances, I can get rid of all
> > > wmb() as follows.
> > >
> > > However, I started having my doubts now. Are these wmb() used as a
> > > SMP barrier too?
> > > I can't find any smp_Xmb() in drivers/infiniband/hw/qedr directory.
> >
> > Your doubts are in place. You initial patch series modified writel to
> > writel_relaxed Simply removing the wmb is dangerous. The wmb before
> > writel are used to make sure the HW observes the changes in memory
> > before we trigger the doorbell. Smp barriers here wouldn't suffice, as
> > on a single processor. we still need to make sure memory is updated and
> not remained in cache when HW accesses it.
> > Reviewing the qedr barriers, I can find places where this may have not
> > been necessary, But definitely you can't simply remove this wmb barriers.
> 
> As Sinan said, the consensus is that wmb();writel(); is redundant if the only
> purpose of the wmb is to order DMA and system memory.
> 
> So can you review these patches on that basis please? Is the WMB doing
> something else, eg SMP related? If yes, please send a patch adding
> appropriate comments.

Thanks Sinan and Jason for the references and explanations, I've reviewed the wmb
usages in qedr and am about to send a patch that replaces two of them with smp_wmb
and completely removes two of them that given your explanation, turned out to be redundant,
thanks.

> 
> Thanks,
> Jason
