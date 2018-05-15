Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeEON6k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:58:40 -0400
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:62336
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752704AbeEON6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:58:38 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Keith Busch <keith.busch@linux.intel.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: NVMe Poll CQ on timeout
Thread-Topic: NVMe Poll CQ on timeout
Thread-Index: AdPdbaKnll1ikIRyRXyNIhFzf8HT4wIYrQ9gABMa5QABjX+swA==
Date: Tue, 15 May 2018 13:58:32 +0000
Message-ID: <BLUPR0201MB15052CE08EF4230487E8DEC8A5930@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20180507160211.GE20686@localhost.localdomain>
In-Reply-To: <20180507160211.GE20686@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0201MB1473;7:0ekbg15248UOjojXArCI6FY+kIgqML+C94yqHEM1vXw5Ty1bZcM0Jgh/IJ9DelilBX4yJcCoOMe5hLGo9X6EoIypYly/jUPK56sUyWw6Fzqc1F/Y2bnVdUfhKJPkFsIJWbwiiq9yfcaqey6weBr/G/XLXFhaYFhRvAqgBDBrNn3rsd54Yv9Cs/DlUWo4EQbs7WMTxaeUyox++nRuX2rf9QpbdGk1Tydl+QUbJp4wymeIpsyIIXXU80UF5utmLYYU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BLUPR0201MB1473;
x-ms-traffictypediagnostic: BLUPR0201MB1473:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BLUPR0201MB14737A5A38D4683CD723136AA5930@BLUPR0201MB1473.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR0201MB1473;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1473;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(81156014)(81166006)(14454004)(6506007)(26005)(7696005)(99286004)(8936002)(316002)(305945005)(68736007)(66066001)(6916009)(7736002)(33656002)(25786009)(2900100001)(97736004)(8676002)(186003)(76176011)(55236004)(2906002)(6246003)(59450400001)(6116002)(3846002)(5660300001)(486006)(53936002)(102836004)(9686003)(55016002)(11346002)(476003)(5250100002)(446003)(478600001)(74316002)(106356001)(54906003)(3280700002)(4326008)(229853002)(6436002)(86362001)(3660700001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1473;H:BLUPR0201MB1505.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: abw/Ge1syESMHFFiDD6hcGu9Xq8RvXhwDDPDtLXt6TrXXQ4nCLtINaHminEAdURX+p/SBZIrMWKF+I4a9sx9Z0agzdAXH81R3v9XVnSHqZPAXrFwFVM40yk4fJXi19TKXRyBEJXeyZLnVdXCe/G7TQ5A2pnlHCq58U+qTgPFOJXyia5EVGYrIwwRlxRslIWY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6c4d5024-6e45-471b-b13e-08d5ba6bf225
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d5024-6e45-471b-b13e-08d5ba6bf225
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 13:58:32.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FDwksp025197

> I recall we did observe issues like this when legacy interrupts were used, so
> the driver does try to use MSI/MSIx if possible.
> 
> The nvme_timeout() is called from the block layer when the driver didn't
> provide a completion within the timeout (default is 30 seconds for IO,
> 60 seconds for admin).
> 
> This message you're seeing means the device did indeed post a completion
> queue entry for the timed out command, but the driver believes it was never
> notified via interrupt to check the completion queue.
> 
> This means either one of two things happened: the interrupt was raised prior
> to the completion queue entry being written, or the interrupt was never
> raised in the first place.
> 
> It might be possible to determine which if you can read the values from
> /proc/irq/<irq#>/spurious and see if the "last_unhandled" aligns with the
> expected completion time.
> 
Thanks keith. We are seeing the condition for transactions greater than 256 KB.
We did try increase IO timeout to 60sec but we still see issue. 

We do see spurious interrupts as following:
count 53224
unhandled 15890
last_unhandled 4294917520 ms

If there are spurious interrupts, isn't the EP handler called more times 
and this might help EP driver to process pending completions. (Because as per the code in 4.14 EP
driver isn't checking any interrupt status register, it starts processing completion queues immediately
in interrupt handler)

If we have spurious why do we still see completion polled ?

Regards,
Bharat


> > > Hi,
> > >
> > > We are testing NVMe cards on ARM64 platform, the card uses legacy
> > > interrupts.
> > > Intermittently we are hitting following case in drivers/nvme/host/pci.c
> > >        /*
> > >          * Did we miss an interrupt?
> > >          */
> > >         if (__nvme_poll(nvmeq, req->tag)) {
> > >                 dev_warn(dev->ctrl.device,
> > >                          "I/O %d QID %d timeout, completion polled\n",
> > >                          req->tag, nvmeq->qid);
> > >                 return BLK_EH_HANDLED;
> > >         }
> > >
> > > Can anyone tell when does nvme_timeout gets invoked ?
> > > What does "Did we miss an interrupt mean" ? Does it mean host
> > > missing to service a interrupt raised by EP card ?
> > >
> > > Regards,
> > > Bharat
